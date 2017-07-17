From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 17 Jul 2017 14:43:49 +0100
Subject: [PATCH 6/7] staging: fsl-mc: rewrite mc command send/receive to
 work on 32-bits
In-Reply-To: <20170717132646.3020-7-laurentiu.tudor@nxp.com>
References: <20170717132646.3020-1-laurentiu.tudor@nxp.com>
 <20170717132646.3020-7-laurentiu.tudor@nxp.com>
Message-ID: <59364128-679b-2ea8-9838-62e9bd5f5a7e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/17 14:26, laurentiu.tudor at nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Split the 64-bit accesses in 32-bit accesses because there's no real
> constrain in MC to do only atomic 64-bit. There's only one place
> where ordering is important: when writing the MC command header the
> first 32-bit part of the header must be written last.
> We do this switch in order to allow compiling the driver on 32-bit.

#include <linux/io-64-nonatomic-hi-lo.h>

Then you can just use writeq()/writeq_relaxed()/readq_relaxed() on
32-bit platforms as well.

Robin.

> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/staging/fsl-mc/bus/mc-sys.c | 31 ++++++++++++-------------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/staging/fsl-mc/bus/mc-sys.c b/drivers/staging/fsl-mc/bus/mc-sys.c
> index 195d9f3..dd2828e 100644
> --- a/drivers/staging/fsl-mc/bus/mc-sys.c
> +++ b/drivers/staging/fsl-mc/bus/mc-sys.c
> @@ -124,14 +124,15 @@ static inline void mc_write_command(struct mc_command __iomem *portal,
>  {
>  	int i;
>  
> -	/* copy command parameters into the portal */
> -	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
> -		__raw_writeq(cmd->params[i], &portal->params[i]);
> -	/* ensure command params are committed before submitting it */
> -	wmb();
> -
> -	/* submit the command by writing the header */
> -	__raw_writeq(cmd->header, &portal->header);
> +	/*
> +	 * copy command parameters into the portal. Final write
> +	 * triggers the submission of the command.
> +	 */
> +	for (i = sizeof(struct mc_command) / sizeof(u32) - 1; i >= 0; i--) {
> +		__raw_writel(((u32 *)cmd)[i], &((u32 *)portal)[i]);
> +		/* ensure command params are committed before submitting it */
> +		wmb();
> +	}
>  }
>  
>  /**
> @@ -148,19 +149,11 @@ static inline enum mc_cmd_status mc_read_response(struct mc_command __iomem *
>  						  struct mc_command *resp)
>  {
>  	int i;
> -	enum mc_cmd_status status;
> -
> -	/* Copy command response header from MC portal: */
> -	resp->header = __raw_readq(&portal->header);
> -	status = mc_cmd_hdr_read_status(resp);
> -	if (status != MC_CMD_STATUS_OK)
> -		return status;
>  
> -	/* Copy command response data from MC portal: */
> -	for (i = 0; i < MC_CMD_NUM_OF_PARAMS; i++)
> -		resp->params[i] = __raw_readq(&portal->params[i]);
> +	for (i = 0; i < sizeof(struct mc_command) / sizeof(u32); i++)
> +		((u32 *)resp)[i] = __raw_readl(&((u32 *)portal)[i]);
>  
> -	return status;
> +	return mc_cmd_hdr_read_status(resp);
>  }
>  
>  /**
> 
