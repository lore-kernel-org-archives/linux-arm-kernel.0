From: Florian.Belser@sensor-technik.de (Belser Florian)
Date: Thu, 28 Nov 2013 07:55:08 +0000
Subject: [PATCH] IMX6: Add static /8 prescaler to can_root clock configuration
Message-ID: <5EC8D4ACC923FE4D871AFFACC9761279739BE8@stwexdb.stww2k.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

think I found a bug in the clk-imx6q.c source file. According to the reference manual the can_root clock isn't directly derived from the pll3_usb_otg clock. There is a static /8 divider instead.
Please refer to the imx6 application reference manual:
     i.MX 6Dual/6Quad Applications Processor Reference Manual, Rev. 0, 11/2012 --> Figure 18-3. Clock Tree - Part 2 (805)

Here is the patch:

--- linux-3.10.20/arch/arm/mach-imx/clk-imx6q.c.orig    2013-11-20 21:28:01.000000000 +0100
+++ linux-3.10.20/arch/arm/mach-imx/clk-imx6q.c    2013-11-28 08:18:47.379521587 +0100
@@ -424,7 +424,7 @@ int __init mx6q_clocks_init(void)
     clk[asrc_podf]        = imx_clk_divider("asrc_podf",        "asrc_pred",         base + 0x30, 9,  3);
     clk[spdif_pred]       = imx_clk_divider("spdif_pred",       "spdif_sel",         base + 0x30, 25, 3);
     clk[spdif_podf]       = imx_clk_divider("spdif_podf",       "spdif_pred",        base + 0x30, 22, 3);
-    clk[can_root]         = imx_clk_divider("can_root",         "pll3_usb_otg",      base + 0x20, 2,  6);
+    clk[can_root]         = imx_clk_divider("can_root",         "pll3_60m",          base + 0x20, 2,  6);
     clk[ecspi_root]       = imx_clk_divider("ecspi_root",       "pll3_60m",          base + 0x38, 19, 6);
     clk[gpu2d_core_podf]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
     clk[gpu3d_core_podf]  = imx_clk_divider("gpu3d_core_podf",  "gpu3d_core_sel",    base + 0x18, 26, 3);


Best regards,

Florian Belser
