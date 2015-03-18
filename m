From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Mar 2015 11:21:37 +0100
Subject: [PATCH] pinmux: allow exlusive pin allocation among GPIO and
 peripheral funtions via flag strict in struct pinctrl_desc
In-Reply-To: <1426154203-11551-1-git-send-email-sonic.adi@gmail.com>
References: <1426154203-11551-1-git-send-email-sonic.adi@gmail.com>
Message-ID: <CACRpkdZ-wmZRHR1eTwhaNYcot=T4GVX2spm80hv8Makw99bowQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 10:56 AM, Sonic Zhang <sonic.adi@gmail.com> wrote:

> From: Sonic Zhang <sonic.zhang@analog.com>
>
> The blackfin pinmux and gpio controller doesn't allow user to set up 1 pin
> for both GPIO and peripheral function. So, add flag strict in struct pinctrl
> to check both gpio_owner and mux_owner before approving the pin request.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>

Nice!

But mention in the commit that ADI2 is also patched to use
this.

Do we have other candidates for strict GPIO/mux separation?
What do people on the lists say?

> +++ b/drivers/pinctrl/pinmux.c
> @@ -99,24 +99,25 @@ static int pin_request(struct pinctrl_dev *pctldev,
>         dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
>                 pin, desc->name, owner);
>
> +       if ((gpio_range || pctldev->desc->strict) && desc->gpio_owner) {

So either we find a range map or we are strict and there is also a
previous owner of the pin.

Is this correct? I think we should *always* find a range to request
a pin.

I think you should just leave this if()-statement alone and insert
some new stuff inside the lower else()-clause.


> +               dev_err(pctldev->dev,
> +                       "pin %s already requested by %s; cannot claim for %s\n",
> +                       desc->name, desc->gpio_owner, owner);
> +               goto out;
> +       }
> +
> +       if ((!gpio_range || pctldev->desc->strict) &&
> +           desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
> +               dev_err(pctldev->dev,
> +                       "pin %s already requested by %s; cannot claim for %s\n",
> +                       desc->name, desc->mux_owner, owner);
> +               goto out;
> +       }

This is wrong.

If the function is entered with gpio_range != NULL it is a request
for a single GPIO line, else it is regular muxing.

Keep the else() clause, just also include an explicit check
to see if desc->gpio_owner is set, and in that case, if we
are also strict, bail out.

else { /* No gpio_range */
   if (pctldev->desc->strict && desc->gpio_owner) {
      err "already used for GPIO..."
   }

> +
>         if (gpio_range) {

So just keep the whole thing inside if (gpio_range).

>                 desc->mux_usecount++;
>                 if (desc->mux_usecount > 1)
>                         return 0;
> diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
> index 66e4697..ca6c99c0 100644
> --- a/include/linux/pinctrl/pinctrl.h
> +++ b/include/linux/pinctrl/pinctrl.h
> @@ -132,6 +132,7 @@ struct pinctrl_desc {
>         const struct pinctrl_ops *pctlops;
>         const struct pinmux_ops *pmxops;
>         const struct pinconf_ops *confops;
> +       bool strict;

Also update the kerneldoc above this struct.

Also update examples and text in
Documentation/pinctrl.txt
so it is clear when to use this option and what it means.

Yours,
Linus Walleij
