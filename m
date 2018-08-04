From: bp@alien8.de (Borislav Petkov)
Date: Sat, 4 Aug 2018 07:18:57 +0200
Subject: [PATCH v3 1/4] edac: synps: Add platform specific structures for
 ddrc controller
In-Reply-To: <1533214282-9977-2-git-send-email-manish.narani@xilinx.com>
References: <1533214282-9977-1-git-send-email-manish.narani@xilinx.com>
 <1533214282-9977-2-git-send-email-manish.narani@xilinx.com>
Message-ID: <20180804051857.GA3843@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 06:21:19PM +0530, Manish Narani wrote:
> This patch adds platform specific structures, so that we can add

"This patch" in a commit message is tautologically redundant.

> different IP support later using quirks.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/synopsys_edac.c | 64 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 53 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 0c9c59e..d4798e8 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  
>  #include "edac_module.h"
>  
> @@ -130,6 +131,7 @@ struct synps_ecc_status {
>   * @baseaddr:	Base address of the DDR controller
>   * @message:	Buffer for framing the event specific info
>   * @stat:	ECC status information
> + * @p_data:	Pointer to platform data
>   * @ce_cnt:	Correctable Error count
>   * @ue_cnt:	Uncorrectable Error count
>   */
> @@ -137,11 +139,29 @@ struct synps_edac_priv {
>  	void __iomem *baseaddr;
>  	char message[SYNPS_EDAC_MSG_SIZE];
>  	struct synps_ecc_status stat;
> +	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
>  };
>  
>  /**
> + * struct synps_platform_data -  synps platform data structure
> + * @synps_edac_geterror_info:	function pointer to synps edac error info
> + * @synps_edac_get_mtype:	function pointer to synps edac mtype
> + * @synps_edac_get_dtype:	function pointer to synps edac dtype
> + * @synps_edac_get_eccstate:	function pointer to synps edac eccstate
> + * @quirks:			to differentiate IPs
> + */
> +struct synps_platform_data {
> +	int (*synps_edac_geterror_info)(void __iomem *base,
> +					struct synps_ecc_status *p);
> +	enum mem_type (*synps_edac_get_mtype)(const void __iomem *base);
> +	enum dev_type (*synps_edac_get_dtype)(const void __iomem *base);
> +	bool (*synps_edac_get_eccstate)(void __iomem *base);
> +	int quirks;
> +};
> +
> +/**
>   * synps_edac_geterror_info - Get the current ecc error info
>   * @base:	Pointer to the base address of the ddr memory controller
>   * @p:		Pointer to the synopsys ecc status structure
> @@ -242,7 +262,8 @@ static void synps_edac_check(struct mem_ctl_info *mci)
>  	struct synps_edac_priv *priv = mci->pvt_info;
>  	int status;
>  
> -	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
> +	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
> +							&priv->stat);

Unnecessarily long line - shortening by renaming might help.

>  	if (status)
>  		return;
>  
> @@ -372,10 +393,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
>  		for (j = 0; j < csi->nr_channels; j++) {
>  			dimm            = csi->channels[j]->dimm;
>  			dimm->edac_mode = EDAC_FLAG_SECDED;
> -			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
> +			dimm->mtype     = priv->p_data->synps_edac_get_mtype(
> +						priv->baseaddr);

Ditto - that trailing opening brace at the end is just yucky. Shorten it
and let is stick out even if it longer than 80 cols.

>  			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
>  			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
> -			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
> +			dimm->dtype     = priv->p_data->synps_edac_get_dtype(
> +						priv->baseaddr);
>  		}
>  	}
>  
> @@ -423,6 +446,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	return status;
>  }
>  
> +static const struct synps_platform_data zynq_edac_def = {
> +	.synps_edac_geterror_info	= synps_edac_geterror_info,
> +	.synps_edac_get_mtype		= synps_edac_get_mtype,
> +	.synps_edac_get_dtype		= synps_edac_get_dtype,
> +	.synps_edac_get_eccstate	= synps_edac_get_eccstate,
> +	.quirks				= 0,

Drop the "synps_" prefix from the function pointer names and leave them
in the actual function names so that when one looks at the code, knows
what is what.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
