From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Wed, 8 Feb 2017 14:26:06 +0100
Subject: [PATCH 10/10] ARM: davinci: add pdata-quirks for da850-evm vpif
 display
In-Reply-To: <m2k291kglb.fsf@baylibre.com>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <1486485683-11427-11-git-send-email-bgolaszewski@baylibre.com>
 <m2k291kglb.fsf@baylibre.com>
Message-ID: <CAMpxmJUEH4-bP-x06fvYSy-6ViVMr3++txBQmtm5bEENR1yqnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-02-07 19:20 GMT+01:00 Kevin Hilman <khilman@baylibre.com>:
> Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:
>
>> Similarly to vpif capture: we need to register the vpif display driver
>> and the corresponding adv7343 encoder in pdata-quirks as the DT
>> support is not complete.
>
> To add a bit more detail to the changelog:  DT support is not complete
> since there isn't currently a way to define the output_routing in the
> V4L2 drivers (c.f. s_routing) via DT.
>

I'll add this in v2.

>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> minor nit below, otherwise
>
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>
>> ---
>>  arch/arm/mach-davinci/pdata-quirks.c | 86 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 85 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-davinci/pdata-quirks.c b/arch/arm/mach-davinci/pdata-quirks.c
>> index 09f62ac..0a55546 100644
>> --- a/arch/arm/mach-davinci/pdata-quirks.c
>> +++ b/arch/arm/mach-davinci/pdata-quirks.c
>> @@ -9,13 +9,17 @@
>>   */
>>  #include <linux/kernel.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/gpio.h>
>>
>>  #include <media/i2c/tvp514x.h>
>> +#include <media/i2c/adv7343.h>
>>
>>  #include <mach/common.h>
>>  #include <mach/da8xx.h>
>>  #include <mach/mux.h>
>>
>> +#define DA850_EVM_UI_EXP_SEL_VPIF_DISP 5
>> +
>>  struct pdata_init {
>>       const char *compatible;
>>       void (*fn)(void);
>> @@ -107,7 +111,78 @@ static struct vpif_capture_config da850_vpif_capture_config = {
>>       },
>>       .card_name = "DA850/OMAP-L138 Video Capture",
>>  };
>> +#endif /* IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE) */
>> +
>> +#if defined(CONFIG_DA850_UI_SD_VIDEO_PORT)
>
> Why not IS_ENABLED(CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE) also here?

Just a reflex ;)

I'll fix this too.

Thanks,
Bartosz
