From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun, 12 Apr 2015 22:30:59 +0200
Subject: [PATCH 1/1] ARM: dts: Make DP a consumer of DISP1 power domain on
 Exynos5420
Message-ID: <1428870659-5525-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ea08de16eb1b ("ARM: dts: Add DISP1 power domain for exynos5420")
added a device node for the Exynos5420 DISP1 power domain but dit not
make the DP controller a consumer of that power domain.

This causes an "Unhandled fault: imprecise external abort" error if the
exynos-dp driver tries to access the DP controller registers and the PD
was turned off. This lead to a kernel panic and a complete system hang.

Make the DP controller device node a consumer of the DISP1 power domain
to ensure that the PD is turned on when the exynos-dp driver is probed.

Fixes: ea08de16eb1b ("ARM: dts: Add DISP1 power domain for exynos5420")
Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Hello,

This latent bug was not exposed before since drivers for other devices
marked as DISP1 power domain consumers were probed before exynos-dp so
the PD was already on which made possible to access the DP registers.

But "regulator: Defer lookup of supply to regulator_get" [0] that is in
linux-next from a couple of days now, changed the order on which the
drivers' probes succeed so the PD was disabled during exynos-dp probe.

Exynos5420 machines with a display such as the Exynos5420 Peach Pit and
Exynos5800 Peach Pi were failing to boot due this issue, i.e: [1].

Olof,

Could you please confirm $subject fixes the issue catched by your farm?

Krzysztof,

This patch conflicts with your Exynos5 phandle notation cleanup [2] but
I preferred to send it on top of linux-next instead of making your series
a dependency since it fixes a very important bug that had caused -next to
be broken on these matchines for days now.

Thanks a lot and best regards,
Javier

[0]: https://lkml.org/lkml/2015/3/24/1167
[1]: http://arm-soc.lixom.net/bootlogs/next/next-20150409/pi-arm-exynos_defconfig.html
[2]: https://lkml.org/lkml/2015/4/12/49

 arch/arm/boot/dts/exynos5420.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index f67b23f303c3..45317538bbae 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -536,6 +536,7 @@
 		clock-names = "dp";
 		phys = <&dp_phy>;
 		phy-names = "dp";
+		power-domains = <&disp_pd>;
 	};
 
 	mipi_phy: video-phy at 10040714 {
-- 
2.1.4
