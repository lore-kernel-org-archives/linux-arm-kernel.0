From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Oct 2012 10:07:30 +0200
Subject: [PATCH 2/2] ASoC: atmel-ssc: use module_platform_driver macro
In-Reply-To: <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
 <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
Message-ID: <507D15C2.7000606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/16/2012 05:56 AM, Bo Shen :
> This patch removes some code duplication by using module_platform_driver
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Very good simplification but...

> ---
>  drivers/misc/atmel-ssc.c |   18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index 23dcb76..ac00f83 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -68,7 +68,7 @@ void ssc_free(struct ssc_device *ssc)
>  }
>  EXPORT_SYMBOL(ssc_free);
>  
> -static int __init ssc_probe(struct platform_device *pdev)
> +static int ssc_probe(struct platform_device *pdev)

Here you remove the __init altogether, maybe converting to __devinit is
the proper replacement for this? I do not know myself but if anybody knows?

Bye,


>  {
>  	struct resource *regs;
>  	struct ssc_device *ssc;
> @@ -135,24 +135,14 @@ static int __devexit ssc_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver ssc_driver = {
> -	.remove		= __devexit_p(ssc_remove),
>  	.driver		= {
>  		.name		= "ssc",
>  		.owner		= THIS_MODULE,
>  	},
> +	.probe		= ssc_probe,
> +	.remove		= __devexit_p(ssc_remove),
>  };
> -
> -static int __init ssc_init(void)
> -{
> -	return platform_driver_probe(&ssc_driver, ssc_probe);
> -}
> -module_init(ssc_init);
> -
> -static void __exit ssc_exit(void)
> -{
> -	platform_driver_unregister(&ssc_driver);
> -}
> -module_exit(ssc_exit);
> +module_platform_driver(ssc_driver);
>  
>  MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
>  MODULE_DESCRIPTION("SSC driver for Atmel AVR32 and AT91");
> 


-- 
Nicolas Ferre
