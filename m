From: eric@anholt.net (Eric Anholt)
Date: Wed, 07 Dec 2016 11:16:32 -0800
Subject: [PATCH RFC] drm/sun4i: rgb: Add 5% tolerance to dot clock
 frequency check
In-Reply-To: <20161206172911.z6sbjzgqv3vfcrfh@lukather>
References: <20161124112231.4297-1-wens@csie.org>
 <20161206172911.z6sbjzgqv3vfcrfh@lukather>
Message-ID: <87oa0nbldb.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard <maxime.ripard@free-electrons.com> writes:

> [ Unknown signature status ]
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

For RPi, you just adjust the pixel clock of the panel's mode to be
whatever the platform can support, and expand the blanking intervals to
get the refresh rate back to desired.  This is nothing like what the
datasheet says, but it's not important what the datasheet says, it's
important what makes the product work.

Our clock driver looks for the best matching clock that's not over the
target rate.  This is somewhat unfortunate, as you end up slightly
inflating your requested clocks so that a possible clock lands under
that.  I'd rather we chose the closest matching clock, but then people
get worried about what if selected clock rate is 1% higher than expected
(the answer is "nothing").

I think this patch is a fine solution, and the alternative would be to
just drop the mode high/low check and say that if you're pairing a panel
with some display hardware, it's up to you to make sure that the panel's
mode actually scans out successfully.  Then, since compatible strings
are cheap, you can use a new one if necessary to attach better modes to
the panel for a particular clock driver by adjusting your timings to get
closer to the refresh rates you want.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161207/d2a9b314/attachment.sig>
