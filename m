From: sonic.adi@gmail.com (Sonic Zhang)
Date: Thu, 19 Mar 2015 18:06:37 +0800
Subject: [PATCH] pinmux: allow exlusive pin allocation among GPIO and
 peripheral funtions via flag strict in struct pinctrl_desc
In-Reply-To: <CACRpkdZ-wmZRHR1eTwhaNYcot=T4GVX2spm80hv8Makw99bowQ@mail.gmail.com>
References: <1426154203-11551-1-git-send-email-sonic.adi@gmail.com>
 <CACRpkdZ-wmZRHR1eTwhaNYcot=T4GVX2spm80hv8Makw99bowQ@mail.gmail.com>
Message-ID: <CAJxxZ0OC0xDs3Y_kn=_r59Sx8mf3aUxE9unH+8mjuEsQrK8q=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Mar 18, 2015 at 6:21 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Mar 12, 2015 at 10:56 AM, Sonic Zhang <sonic.adi@gmail.com> wrote:
>
>> From: Sonic Zhang <sonic.zhang@analog.com>
>>
>> The blackfin pinmux and gpio controller doesn't allow user to set up 1 pin
>> for both GPIO and peripheral function. So, add flag strict in struct pinctrl
>> to check both gpio_owner and mux_owner before approving the pin request.
>>
>> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>
> Nice!
>
> But mention in the commit that ADI2 is also patched to use
> this.
OK

>
> Do we have other candidates for strict GPIO/mux separation?
> What do people on the lists say?
>
>> +++ b/drivers/pinctrl/pinmux.c
>> @@ -99,24 +99,25 @@ static int pin_request(struct pinctrl_dev *pctldev,
>>         dev_dbg(pctldev->dev, "request pin %d (%s) for %s\n",
>>                 pin, desc->name, owner);
>>
>> +       if ((gpio_range || pctldev->desc->strict) && desc->gpio_owner) {
>
> So either we find a range map or we are strict and there is also a
> previous owner of the pin.
>
> Is this correct? I think we should *always* find a range to request
> a pin.
When requesting regular muxing from function pinmux_enable_setting(),
pin_request() is invoked with gpio_range = NULL. But, when requesting
GPIO, function pinmux_request_gpio() always passes a valid range. So,
if gpio_owner is set, it is correct to fail a request either the
request is for this GPIO or the request is for regular muxing of this
GPIO pin and the strict bit is set.

>
> I think you should just leave this if()-statement alone and insert
> some new stuff inside the lower else()-clause.
>
>
>> +               dev_err(pctldev->dev,
>> +                       "pin %s already requested by %s; cannot claim for %s\n",
>> +                       desc->name, desc->gpio_owner, owner);
>> +               goto out;
>> +       }
>> +
>> +       if ((!gpio_range || pctldev->desc->strict) &&
>> +           desc->mux_usecount && strcmp(desc->mux_owner, owner)) {
>> +               dev_err(pctldev->dev,
>> +                       "pin %s already requested by %s; cannot claim for %s\n",
>> +                       desc->name, desc->mux_owner, owner);
>> +               goto out;
>> +       }
>
> This is wrong.
>
> If the function is entered with gpio_range != NULL it is a request
> for a single GPIO line, else it is regular muxing.

Why this is wrong? If gpio_range != NULL, the request of a GPIO is
already checked in the first if clause.

In strict case:
Both mux_owner and gpio_owner are checked no matter whether GPIO or
regular muxing is requested.
If both checking pass, muxing_owner or gpio_owner is set according to
the request type.

In non strict case:
Request of GPIO is checked in the first if clause against gpio_owner,
while request of regular muxing is checked in the second if clause
against mux_owner.
If either checking passes, its owner is set which doesn't affect the
checking of the other request type.

>
> Keep the else() clause, just also include an explicit check
> to see if desc->gpio_owner is set, and in that case, if we
> are also strict, bail out.

Anyway, if you think doing the explicit check in both if() and else()
clauses is better, I am fine to send a new patch.

>
> else { /* No gpio_range */
>    if (pctldev->desc->strict && desc->gpio_owner) {
>       err "already used for GPIO..."
>    }
>
>> +
>>         if (gpio_range) {
>
> So just keep the whole thing inside if (gpio_range).
>
>>                 desc->mux_usecount++;
>>                 if (desc->mux_usecount > 1)
>>                         return 0;
>> diff --git a/include/linux/pinctrl/pinctrl.h b/include/linux/pinctrl/pinctrl.h
>> index 66e4697..ca6c99c0 100644
>> --- a/include/linux/pinctrl/pinctrl.h
>> +++ b/include/linux/pinctrl/pinctrl.h
>> @@ -132,6 +132,7 @@ struct pinctrl_desc {
>>         const struct pinctrl_ops *pctlops;
>>         const struct pinmux_ops *pmxops;
>>         const struct pinconf_ops *confops;
>> +       bool strict;
>
> Also update the kerneldoc above this struct.
>
> Also update examples and text in
> Documentation/pinctrl.txt
> so it is clear when to use this option and what it means.

OK

Regards,

Sonic
