From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 21 Jan 2013 15:29:16 +0100
Subject: [PATCH v5 00/12] clk: exynos4: migrate to common clock framework
In-Reply-To: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
References: <1356827621-27617-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <50FD50BC.4020902@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/30/2012 01:33 AM, Thomas Abraham wrote:
> Changes since v4:
> - Rebased to linux-3.8-rc1.
> 
> Changes since v3:
> - Includes changes suggested by Tomasz Figa <tomasz.figa@gmail.com>
> 
> This patch series migrates the Samsung Exynos4 SoC clock code to adopt the
> common clock framework. The use of Samsung specific clock structures has
> been removed and all board support code has been updated. imx-style of
> clock registration and lookup has been adopted for device tree based
> exynos4 platforms.
> 
> This patch series depends on this series:
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14471.html
> and this patch
> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg14472.html
> 
> Thomas Abraham (12):
>   clk: samsung: add common clock framework helper functions for Samsung platforms
>   clk: samsung: add pll clock registration helper functions
>   clk: exynos4: register clocks using common clock framework
>   ARM: Exynos: Rework timer initialization sequence
>   ARM: Exynos4: Migrate clock support to common clock framework
>   ARM: dts: add exynos4 clock controller nodes
>   ARM: dts: add xxti and xusbxti fixed rate clock nodes for exynos4 based platforms
>   ARM: Exynos4: allow legacy board support to specify xxti and xusbxti clock speed
>   ARM: dts: add clock provider information for all controllers in Exynos4 SoC
>   ARM: Exynos4: remove auxdata table from machine file
>   ARM: Exynos: use fin_pll clock as the tick clock source for mct
>   ARM: Exynos: add support for mct clock setup
> 
>  .../devicetree/bindings/clock/exynos4-clock.txt    |  215 +++++++
>  arch/arm/boot/dts/exynos4.dtsi                     |   50 ++
>  arch/arm/boot/dts/exynos4210-origen.dts            |   12 +
>  arch/arm/boot/dts/exynos4210-smdkv310.dts          |   12 +
>  arch/arm/boot/dts/exynos4210.dtsi                  |    6 +
>  arch/arm/boot/dts/exynos4412-origen.dts            |   12 +
>  arch/arm/boot/dts/exynos4412-smdk4412.dts          |   12 +
>  arch/arm/boot/dts/exynos4x12.dtsi                  |    6 +
>  arch/arm/mach-exynos/Kconfig                       |    1 +
>  arch/arm/mach-exynos/Makefile                      |    3 -
>  arch/arm/mach-exynos/clock-exynos4.h               |   35 -
>  arch/arm/mach-exynos/clock-exynos4210.c            |  188 ------
>  arch/arm/mach-exynos/clock-exynos4212.c            |  192 ------
>  arch/arm/mach-exynos/common.c                      |   57 ++-
>  arch/arm/mach-exynos/common.h                      |   21 +-
>  arch/arm/mach-exynos/mach-armlex4210.c             |    3 +-
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |   72 +--
>  arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +-
>  arch/arm/mach-exynos/mach-nuri.c                   |    5 +-
>  arch/arm/mach-exynos/mach-origen.c                 |    5 +-
>  arch/arm/mach-exynos/mach-smdk4x12.c               |    5 +-
>  arch/arm/mach-exynos/mach-smdkv310.c               |    7 +-
>  arch/arm/mach-exynos/mach-universal_c210.c         |    3 +-
>  arch/arm/mach-exynos/mct.c                         |   32 +-
>  arch/arm/plat-samsung/Kconfig                      |    4 +-
>  drivers/clk/Makefile                               |    1 +
>  drivers/clk/samsung/Makefile                       |    6 +
>  drivers/clk/samsung/clk-exynos4.c                  |  655 ++++++++++++++++++++
>  drivers/clk/samsung/clk-pll.c                      |  400 ++++++++++++
>  drivers/clk/samsung/clk-pll.h                      |   38 ++
>  drivers/clk/samsung/clk.c                          |  180 ++++++
>  drivers/clk/samsung/clk.h                          |  216 +++++++
>  32 files changed, 1919 insertions(+), 537 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/exynos4-clock.txt
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4.h
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4210.c
>  delete mode 100644 arch/arm/mach-exynos/clock-exynos4212.c
>  create mode 100644 drivers/clk/samsung/Makefile
>  create mode 100644 drivers/clk/samsung/clk-exynos4.c
>  create mode 100644 drivers/clk/samsung/clk-pll.c
>  create mode 100644 drivers/clk/samsung/clk-pll.h
>  create mode 100644 drivers/clk/samsung/clk.c
>  create mode 100644 drivers/clk/samsung/clk.h

Thanks Thomas! The patch series generally looks good to me, I've tested 
it on an Exynos4412 based board. I have applied couple fixes that Tomasz
Figa has sent you off the mailing list. And to make a MIPI-CSI2 camera 
working a small fixup patch as below.

I have just one remark, but this could possibly be done as a follow up 
patch. Namely it may make sense to rename various sclk_* clocks to just
"sclk", so for instance we don't have "fimd", "sclk_fimd", "fimc", 
"sclk_fimc" but e.g. "bus" or "gate" and "sclk" for each device. Such 
naming might be better for handling devices at core subsystems level, 
e.g. Runtime PM or devfreq.

Please feel free to add:

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

I would be great to have this patch set merged for 3.9, so people can 
switch earlier to the common clock API, rather than modifying files 
that will be removed soon.

--

Regards,
Sylwester

>From 8382dcc93bf465e9a03f4f07426825f1a9be0ba1 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 18 Jan 2013 19:13:52 +0100
Subject: [PATCH] clk: samsung: Correct definition of sclk_cam gate clocks

sclk_cam0/1 clock gates are present on all exynos4 SoCs. Move
definitions of these clocks to proper table to reflect that.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 6bdb13b..9c3e106 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -299,6 +299,8 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 			0xc320, 24, CLK_SET_RATE_PARENT, 0, "sclk_csis"),
 	GATE_DA(sclk_csis1, "s5p-mipi-csis.1", "sclk_csis1", "div_csis1",
 			0xc320, 28, CLK_SET_RATE_PARENT, 0, "sclk_csis"),
+	GATE(sclk_cam0, "sclk_cam0", "div_cam0", 0xc820, 4, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_cam1, "sclk_cam1", "div_cam1", 0xc820, 5, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_hdmi, "sclk_hdmi", "mout_hdmi", 0xc324, 0, 0, 0),
 	GATE(sclk_mixer, "sclk_mixer", "mout_mixer", 0xc324, 4, 0, 0),
 	GATE(sclk_dac, "sclk_dac", "mout_dac", 0xc324, 8, 0, 0),
@@ -416,8 +418,6 @@ struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 			0xc338, 0, CLK_SET_RATE_PARENT, 0, "sclk_fimd"),
 	GATE(sclk_mipi1, "sclk_mipi1", "div_mipi_pre1", 0xc338, 12, CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_sata, "sclk_sata", "div_sata", 0xc340, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_cam0, "sclk_cam0", "div_cam0", 0xc820, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(sclk_cam1, "sclk_cam1", "div_cam1", 0xc820, 5, CLK_SET_RATE_PARENT, 0),
 	GATE(tvenc, "tvenc", "aclk160", 0xc924, 2, 0, 0),
 	GATE(g2d, "g2d", "aclk200", 0xc930, 0, 0, 0),
 	GATE(rotator, "rotator", "aclk200", 0xc930, 1, 0, 0),
-- 
1.7.9.5
