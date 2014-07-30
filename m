From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 30 Jul 2014 09:52:45 -0500
Subject: [PATCH net v3 6/6] net: stmmac: squelch sparse warning with casts
In-Reply-To: <1406671607-27368-7-git-send-email-vbridgers2013@gmail.com>
References: <1406671607-27368-1-git-send-email-vbridgers2013@gmail.com>
 <1406671607-27368-7-git-send-email-vbridgers2013@gmail.com>
Message-ID: <1406731965.23841.2.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vince,

On Tue, 2014-07-29 at 17:06 -0500, Vince Bridgers wrote:
> Add casts to squelch the following sparse warnings so we can see
> the ones that matter when they occur.
> 
> stmmac_platform.c:260:20: warning: incorrect type in argument 1
> 			  (different address spaces)
> stmmac_platform.c:260:20:    expected void const *static extern
> 			  [signed] [long] [typedef] [tls] inline [safe] ptr
> stmmac_platform.c:260:20:    got void [noderef] <asn:2>*[assigned] addr
> stmmac_platform.c:261:32: warning: incorrect type in argument 1
> 			  (different address spaces)
> stmmac_platform.c:261:32:    expected void const *static extern
> 			  [signed] [long] [typedef] [tls] inline [safe] ptr
> stmmac_platform.c:261:32:    got void [noderef] <asn:2>*[assigned] addr
> 


I think you should update your sparse. I have 0.5.0 and the only sparse
warnings for stmmac are:

drivers/net/ethernet/stmicro/stmmac/enh_desc.c:381:30: warning: symbol
'enh_desc_ops' was not declared. Should it be static?
drivers/net/ethernet/stmicro/stmmac/norm_desc.c:253:30: warning: symbol
'ndesc_ops' was not declared. Should it be static?
drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c:128:29: warning:
symbol 'socfpga_gmac_data' was not declared. Should it be static?
drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c:141:33: warning:
symbol 'stmmac_ptp' was not declared. Should it be static?


Dinh
> Signed-off-by: Vince Bridgers <vbridgers2013@gmail.com>
> ---
> V3: Add minor sparse warning correction as part of series
> V2: Not present in prior submissions
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index bb524a9..228003b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -257,8 +257,8 @@ static int stmmac_pltfr_probe(struct platform_device *pdev)
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	addr = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(addr))
> -		return PTR_ERR(addr);
> +	if (IS_ERR((void __force *)addr))
> +		return PTR_ERR((void __force *)addr);
>  
>  	plat_dat = dev_get_platdata(&pdev->dev);
>  	if (pdev->dev.of_node) {
