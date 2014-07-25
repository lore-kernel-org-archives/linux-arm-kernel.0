From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jul 2014 20:17:52 +0200
Subject: [PATCH] ARM: mvebu: armada xp: Generalize use of i2c quirk
In-Reply-To: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
References: <1406308951-14612-1-git-send-email-andrew@lunn.ch>
Message-ID: <6576319.3qh6UrO3Zo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 July 2014 19:22:31 Andrew Lunn wrote:
> A second product has come to light which makes use of the A0 stepping
> of the Armada XP SoC. A0 stepping has a hardware bug in the i2c core
> meaning that hardware offload does not work, resulting in the kernel
> failing to boot. The quirk detects that the kernel is running on an A0
> stepping SoC and disables the use of hardware offload.
> 
> Currently the quirk is only enabled for PlatHome Openblocks AX3. The
> AX3 has been produced with both A0 and B1 stepping SoCs. The second
> product is the Lenovo Iomega IX4-300d. It seems likely that this
> device will also swap from A0 to B1 SoC sometime during its life.
> 
> If there are two products using A0, it seems likely there are more
> products with A0. Also, since the number of A0 SoCs is limited, these
> products are also likely to transition to B1. Hence detecting at run
> time is the safest option. So enable the quirk for all Armada XP
> boards.
> 
> Tested on an AX3 with A0 stepping.
> 

Based on the discussion on IRC, I think we can actually simplify the
existing quirk and avoid spreading it further. Below would be my
preferred approach.

8<------
[PATCH] ARM: mvebu: simplify openblocks ax3 quirk

We currently check the SoC revision in order to find out whether we
have an old or new openblocks ax3 machine and apply a quirk to
fix the compatible string for the old ones so the i2c driver does
not crash.

As it turns out, that is not necessary because the code for the a0
version also works on all following revisions, just slightly slower.
As only an RTC is connected to this bus and there are no performance
constraints in accessing that, we can easily apply that fixup
for all ax3 machines.

This also fixes the dtb file to contain the specific revision for a0,
so we can eventually run without the quirk. Other machines that may
be based on the a0 revision should do the same.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 4e5a59ee1501..2c6ac448b098 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -158,10 +158,16 @@
 				phy-mode = "sgmii";
 			};
 			i2c at 11000 {
+				compatible = "marvell,mv78230-a0-i2c",
+					     "marvell,mv78230-i2c",
+					     "marvell,mv64xxx-i2c";
 				status = "okay";
 				clock-frequency = <400000>;
 			};
 			i2c at 11100 {
+				compatible = "marvell,mv78230-a0-i2c",
+					     "marvell,mv78230-i2c",
+					     "marvell,mv64xxx-i2c";
 				status = "okay";
 				clock-frequency = <400000>;
 
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 6478626e3ff6..3f9cc8b58119 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -102,13 +102,13 @@ static void __init i2c_quirk(void)
 	u32 dev, rev;
 
 	/*
-	 * Only revisons more recent than A0 support the offload
-	 * mechanism. We can exit only if we are sure that we can
-	 * get the SoC revision and it is more recent than A0.
+	 * Some ax3 machines have an older SoC revision with a
+	 * slightly incompatible i2c controller. Since existing
+	 * device tree blobs may not reflect this correctly, let's
+	 * update the compatible string for that device.
+	 * New dtb files should list the a0 revision here, which
+	 * will work on all SoCs.
 	 */
-	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > MV78XX0_A0_REV)
-		return;
-
 	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c") {
 		struct property *new_compat;
 
