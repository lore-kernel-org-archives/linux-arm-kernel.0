From: hector.palacios@digi.com (Hector Palacios)
Date: Fri, 20 Sep 2013 15:50:23 +0200
Subject: mxsfb on i.MX28 uses bypassed ref_xtal 24MHz clock for LCD
In-Reply-To: <5196375A.1070308@digi.com>
References: <5196375A.1070308@digi.com>
Message-ID: <523C529F.4000300@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2013 03:57 PM, Hector Palacios wrote:
> Hello,
>
> I was testing the framebuffer on an i.MX28 based platform and found out that the lcdif
> clock is actually bypassed to use the ref_xtal of 24MHz, which makes the
> clk_set_rate() call in the driver useless (as well as the pixclock settings in
> fb_videomode variables in mach-mxs.c):
>
> static void mxsfb_enable_controller(struct fb_info *fb_info)
> {
>      struct mxsfb_info *host = to_imxfb_host(fb_info);
>      u32 reg;
>
>      dev_dbg(&host->pdev->dev, "%s\n", __func__);
>
>      clk_prepare_enable(host->clk);
>      clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
>
> This can easily be checked by probing the pixel clock signal.
> Is this known or did it go unnoticed because the supported displays work ok with the
> bypassed 24MHz frequency?
> If using a pixel clock below 24MHz, the divisor will round to 2 thus generating a
> 12MHz signal.

Going back to this, after a while. The lcdif clock hierarchy is the following:

ref_clk (24MHz)-----\
                      +--+ lcdif_sel (MUX type)
frac1_clk (480Mhz)--/   |
                         \--+ lcdif_div (DIV type)
                            |
                            \-- lcdif (GATE type)

The mxsfb driver retrieves the 'lcdif_div' clock from the DT, but the 'lcdif_sel' is 
by default sourced from 'ref_clk'. Since the driver doesn't know about the different 
clocks that can source its clk parent from, would it be acceptable to select the 
parent during the general clocks initialization?

diff --git a/drivers/clk/mxs/clk-imx28.c b/drivers/clk/mxs/clk-imx28.c
index fd17995..211b4d9 100644
--- a/drivers/clk/mxs/clk-imx28.c
+++ b/drivers/clk/mxs/clk-imx28.c
@@ -246,6 +246,12 @@ int __init mx28_clocks_init(void)
	clk_data.clk_num = ARRAY_SIZE(clks);
	of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);

+	/*
+	 * Select PLL as the parent source of lcdif_sel clk to have a finer
+	 * granularity when calculating the LCD pixelclock
+	 */
+	clk_set_parent(clks[lcdif_sel], clks[ref_pix]);
+
	clk_register_clkdev(clks[enet_out], NULL, "enet_out");

	for (i = 0; i < ARRAY_SIZE(clks_init_on); i++)


Without this, the pixelclock can only be a power of two divisor of 24MHz, and I need a 
20MHz signal, otherwise I see bad pixels in true color images on my LCD.

Best regards,
--
Hector Palacios
