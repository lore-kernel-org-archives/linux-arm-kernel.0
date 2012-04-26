From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 26 Apr 2012 14:57:02 +0800
Subject: [PATCH 33/33] ARM: i.MX6: implement clocks using common clock
 framework
In-Reply-To: <20120426064150.GE3852@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-34-git-send-email-s.hauer@pengutronix.de>
 <20120426024837.GD28063@b20223-02.ap.freescale.net>
 <20120426064150.GE3852@pengutronix.de>
Message-ID: <20120426065701.GH28063@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 08:41:50AM +0200, Sascha Hauer wrote:
> On Thu, Apr 26, 2012 at 10:48:38AM +0800, Richard Zhao wrote:
> > The below code is removed from mx6q_clocks_init implicitly.
> > Why? If it's reasonable, it needs to be on a separate patch too.
> > 
> > /* only keep necessary clocks on */
> > writel_relaxed(0x3 << CG0  | 0x3 << CG1  | 0x3 << CG2,  CCGR0);
> > writel_relaxed(0x3 << CG8  | 0x3 << CG9  | 0x3 << CG10, CCGR2);
> > writel_relaxed(0x3 << CG10 | 0x3 << CG12,               CCGR3);
> > writel_relaxed(0x3 << CG4  | 0x3 << CG6  | 0x3 << CG7,  CCGR4);
> > writel_relaxed(0x3 << CG0,                              CCGR5);
> > writel_relaxed(0,                                       CCGR6);
> > writel_relaxed(0,                                       CCGR7);
> 
> The clock framework will turn them off automatically.
> For the first time the hardware state will be consistent with the
> software state. Hurray!
> 
> > 
> > clk_enable(&uart_clk);
> 
> This is not needed anymore. For the early debug case we depend on the
> uart being enabled by the bootloader anyway, so it's safe to assume that
> the clock is turned on also. Otherwise the uart driver turns on this
> clock when needed.
> 
> > clk_enable(&mmdc_ch0_axi_clk);
> 
> This reminds me on something. This clock is turned on in the loop around
> clks_init_on. Since we now have pointers to each clock we don't need the
> clk_get_sys() anymore but can use the pointers directly. Will fix this
> one.
> 
> > 
> > clk_set_rate(&pll4_audio, FREQ_650M);
> > clk_set_rate(&pll5_video, FREQ_650M);
> > clk_set_parent(&ipu1_di0_clk, &ipu1_di0_pre_clk);
> > clk_set_parent(&ipu1_di0_pre_clk, &pll5_video);
> > clk_set_parent(&gpu3d_shader_clk, &pll2_pfd_594m);
> > clk_set_rate(&gpu3d_shader_clk, FREQ_594M);
> > clk_set_parent(&gpu3d_core_clk, &mmdc_ch0_axi_clk);
> > clk_set_rate(&gpu3d_core_clk, FREQ_528M);
> > clk_set_parent(&asrc_serial_clk, &pll3_usb_otg);
> > clk_set_rate(&asrc_serial_clk, 1500000);
> > clk_set_rate(&enfc_clk, 11000000);
> > 
> > /*
> >  * Before pinctrl API is available, we have to rely on the pad
> >  * configuration set up by bootloader.  For usdhc example here,
> >  * u-boot sets up the pads for 49.5 MHz case, and we have to lower
> >  * the usdhc clock from 198 to 49.5 MHz to match the pad configuration.
> >  *
> >  * FIXME: This is should be removed after pinctrl API is available.
> >  * At that time, usdhc driver can call pinctrl API to change pad
> >  * configuration dynamically per different usdhc clock settings.
> >  */
> > clk_set_rate(&usdhc1_clk, 49500000);
> > clk_set_rate(&usdhc2_clk, 49500000);
> > clk_set_rate(&usdhc3_clk, 49500000);
> > clk_set_rate(&usdhc4_clk, 49500000);
> 
> Can't say anything to these, probably Shawn has simply lost them while
> porting.
> 
> > 
> > clk_set_parent(&cko1_clk, &ahb_clk);
> 
> Why this? The cko pin has different usecases on each board, mostly I
> think for debugging. We shouldn't touch it here.
clko1's used by audio codec on many boards.
Do you/Shawn think I can add board specific code here with
of_machine_is_compatible? I need to add audio codec clkdev. Other places
can not get clk pointers.

Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
