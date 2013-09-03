From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 3 Sep 2013 07:54:53 -0300
Subject: [PATCH 1/2] mtd: atmel_nand: remove unneeded ifdef CONFIG_OF
In-Reply-To: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
References: <1378200028-15415-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20130903105452.GB2355@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 05:20:27PM +0800, Josh Wu wrote:
> Since following commit
>   f3b391425d21e6138e57b2432d91134e0bc2b975
>   (of_mtd: Add no-op stubs to support CONFIG_OF=n)
> 
> implements the stub for CONFIG_OF=n. Now we can safely remove all
> CONFIG_OF in atmel_nand. (Thanks to Ezequiel Garcia's for this protype)
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  drivers/mtd/nand/atmel_nand.c |   14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/drivers/mtd/nand/atmel_nand.c b/drivers/mtd/nand/atmel_nand.c
> index 060feea..1ca0724 100644
> --- a/drivers/mtd/nand/atmel_nand.c
> +++ b/drivers/mtd/nand/atmel_nand.c
> @@ -1449,7 +1449,6 @@ static void atmel_nand_hwctl(struct mtd_info *mtd, int mode)
>  		ecc_writel(host->ecc, CR, ATMEL_ECC_RST);
>  }
>  
> -#if defined(CONFIG_OF)
>  static int atmel_of_init_port(struct atmel_nand_host *host,
>  			      struct device_node *np)
>  {
> @@ -1457,7 +1456,7 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
>  	u32 offset[2];
>  	int ecc_mode;
>  	struct atmel_nand_data *board = &host->board;
> -	enum of_gpio_flags flags;
> +	enum of_gpio_flags flags = 0;
>  
>  	if (of_property_read_u32(np, "atmel,nand-addr-offset", &val) == 0) {
>  		if (val >= 32) {
> @@ -1540,13 +1539,6 @@ static int atmel_of_init_port(struct atmel_nand_host *host,
>  
>  	return 0;
>  }
> -#else
> -static int atmel_of_init_port(struct atmel_nand_host *host,
> -			      struct device_node *np)
> -{
> -	return -EINVAL;
> -}
> -#endif
>  
>  static int __init atmel_hw_nand_init_params(struct platform_device *pdev,
>  					 struct atmel_nand_host *host)
> @@ -2207,14 +2199,12 @@ static int __exit atmel_nand_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_OF)
>  static const struct of_device_id atmel_nand_dt_ids[] = {
>  	{ .compatible = "atmel,at91rm9200-nand" },
>  	{ /* sentinel */ }
>  };
>  
>  MODULE_DEVICE_TABLE(of, atmel_nand_dt_ids);
> -#endif
>  
>  static int atmel_nand_nfc_probe(struct platform_device *pdev)
>  {
> @@ -2253,12 +2243,10 @@ static int atmel_nand_nfc_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_OF)
>  static struct of_device_id atmel_nand_nfc_match[] = {
>  	{ .compatible = "atmel,sama5d3-nfc" },
>  	{ /* sentinel */ }
>  };
> -#endif
>  
>  static struct platform_driver atmel_nand_nfc_driver = {
>  	.driver = {
> -- 
> 1.7.9.5
> 

Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
