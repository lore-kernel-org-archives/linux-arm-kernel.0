From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sat, 14 Mar 2015 09:11:56 +0100
Subject: [PATCH 1/1] ARM: dts: don't make DP a consumer of DISP1 on Exynos5250
Message-ID: <1426320716-28137-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By making the DP controller a consumer of DISP1, the PD is powered
off when the exynos-dp probe is deferred and powered on again when
the exynos-drm driver is probed.

But this causes the exynos-dp driver failing to obtain the stream
clock since the FIMD has been powered off with the DISP1 PD:

exynos-dp 145b0000.dp-controller: Timeout of video streamclk ok
exynos-dp 145b0000.dp-controller: unable to config video

The Exynos5250 documentation doesn't mention that the Display Port
Transmitter module is included in the DISP1 PD so the device should
not have a reference to this Power Domain.

This patch fixes video display on an Exynos5250 Snow Chromebook.

Fixes: 2d2c9a8d0a4f ("ARM: dts: add display power domain for exynos5250")
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Hello Andrzej and Marek,

I need this patch to have display working on an Snow Chromebook with
next20150312. I remember testing the mentioned patch that introduced
the regression when it was posted and I did not find any issues with
it. Do you know what could had caused this behavior change?

According to the Exynos5250 documentation I've access to, the modules
that are included in the DISP1 power domain are LCD controller (FIMD),
MIE1 VP, MIXER, TV Encoder and HDMI so I think this patch is correct
since it not only solves the regression but also models the HW better.

Please let me know if you think it should be fixed in a different way.

Best regards,
Javier

 arch/arm/boot/dts/exynos5250.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index adbde1adad95..ffb505171216 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -775,7 +775,6 @@
 	};
 
 	dp: dp-controller at 145B0000 {
-		power-domains = <&pd_disp1>;
 		clocks = <&clock CLK_DP>;
 		clock-names = "dp";
 		phys = <&dp_phy>;
-- 
2.1.4
