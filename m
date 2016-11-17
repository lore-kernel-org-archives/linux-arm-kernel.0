From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 17 Nov 2016 16:36:33 +1030
Subject: [RFC PATCH] mfd: dt: Add Aspeed LPC binding
Message-ID: <20161117060633.3837-1-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---

I'd like to start a discussion about how to handle the LPC register space in
the Aspeed SoC. There are a number of issues, largely concerned with the layout
of the registers but also with the fact that LPC register state is used by the
pinmux to determine some pin functionality.

So the register layout is problematic. Registers for what I think are coherent
pieces of functionality functionality are littered through the layout: Post
Code Control registers (PCCR) are interleaved with LPC Host Controller
registers (LHCR) which are interleaved with Host Interface Controller registers
(HICR) which are segmented by LPC Snoop registers. It seems appropriate that
the whole thing is represented as an MFD syscon, with the alternative being
writing several distinct drivers that map some number of resources to access
all of their registers.

The disadvantage of not representing the LPC space as a syscon is the LPC Host
Controller driver will need to provide accessor functions for the pinmux
driver. Pinmux also depends on bits in the Display Controller, and would need
similar accessors provided there. The idea of using syscon regmaps removes the
need to write these accessors. If the changes between the AST2400 and AST2500
are anything to go by, the pinmux complexity of the SoCs will only increase
which will likely lead to the spread of these accessor functions.

Yet another option would be to only expose the LPC Host Controller as a syscon
instead of the whole LPC register space. I feel this is a little distasteful
as the LHCRs are not in contiguous memory space; as mentioned above they are
separated (seemingly randomly) by a PCCR. We could specify the LPC Host
Controller as a syscon and provide multiple resources: The syscon
implementation consumes the first resource which is what we desire here for use
with pinmux, but the driver would be left to map any subsequent resources. That
feels odd to me, but I'm interested in arguments for it.

We could also map the LPC Host Controller syscon across the offending PCCR, but
then any driver developed for the Post Code Controller would have to take a
reference to the LPC Host Controller regmap. I feel like we might wind up with
a syscon phandle spaghetti across the LPC controller if we use that approach.

Finally, the LPC registers can be divided in two: one set for H8S/2168
compatible LPC functionality, and the rest for Aspeed-specific registers.
Division in two is required if we are going to throw a regmap over the LPC
space as the H8S/2168 registers are 1-byte wide, whilst the Aspeed LPC
registers are 4-bytes. As far as I can tell we can treat them as separate
functionality without any loss; if there is a cross-over in configuration we
can have each phandle the other in the devicetree.

The final complication is the iBT device sits in the Aspeed-specific part of
the LPC controller and has an upstream driver that isn't regmap-capable.
Describing the LPC controller as a syscon will require some changes there, but
I think we can make it work without too much trouble.

What is the recommended approach to managing such hardware?

Cheers,

Andrew

PS: I sent a devicetree binding document out for the LPC Host Controller as
part of a recent pinmux series[1]. As it stands the example in the document
doesn't cover the all the registers relevant to the LPC Host Controller, which
was a motivation for trying to sort the problem out properly.

[1] https://www.spinics.net/lists/arm-kernel/msg540084.html

 .../devicetree/bindings/mfd/aspeed-lpc.txt         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed-lpc.txt

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
new file mode 100644
index 000000000000..36c8a9e08dc6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
@@ -0,0 +1,28 @@
+* Device tree bindings for the Aspeed LPC Controller
+
+The Aspeed LPC controller contains registers for a variety of functions. Not
+all registers for a function are contiguous, and some registers are referenced
+by functions outside the LPC controller.
+
+Note that this is separate from the H8S/2168 compatible register set occupying
+the start of the LPC controller address space.
+
+Some significant functions in the LPC controller:
+
+* LPC Host Controller
+* Host Interface Controller
+* iBT Controller
+* SuperIO Scratch registers
+
+Required properties:
+- compatible:		"aspeed,ast2500-lpc", "syscon"
+- reg:			contains offset/length value of the Aspeed-specific LPC
+			memory region.
+
+Example:
+
+lpc: lpc at 1e7890a0 {
+	compatible = "aspeed,ast2500-lpc", "syscon";
+	reg = <0x1e789080 0x1e0>;
+};
+
-- 
2.9.3
