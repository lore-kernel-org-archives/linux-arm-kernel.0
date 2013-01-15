From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 15 Jan 2013 14:08:34 +0800
Subject: [PATCH v2 1/4] ARM i.MX6: use reserved bit for mxs phy clock gate
Message-ID: <1358230117-19443-1-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For mxs-phy user i.mx6q, the PHY's clock is controlled by
hardware automatically, the software only needs to enable it
at probe, disable it at remove. During the runtime,
we don't need to control it. So for the usbphy clk policy:

- Keep refcount for usbphy as clk framework needs to know if
it is off or on.
- Use reserved bit, in that case, clk_enable/disable will
only update refcount, but without any hardware effects.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
Changes for v2:
- Use reserved bit for usb phy clk control

 arch/arm/mach-imx/clk-imx6q.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 7f2c10c..85dcc89 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -208,8 +208,14 @@ int __init mx6q_clocks_init(void)
 	clk[pll7_usb_host] = imx_clk_pllv3(IMX_PLLV3_USB,	"pll7_usb_host","osc", base + 0x20, 0x3);
 	clk[pll8_mlb]      = imx_clk_pllv3(IMX_PLLV3_MLB,	"pll8_mlb",	"osc", base + 0xd0, 0x0);
 
-	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 6);
-	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 6);
+	/*
+	 * Bit 20 is the reserved and read-only bit, we do this only for:
+	 * - Do nothing for usbphy clk_enable/disable
+	 * - Keep refcount when do usbphy clk_enable/disable, in that case,
+	 * the clk framework can know the USB phy clk is on or off
+	 */
+	clk[usbphy1] = imx_clk_gate("usbphy1", "pll3_usb_otg", base + 0x10, 20);
+	clk[usbphy2] = imx_clk_gate("usbphy2", "pll7_usb_host", base + 0x20, 20);
 
 	clk[sata_ref] = imx_clk_fixed_factor("sata_ref", "pll6_enet", 1, 5);
 	clk[pcie_ref] = imx_clk_fixed_factor("pcie_ref", "pll6_enet", 1, 4);
-- 
1.7.0.4
