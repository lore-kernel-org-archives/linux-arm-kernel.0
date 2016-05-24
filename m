From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 May 2016 17:01:46 +0800
Subject: [PATCH 07/16] clk: sunxi-ng: Add phase clock support
In-Reply-To: <20160523170129.GB27618@lukather>
References: <1462737711-10017-1-git-send-email-maxime.ripard@free-electrons.com>
 <1462737711-10017-8-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v661dvdPKj9DWL7LWGgiDCEk7G-a_7jv5gb+KBMoWbR8Lg@mail.gmail.com>
 <20160523170129.GB27618@lukather>
Message-ID: <CAGb2v641TqdnDLAET7NPFsAgB4d4aroCWOw8G85pbOJhNs-Rnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 24, 2016 at 1:01 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, May 22, 2016 at 12:43:48AM +0800, Chen-Yu Tsai wrote:
>> > +static int ccu_phase_set_phase(struct clk_hw *hw, int degrees)
>> > +{
>> > +       struct ccu_phase *phase = hw_to_ccu_phase(hw);
>> > +       struct clk_hw *parent, *pparent;
>> > +       unsigned int parent_rate, pparent_rate;
>>
>> grandparent(_rate) would be easier to understand.
>
> Ack.
>
>>
>> > +       unsigned long flags;
>> > +       u32 reg;
>> > +       u8 delay;
>> > +
>> > +       /* Get our parent clock, it's the one that can adjust its rate */
>> > +       parent = clk_hw_get_parent(hw);
>> > +       if (!parent)
>> > +               return -EINVAL;
>> > +
>> > +       /* And its rate */
>> > +       parent_rate = clk_hw_get_rate(parent);
>> > +       if (!parent_rate)
>> > +               return -EINVAL;
>> > +
>> > +       /* Now, get our parent's parent (most likely some PLL) */
>> > +       pparent = clk_hw_get_parent(parent);
>> > +       if (!pparent)
>> > +               return -EINVAL;
>> > +
>> > +       /* And its rate */
>> > +       pparent_rate = clk_hw_get_rate(pparent);
>> > +       if (!pparent_rate)
>> > +               return -EINVAL;
>> > +
>> > +       if (degrees != 180) {
>> > +               u16 step, parent_div;
>> > +
>> > +               /* Get our parent divider */
>> > +               parent_div = pparent_rate / parent_rate;
>> > +
>> > +               /*
>> > +                * We can only outphase the clocks by multiple of the
>> > +                * PLL's period.
>> > +                *
>> > +                * Since our parent clock is only a divider, and the
>> > +                * formula to get the outphasing in degrees is deg =
>> > +                * 360 * delta / period
>> > +                *
>> > +                * If we simplify this formula, we can see that the
>> > +                * only thing that we're concerned about is the number
>> > +                * of period we want to outphase our clock from, and
>> > +                * the divider set by our parent clock.
>> > +                */
>> > +               step = DIV_ROUND_CLOSEST(360, parent_div);
>> > +               delay = DIV_ROUND_CLOSEST(degrees, step);
>>
>> Doesn't this mean some delay values are impossible to set?
>>
>> For instance, for PLL = 600 MHz and this clock = 50 MHz, div would be 12,
>> and a step would be 30 degrees. This means we can't ask for a delay of 6,
>> which is 180 degrees.
>>
>> For PLL = 600 MHz, clock = 100 MHz, div would be 6, and a step is 60
>> degrees. Therefor we can't ask for a delay of 3.
>
> You don't ask for a delay, you ask for an outphasing in degrees. In
> the hardware, in the register 0 means an outphasing of 180 degrees
> (and this has been confirmed by Allwinner a while back). In the two
> cases you point out, we would have two ways of achieving the same
> thing, we prefer one over another, but I don't see how it's
> problematic.

I guess I find the outphasing degrees not being increasing somewhat
odd...

> It's also a direct copy of the current code we have, which didn't
> raise any objection, or had any known bugs.

I had a hard time wrapping this around my head when I was working on
the MMC DDR stuff. Allwinner's code directly asks for a delay, not a
outphasing. I just checked and it seems I converted some values
incorrectly. I need to do some more tests for the A80...

Thanks for the explanation.


Regards
ChenYu

>
>> > +struct ccu_phase {
>> > +       u8                      shift;
>> > +       u8                      width;
>>
>> Not sure why you used struct ccu_factor in the divider table clock,
>> but separate fields directly in ccu_phase here.
>
> Because this is not meant for the same thing. ccu_factor is probably
> going to go away anyway because of the dividers consolidation.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
