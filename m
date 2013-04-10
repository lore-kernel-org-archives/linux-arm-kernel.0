From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 10 Apr 2013 13:03:17 +0200
Subject: [PATCH v2 01/11] ASoC: phycore-ac97: Add DT support
In-Reply-To: <516230E1.3070509@tabi.org>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-2-git-send-email-mpa@pengutronix.de>
 <516230E1.3070509@tabi.org>
Message-ID: <20130410110317.GA16749@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 07, 2013 at 09:52:17PM -0500, Timur Tabi wrote:
> Markus Pargmann wrote:
> >Notes:
> >    Changes in v2:
> >     - Simplify the driver, by combining audmux port configurations. The
> >       audmux driver actually knows on which platform he is running and
> >       will return the appropriate error code if we use functions for
> >       another platform. So we don't need to have the knowledge about it
> >       in phycore-ac97 and can try both functions. This removes the need
> >       of different compatibilities and renames it to imx27-ac97.
> >     - Use a phandle for the cpu_dai link.
> >     - Add devicetree binding documentation.
> >     - Rename binding to phytec,phycore-ac97 and fsl,ssi to phytec,ssi
> 
> I think some of this information belongs in the changelog.

Okay

> 
> >+#ifdef CONFIG_MACH_IMX27_DT
> >+		.platform_name	= "imx-fiq-pcm-audio",
> >+#else
> >  		.cpu_dai_name	= "imx-ssi.0",
> >  		.platform_name	= "imx-fiq-pcm-audio.0",
> >+#endif
> 
> What's the difference between "imx-fiq-pcm-audio" and "imx-fiq-pcm-audio.0"?

The previous version of phycore-ac97 was using devices created by the
board init code. They passed a proper pdev id which was used in all
drivers they created. Since fsl-ssi is using DT, that id is -1 and is
ignored for the device name. So we have to remove the .0 for DT here.
This driver is not used multiple times in one system, so it shouldn't be
a problem.

Regards,

Markus

> 
> -- 
> Timur Tabi
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
