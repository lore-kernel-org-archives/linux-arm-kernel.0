From: B04825@freescale.com (Tabi Timur-B04825)
Date: Fri, 16 Mar 2012 03:53:39 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <20120316025219.GB7632@S2101-09.ap.freescale.net>
References: <20120309013216.GH2499@S2101-09.ap.freescale.net>
 <4F5FD706.8040209@freescale.com>
 <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
 <20120316025219.GB7632@S2101-09.ap.freescale.net>
Message-ID: <4F62B941.5010306@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> So something like this?
>
>          /*
>           * If codec-handle property is missing from SSI node, we assume
>           * that the machine driver uses new binding which does not require
>           * SSI driver to trigger machine driver's probe.
>           */
>          if (!of_get_property(np, "codec-handle", NULL)) {
>                  if (ssi_private->ssi_on_imx) {
>                          ssi_private->imx_pcm_pdev =
>                                  platform_device_register_simple("imx-pcm-audio",
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
> It does not reduce any reference to "imx" actually.  If you think it's
> worth another iteration of the series, I will post v5 for it.

I had something more like this in mind:

         /*
          * If codec-handle property is missing from SSI node, we assume
          * that the machine driver uses new binding which does not require
          * SSI driver to trigger machine driver's probe.
          */
         if (!of_get_property(np, "codec-handle", NULL))
		ssi_private->new_binding = true;


	if (ssi_private->ssi_on_imx) {
                 ssi_private->imx_pcm_pdev =
                 	platform_device_register_simple("imx-pcm-audio",
                                                                 -1, NULL, 0);
                         if (IS_ERR(ssi_private->imx_pcm_pdev)) {
                                 ret = PTR_ERR(ssi_private->imx_pcm_pdev);
                                 goto error_dev;
                         }
                 }
                 /* success for new binding case */
                 return 0;
         }

Well, it's not perfect, but the idea is that we keep track of new vs. old 
binding separately from imx vs. powerpc.  Although I'm thinking there 
might be a way to general the call to platform_device_register_simple. 
Maybe we could put "imx-pcm-audio" in the device tree?

-- 
Timur Tabi
Linux kernel developer at Freescale
