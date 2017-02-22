From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 22 Feb 2017 20:46:34 +0800
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <20161206172911.z6sbjzgqv3vfcrfh@lukather>
References: <20161124112231.4297-1-wens@csie.org>
 <20161206172911.z6sbjzgqv3vfcrfh@lukather>
Message-ID: <2823101487767594@web44j.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



07.12.2016, 05:03, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Thu, Nov 24, 2016 at 07:22:31PM +0800, Chen-Yu Tsai wrote:
>> ?The panels shipped with Allwinner devices are very "generic", i.e.
>> ?they do not have model numbers or reliable sources of information
>> ?for the timings (that we know of) other than the fex files shipped
>> ?on them. The dot clock frequency provided in the fex files have all
>> ?been rounded to the nearest MHz, as that is the unit used in them.
>>
>> ?We were using the simple panel "urt,umsh-8596md-t" as a substitute
>> ?for the A13 Q8 tablets in the absence of a specific model for what
>> ?may be many different but otherwise timing compatible panels. This
>> ?was usable without any visual artifacts or side effects, until the
>> ?dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
>> ?rgb: Validate the clock rate").
>>
>> ?The reason this check fails is because the dotclock frequency for
>> ?this model is 33.26 MHz, which is not achievable with our dot clock
>> ?hardware, and the rate returned by clk_round_rate deviates slightly,
>> ?causing the driver to reject the display mode.
>>
>> ?The LCD panels have some tolerance on the dot clock frequency, even
>> ?if it's not specified in their datasheets.
>>
>> ?This patch adds a 5% tolerence to the dot clock check.
>
> As we discussed already, I really believe this is just as arbitrary as
> the current behaviour.
>
> Some panels require an exact frequency, some have a minimal frequency
> but no maximum, some have a maximum frequency but no minimal, and I
> guess most of them deviates by how much exactly they can take (and
> possibly can take more easily a higher frequency, but are less
> tolerant if you take a frequency lower than the nominal.
>
> And we cannot remove that check entirely, since some bridges will
> report out of range frequencies for higher modes that we know we
> cannot reach.
>
> We could just try to see if the screen pixel clock frequency is out of
> the pixel clock range we can generate, but then we will loop back on
> how much out of range is it exactly, and is it within the screen
> tolerancy.
>
> We have an API to deal with the panel tolerancies in the DRM panel
> framework, we can (and should) use it.
>
> I'm not sure how others usually deal with this though. I think I
> remember Eric telling me that for the RPi they just adjusted the
> timings a bit, but they only really had a single panel to deal with.
>
> Daniel, Eric, Laurent, Sean? Any ideas?

This time I found a non-generic panel, "qiaodian,qd43003c0-40",
available as an accessary of Lichee Pi One/Zero (A13/V3s) boards,
which needs this fix to work.

The problem now is just the driver cannot support several panels.

If you want, here's the panel's datasheet:
https://github.com/Zepan/lichee-pi-zero/blob/master/HardWare/IC/3_Display_LCD_QD043003C0-40-7LED%E4%BA%A7%E5%93%81%E8%A7%84%E6%A0%BC%E4%B9%A6.pdf

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
> ,
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
