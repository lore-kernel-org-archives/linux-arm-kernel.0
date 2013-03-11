From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 11 Mar 2013 17:18:49 +0530
Subject: [PATCH v8 3/7] ARM: davinci: Add support for configuring
 DA8XX_REMOTEPROC
In-Reply-To: <1362782508-3166-4-git-send-email-rtivy@ti.com>
References: <1362782508-3166-1-git-send-email-rtivy@ti.com>
 <1362782508-3166-4-git-send-email-rtivy@ti.com>
Message-ID: <513DC4A1.8020700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 3/9/2013 4:11 AM, Robert Tivy wrote:
> Also fix REMOTEPROC config to select FW_LOADER (instead of FW_CONFIG).

It is preferable to have the patch description make sense standalone
even when read without the subject line.

> 
> Signed-off-by: Robert Tivy <rtivy@ti.com>

Please follow the subject line conventions of the subsystem the patch is
touching. This is not an ARM patch so the "ARM: davinci: " prefix in
subject is surely wrong.

And I think I mentioned this once before but we want to see
Kconfig/Makefile changes along with driver addition in the same patch.

> ---
>  drivers/remoteproc/Kconfig |   26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 96ce101..21d04f1 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -5,7 +5,7 @@ config REMOTEPROC
>  	tristate
>  	depends on EXPERIMENTAL
>  	depends on HAS_DMA
> -	select FW_CONFIG
> +	select FW_LOADER
>  	select VIRTIO
>  
>  config OMAP_REMOTEPROC
> @@ -41,4 +41,28 @@ config STE_MODEM_RPROC
>  	  This can be either built-in or a loadable module.
>  	  If unsure say N.
>  
> +config DA8XX_REMOTEPROC
> +	tristate "DA830/OMAPL137 & DA850/OMAPL138 remoteproc support (EXPERIMENTAL)"
> +	depends on ARCH_DAVINCI_DA8XX
> +	select REMOTEPROC
> +	select RPMSG
> +	select CMA

Its nice to keep the selects sorted. It helps avoid duplicates.

> +	default n

No need of this I think, it should default to no already.

> +	help
> +	  Say y here to support DA830/OMAPL137 & DA850/OMAPL138 remote
> +	  processors via the remote processor framework.
> +
> +	  You want to say y here in order to enable AMP
> +	  use-cases to run on your platform (multimedia codecs are
> +	  offloaded to remote DSP processors using this framework).
> +
> +	  This module controls the name of the firmware file that gets
> +	  loaded on the DSP.  This file must reside in the /lib/firmware
> +	  directory.  It can be specified via the module parameter
> +	  da8xx_fw_name=<filename>, and if not specified will default to
> +	  "rproc-dsp-fw".

I hope running modinfo gives these details as well.

> +
> +	  It's safe to say n here if you're not interested in multimedia
> +	  offloading or just want a bare minimum kernel.

I think this is misleading a bit since just selecting 'n' here will not
result in a "bare minimum kernel" - better to just avoid mention of it.

Thanks,
Sekhar
