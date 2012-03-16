From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 16 Mar 2012 12:05:11 +0800
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F62B941.5010306@freescale.com>
References: <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
 <20120316025219.GB7632@S2101-09.ap.freescale.net>
 <4F62B941.5010306@freescale.com>
Message-ID: <20120316040509.GA7758@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 03:53:39AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > So something like this?
> >
> >          /*
> >           * If codec-handle property is missing from SSI node, we assume
> >           * that the machine driver uses new binding which does not require
> >           * SSI driver to trigger machine driver's probe.
> >           */
> >          if (!of_get_property(np, "codec-handle", NULL)) {
> >                  if (ssi_private->ssi_on_imx) {
> >                          ssi_private->imx_pcm_pdev =
> >                                  platform_device_register_simple("imx-pcm-audio",
> >                                                                  -1, NULL, 0);
> >                          if (IS_ERR(ssi_private->imx_pcm_pdev)) {
> >                                  ret = PTR_ERR(ssi_private->imx_pcm_pdev);
> >                                  goto error_dev;
> >                          }
> >                  }
> >                  /* success for new binding case */
> >                  return 0;
> >          }
> >
> > It does not reduce any reference to "imx" actually.  If you think it's
> > worth another iteration of the series, I will post v5 for it.
> 
> I had something more like this in mind:
> 
>          /*
>           * If codec-handle property is missing from SSI node, we assume
>           * that the machine driver uses new binding which does not require
>           * SSI driver to trigger machine driver's probe.
>           */
>          if (!of_get_property(np, "codec-handle", NULL))
> 		ssi_private->new_binding = true;
> 
> 
> 	if (ssi_private->ssi_on_imx) {
>                  ssi_private->imx_pcm_pdev =
>                  	platform_device_register_simple("imx-pcm-audio",
>                                                                  -1, NULL, 0);
>                          if (IS_ERR(ssi_private->imx_pcm_pdev)) {
>                                  ret = PTR_ERR(ssi_private->imx_pcm_pdev);
>                                  goto error_dev;
>                          }
>                  }
>                  /* success for new binding case */
>                  return 0;
>          }
> 
> Well, it's not perfect, but the idea is that we keep track of new vs. old 
> binding separately from imx vs. powerpc.

Fine with me.

> Although I'm thinking there 
> might be a way to general the call to platform_device_register_simple. 
> Maybe we could put "imx-pcm-audio" in the device tree?
> 
It seems a little bit abuse of device tree to me.  My first choice was
to do that in imx-sgtl5000 machine driver.  But Mark disagrees.

-- 
Regards,
Shawn
