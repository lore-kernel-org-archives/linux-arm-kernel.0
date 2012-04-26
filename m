From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 Apr 2012 15:42:08 +0800
Subject: [PATCH 33/33] ARM: i.MX6: implement clocks using common clock
 framework
In-Reply-To: <20120426064150.GE3852@pengutronix.de>
References: <1335367703-19929-1-git-send-email-s.hauer@pengutronix.de>
 <1335367703-19929-34-git-send-email-s.hauer@pengutronix.de>
 <20120426024837.GD28063@b20223-02.ap.freescale.net>
 <20120426064150.GE3852@pengutronix.de>
Message-ID: <20120426074205.GA2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 08:41:50AM +0200, Sascha Hauer wrote:
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

I copied these from Freescale internal BSP when I was creating the file,
but did not really think about if we need them or not, so I took the
chance to clean them up.  From my testing, I haven't observed any
problem with in-tree imx6 drivers.

Basically, I do not to mess up the soc clock init with too much driver
specific stuff there.  Unless we are back to the corner, individual
driver should set up its clock properly with clk API.

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
I dropped it on purpose.  This quick hack made by me is actually broken.
Whenever bootloader changes the pad setting, we have problem here.  So
before pinctrl support is available bootloader should be responsible
for setting pad and clock in the correct pair.

-- 
Regards,
Shawn
