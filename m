From: valentin.longchamp@keymile.com (Valentin Longchamp)
Date: Tue,  7 May 2013 17:52:19 +0200
Subject: [PATCH 1/3] clk: mvebu: add gate ctrl for Prestera kirkwood variants
In-Reply-To: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
References: <1367941941-19152-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <1367941941-19152-2-git-send-email-valentin.longchamp@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kirkwood device found in the Prestera SoCs does not have all the
peripherals of its the usual kirkwood SoCs. There are hence missing
clocks in the SoCs.

This patch registers another gate controller for the kirkwood that
registers only the available clocks of this kirkwood variant.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 .../devicetree/bindings/clock/mvebu-gated-clock.txt   | 17 +++++++++++++++++
 drivers/clk/mvebu/clk-gating-ctrl.c                   | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index cffc93d..7f494e90 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -92,10 +92,27 @@ ID	Clock	Peripheral
 19	ge1	Gigabit Ethernet 1
 20	tdm	Time Division Mplx
 
+The following is a list of provided IDs for Kirkwood Prestera variant:
+ID	Clock	Peripheral
+-----------------------------------
+0	ge0	Gigabit Ethernet 0
+2	pex0	PCIe Cntrl 0
+3	usb0	USB Host 0
+4	sdio	SDIO Cntrl
+5	tsu	Transp. Stream Unit
+6	dunit	SDRAM Cntrl
+7	runit	Runit
+8	xor0	XOR DMA 0
+16	xor1	XOR DMA 1
+17	crypto	CESA engine
+19	ge1	Gigabit Ethernet 1
+
+
 Required properties:
 - compatible : shall be one of the following:
 	"marvell,dove-gating-clock" - for Dove SoC clock gating
 	"marvell,kirkwood-gating-clock" - for Kirkwood SoC clock gating
+	"marvell,prestera-kw-gating-clock" - for Preseta SoC clock gating
 - reg : shall be the register address of the Clock Gating Control register
 - #clock-cells : from common clock binding; shall be set to 1
 
diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index ebf141d..ba37802 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -203,6 +203,21 @@ static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
 	{ "tdm", NULL, 20 },
 	{ }
 };
+
+static const struct mvebu_soc_descr __initconst prestera_kw_gating_descr[] = {
+	{ "ge0", NULL, 0 },
+	{ "pex0", NULL, 2 },
+	{ "usb0", NULL, 3 },
+	{ "sdio", NULL, 4 },
+	{ "tsu", NULL, 5 },
+	{ "runit", NULL, 7 },
+	{ "xor0", NULL, 8 },
+	{ "powersave", "cpuclk", 11 },
+	{ "xor1", NULL, 16 },
+	{ "crypto", NULL, 17 },
+	{ "ge1", NULL, 19 },
+	{ }
+};
 #endif
 
 static const __initdata struct of_device_id clk_gating_match[] = {
@@ -232,6 +247,10 @@ static const __initdata struct of_device_id clk_gating_match[] = {
 		.compatible = "marvell,kirkwood-gating-clock",
 		.data = kirkwood_gating_descr,
 	},
+	{
+		.compatible = "marvell,prestera-kw-gating-clock",
+		.data = prestera_kw_gating_descr,
+	},
 #endif
 
 	{ }
-- 
1.8.0.1
