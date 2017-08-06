From: bp@alien8.de (Borislav Petkov)
Date: Sun, 6 Aug 2017 07:18:30 +0200
Subject: [PATCH 1/5] edac: synopsys: Add platform specific structures
 ddrc controller
In-Reply-To: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
References: <60ff19f90adfd252cf296fe8988c614c4c3e43fd.1501848023.git.michal.simek@xilinx.com>
Message-ID: <20170806051830.GC28006@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 04, 2017 at 02:00:23PM +0200, Michal Simek wrote:
> From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

That subject:
 Subject: [PATCH 1/5] edac: synopsys: Add platform specific structures ddrc controller

doesn't read like a proper sentence to me.

> This patch adds platform specific structures, so that we can add

"This patch" in a commit message is tautologically redundant.

> different IP support later using quirks.
> 
> Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  drivers/edac/synopsys_edac.c | 70 ++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 58 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 1c01dec78ec3..65f3b04d5a87 100644
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
> @@ -95,6 +96,9 @@
>  #define SCRUB_MODE_MASK		0x7
>  #define SCRUB_MODE_SECDED	0x4
>  
> +/* DDR ECC Quirks */
> +#define DDR_ECC_INTR_SUPPORT    BIT(0)
> +
>  /**
>   * struct ecc_error_info - ECC error log information
>   * @row:	Row number
> @@ -130,6 +134,7 @@ struct synps_ecc_status {
>   * @baseaddr:	Base address of the DDR controller
>   * @message:	Buffer for framing the event specific info
>   * @stat:	ECC status information
> + * @p_data:	Pointer to platform data
>   * @ce_cnt:	Correctable Error count
>   * @ue_cnt:	Uncorrectable Error count
>   */
> @@ -137,11 +142,29 @@ struct synps_edac_priv {
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

"function pointer to" and then something, doesn't look like an optimal
explanation to me. How about:

"Function which returns the DIMM type"

and so on.

> + * @quirks:			to differentiate IPs
> + */
> +struct synps_platform_data {
> +	int (*synps_edac_geterror_info)(void __iomem *base,
> +					 struct synps_ecc_status *p);
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
> @@ -242,7 +265,8 @@ static void synps_edac_check(struct mem_ctl_info *mci)
>  	struct synps_edac_priv *priv = mci->pvt_info;
>  	int status;
>  
> -	status = synps_edac_geterror_info(priv->baseaddr, &priv->stat);
> +	status = priv->p_data->synps_edac_geterror_info(priv->baseaddr,
> +							&priv->stat);
>  	if (status)
>  		return;
>  
> @@ -372,10 +396,12 @@ static int synps_edac_init_csrows(struct mem_ctl_info *mci)
>  		for (j = 0; j < csi->nr_channels; j++) {
>  			dimm            = csi->channels[j]->dimm;
>  			dimm->edac_mode = EDAC_FLAG_SECDED;
> -			dimm->mtype     = synps_edac_get_mtype(priv->baseaddr);
> +			dimm->mtype     = priv->p_data->synps_edac_get_mtype(
> +						priv->baseaddr);
>  			dimm->nr_pages  = (size >> PAGE_SHIFT) / csi->nr_channels;
>  			dimm->grain     = SYNPS_EDAC_ERR_GRAIN;
> -			dimm->dtype     = synps_edac_get_dtype(priv->baseaddr);
> +			dimm->dtype     = priv->p_data->synps_edac_get_dtype(
> +						priv->baseaddr);
>  		}
>  	}
>  
> @@ -424,6 +450,21 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	return status;
>  }
>  
> +static const struct synps_platform_data zynq_edac_def = {
> +	.synps_edac_geterror_info	= synps_edac_geterror_info,
> +	.synps_edac_get_mtype		= synps_edac_get_mtype,
> +	.synps_edac_get_dtype		= synps_edac_get_dtype,
> +	.synps_edac_get_eccstate	= synps_edac_get_eccstate,
> +	.quirks				= 0,
> +};

Please make the actual function names and function pointer names
different. For example, the function pointer names don't need to have
the "synpc_" prefix as they're used all locally.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
