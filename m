From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 30 Jun 2015 11:44:24 +0200
Subject: [PATCH 4/7] pinctrl: sh-pfc: Stop calling gpiochip_add_pin_range()
 on DT platforms
In-Reply-To: <3655225.qDiVN00LS0@avalon>
References: <1435650327-2542-1-git-send-email-geert+renesas@glider.be>
 <1435650327-2542-5-git-send-email-geert+renesas@glider.be>
 <3655225.qDiVN00LS0@avalon>
Message-ID: <CAMuHMdWTQrhFeuoiCUM==xkHv4RednxB+-Eb8_zVUiESAaTbYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jun 30, 2015 at 11:30 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 30 June 2015 09:45:24 Geert Uytterhoeven wrote:
>> On platforms where the PFC/GPIO controller is instantiated from DT, the
>> mapping between GPIOs and pins is set up using the "gpio-ranges"
>> property in DT.
>>
>> Hence stop setting up the mapping from C code on DT platforms.
>> This code is still used for SH or ARM-legacy platforms.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/pinctrl/sh-pfc/gpio.c | 36 ++++++++++++++++++++----------------
>>  1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
>> index ba353735ecf2be9a..1be118e4865fd3f8 100644
>> --- a/drivers/pinctrl/sh-pfc/gpio.c
>> +++ b/drivers/pinctrl/sh-pfc/gpio.c
>> @@ -379,22 +379,26 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
>>
>>       pfc->gpio = chip;
>>
>> -     /* Register the GPIO to pin mappings. As pins with GPIO ports must come
>> -      * first in the ranges, skip the pins without GPIO ports by stopping at
>> -      * the first range that contains such a pin.
>> -      */
>> -     for (i = 0; i < pfc->nr_ranges; ++i) {
>> -             const struct sh_pfc_pin_range *range = &pfc->ranges[i];
>> -
>> -             if (range->start >= pfc->nr_gpio_pins)
>> -                     break;
>> -
>> -             ret = gpiochip_add_pin_range(&chip->gpio_chip,
>> -                                          dev_name(pfc->dev),
>> -                                          range->start, range->start,
>> -                                          range->end - range->start + 1);
>> -             if (ret < 0)
>> -                     return ret;
>> +     if (IS_ENABLED(CONFIG_SUPERH) ||
>> +         IS_ENABLED(CONFIG_ARCH_SHMOBILE_LEGACY)) {
>
> I'd prefer checking IS_ENABLED(CONFIG_OF) && pfc->dev->of_node as that doesn't
> explicitly depend on the platform type.

Note that CONFIG_OF is also set for ARM-legacy (and soon for SH). But that's
a minor problem. But due to the runtime check on pfc->dev->of_node, the
unused code below won't be left out by the compiler, and I want to get rid
of that code.

The platform check make it clear when the code can be removed.

> As the code after this if block also don't need to run on non-DT platforms,
> how about just using
>
>         if (IS_ENABLED(CONFIG_OF) && pfc->dev->of_node)
>                 return 0;
>
> ?

Early return is indeed an option, as we don't need the function GPIOs on
DT platforms.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
