From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 5 Aug 2013 10:47:10 +0100
Subject: [PATCH 0/3] ARM: vexpress: TC2 MCPM/SPC cleanups
In-Reply-To: <1375675793-16492-1-git-send-email-olof@lixom.net>
References: <1375675793-16492-1-git-send-email-olof@lixom.net>
Message-ID: <20130805094709.GA29090@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 05, 2013 at 05:09:50AM +0100, Olof Johansson wrote:
> Here's a short series on top of Nico's TC2 MCPM series to move the SPC driver
> back under mach-vexpress where it should be, and a couple of tiny cleanups
> to the driver.
> 
> I'll pick this up together with the base branch in arm-soc for-next, but I
> haven't staged it in a next/* branch so it can be rebased/changed/dropped
> if needed.
> 
> There's still one thing left to iron out, and that's the actual binding
> for the "SPC" node. Since the spc code needs a non-zero SPC_BASE, it
> implies that there's more than just SPC described by the device node. So
> either the naming and description needs to be changed, or there's need
> for more than one device node to describe the other register ranges. The
> former might be easier in this case...
> 
> Pawel, I'd appreciate a quick test from you to make sure I didn't break
> anything since I don't have a way to boot this myself.

Thanks Olof.

Tested, a couple of fixes needed to compile your series, comments in the
relative patches.

For the bindings, you are right, how about this (commit log written just
for the sake of it, it should be squashed in Nico's original series) ?

-- >8 --
Subject: [PATCH] Documentation: devicetree: arm: rename SPC device tree
 bindings to SCC

The Serial Power Controller (SPC) is part of an HW IP called Serial
Configuration Controller (SCC), hence it must not define an independent
devicetree node and relative bindings. This patch replaces the existing
SPC documentation with the more generic SCC bindings.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 .../devicetree/bindings/arm/vexpress-scc.txt       | 37 ++++++++++++++++++++++
 .../devicetree/bindings/arm/vexpress-spc.txt       | 36 ---------------------
 2 files changed, 37 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress-scc.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/vexpress-spc.txt

diff --git a/Documentation/devicetree/bindings/arm/vexpress-scc.txt b/Documentation/devicetree/bindings/arm/vexpress-scc.txt
new file mode 100644
index 0000000..f25849d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/vexpress-scc.txt
@@ -0,0 +1,37 @@
+* ARM Versatile Express Serial Configuration Controller device tree bindings
+
+Latest ARM development boards implement a serial configuration interface (SCC)
+that can be used to retrieve temperature sensors, energy/voltage/current
+probes and oscillators values through the SYS configuration protocol defined
+for versatile express motherboards.
+It also provides a power management interface (serial power controller - SPC)
+that is capable of managing power/voltage and operating points transitions,
+wake-up IRQs and resume addresses for ARM multiprocessor testchips.
+
+The SCC DT bindings are defined as follows:
+
+- scc node
+
+	- compatible:
+		Usage: required
+		Value type: <stringlist>
+		Definition: must be
+			    "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc"
+	- reg:
+		Usage: required
+		Value type: <prop-encode-array>
+		Definition: A standard property that specifies the base address
+			    and the size of the SCC address space
+	- interrupts:
+		Usage: required
+		Value type: <prop-encoded-array>
+		Definition:  SCC interrupt configuration. A standard property
+			     that follows ePAPR interrupts specifications
+
+Example:
+
+scc: scc at 7fff0000 {
+	compatible = "arm,vexpress-scc,v2p-ca15_a7", "arm,vexpress-scc";
+	reg = <0x7fff0000 0x1000>;
+	interrupts = <0 95 4>;
+};
diff --git a/Documentation/devicetree/bindings/arm/vexpress-spc.txt b/Documentation/devicetree/bindings/arm/vexpress-spc.txt
deleted file mode 100644
index 1614725..0000000
--- a/Documentation/devicetree/bindings/arm/vexpress-spc.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* ARM Versatile Express Serial Power Controller device tree bindings
-
-Latest ARM development boards implement a power management interface (serial
-power controller - SPC) that is capable of managing power states transitions,
-wake-up IRQs and resume addresses for ARM multiprocessor testchips.
-The serial controller can be programmed through a memory mapped interface
-that enables communication between firmware running on the microcontroller
-managing power states and the application processors.
-
-The SPC DT bindings are defined as follows:
-
-- spc node
-
-	- compatible:
-		Usage: required
-		Value type: <stringlist>
-		Definition: must be
-			    "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc"
-	- reg:
-		Usage: required
-		Value type: <prop-encode-array>
-		Definition: A standard property that specifies the base address
-			    and the size of the SPC address space
-	- interrupts:
-		Usage: required
-		Value type: <prop-encoded-array>
-		Definition:  SPC interrupt configuration. A standard property
-			     that follows ePAPR interrupts specifications
-
-Example:
-
-spc: spc at 7fff0000 {
-	compatible = "arm,vexpress-spc,v2p-ca15_a7", "arm,vexpress-spc";
-	reg = <0x7fff0000 0x1000>;
-	interrupts = <0 95 4>;
-};
-- 
1.8.2.2
