From: Shenwei.Wang@freescale.com (Shenwei Wang)
Date: Wed, 29 Apr 2015 19:56:57 +0000
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <20150429185736.GA27777@pengutronix.de>
References: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
 <20150429185736.GA27777@pengutronix.de>
Message-ID: <BL2PR03MB370C3AEE0CB1200EDDDD0FE83D70@BL2PR03MB370.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sacha,

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: 2015?4?29? 13:58
> To: Wang Shenwei-B38339
> Cc: shawn.guo at linaro.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
> independent of SoCs.
> 
> On Wed, Apr 29, 2015 at 09:14:41AM -0500, Shenwei Wang wrote:
> > There are 4 versions of the timer hardware on Freescale MXC hardware.
> > --Version 0: MX1/MXL
> > --Version 1: MX21, MX27.
> > --Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q --Version 3: MX6DL,
> > MX6SX
> >
> > This patch has removed the SoC related codes, and implemented the
> > driver directly upon the hardware timer IP version.
> >
> > The new driver can be installed via device tree or the direct function
> > call to mxc_timer_init in order to support imx legacy systems like
> > MX21 and MX27.
> >
> > For the device tree implementation, the driver is compatible with the
> > current bindings like "fsl,imx6q-gpt", but for future dts file, the
> > string like "fsl,imx-gpt-v2" without SoC information is recommended.
> 
> [...]
> 
> > +
> > +CLOCKSOURCE_OF_DECLARE(mx_timer_v0, "fsl,imx-gpt-v0",
> > +mxc_timer_init_dt); CLOCKSOURCE_OF_DECLARE(mx_timer_v1,
> > +"fsl,imx-gpt-v1", mxc_timer_init_dt);
> > +CLOCKSOURCE_OF_DECLARE(mx_timer_v2, "fsl,imx-gpt-v2",
> > +mxc_timer_init_dt); CLOCKSOURCE_OF_DECLARE(mx_timer_v3,
> > +"fsl,imx-gpt-v3", mxc_timer_init_dt);
> >  CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
> > CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt",
> > mxc_timer_init_dt);  CLOCKSOURCE_OF_DECLARE(mx50_timer,
> > "fsl,imx50-gpt", mxc_timer_init_dt);
> 
> Don't make it more complicated than it is. Instead of using mxc_timer_init_dt for
> all different timers and dispatch the different versions later introduce
> mxc_timer_init_v[0123] and put this directly into the function callbacks here.
> 
> Overall this patch has much too many changes in it. It changes the compatible
> entries, changes the implementation, splits the two timer versions into four,
> changes the scope of the clockevent_mode variable and renames it to last_mode.
> This should be split up into different patches.
> 
The patch did create some trouble for review. I am going to split it into several small patches.


> I don't like these fsl,imx-gpt-vx compatibles at all. They seem to be pretty useless
> since all device trees already have a oldest compatible version as second
> compatible entry. There's no need to create new compatibles.
> 
The second compatible string is useless at all in this case. Because the driver will only run correctly 
on the specified version of IP block. For example, you can not specify a compatible string of "fsl,imx25-gpt"
in imx6sx dts file and then suppose it could work on the imx6sx platform. There are still some real needs to
let the version of the IP block. For example, there are two revisions of imx6q SoCs. One revision has a v2 timer 
IP block, and the other revision has a v3 one. Since both revisions are imx6q, one way has to be selected to 
identify them. So I don't think it is useless. "fsl,imx-gpt-vx" is not a beautiful name, but I think it is a better 
name than the current one.

Shenwei


> Sascha
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
