From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 30 Nov 2015 22:29:26 +0530
Subject: [PATCH v2] arm: dts: Fix audio card detection on peach boards
In-Reply-To: <565C56BD.2050002@osg.samsung.com>
References: <1444653438-6532-1-git-send-email-alim.akhtar@samsung.com>
 <565C56BD.2050002@osg.samsung.com>
Message-ID: <CAGOxZ52=rci6MaEL4aa_G8VP16kDi9QhYUcYS8qF263nZeHgpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Mon, Nov 30, 2015 at 7:31 PM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> Hello Alim,
>
> On 10/12/2015 09:37 AM, Alim Akhtar wrote:
>> Since commit 2fad972d45c4 ("ARM: dts: Add mclk entry for Peach boards"),
>> sound card detection is broken on peach boards and gives below errors:
>>
>> [    3.630457] max98090 7-0010: MAX98091 REVID=0x51
>> [    3.634233] max98090 7-0010: use default 2.8v micbias
>> [    3.640985] snow-audio sound: HiFi <-> 3830000.i2s mapping ok
>> [    3.645307] max98090 7-0010: Invalid master clock frequency
>> [    3.650824] snow-audio sound: ASoC: Peach-Pi-I2S-MAX98091 late_probe() failed: -22
>> [    3.658914] snow-audio sound: snd_soc_register_card failed (-22)
>> [    3.664366] snow-audio: probe of sound failed with error -22
>>
>> This patch adds missing assigned-clocks and assigned-clock-parents for
>> pmu_system_controller node which is used as "mclk" for audio codec.
>>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> Fixes: 2fad972d45c4 ("ARM: dts: Add mclk entry for Peach boards")
>
> I found that this patch is not enough to have proper audio working
> on an Exynos5800 Peach Pi. Even playing a simple wav does not work:
>
> $ time aplay -D sysdefault /usr/share/sounds/alsa/Front_Center.wav
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
>
> real    0m1.138s
> user    0m0.005s
> sys     0m0.005s
>
> This should be ~1.5 seconds so audio is processed faster than expected.
>
Did you tried playing any other file, like 128 KHz rate files etc..?
> So something else besides making the CLKOUT to provide a valid frequency
> for the codec's master clock is needed.
>
The $SUBJECT patch actually  fix the audio card detection issue, which
was failing because of the missing master clock.

> Do you know what's missing in mainline? For instance, I see that the
> sound/soc/samsung/snow.c ASoC machine driver doesn't have a hw_params
> but I'm not that familiar with ALSA to know if that makes sense or not.
>
I need to check this, currently I am out on a business travel, so
won't be able to check.
Probably we can go back to before "2fad972d45c4" and check that.

> Also, do you know if the "simple-audio-card" can be used instead for
> snow and peachs as it is used for other Exynos5 boards or a specific
> ASoC machine driver is really needed for these Chromebooks?
>
Not sure, AFAIR, I used machine driver on chromebooks (snow and peach).

> Best regards,
> --
> Javier Martinez Canillas
> Open Source Group
> Samsung Research America
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim
