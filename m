From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 21:40:23 +0200
Subject: [PATCH 2/6 v2] ARM: integrator: check PL010 device name rather
 than base address
In-Reply-To: <201209011832.47805.arnd@arndb.de>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <201209011832.47805.arnd@arndb.de>
Message-ID: <CACRpkdYMjJFHscO1BztOFBRMf+YZo+jO5pCrEiGeeeU_Oh_rfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 1, 2012 at 8:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 01 September 2012, Linus Walleij wrote:
>> In the PL010 UART callback a comparison against the base address is
>> done to figure out which UART is doing the callback. This does not
>> play well with device tree, so let's check the dev_name() of the
>> device instead.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hmm, I think the dev_name would also not be that nice, because it changes
> after the conversion to DT is complete.

Hmmmm yeah. I do tie down the name to "uart0" using auxdata.

(...)
>> +++ b/arch/arm/mach-integrator/core.c
>> @@ -100,7 +100,7 @@ static void integrator_uart_set_mctrl(struct amba_device *dev, void __iomem *bas
>>  {
>>         unsigned int ctrls = 0, ctrlc = 0, rts_mask, dtr_mask;
>>
>> -       if (dev == &uart0_device) {
>> +       if (!strcmp(dev_name(&dev->dev), "uart0")) {
>>                 rts_mask = 1 << 4;
>>                 dtr_mask = 1 << 5;
>>         } else {
>
> Maybe it's possible to compare the base pointer against INTEGRATOR_UART0_BASE instead?

Nope, that is an ioremapped() base, I have no clue what it may be.

Yours,
Linus Walleij
