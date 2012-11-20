From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 15:31:12 +0100
Subject: [PATCH 4/8] clk: mvebu: armada 370/XP add clock gating control
 provider for DT
In-Reply-To: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353421876-13759-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353421876-13759-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 .../bindings/clock/mvebu-gated-clock.txt           |   43 ++++++++++++
 drivers/clk/mvebu/clk-gating-ctrl.c                |   74 +++++++++++++++++++-
 2 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
index 4ad8ccd..7337005 100644
--- a/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
+++ b/Documentation/devicetree/bindings/clock/mvebu-gated-clock.txt
@@ -6,6 +6,49 @@ the clock ID in its "clocks" phandle cell. The clock ID is directly mapped to
 the corresponding clock gating control bit in HW to ease manual clock lookup
 in datasheet.
 
+The following is a list of provided IDs for Armada 370:
+ID	Clock	Peripheral
+-----------------------------------
+0	Audio	AC97 Cntrl
+1	pex0_en	PCIe 0 Clock out
+2	pex1_en	PCIe 1 Clock out
+3	ge1	Gigabit Ethernet 1
+4	ge0	Gigabit Ethernet 0
+5	pex0	PCIe Cntrl 0
+9	pex1	PCIe Cntrl 1
+15	sata0	SATA Host 0
+17	sdio	SDHCI Host
+25	tdm	Time Division Mplx
+28	ddr	DDR Cntrl
+30	sata1	SATA Host 0
+
+The following is a list of provided IDs for Armada XP:
+ID	Clock	Peripheral
+-----------------------------------
+0	audio	Audio Cntrl
+1	ge3	Gigabit Ethernet 3
+2	ge2	Gigabit Ethernet 2
+3	ge1	Gigabit Ethernet 1
+4	ge0	Gigabit Ethernet 0
+5	pex0	PCIe Cntrl 0
+6	pex1	PCIe Cntrl 1
+7	pex2	PCIe Cntrl 2
+8	pex3	PCIe Cntrl 3
+13	bp
+14	sata0lnk
+15	sata0	SATA Host 0
+16	lcd	LCD Cntrl
+17	sdio	SDHCI Host
+18	usb0	USB Host 0
+19	usb1	USB Host 1
+20	usb2	USB Host 2
+22	xor0	XOR DMA 0
+23	crypto	CESA engine
+25	tdm	Time Division Mplx
+28	xor1	XOR DMA 1
+29	sata1lnk
+30	sata1	SATA Host 0
+
 The following is a list of provided IDs for Dove:
 ID	Clock	Peripheral
 -----------------------------------
diff --git a/drivers/clk/mvebu/clk-gating-ctrl.c b/drivers/clk/mvebu/clk-gating-ctrl.c
index fa69f87..c6d3c26 100644
--- a/drivers/clk/mvebu/clk-gating-ctrl.c
+++ b/drivers/clk/mvebu/clk-gating-ctrl.c
@@ -88,10 +88,21 @@ static void __init mvebu_clk_gating_setup(
 	}
 
 	for (n = 0; n < ctrl->num_gates; n++) {
+		u8 flags = 0;
 		const char *parent =
 			(descr[n].parent) ? descr[n].parent : default_parent;
+
+		/*
+		 * On Armada 370, the DDR clock is a special case: it
+		 * isn't taken by any driver, but should anyway be
+		 * kept enabled, so we mark it as IGNORE_UNUSED for
+		 * now.
+		 */
+		if (!strcmp(descr[n].name, "ddr"))
+			flags |= CLK_IGNORE_UNUSED;
+
 		ctrl->gates[n] = clk_register_gate(NULL, descr[n].name, parent,
-				   0, base, descr[n].bit_idx, 0, &ctrl->lock);
+				   flags, base, descr[n].bit_idx, 0, &ctrl->lock);
 		WARN_ON(IS_ERR(ctrl->gates[n]));
 	}
 	of_clk_add_provider(np, mvebu_clk_gating_get_src, ctrl);
@@ -101,6 +112,53 @@ static void __init mvebu_clk_gating_setup(
  * SoC specific clock gating control
  */
 
+#ifdef CONFIG_MACH_ARMADA_370
+static const struct mvebu_soc_descr __initconst armada_370_gating_descr[] = {
+	{ "audio", NULL, 0 },
+	{ "pex0_en", NULL, 1 },
+	{ "pex1_en", NULL,  2 },
+	{ "ge1", NULL, 3 },
+	{ "ge0", NULL, 4 },
+	{ "pex0", NULL, 5 },
+	{ "pex1", NULL, 9 },
+	{ "sata0", NULL, 15 },
+	{ "sdio", NULL, 17 },
+	{ "tdm", NULL, 25 },
+	{ "ddr", NULL, 28 },
+	{ "sata1", NULL, 30 },
+	{ }
+};
+#endif
+
+#ifdef CONFIG_MACH_ARMADA_XP
+static const struct mvebu_soc_descr __initconst armada_xp_gating_descr[] = {
+	{ "audio", NULL, 0 },
+	{ "ge3", NULL, 1 },
+	{ "ge2", NULL,  2 },
+	{ "ge1", NULL, 3 },
+	{ "ge0", NULL, 4 },
+	{ "pex0", NULL, 5 },
+	{ "pex1", NULL, 6 },
+	{ "pex2", NULL, 7 },
+	{ "pex3", NULL, 8 },
+	{ "bp", NULL, 13 },
+	{ "sata0lnk", NULL, 14 },
+	{ "sata0", "sata0lnk", 15 },
+	{ "lcd", NULL, 16 },
+	{ "sdio", NULL, 17 },
+	{ "usb0", NULL, 18 },
+	{ "usb1", NULL, 19 },
+	{ "usb2", NULL, 20 },
+	{ "xor0", NULL, 22 },
+	{ "crypto", NULL, 23 },
+	{ "tdm", NULL, 25 },
+	{ "xor1", NULL, 28 },
+	{ "sata1lnk", NULL, 29 },
+	{ "sata1", "sata1lnk", 30 },
+	{ }
+};
+#endif
+
 #ifdef CONFIG_ARCH_DOVE
 static const struct mvebu_soc_descr __initconst dove_gating_descr[] = {
 	{ "usb0", NULL, 0 },
@@ -147,6 +205,20 @@ static const struct mvebu_soc_descr __initconst kirkwood_gating_descr[] = {
 #endif
 
 static const __initdata struct of_device_id clk_gating_match[] = {
+#ifdef CONFIG_MACH_ARMADA_370
+	{
+		.compatible = "marvell,armada-370-gating-clock",
+		.data = armada_370_gating_descr,
+	},
+#endif
+
+#ifdef CONFIG_MACH_ARMADA_XP
+	{
+		.compatible = "marvell,armada-xp-gating-clock",
+		.data = armada_xp_gating_descr,
+	},
+#endif
+
 #ifdef CONFIG_ARCH_DOVE
 	{
 		.compatible = "marvell,dove-gating-clock",
-- 
1.7.9.5
