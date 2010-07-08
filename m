From: s-ghorai@ti.com (Ghorai, Sukumar)
Date: Thu, 8 Jul 2010 09:09:22 +0530
Subject: [PATCH 04/15] mmc: support embedded data field in mmc_host
In-Reply-To: <1278376666-3509-5-git-send-email-ohad@wizery.com>
References: <1278376666-3509-1-git-send-email-ohad@wizery.com>
	<1278376666-3509-5-git-send-email-ohad@wizery.com>
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C9B5@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> owner at vger.kernel.org] On Behalf Of Ohad Ben-Cohen
> Sent: Tuesday, July 06, 2010 6:08 AM
> To: linux-wireless at vger.kernel.org; linux-mmc at vger.kernel.org; linux-
> omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk;
> Chikkature Rajashekar, Madhusudhan; Luciano Coelho; akpm at linux-
> foundation.org; San Mehat; Ben-cohen, Ohad
> Subject: [PATCH 04/15] mmc: support embedded data field in mmc_host
> 
> From: Ohad Ben-Cohen <ohadb@ti.com>
> 
> Add support to set/get mmc_host private embedded
> data.
> 
> This is needed to allow software to dynamically
> create (and remove) SDIO functions which represents
> embedded SDIO devices.
> 
> Typically, it will be used to set the context of
> a driver that is creating a new SDIO function
> (and would then expect to be able to get that context
> back upon creation of the new sdio func).
> 
> Signed-off-by: Ohad Ben-Cohen <ohadb@ti.com>
> ---
>  drivers/mmc/core/Kconfig |    8 ++++++++
>  include/linux/mmc/host.h |   16 ++++++++++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/Kconfig b/drivers/mmc/core/Kconfig
> index bb22ffd..ab27eb3 100644
> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/mmc/core/Kconfig
> @@ -16,3 +16,11 @@ config MMC_UNSAFE_RESUME
> 
>  	  This option sets a default which can be overridden by the
>  	  module parameter "removable=0" or "removable=1".
> +
> +config MMC_EMBEDDED_SDIO
> +	boolean "MMC embedded SDIO device support"
> +	help
> +	  If you say Y here, support will be added for embedded SDIO
> +	  devices (e.g. hardwired embedded WLAN SDIO devices).
> +	  Such devices require software support for emulating
> +	  card detect events.
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f65913c..9a48486 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -209,6 +209,10 @@ struct mmc_host {
>  	struct led_trigger	*led;		/* activity led */
>  #endif
> 
> +#ifdef CONFIG_MMC_EMBEDDED_SDIO
> +	void			*embedded_data;
> +#endif
> +
>  	struct dentry		*debugfs_root;
> 
>  	unsigned long		private[0] ____cacheline_aligned;
> @@ -264,5 +268,17 @@ static inline void mmc_set_disable_delay(struct
> mmc_host *host,
>  	host->disable_delay = disable_delay;
>  }
> 
> +#ifdef CONFIG_MMC_EMBEDDED_SDIO
> +static inline void *mmc_get_embedded_data(struct mmc_host *host)
> +{
> +	return host->embedded_data;
> +}
> +
> +static inline void mmc_set_embedded_data(struct mmc_host *host, void
> *data)
> +{
> +	host->embedded_data = data;
> +}
> +#endif
> +
[Ghorai] we can avoid CONFIG_MMC_EMBEDDED_SDIO flag itself. Why we are passing fixed data? We can enquire form card for the functions, features,.. and at runtime itself. And we are adding many compile-time/kconfig options in this patch series.
>  #endif
> 
> --
> 1.7.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
