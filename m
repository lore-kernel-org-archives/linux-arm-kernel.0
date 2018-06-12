From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2018 12:43:14 +0200
Subject: [PATCH] pwm: stm32: fix build warning with CONFIG_DMA_ENGINE
 disabled
In-Reply-To: <CAMuHMdXJg0mYbs=e0QJMDb=A+bRbPsNF=TJzSumSjjOK3yJw2Q@mail.gmail.com>
References: <20180525210843.1821071-1-arnd@arndb.de>
 <CAMuHMdXJg0mYbs=e0QJMDb=A+bRbPsNF=TJzSumSjjOK3yJw2Q@mail.gmail.com>
Message-ID: <CAK8P3a2=v5cazbSvdAMX8yf0x=PmCAQatQR6ZD=N0oM5-RGoUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 9:25 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>> --- a/drivers/pwm/pwm-stm32.c
>> +++ b/drivers/pwm/pwm-stm32.c
>> @@ -484,9 +484,7 @@ static int stm32_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
>>  static const struct pwm_ops stm32pwm_ops = {
>>         .owner = THIS_MODULE,
>>         .apply = stm32_pwm_apply_locked,
>> -#if IS_ENABLED(CONFIG_DMA_ENGINE)
>> -       .capture = stm32_pwm_capture,
>> -#endif
>> +       .capture = IS_ENABLED(CONFIG_DMA_ENGINE) ? stm32_pwm_capture : NULL,
>
> Cool, I didn't know IS_ENABLED() can be used in static initializers.
> I guess it's too late/much work to use this trick in e.g. SET_*_PM_OPS(),
> as there are lots of places protecting the functions by #ifdefs?

It's one of those things I've been planning to do for a long time, but as
you noticed, we can't just change the macro but have to come up with a
replacement that works without those #ifdefs. Unfortunately, nobody has
come up with a good /name/ for those macros, which is still the main blocker ;-)

      Arnd
