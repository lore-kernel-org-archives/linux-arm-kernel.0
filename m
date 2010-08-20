From: robherring2@gmail.com (Rob Herring)
Date: Fri, 20 Aug 2010 16:20:26 -0500
Subject: RFC: A better clock rounding API?
In-Reply-To: <4C6B7213.3030808@codeaurora.org>
References: <4C6B7213.3030808@codeaurora.org>
Message-ID: <AANLkTik1cES4GP4hRf=B5BLrEN35B3p7rFz+tcsHDtHf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Saravana,

On Wed, Aug 18, 2010 at 12:39 AM, Saravana Kannan
<skannan@codeaurora.org> wrote:
> I'm mostly familiar with ARM. ?So I will limit the discussion to ARM
> boards/machines. ?But I think the points raised in this email would apply
> for most architectures.
>
> I'm sending this to the ARM mailing list first to see if I can get a
> consensus within the ARM community before I propose this to the wider
> audience in LKML.
>
> The meaning of clk_round_rate() is very ambiguous since the nature of the
> rounding is architecture and platform specific. ?In the case of ARM, it's up
> to each ARM mach's clock driver to determine how it wants to round the rate.
>
> To quote Russel King from an email about a month ago:
> "clk_round_rate() returns the clock rate which will be set if you ask
> clk_set_rate() to set that rate. ?It provides a way to query from the
> implementation exactly what rate you'll get if you use clk_set_rate() with
> that same argument."
>
> So when someone writes a device driver for a device that's external to the
> SoC or is integrated into more than one SoC, they currently have the
> following options to deal with clock rates differences:
>
> 1. Use clk_round_rate() to get clock rates and test their driver on the
> one/few board(s) they have at hand and hope it works on boards using
> different SoCs.
>
> 2. Add each and every needed clock rate (low power rate, high performance
> rate, handshake rate, etc) as fields to their platform data and have it
> populated in every board file that uses the device.
>
> 3. Do a search of the frequency space of the clock by making several
> clk_round_rate() calls at various intervals between their minimum and
> maximum acceptable rates and hope to find one of the supported rates. If
> clk_round_rate() does a +/- N percentage rounding and the interval is
> larger, even this searching might not find an existing rate that's supported
> between the driver's min and max acceptable rates.
>
> IMHO, each of these options have short comings that could be alleviated by
> adding a more definitive "rounding" API. ?Also, considering that it's the
> consumer of each clock that knows best what amount of rounding and in which
> direction is acceptable, IMHO the current approach of hiding the rounding
> inside the clock drivers seems counter intuitive.
>
> I would like to propose the addition of either:
>
> long clk_find_rate(struct clk *clk,
> ? ? ? ? ? ? ? ? ? ? ? ?unsigned long min_rate,
> ? ? ? ? ? ? ? ? ? ? ? ?long max_rate);
>
> or
>
> long clk_find_rate(struct clk *clk,
> ? ? ? ? ? ? ? ? ? ? ? ?unsigned long start_rate,
> ? ? ? ? ? ? ? ? ? ? ? ?long end_rate);
>
> The advantage of the 2nd suggestion is that it allows a driver to specify
> which end of a frequency range it prefers. ?But I'm not sure how important
> of an advantage that is. ?So, proposing both and having the community decide
> which one, if any, is acceptable.
>
> If the clk_find_rate() API is available, the driver developer wouldn't have
> to worry about figuring out a way for the clk_set_rate() to work on
> different platforms/machs/SoCs. If a platform/mach/SoC can provide a clock
> rate that's acceptable to their hardware and software requirements, then
> they can be assured to find it without having to jump through hoops or
> having a driver not work when it could have.
>
> Does the addition of one of the suggested APIs sound reasonable? If not, can
> someone explain what the right/better solution is? If the addition of a new
> API is reasonable, what's the community preference between the two
> suggestion? If I submit a patch that will add one of the APIs is it likely
> to be accepted?
>
> Thanks for your time.
>

This is still ambiguous. If there are multiple valid frequencies in
the range, is the preferred rate returned the lowest rate or highest
rate in the range? For something like an SD bus clock you would want
the maximum rate within the range. For something like a LCD pixel
clock or CMOS sensor input clock, you typically only need to be
greater than a certain minimum freq and for power reasons you want it
to be closest to the minimum.

Perhaps adding a flag to clk_round_rate to indicate to round up, down,
or smallest delta would be sufficient.

Rob
