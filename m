From: sean.wang@kernel.org (Sean Wang)
Date: Mon, 26 Nov 2018 23:20:53 -0800
Subject: [PATCH 1/2] gpio: mt7621: report failure of devm_kasprintf()
In-Reply-To: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
References: <1542823573-20228-1-git-send-email-hofrat@osadl.org>
Message-ID: <CAGp9LzqF7odHdOk85Z=iVG2ecuDcKXwod=9r0Kh2CDeZWZiK=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicholas Mc Guire <hofrat@osadl.org> ? 2018?11?21? ?? ??10:13???
>
> kasprintf() may return NULL on failure of internal allocation thus the
> assigned  label  is not safe if not explicitly checked. On error
> mediatek_gpio_bank_probe() returns negative values so -ENOMEM in the
> (unlikely) failure case should be fine here.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Sean Wang <sean.wang@kernel.org>

> Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
> ---
>
> V2: The dev_err() for the unlikely case of the devm_kasprintf()
>     failing was removed on request from Bartosz Golaszewski
>     <bgolaszewski@baylibre.com>
>
> Problem located with experimental coccinelle script
>
> Patch was compile tested with: omega2p_defconfig, SOC_MT7621=y,
> GPIOLIB=y, GPIO_MT7621=y
>
> Patch is against 4.20-rc3 (localversion-next is next-20181121)
>
>  drivers/gpio/gpio-mt7621.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
> index d72af6f..1ec95bc 100644
> --- a/drivers/gpio/gpio-mt7621.c
> +++ b/drivers/gpio/gpio-mt7621.c
> @@ -244,6 +244,8 @@ mediatek_gpio_bank_probe(struct device *dev,
>         rg->chip.of_xlate = mediatek_gpio_xlate;
>         rg->chip.label = devm_kasprintf(dev, GFP_KERNEL, "%s-bank%d",
>                                         dev_name(dev), bank);
> +       if (!rg->chip.label)
> +               return -ENOMEM;
>
>         ret = devm_gpiochip_add_data(dev, &rg->chip, mtk);
>         if (ret < 0) {
> --
> 2.1.4
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
