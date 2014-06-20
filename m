From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 20 Jun 2014 12:38:43 +0100
Subject: [PATCH] pinctrl: st: Fix irqmux handler
In-Reply-To: <1403264094-16140-1-git-send-email-maxime.coquelin@st.com>
References: <1403264094-16140-1-git-send-email-maxime.coquelin@st.com>
Message-ID: <53A41D43.3010907@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 20/06/14 12:34, Maxime COQUELIN wrote:
> st_gpio_irqmux_handler() reads the status register to find out
> which banks inside the controller have pending IRQs.
> For each banks having pending IRQs, it calls the corresponding handler.
>
> Problem is that current code restricts the number of possible banks inside the
> controller to ST_GPIO_PINS_PER_BANK. This define represents the number of pins
> inside a bank, so it shouldn't be used here.
You are right.
Good find.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


>
> On STiH407, PIO_FRONT0 controller has 10 banks, so IRQs pending in the two
> last banks (PIO18 & PIO19) aren't handled.
>
> This patch replace ST_GPIO_PINS_PER_BANK by the number of banks inside the
> controller.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: <stable@vger.kernel.org> #v3.15+
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>   drivers/pinctrl/pinctrl-st.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 1bd6363bc9..9f43916 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1431,7 +1431,7 @@ static void st_gpio_irqmux_handler(unsigned irq, struct irq_desc *desc)
>
>   	status = readl(info->irqmux_base);
>
> -	for_each_set_bit(n, &status, ST_GPIO_PINS_PER_BANK)
> +	for_each_set_bit(n, &status, info->nbanks)
>   		__gpio_irq_handler(&info->banks[n]);
>
>   	chained_irq_exit(chip, desc);
>
