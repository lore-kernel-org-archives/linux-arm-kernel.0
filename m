From: javi.merino@arm.com (Javi Merino)
Date: Fri, 25 Apr 2014 21:11:12 +0100
Subject: [PATCH] ARM: dts: Remove vmmc-supply for mmc@12220000 on arndale-octa
 board
Message-ID: <1398456672-3936-1-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

d726ca2d3316 (ARM: dts: Add vmmc-supply to MMC on arndale-octa board)
added the vmmc-supply to nodes mmc at 12200000 and mmc at 12220000 of the
DT.  However, this makes the kernel fail to boot on the arndale-octa
spews:

[    5.060000] dwmmc_exynos 12200000.mmc: num-slots property not found, assuming 1 slot is available
[    5.065000] platform 12200000.mmc: Driver dwmmc_exynos requests probe deferral
[    5.075000] dwmmc_exynos 12220000.mmc: num-slots property not found, assuming 1 slot is available
[    5.085000] platform 12220000.mmc: Driver dwmmc_exynos requests probe deferral

And eventually hangs.  Without the vmmc-supply property in the
mmc at 12220000 node, the kernel boots again.

Signed-off-by: Javi Merino <javi.merino@arm.com>
---

Hi,

Note that I don't know *why* removing the property works, all I know
is that 3.15-rc2 fails to boot on my Arndale Octa unless I apply this
patch.

Cheers,
Javi

 arch/arm/boot/dts/exynos5420-arndale-octa.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 80a3bf4..722fb6c 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -64,7 +64,6 @@
 		samsung,dw-mshc-ddr-timing = <1 2>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
-		vmmc-supply = <&ldo10_reg>;
 
 		slot at 0 {
 			reg = <0>;
-- 
1.7.9.5
