From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Jul 2014 06:28:39 +0200
Subject: [PATCH/RFC 3/6] ARM: shmobile: bockw: Initialise SCIF device using DT
In-Reply-To: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404275322-26514-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialise SCIF device using DT when booting bockw
using DT reference.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
N.B: This only enables the production serial port (scif0) and not the
debug serial port. It is unclear to me if the debug port is scif1 or scif5.
And if the required PFC support is in place. At the very least the
latter appears to be missing from r8a7778-bockw-reference.dts.
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 14 +++++++++++---
 arch/arm/mach-shmobile/setup-r8a7778.c        | 12 ++++++------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index f76f6ec..5d14688 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -23,6 +23,10 @@
 	model = "bockw";
 	compatible = "renesas,bockw-reference", "renesas,r8a7778";
 
+	aliases {
+		serial0 = &scif0;
+	};
+
 	chosen {
 		bootargs = "console=ttySC0,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
 	};
@@ -70,9 +74,6 @@
 };
 
 &pfc {
-	pinctrl-0 = <&scif0_pins>;
-	pinctrl-names = "default";
-
 	scif0_pins: serial0 {
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
 		renesas,function = "scif0";
@@ -124,3 +125,10 @@
 		};
 	};
 };
+
+&scif0 {
+       pinctrl-0 = <&scif0_pins>;
+       pinctrl-names = "default";
+
+       status = "okay";
+};
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 2ccc012..e218c46 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -294,12 +294,6 @@ void __init r8a7778_add_dt_devices(void)
 	}
 #endif
 
-	r8a7778_register_scif(0);
-	r8a7778_register_scif(1);
-	r8a7778_register_scif(2);
-	r8a7778_register_scif(3);
-	r8a7778_register_scif(4);
-	r8a7778_register_scif(5);
 	r8a7778_register_tmu(0);
 }
 
@@ -508,6 +502,12 @@ static void __init r8a7778_register_hpb_dmae(void)
 void __init r8a7778_add_standard_devices(void)
 {
 	r8a7778_add_dt_devices();
+	r8a7778_register_scif(0);
+	r8a7778_register_scif(1);
+	r8a7778_register_scif(2);
+	r8a7778_register_scif(3);
+	r8a7778_register_scif(4);
+	r8a7778_register_scif(5);
 	r8a7778_register_i2c(0);
 	r8a7778_register_i2c(1);
 	r8a7778_register_i2c(2);
-- 
2.0.0.rc2
