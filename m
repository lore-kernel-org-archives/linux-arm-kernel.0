From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 04 Nov 2011 09:55:12 +0100
Subject: [PATCH v5] atmel/spi: fix missing probe
In-Reply-To: <1320344166-31077-1-git-send-email-plagnioj@jcrosoft.com>
References: <1320344166-31077-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4EB3A870.3050107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2011 07:16 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Commit 940ab889 "drivercore: Add helper macro for platform_driver boilerplate"
> converted this driver to use module_platform_driver, but due to the use
> of platform_driver_probe(), this resulted in the call to atmel_spi_probe being
> lost. Place the call to this function into the driver structure.
> 
> fix section missmatch
> 
> atmel_spi_probe is marked __init where it's supposed to be __devinit
> atmel_spi_remove is marked __exit where it's supposed to be __devexit
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

J. can you please queue it in:

git://github.com/at91linux/linux-at91.git   at91-fixes

We may also need to rebase the material already there (one patch) on a
newer linus' kernel...

Thanks, bye,

> ---
> V5:
> 
> 	do it in in patch
> 
> Best Regards,
> J.
>  drivers/spi/spi-atmel.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 79665e2..16d6a83 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -907,7 +907,7 @@ static void atmel_spi_cleanup(struct spi_device *spi)
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static int __init atmel_spi_probe(struct platform_device *pdev)
> +static int __devinit atmel_spi_probe(struct platform_device *pdev)
>  {
>  	struct resource		*regs;
>  	int			irq;
> @@ -1003,7 +1003,7 @@ out_free:
>  	return ret;
>  }
>  
> -static int __exit atmel_spi_remove(struct platform_device *pdev)
> +static int __devexit atmel_spi_remove(struct platform_device *pdev)
>  {
>  	struct spi_master	*master = platform_get_drvdata(pdev);
>  	struct atmel_spi	*as = spi_master_get_devdata(master);
> @@ -1072,6 +1072,7 @@ static struct platform_driver atmel_spi_driver = {
>  	},
>  	.suspend	= atmel_spi_suspend,
>  	.resume		= atmel_spi_resume,
> +	.probe		= atmel_spi_probe,
>  	.remove		= __exit_p(atmel_spi_remove),
>  };
>  module_platform_driver(atmel_spi_driver);


-- 
Nicolas Ferre
