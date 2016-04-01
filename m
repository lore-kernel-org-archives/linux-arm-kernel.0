From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 1 Apr 2016 22:28:01 +0800
Subject: [PATCH] pinctrl: mediatek: correct debounce time unit in
 mtk_gpio_set_debounce
In-Reply-To: <1459518711-61619-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1459518711-61619-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CAGS+omA=xbZH04nkVddVi77xvNznjx36_rHJHhAHBLejuxZqgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yingjoe,

On Fri, Apr 1, 2016 at 9:51 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> The debounce time unit for gpio_chip.set_debounce is us but
> mtk_gpio_set_debounce regard it as ms.
> Fix this by correct debounce time array dbnc_arr so it can find correct
> debounce setting.

This patch also changes the first entry to 500 usec.  At least mention why.

>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 2bbe6f7..be72325 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1004,7 +1004,8 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
>         struct mtk_pinctrl *pctl = dev_get_drvdata(chip->parent);
>         int eint_num, virq, eint_offset;
>         unsigned int set_offset, bit, clr_bit, clr_offset, rst, i, unmask, dbnc;
> -       static const unsigned int dbnc_arr[] = {0 , 1, 16, 32, 64, 128, 256};
> +       static const unsigned int dbnc_arr[] = {500, 1000, 16000, 32000, 64000,
> +                                               128000, 256000};

While you are at it, can you please rename this to something more
readable than "dbnc"?

-Dan

>         const struct mtk_desc_pin *pin;
>         struct irq_data *d;
>
> --
> 1.9.1
>
