From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 7 Dec 2016 10:26:25 +0800
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <20161206172911.z6sbjzgqv3vfcrfh@lukather>
References: <20161124112231.4297-1-wens@csie.org>
 <20161206172911.z6sbjzgqv3vfcrfh@lukather>
Message-ID: <CAGb2v65uTH_PD28KqAhhzkE5zhLt54GUb7xXNxxe0xHW0A+xjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 7, 2016 at 1:29 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, Nov 24, 2016 at 07:22:31PM +0800, Chen-Yu Tsai wrote:
>> The panels shipped with Allwinner devices are very "generic", i.e.
>> they do not have model numbers or reliable sources of information
>> for the timings (that we know of) other than the fex files shipped
>> on them. The dot clock frequency provided in the fex files have all
>> been rounded to the nearest MHz, as that is the unit used in them.
>>
>> We were using the simple panel "urt,umsh-8596md-t" as a substitute
>> for the A13 Q8 tablets in the absence of a specific model for what
>> may be many different but otherwise timing compatible panels. This
>> was usable without any visual artifacts or side effects, until the
>> dot clock rate check was added in commit bb43d40d7c83 ("drm/sun4i:
>> rgb: Validate the clock rate").
>>
>> The reason this check fails is because the dotclock frequency for
>> this model is 33.26 MHz, which is not achievable with our dot clock
>> hardware, and the rate returned by clk_round_rate deviates slightly,
>> causing the driver to reject the display mode.
>>
>> The LCD panels have some tolerance on the dot clock frequency, even
>> if it's not specified in their datasheets.
>>
>> This patch adds a 5% tolerence to the dot clock check.
>
> As we discussed already, I really believe this is just as arbitrary as
> the current behaviour.

Yes. I agree. This patch is mainly to give something that works for
people who don't care about the details, and to get some feedback
from people that do.

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

I believe this should be handled by the bridge driver in the check
callback? The callback I'm changing is attached to the connector,
which I think doesn't get used if you have a bridge instead.
And this only checks the pre-registered display modes, such as
those specified in simple-panel or EDID.

> We could just try to see if the screen pixel clock frequency is out of
> the pixel clock range we can generate, but then we will loop back on
> how much out of range is it exactly, and is it within the screen
> tolerancy.
>
> We have an API to deal with the panel tolerancies in the DRM panel
> framework, we can (and should) use it.

If you mean the get_timings callback, it's not very useful. Most of
the panels in simple-panel do not use the display_timings structure,
so they don't return anything. And I get that. The few datasheets
I found don't list min/max tolerances for the dotclock.

The ones that do have the min/max the same as the recommended value.
This may or may not be accurate. IIRC the one panel that had this
that I did check didn't list min/max values in its datasheet.

>
> I'm not sure how others usually deal with this though. I think I
> remember Eric telling me that for the RPi they just adjusted the
> timings a bit, but they only really had a single panel to deal with.
>
> Daniel, Eric, Laurent, Sean? Any ideas?

Yes! Feedback please! Between Maxime and me I think we only have a
limited number of panels, with some overlap.

Regards
ChenYu

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
