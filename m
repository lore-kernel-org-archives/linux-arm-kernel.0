From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:49:51 +0900
Subject: [PATCH 03/11] ARM: shmobile: armadillo800eva legacy: Add missing A3SP
 pm domain devices
In-Reply-To: <cover.1415058794.git.horms+renesas@verge.net.au>
References: <cover.1415058794.git.horms+renesas@verge.net.au>
Message-ID: <4311d9654c66b7cc7147035b8ec74f41ddffa650.1415058794.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Commit 802a5639aa7041b2 ("ARM: shmobile: r8a7740: add A3SP pm domain
support") added the A3SP power domain, but forgot to hook up the TPU,
SDHI0/1, and MMCIF hardware blocks.

Note: As the default PM QoS latency constraint for SDHI is only 100 ?s
(cfr. commit c419e611c3c59c0e ("tmio_mmc / PM: Use PM QoS latency
constraint"), while DEFAULT_DEV_LATENCY_NS is 250000, suspend fails with
-EBUSY, unless the constraint is increased first to more than 500 ?s
using e.g.

    echo 501 > /sys/devices/platform/sh_mobile_sdhi.0/power/pm_qos_resume_latency_us

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e709835..4bc202d 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1234,8 +1234,11 @@ static void __init eva_init(void)
 	static struct pm_domain_device domain_devices[] __initdata = {
 		{ "A4LC", &lcdc0_device },
 		{ "A4LC", &hdmi_lcdc_device },
+		{ "A3SP", &pwm_device },
+		{ "A3SP", &sdhi0_device },
+		{ "A3SP", &sh_mmcif_device },
 	};
-	struct platform_device *usb = NULL;
+	struct platform_device *usb = NULL, *sdhi1 = NULL;
 
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
@@ -1304,6 +1307,7 @@ static void __init eva_init(void)
 
 		platform_device_register(&vcc_sdhi1);
 		platform_device_register(&sdhi1_device);
+		sdhi1 = &sdhi1_device;
 	}
 
 
@@ -1324,6 +1328,8 @@ static void __init eva_init(void)
 				       ARRAY_SIZE(domain_devices));
 	if (usb)
 		rmobile_add_device_to_domain("A3SP", usb);
+	if (sdhi1)
+		rmobile_add_device_to_domain("A3SP", sdhi1);
 
 	r8a7740_pm_init();
 }
-- 
2.1.1
