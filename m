From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 20 Nov 2018 13:59:07 -0700
Subject: [RFC PATCH 2/3] coresight: etmv4: Update ID register table to
 add UCI support
In-Reply-To: <20181115012842.2353-3-mike.leach@linaro.org>
References: <20181115012842.2353-1-mike.leach@linaro.org>
 <20181115012842.2353-3-mike.leach@linaro.org>
Message-ID: <20181120205907.GB17267@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 01:28:41AM +0000, Mike Leach wrote:
> Updates the ID register tables to contain a UCI entry for the A35 ETM
> device to allow correct matching of driver in the amba bus code.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 26 +++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 53e2fb6e86f6..1dcb7e14ea6b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1073,12 +1073,28 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		.mask	= 0x000fffff,		\
>  	}
>  
> +static struct amba_cs_uci_id uci_id_etm4[] = {
> +	{
> +		/*  ETMv4 UCI data */
> +		.devarch	= 0x00004a13,
> +		.mask		= 0x0000ffff,
> +		.devtype	= 0x00000013,
> +	}
> +};
> +
> +#define ETM4x_AMBA_UCI_ID(pid)			\
> +	{					\
> +		.id	= pid,			\
> +		.mask	= 0x000fffff,		\
> +		.data	= uci_id_etm4,		\
> +	}
> +
>  static const struct amba_id etm4_ids[] = {
> -	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
> -	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
> -	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
> -	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
> -	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
> +	ETM4x_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
> +	ETM4x_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
> +	ETM4x_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
> +	ETM4x_AMBA_ID(0x000bb959),			/* Cortex-A73 */

There is no need to add the extra tabulation for the above.

> +	ETM4x_AMBA_UCI_ID(0x000bb9da),			/* Cortex-A35 */
>  	{},
>  };
>  
> -- 
> 2.19.1
> 
