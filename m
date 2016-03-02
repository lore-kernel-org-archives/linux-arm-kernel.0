From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Mar 2016 09:57:27 +0100
Subject: [PATCH 1/6] rtc: generic: allow building on all architectures
In-Reply-To: <1456851608-3374907-2-git-send-email-arnd@arndb.de>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
Message-ID: <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Mar 1, 2016 at 5:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> There are four architectures using this driver, but since we can
> build it with COMPILE_TEST, we should try dealing with the absence
> of the asm/rtc.h header file, to avoid getting a build error:
>
> drivers/rtc/rtc-generic.c:12:21: fatal error: asm/rtc.h: No such file or directory
>
> This creates an alternative use of the driver, allowing architectures
> to pass a set of rtc_class_ops in platform data. We can convert the
> four architectures to use this and then remove the original
> code.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-generic.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-generic.c b/drivers/rtc/rtc-generic.c
> index e782ebd719b2..d726c6aa96a8 100644
> --- a/drivers/rtc/rtc-generic.c
> +++ b/drivers/rtc/rtc-generic.c
> @@ -9,6 +9,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/rtc.h>
>
> +#if defined(CONFIG_M68K) || defined(CONFIG_PARISC) || \
> +    defined(CONFIG_PPC) || defined(CONFIG_SUPERH32)
>  #include <asm/rtc.h>
>
>  static int generic_get_time(struct device *dev, struct rtc_time *tm)
> @@ -33,13 +35,21 @@ static const struct rtc_class_ops generic_rtc_ops = {
>         .read_time = generic_get_time,
>         .set_time = generic_set_time,
>  };
> +#else
> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
> +#endif
>
>  static int __init generic_rtc_probe(struct platform_device *dev)
>  {
>         struct rtc_device *rtc;
> +       const struct rtc_class_ops *ops;
> +
> +       ops = dev_get_platdata(&dev->dev);
> +       if (!ops)
> +               ops = &generic_rtc_ops;

I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
undefined behavior?

>
>         rtc = devm_rtc_device_register(&dev->dev, "rtc-generic",
> -                                       &generic_rtc_ops, THIS_MODULE);
> +                                       ops, THIS_MODULE);
>         if (IS_ERR(rtc))
>                 return PTR_ERR(rtc);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
