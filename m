From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Jul 2011 13:49:44 -0600
Subject: [PATCH 3/7] ARM: mmp: support DT on both dkb and brownstone
In-Reply-To: <4E2589C8.8010604@firmworks.com>
References: <2011071901>
	<1311042290-20253-1-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-2-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-3-git-send-email-haojian.zhuang@marvell.com>
	<1311042290-20253-4-git-send-email-haojian.zhuang@marvell.com>
	<4E2589C8.8010604@firmworks.com>
Message-ID: <20110719194944.GM6848@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2011 at 09:42:32PM +0800, Mitch Bradley wrote:
> Thanks for doing this work.  I'm currently working on a One Laptop
> Per Child product that is based on the Armada 610, so this very
> timely for OLPC.
> 
> See my in-line comments on the specification of the soc top-level
> nodes, related to the addressing of their children, and on the
> presence of "#address-cells" and "#size-cells" in the intc nodes.
> 
> -- Mitch Bradley
> 
> On 7/19/2011 10:24 AM, Haojian Zhuang wrote:
> >Add new boards.c to support both TTC-DKB and MMP2-BROWNSTONE. While
> >CONFIG_MMP_USE_OF is selected, original ttc_dkb.c and brownstone.c won't be
> >compiled.
> >
> >While everything moving to DT in ARCH-MMP, original ttc_dkb.c and brownstone.c
> >will be abandoned.
> >
> >Signed-off-by: Haojian Zhuang<haojian.zhuang@marvell.com>
> >---
> >  .../devicetree/bindings/arm/marvell/boards.txt     |    7 +
> >  arch/arm/boot/dts/mmp2-brownstone.dts              |  242 ++++++++++++++++++++
> >  arch/arm/boot/dts/ttc-dkb.dts                      |   80 +++++++
> >  arch/arm/mach-mmp/Makefile                         |    4 +
> >  arch/arm/mach-mmp/boards.c                         |  159 +++++++++++++
> >  5 files changed, 492 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/arm/marvell/boards.txt
> >  create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
> >  create mode 100644 arch/arm/boot/dts/ttc-dkb.dts
> >  create mode 100644 arch/arm/mach-mmp/boards.c
> >
> >diff --git a/Documentation/devicetree/bindings/arm/marvell/boards.txt b/Documentation/devicetree/bindings/arm/marvell/boards.txt
> >new file mode 100644
> >index 0000000..219e134
> >--- /dev/null
> >+++ b/Documentation/devicetree/bindings/arm/marvell/boards.txt
> >@@ -0,0 +1,7 @@
> >+TTC(pxa910) "DKB" evalutation board
> >+Required root node properties:
> >+	- compatible = "mrvl,ttc-dkb", "mrvl,pxa910-dkb";
> >+
> >+mmp2(armada610) "Brownstone" evalutation board
> >+Required root node properties:
> >+	- compatible = "mrvl,mmp2-brownstone", "mrvl,armada610-brownstone";
> >diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
> >new file mode 100644
> >index 0000000..4e14388
> >--- /dev/null
> >+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
> >@@ -0,0 +1,242 @@
> >+/dts-v1/;
> >+
> >+/include/ "skeleton.dtsi"
> >+
> >+/ {
> >+	model = "Marvell MMP2 Brownstone";
> >+	compatible = "mrvl,mmp2-brownstone", "mrvl,armada610-brownstone";
> >+
> >+	memory {
> >+		reg =<0x00000000 0x20000000>;
> >+	};
> >+
> >+	chosen {
> >+		bootargs = "console=ttyS2,38400 root=/dev/nfs nfsroot=192.168.1.100:192.168.1.101::255.255.255.0::eth0:on";
> >+		linux,stdout-path =&uart2;
> >+	};
> >+
> >+	soc at d4000000 {
> >+		compatible = "mrvl,mmp2", "mrvl,armada610", "simple-bus";
> >+		device_type = "soc";
> 
> Can someone comment on the use of "device_type" here?  I thought
> that device_type was deprecated.  Is there some residual use for it
> in Linux?

It is, and device_type should be removed for .dts files.

> 
> >+		#address-cells =<1>;
> >+		#size-cells =<1>;
> >+		ranges;
> 
> This way of addressing of APB and AXI devices would work, in that
> the empty ranges property specifies no address translation across
> the "soc" node.  However, in a case like this, it is unclear to me
> why you need an "soc" node at all.  The "soc" node appears to have
> no semantics.  You could just move all the subordinate devices up a
> level, making them direct children of the root node.  As I
> understand it, the Linux kernel no longer has a problem with devices
> being directly attached to the root node.
> 
> If you want to have a bus node at this level, I think it's best to
> go all the way and define it as an AXI/APB bus, exposing some of the
> addressing semantics of that kind of bus.  See below for an
> exploration of how that might work, in the comments for the ttc-dkb
> "soc" node.
> 
> >+
> >+		mmp_intc: interrupt-controller at d4282000 {
> >+			compatible = "mrvl,mmp-intc";
> >+			#address-cells =<1>;
> >+			#size-cells =<1>;
> 
> I believe that this node should not have "#address-cells" and
> "#size-cells" properties.  Such properties apply to nodes that have
> child nodes, expressing how those children are addressed.  I think
> that the interrupt controller is not intended to have child nodes.

I agree
