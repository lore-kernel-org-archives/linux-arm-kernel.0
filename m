From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Apr 2015 20:57:36 +0200
Subject: [PATCH 1/1] ARM: imx: make the imx timer driver implementation
 independent of SoCs.
In-Reply-To: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
References: <1430316881-4668-1-git-send-email-shenwei.wang@freescale.com>
Message-ID: <20150429185736.GA27777@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 09:14:41AM -0500, Shenwei Wang wrote:
> There are 4 versions of the timer hardware on Freescale MXC hardware.
> --Version 0: MX1/MXL
> --Version 1: MX21, MX27.
> --Version 2: MX25, MX31, MX35, MX37, MX51, MX6Q
> --Version 3: MX6DL, MX6SX
> 
> This patch has removed the SoC related codes, and implemented the driver
> directly upon the hardware timer IP version.
> 
> The new driver can be installed via device tree or the direct function
> call to mxc_timer_init in order to support imx legacy systems like MX21
> and MX27.
> 
> For the device tree implementation, the driver is compatible with the current
> bindings like "fsl,imx6q-gpt", but for future dts file, the string like
> "fsl,imx-gpt-v2" without SoC information is recommended.

[...]

> +
> +CLOCKSOURCE_OF_DECLARE(mx_timer_v0, "fsl,imx-gpt-v0", mxc_timer_init_dt);
> +CLOCKSOURCE_OF_DECLARE(mx_timer_v1, "fsl,imx-gpt-v1", mxc_timer_init_dt);
> +CLOCKSOURCE_OF_DECLARE(mx_timer_v2, "fsl,imx-gpt-v2", mxc_timer_init_dt);
> +CLOCKSOURCE_OF_DECLARE(mx_timer_v3, "fsl,imx-gpt-v3", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx1_timer, "fsl,imx1-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx25_timer, "fsl,imx25-gpt", mxc_timer_init_dt);
>  CLOCKSOURCE_OF_DECLARE(mx50_timer, "fsl,imx50-gpt", mxc_timer_init_dt);

Don't make it more complicated than it is. Instead of using
mxc_timer_init_dt for all different timers and dispatch the different
versions later introduce mxc_timer_init_v[0123] and put this directly
into the function callbacks here.

Overall this patch has much too many changes in it. It changes the
compatible entries, changes the implementation, splits the two timer
versions into four, changes the scope of the clockevent_mode variable
and renames it to last_mode. This should be split up into different
patches.

I don't like these fsl,imx-gpt-vx compatibles at all. They seem to be
pretty useless since all device trees already have a oldest compatible
version as second compatible entry. There's no need to create new
compatibles.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
