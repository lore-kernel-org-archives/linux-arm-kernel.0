From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 8 Apr 2016 19:01:56 +0800
Subject: [PATCH v2] pinctrl: mediatek: correct debounce time unit in
 mtk_gpio_set_debounce
In-Reply-To: <1459580269-64531-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1459580269-64531-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <CAGS+omDzU8sEwqkQn95UQCgpgE59jvnpQaTO=3HivQhZ6V-UOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 2, 2016 at 2:57 PM, Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
> The debounce time unit for gpio_chip.set_debounce is us but
> mtk_gpio_set_debounce regard it as ms.
> Fix this by correct debounce time array dbnc_arr so it can find correct
> debounce setting. Debounce time for first debounce setting is 500us,
> correct this as well.
>
> While I'm at it, also change the debounce time array name to
> "debounce_time" for readability.
>
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
> This was based on v4.6-rc1
> Change since v1:
> - Improve commit message.
> - Change dbnc_arr name to debounce_time
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> index 2bbe6f7..6ab8c3c 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> @@ -1004,7 +1004,8 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
>         struct mtk_pinctrl *pctl = dev_get_drvdata(chip->parent);
>         int eint_num, virq, eint_offset;
>         unsigned int set_offset, bit, clr_bit, clr_offset, rst, i, unmask, dbnc;
> -       static const unsigned int dbnc_arr[] = {0 , 1, 16, 32, 64, 128, 256};
> +       static const unsigned int debounce_time[] = {500, 1000, 16000, 32000, 64000,
> +                                               128000, 256000};
>         const struct mtk_desc_pin *pin;
>         struct irq_data *d;
>
> @@ -1022,9 +1023,9 @@ static int mtk_gpio_set_debounce(struct gpio_chip *chip, unsigned offset,
>         if (!mtk_eint_can_en_debounce(pctl, eint_num))
>                 return -ENOSYS;
>
> -       dbnc = ARRAY_SIZE(dbnc_arr);
> -       for (i = 0; i < ARRAY_SIZE(dbnc_arr); i++) {
> -               if (debounce <= dbnc_arr[i]) {
> +       dbnc = ARRAY_SIZE(debounce_time);
> +       for (i = 0; i < ARRAY_SIZE(debounce_time); i++) {
> +               if (debounce <= debounce_time[i]) {
>                         dbnc = i;
>                         break;
>                 }
> --
> 1.9.1
>
