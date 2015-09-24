From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Sep 2015 10:49:57 -0700
Subject: [PATCH v2 1/3] gpio: Use __gpiod_request directly
In-Reply-To: <CAAVeFuJPzjJ6td9UZ993sbfOyEOo=7WVu-Y2KnFgXewyt_8knA@mail.gmail.com>
References: <1440920686-6892-1-git-send-email-mpa@pengutronix.de>
 <1440920686-6892-2-git-send-email-mpa@pengutronix.de>
 <CAAVeFuJPzjJ6td9UZ993sbfOyEOo=7WVu-Y2KnFgXewyt_8knA@mail.gmail.com>
Message-ID: <CACRpkdaBxAhWKnJ3vsd+K6xMgaym7D9M0zTEMu_=fmiUNpxTEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 9:25 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Sun, Aug 30, 2015 at 4:44 PM, Markus Pargmann <mpa@pengutronix.de> wrote:
>> There is no reason to find out chip and hwnum to use to request a gpio
>> and get another gpio descriptor. We already have the descriptor we want
>> to use so we can directly use it.
>>
>> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
>> ---
>>  drivers/gpio/gpiolib.c | 17 ++++++-----------
>>  1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
>> index 79a0b41ce57b..872fdd3617c1 100644
>> --- a/drivers/gpio/gpiolib.c
>> +++ b/drivers/gpio/gpiolib.c
>> @@ -2189,25 +2189,20 @@ EXPORT_SYMBOL_GPL(__gpiod_get_index_optional);
>>  int gpiod_hog(struct gpio_desc *desc, const char *name,
>>               unsigned long lflags, enum gpiod_flags dflags)
>>  {
>> -       struct gpio_chip *chip;
>> -       struct gpio_desc *local_desc;
>> -       int hwnum;
>>         int status;
>>
>> -       chip = gpiod_to_chip(desc);
>> -       hwnum = gpio_chip_hwgpio(desc);
>> -
>> -       local_desc = gpiochip_request_own_desc(chip, hwnum, name);
>> -       if (IS_ERR(local_desc)) {
>> +       status = __gpiod_request(desc, name);
>> +       if (status) {
>>                 pr_err("requesting hog GPIO %s (chip %s, offset %d) failed\n",
>> -                      name, chip->label, hwnum);
>> -               return PTR_ERR(local_desc);
>> +                      name, gpiod_to_chip(desc)->label,
>> +                      gpio_chip_hwgpio(desc));
>> +               return status;
>>         }
>>
>>         status = gpiod_configure_flags(desc, name, lflags, dflags);
>>         if (status < 0) {
>>                 pr_err("setup of hog GPIO %s (chip %s, offset %d) failed\n",
>> -                      name, chip->label, hwnum);
>> +                      name, gpiod_to_chip(desc)->label, gpio_chip_hwgpio(desc));
>>                 gpiochip_free_own_desc(desc);
>
> Mmm I should have reviewed this patch earlier, but what bothers me a
> bit is that it breaks the symetry that we had by calling
> request_own_desc() and free_own_desc() in the failing case (as well as
> in gpiochip_free_hogs). And in the end you still need to call
> gpiod_to_chip() so I am not sure what the benefit is.
>
> Sure, the code is less verbose, but at the same time it has become
> slightly harder to understand. Semantically speaking
> "request_own_desc()" is exactly the action we want to convey.
> __gpiod_request() is more ambiguous.
>
> Note that this is not a reject, I just wanted to stress that "less
> code" is not necessarily the same as "easier to read".

OK I dropped this patch for now.

Markus can you live without this patch for 2/3 and 3/3?

Yours,
Linus Walleij
