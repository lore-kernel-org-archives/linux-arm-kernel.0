From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 12 Jun 2015 10:53:25 +0900
Subject: [PATCH v2] clk: exynos4: Fix wrong clock for Exynos4x12 ADC
Message-ID: <1434074005-18846-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TSADC gate clock was used in Exynos4x12 DTSI for exynos-adc driver.
However TSADC is present only on Exynos4210 so on Trats2 board (with
Exynos4412 SoC) the exynos-adc driver could not be probed:
   ERROR: could not get clock /adc at 126C0000:adc(0)
   exynos-adc 126c0000.adc: failed getting clock, err = -2
   exynos-adc: probe of 126c0000.adc failed with error -2

Instead on Exynos4x12 SoCs the main clock used by Analog to Digital
Converter is located in different register and it is named in datasheet
as PCLK_ADC. Regardless of the name the purpose of this PCLK_ADC clock
is the same as purpose of TSADC from Exynos4210.

The patch adds gate clock for Exynos4x12 using the proper register so
backward compatibility is preserved. This fixes the probe of exynos-adc
driver on Exynos4x12 boards and allows accessing sensors connected to it
on Trats2 board (ntc,ncp15wb473 AP and battery thermistors).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: <stable@vger.kernel.org>
Fixes: c63c57433003 ("ARM: dts: Add ADC's dt data to read raw data for exynos4x12")
Link: https://lkml.org/lkml/2015/6/11/85

---

Changes since v1:
1. After discussion on LKML this solution was chosen because it smaller,
   simpler, self-contained (one patch to fix issue) and maintains backward
   compatibility. Thanks to Javier Martinez Canillas and Tomasz Figa for
   valuable comments.
2. Dropped patch 2/2 because now it is not needed. The clock id "TSADC"
   will be used on all Exynos4 boards.
3. Added CC-stable.
---
 drivers/clk/samsung/clk-exynos4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 714d6ba782c8..f7890bf652e6 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -85,6 +85,7 @@
 #define DIV_PERIL4		0xc560
 #define DIV_PERIL5		0xc564
 #define E4X12_DIV_CAM1		0xc568
+#define E4X12_GATE_BUS_FSYS1	0xc744
 #define GATE_SCLK_CAM		0xc820
 #define GATE_IP_CAM		0xc920
 #define GATE_IP_TV		0xc924
@@ -1095,6 +1096,7 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 		0),
 	GATE(CLK_PPMUIMAGE, "ppmuimage", "aclk200", E4X12_GATE_IP_IMAGE, 9, 0,
 		0),
+	GATE(CLK_TSADC, "tsadc", "aclk133", E4X12_GATE_BUS_FSYS1, 16, 0, 0),
 	GATE(CLK_MIPI_HSI, "mipi_hsi", "aclk133", GATE_IP_FSYS, 10, 0, 0),
 	GATE(CLK_CHIPID, "chipid", "aclk100", E4X12_GATE_IP_PERIR, 0, 0, 0),
 	GATE(CLK_SYSREG, "sysreg", "aclk100", E4X12_GATE_IP_PERIR, 1,
-- 
1.9.1
