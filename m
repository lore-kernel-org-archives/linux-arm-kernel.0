From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 30 Jun 2015 11:48:23 +0200
Subject: [PATCH 7/7] pinctrl: sh-pfc: Confine legacy function GPIOs to SH
In-Reply-To: <10481403.sNoQCGtpkA@avalon>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
 <1435650327-2542-8-git-send-email-geert+renesas@glider.be>
 <10481403.sNoQCGtpkA@avalon>
Message-ID: <CAMuHMdX9xK7SWvEacOx4+7QAXJ=oRREAvCBQ5X8cjv+4XeeRrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jun 30, 2015 at 11:38 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/drivers/pinctrl/sh-pfc/gpio.c
>> +++ b/drivers/pinctrl/sh-pfc/gpio.c
>> @@ -290,6 +290,7 @@ static int gpio_pin_setup(struct sh_pfc_chip *chip)
>>   * Function GPIOs
>>   */
>>
>> +#ifdef CONFIG_SUPERH
>>  static int gpio_function_request(struct gpio_chip *gc, unsigned offset)
>>  {
>>       static bool __print_once;
>> @@ -330,6 +331,31 @@ static int gpio_function_setup(struct sh_pfc_chip
>> *chip) return 0;
>>  }
>>
>> +static int sh_pfc_add_function_gpios(struct sh_pfc *pfc)
>> +{
>> +     struct sh_pfc_chip *chip;
>> +
>> +     if (!pfc->info->nr_func_gpios)
>> +             return 0;
>> +
>> +     chip = sh_pfc_add_gpiochip(pfc, gpio_function_setup, NULL);
>> +     if (IS_ERR(chip))
>> +             return PTR_ERR(chip);
>> +
>> +     pfc->func = chip;
>> +
>> +     return 0;
>> +}
>> +
>> +static void sh_pfc_remove_function_gpios(struct sh_pfc *pfc)
>> +{
>> +     gpiochip_remove(&pfc->func->gpio_chip);
>> +}
>> +#else
>> +static inline int sh_pfc_add_function_gpios(struct sh_pfc *pfc) { return 0;
>> }
>> +static inline int sh_pfc_remove_function_gpios(struct sh_pfc *pfc) {
>> return 0; }
>
> Given that those functions are only called from a single location, would it
> make sense to just compile the calls conditionally instead ? I would find that
> slightly more readable as it would be more explicit.

If that's acceptable for you, that would be fine for me, too. One (or two) more
visual cues for future removal of legacy code.

And then I can drop "[PATCH 6/7] pinctrl: sh-pfc: Move sh_pfc_add_gpiochip()
up".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
