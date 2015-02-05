From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 5 Feb 2015 14:53:34 +0100
Subject: [PATCH] pinctrl: pinctrl-imx: don't use invalid value of conf_reg
In-Reply-To: <20150203190141.GE10842@pengutronix.de>
References: <1422399025-25636-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <CACRpkdbtpGU57-tPn9Z0rNvY4zLk+QE6A9Pd87vLUHOmRiB2yg@mail.gmail.com>
 <20150203190141.GE10842@pengutronix.de>
Message-ID: <CACRpkdYXW5X7bSiRPTC3uHT=s+hjxj+jS0YJCBWrcmzHWkpqHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 3, 2015 at 8:01 PM, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:
> On Tue, Feb 03, 2015 at 02:01:09PM +0100, Linus Walleij wrote:
>> On Tue, Jan 27, 2015 at 11:50 PM, Uwe Kleine-K?nig
>> <u.kleine-koenig@pengutronix.de> wrote:
>>
>> > The right check for conf_reg to be invalid it testing against -1 not 0
>> > as is done in the rest of the driver.
>> >
>> > This fixes an oops that can be triggered by:
>> >
>> >         cat /sys/kernel/debug/pinctrl/43fac000.iomuxc/*
>> >
>> > Fixes: ae75ff814538 ("pinctrl: pinctrl-imx: add imx pinctrl core driver")
>> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>
>> Patch applied.
>>
>> But...
>>
>> > -       if (!pin_reg || !pin_reg->conf_reg) {
>> > +       if (!pin_reg || pin_reg->conf_reg == -1) {
>>
>> I can see that the other code checks for -1 in this variable.
>> But where is conf_reg ever set to -1?
>>
>> freescale]$ git grep "\-1"
>> pinctrl-imx.c:          if (pin_reg->mux_reg == -1) {
>> pinctrl-imx.c:  if (pin_reg->mux_reg == -1)
>> pinctrl-imx.c:  if (pin_reg->mux_reg == -1)
>> pinctrl-imx.c:  if (pin_reg->conf_reg == -1) {
>> pinctrl-imx.c:  if (pin_reg->conf_reg == -1) {
>> pinctrl-imx.c:  if (!pin_reg || pin_reg->conf_reg == -1) {
> Uah, ugly. This member gets -1 by means of:
>
>         memset(info->pin_regs, 0xff, sizeof(*info->pin_regs) * info->npins);

OMG. Uwe can you make a patch changing that initialization
code to something sane? We can't have it like this.

Yours,
Linus Walleij
