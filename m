From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 9 Dec 2013 09:24:53 +0100
Subject: [PATCH 2/3] pinctrl: at91: initialize config parameter to 0
In-Reply-To: <1386421734-10240-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1386421734-10240-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1386421734-10240-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <52A57E55.40808@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2013 14:08, Alexandre Belloni :
> When passing a not initialized config parameter, at91_pinconf_get() would return
> a bogus value. Fix that by initializing it to zero before using it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>   drivers/pinctrl/pinctrl-at91.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 6446dc804aa7..b0b78f3468ae 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -722,7 +722,8 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
>   	unsigned pin;
>   	int div;
>
> -	dev_dbg(info->dev, "%s:%d, pin_id=%d, config=0x%lx", __func__, __LINE__, pin_id, *config);
> +	*config = 0;
> +	dev_dbg(info->dev, "%s:%d, pin_id=%d", __func__, __LINE__, pin_id);
>   	pio = pin_to_controller(info, pin_to_bank(pin_id));
>   	pin = pin_id % MAX_NB_GPIO_PER_BANK;

Beyond this patch, I must say that I am puzzled by this function.

What I read from the prototype documentation and what I see in different 
implementations is different...

Linus, can we have a review of this function because it seems not in 
line with what is used for u300 (but on the other hand looks like the 
what is returned by pinctrl-exynos5440.c driver for example).

What would be the consequences if we change this function's behavior: I 
mean use of -EINVAL for pin configuration "available but disabled" as 
said in include/linux/pinctrl/pinconf.h?

Bye,
-- 
Nicolas Ferre
