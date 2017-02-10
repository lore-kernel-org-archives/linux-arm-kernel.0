From: aisheng.dong@nxp.com (A.S. Dong)
Date: Fri, 10 Feb 2017 07:07:17 +0000
Subject: i.MX7 clock support broken
In-Reply-To: <20170210070341.7xjnim5nq37gvnlg@pengutronix.de>
References: <20170207142225.zitac2r7g3kvowjw@pengutronix.de>
 <DB5PR04MB1431EB280E8B9BA929FF006D80420@DB5PR04MB1431.eurprd04.prod.outlook.com>
 <20170210070341.7xjnim5nq37gvnlg@pengutronix.de>
Message-ID: <DB5PR04MB143139FA8AE3AB0246B771D780440@DB5PR04MB1431.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Friday, February 10, 2017 3:04 PM
> To: A.S. Dong
> Cc: linux-arm-kernel at lists.infradead.org; Shawn Guo; Fabio Estevam;
> kernel at pengutronix.de; Andy Duan; Frank Li
> Subject: Re: i.MX7 clock support broken
> 
> On Wed, Feb 08, 2017 at 04:47:06PM +0000, A.S. Dong wrote:
> > Hi Sascha,
> >
> > > -----Original Message-----
> > > From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> > > Sent: Tuesday, February 07, 2017 10:22 PM
> > > To: linux-arm-kernel at lists.infradead.org
> > > Cc: Shawn Guo; A.S. Dong; Fabio Estevam; kernel at pengutronix.de
> > > Subject: i.MX7 clock support broken
> > >
> > > Hi All,
> > >
> > > I recently adopted the i.MX7 clock tree from Linux to barebox and
> > > wondered why ethernet doesn't work.
> >
> > I just reproduced the issue on MX7D SDB board with latest upstream
> > kernel That kernel NULL point crash during boot on
> > fec_enet_open->..->phy_attach_direct.
> >
> > Not sure if the same as yours.
> > (Paste log at last)
> >
> > Andy,
> > Can you help check it?
> >
> > > I found out that the clock tree in Linux is quite different from
> > > what the reference manual describes and also quite different from
> > > the hardware I have on my desk. There are several clocks that only
> > > exist in the driver, but not in the actual hardware and also several
> > > clocks which are in hardware, but not in the driver.
> > >
> > > These clocks exist in the driver only, but not in the hardware:
> > >
> >
> > Please refer to secion 5.2.5 in RM.
> > They're LPCG gates.
> >
> > But I did notice some of them seem not find in RM.
> > e.g. IMX7D_ARM_A7_ROOT_CLK, IMX7D_ARM_M0_ROOT_CLK,
> IMX7D_SPDIF_ROOT_CLK ...
> >
> > It might be true that not all listed in RM as I see a Note " Not all
> > CCGRs are mapped " right upon Table 5-19.
> 
> Ok, I try to be more explicit:
> 
> The current clock driver controls ethernet gates at CCM_BASE + 0x44e0 and
> CCM_BASE + 0x44f0. These registers do not have any effect on the hardware.
> The real gate for enet1 is at CCM_BASE + 0x4700, also documented in the
> reference manual. Changing this register really has an effect on the
> hardware. Or to put it different: Ethernet won't work in the kernel when
> the (real) gates have not been previously enabled in the bootloader.
> 

Yes, i understand.
We was already checking it with our guys.

> 
> >
> > Overally the current imx7d clk driver in upstream seems intend to be
> > an initial version and may miss many local fix patches.
> >
> > You can also refer to:
> > http://git.freescale.com/git/cgit.cgi/imx/linux-imx.git/?h=imx_4.1.15_
> > 2.0.0_ga
> 
> This tree has the same bugs.
> 

Yes, I know. Thanks for report.

> Sascha
> 
> --
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

Regards
Dong Aisheng
