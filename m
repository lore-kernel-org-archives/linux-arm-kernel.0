From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 00:25:50 -0700
Subject: [PATCH] clk: imx: clk-imx6ul: allow lcdif_pre_sel to change
 parent rate
In-Reply-To: <20171012132935.3508-1-p.zabel@pengutronix.de>
References: <20171012132935.3508-1-p.zabel@pengutronix.de>
Message-ID: <20171102072550.GQ30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/12, Philipp Zabel wrote:
> Allowing the lcdif_pre_sel to propagate rate changes to its parent PLL
> allows more fine grained control over the LCDIF pixel clock rate.
> 
> For example, the Innovision AT043TN24 LCD panel described in the
> imx6ul-14x14-evk device tree requires a 9 MHz pixel clock.
> Before this patch, the lcdif_pre_sel clock rate is fixed, and just
> setting the lcdif_pred and lcdif_podf dividers only allows to get as
> close as about 8.44 MHz:
> 
>     pll3                                  1            1   480000000 0 0
>        pll3_bypass                        1            1   480000000 0 0
> 	  pll3_usb_otg                    1            1   480000000 0 0
> 	     pll3_pfd1_540m               1            1   540000000 0 0
> 		lcdif_pre_sel             1            1   540000000 0 0
> 		   lcdif_pred             1            1    67500000 0 0
> 		      lcdif_podf           1            1     8437500 0 0
> 			 lcdif_pix           1            1     8437500 0 0
> 
> Once lcdif_pre_sel is allowed to propagate rate requests to its parent,
> the actual pixel clock matches the requested value:
> 
>     pll3                                  1            1   480000000 0 0
>        pll3_bypass                        1            1   480000000 0 0
> 	  pll3_usb_otg                    1            1   480000000 0 0
> 	     pll3_pfd1_540m               1            1   288000000 0 0
> 		lcdif_pre_sel             1            1   288000000 0 0
> 		   lcdif_pred             1            1    36000000 0 0
> 		      lcdif_podf           1            1     9000000 0 0
>                          lcdif_pix           1            1     9000000 0 0
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
