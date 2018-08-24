From: roy.pledge@nxp.com (Roy Pledge)
Date: Fri, 24 Aug 2018 14:53:56 +0000
Subject: [PATCH 2/2] soc: fsl: qbman: qman: avoid allocating from non
 existing gen_pool
References: <20180823213600.23426-1-alexandre.belloni@bootlin.com>
 <20180823213600.23426-2-alexandre.belloni@bootlin.com>
Message-ID: <DB6PR0402MB272745FC786675AB113E7C7986360@DB6PR0402MB2727.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/23/2018 5:36 PM, Alexandre Belloni wrote:
> If the qman driver didn't probe, calling qman_alloc_fqid_range,
> qman_alloc_pool_range or qman_alloc_cgrid_range (as done in dpaa_eth) will
> pass a NULL pointer to gen_pool_alloc, leading to a NULL pointer
> dereference.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
> index ecb22749df0b..8cc015183043 100644
> --- a/drivers/soc/fsl/qbman/qman.c
> +++ b/drivers/soc/fsl/qbman/qman.c
> @@ -2729,6 +2729,9 @@ static int qman_alloc_range(struct gen_pool *p, u32 *result, u32 cnt)
>  {
>  	unsigned long addr;
>  
> +	if (!p)
> +		return -ENODEV;
> +
>  	addr = gen_pool_alloc(p, cnt);
>  	if (!addr)
>  		return -ENOMEM;

Reviewed-by: Roy Pledge <roy.pledge@nxp.com>
