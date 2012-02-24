From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 24 Feb 2012 15:52:43 +0800
Subject: [PATCH] pinctrl: make the pinmux-pins more helpful
In-Reply-To: <1330062969-25016-1-git-send-email-linus.walleij@stericsson.com>
References: <1330062969-25016-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120224075243.GE25789@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 06:56:09AM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The debugfs file pinmux-pins used to tell which function was
> enabled but now states simply which device owns the pin. Being
> owned by the pinctrl driver itself means just that it's hogged
> so be a bit more helpful by printing that.
> 
It's useful.

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

BTW, one question below although it's not relatd to this patch itself.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I somewhat mourn the loss of being able to tell from the debugfs
> which function is using a certain pin, does anyone have ideas on
> how to go about fixing this properly? The root file
> pinctrl-handles does tell it, but requires cross-referencing
> which isn't helpful.
> ---
>  drivers/pinctrl/pinmux.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
> index 98b89d6..db5ed86 100644
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -626,8 +626,8 @@ static int pinmux_pins_show(struct seq_file *s, void *what)
>  
>  	/* The pin number can be retrived from the pin controller descriptor */
>  	for (i = 0; i < pctldev->desc->npins; i++) {
> -
>  		struct pin_desc *desc;
> +		const char *owner;
>  
>  		pin = pctldev->desc->pins[i].number;
>  		desc = pin_desc_get(pctldev, pin);
> @@ -635,9 +635,16 @@ static int pinmux_pins_show(struct seq_file *s, void *what)
>  		if (desc == NULL)
>  			continue;
>  
> +		if (!desc->owner)
> +			owner = "UNCLAIMED";
> +		else if (!strcmp(desc->owner, pinctrl_dev_get_name(pctldev)))
> +			owner = "HOG";
> +		else
> +			owner = desc->owner;
> +
>  		seq_printf(s, "pin %d (%s): %s\n", pin,
>  			   desc->name ? desc->name : "unnamed",
Is there a little issue?
For this line, i see some code:
static int pinctrl_register_one_pin(struct pinctrl_dev *pctldev,
                                    unsigned number, const char *name)
{
...
        pindesc = kzalloc(sizeof(*pindesc), GFP_KERNEL);
        if (pindesc == NULL)
                return -ENOMEM;
...
        /* Copy basic pin info */
        if (name) {
                pindesc->name = name;
        } else {
                pindesc->name = kasprintf(GFP_KERNEL, "PIN%u", number);
                if (pindesc->name == NULL)
                        return -ENOMEM;
                pindesc->dynamic_name = true;
        }
...
}
So is it possible the desc->name is NULL?

> -			   desc->owner ? desc->owner : "UNCLAIMED");
> +			   owner);
>  	}
>  
>  	return 0;

Regards
Dong Aisheng
