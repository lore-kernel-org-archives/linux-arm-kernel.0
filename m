From: fabio.porcedda@gmail.com (Fabio Porcedda)
Date: Tue, 16 Oct 2012 11:32:38 +0200
Subject: [PATCH 2/2] ASoC: atmel-ssc: use module_platform_driver macro
In-Reply-To: <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com>
 <1350359819-2461-2-git-send-email-voice.shen@atmel.com>
Message-ID: <CAHkwnC_ih_-bHeYxxF0xy+pKjATkzfu1cDPD8XAw8ZHu9OQuxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 5:56 AM, Bo Shen <voice.shen@atmel.com> wrote:
> This patch removes some code duplication by using module_platform_driver
>
> Signed-off-by: Bo Shen <voice.shen@atmel.com>
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
>  {
>         struct resource *regs;
>         struct ssc_device *ssc;
> @@ -135,24 +135,14 @@ static int __devexit ssc_remove(struct platform_device *pdev)
>  }
>
>  static struct platform_driver ssc_driver = {
> -       .remove         = __devexit_p(ssc_remove),
>         .driver         = {
>                 .name           = "ssc",
>                 .owner          = THIS_MODULE,
>         },
> +       .probe          = ssc_probe,
> +       .remove         = __devexit_p(ssc_remove),
>  };
> -
> -static int __init ssc_init(void)
> -{
> -       return platform_driver_probe(&ssc_driver, ssc_probe);
> -}
> -module_init(ssc_init);
> -
> -static void __exit ssc_exit(void)
> -{
> -       platform_driver_unregister(&ssc_driver);
> -}
> -module_exit(ssc_exit);
> +module_platform_driver(ssc_driver);
>
>  MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
>  MODULE_DESCRIPTION("SSC driver for Atmel AVR32 and AT91");
> --
> 1.7.9.5

Maybe the module_platform_driver isn't a substitute of platform_driver_probe,
because module_platform_driver  use platform_driver_register/unregister.
Using that macro we lose the advantage of platform_driver_probe,
as stated in:

https://lkml.org/lkml/2012/1/10/335
On Tue, Jan 10, 2012 at 21:47, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> [...]
>Still, setting up platform_driver.probe and removing __init from all probe
>functions is not the right thing to do, as this make (non-__init) kernel code
>size bigger, while none of these devices are hotpluggable and thus cannot
>appear after bootup. That's why we have platform_driver_probe() in the
>first place. So I think all of this should be reverted for non-hotpluggable
>drivers.
> [...]

What do you think?

Best regards
-- 
Fabio Porcedda
