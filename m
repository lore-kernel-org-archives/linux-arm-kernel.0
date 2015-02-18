From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Feb 2015 12:50:39 -0600
Subject: [PATCH v2 4/4] clk: dt: Introduce always-on clock domain
 documentation
In-Reply-To: <20150218171230.GA30676@x1>
References: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
 <1424276101-30137-5-git-send-email-lee.jones@linaro.org>
 <CAL_Jsq+r1BKt5B9FNPG+Y0Oi1-3RGNmRUDbpX_uDJwr45bxMXA@mail.gmail.com>
 <20150218171230.GA30676@x1>
Message-ID: <CAL_JsqJ0sfQ-OQvYjL3X3ebH4p9HkN4iy35iT7i9S2d+yz9zYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 11:12 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Feb 2015, Rob Herring wrote:
>
>> On Wed, Feb 18, 2015 at 10:15 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> > ---
>> >  .../devicetree/bindings/clock/clk-domain.txt       | 35 ++++++++++++++++++++++
>> >  1 file changed, 35 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/clock/clk-domain.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/clock/clk-domain.txt b/Documentation/devicetree/bindings/clock/clk-domain.txt
>> > new file mode 100644
>> > index 0000000..b86772f5
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/clock/clk-domain.txt
>> > @@ -0,0 +1,35 @@
>> > +Always-on Clock Domain
>> > +
>> > +Some hardware is contains bunches of clocks which must never be
>> > +turned off.  If drivers a) fail to obtain a reference to any of
>> > +these or b) give up a previously obtained reference during suspend,
>> > +the common clk framework will attempt to disable them and the
>> > +hardware can fail irrecoverably.  Usually, the only way to recover
>> > +from these failures is to restart.
>>
>> How is (b) not a bug?
>
> Clocks are normally disabled during suspend.  When clocks are disabled
> they give up their reference.  If references reach 0, the clock is
> gated.  If one of these clocks is gated, the system will never come
> out of suspend.
>
> How is it a bug?

It a clock needs to be enabled during suspend, then the driver using
it should not disable it. Anyway, suspend is a bit orthogonal to this
issue.

>> While I think we need something here, I worry that this will be abused
>> to be a list of clocks you have not gotten around to managing. We
>
> You can say that about any framework.  It's our responsibility to ask
> the right questions and to disallow it from being abused.  The clocks
> I use in the (real-world) example in this set are _really_ always-on.
> If any of them are turned off the system will cease to perform in any
> meaningful way.

You cannot tell here up front whether clocks are really always-on. A
reviewer is not going to know, and the submitter may not even have all
the documentation and know the answer. Getting it wrong here means you
have to change the dtb to fix it. Granted, it doesn't really break
things in this case.

>> cannot be changing the DT every time the kernel starts managing a
>> clock. I think this should operate more as always on until claimed.
>
> The point of this is that even when these clocks are claimed, there is
> an issue that when unclaimed (i.e. during suspend) the clk framework
> will attempt to gate them, and when they do *boom*.
>
>> But then you get into drivers having to be aware that the clock
>> started enabled.
>
> This has nothing to do with the initial state of the clock.  It's
> whether the clock is integral (i.e. is part of a vital interconnect)
> that's important.  For instance, ST's bootloader turns on lots of
> clocks which can be safely gated if unused.  The clocks we're
> registering with this always-on framework cannot.

It does because you have to assume either the initial state is wrong
and you need to disable it, or that the initial state is correct and
you need to leave the clock enabled.

There are also other usecases such as simplefb where you want to leave
clocks on until the real fb driver takes over. Consoles have a similar
issue.

Perhaps you need to model your buses more completely? Does
simple-pm-bus help you?

>> Also, I feel like we are using DT to work around kernel policy (of
>> turning off clocks). If the policy was to leave on clocks, then we
>> would be trying to put a list of clocks to disable in DT.
>
> I'm not sure I understand your point.  The current policy is correct
> if it's power that you care about, which is invariably the point of
> disabling clocks in the first place, right?  Also, this has nothing to
> do with DT per say.  It's just another framework driver.

It does have something to do with DT because you are designing a
binding around what the kernel does. Should the kernel assume it can
disable clocks safely? Another OS may do the opposite and assume it
cannot turn-off unused clocks. Then you would have a list of clocks
safe to disable in DT.

This is also completely solvable within the framework driver by
claiming those clocks in the clock controller driver.

Rob
