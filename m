From: robherring2@gmail.com (Rob Herring)
Date: Wed, 18 Feb 2015 17:45:39 -0600
Subject: [PATCH v2 4/4] clk: dt: Introduce always-on clock domain
 documentation
In-Reply-To: <20150218215435.GA32415@x1>
References: <1424276101-30137-1-git-send-email-lee.jones@linaro.org>
 <1424276101-30137-5-git-send-email-lee.jones@linaro.org>
 <CAL_Jsq+r1BKt5B9FNPG+Y0Oi1-3RGNmRUDbpX_uDJwr45bxMXA@mail.gmail.com>
 <20150218171230.GA30676@x1>
 <CAL_JsqJ0sfQ-OQvYjL3X3ebH4p9HkN4iy35iT7i9S2d+yz9zYg@mail.gmail.com>
 <20150218215435.GA32415@x1>
Message-ID: <CAL_JsqKVGhopYsv_bxaiBo3f=K7GbGK2j8_dPxqA5uvUcpcnqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 3:54 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 18 Feb 2015, Rob Herring wrote:
>
>> On Wed, Feb 18, 2015 at 11:12 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Wed, 18 Feb 2015, Rob Herring wrote:
>> >
>> >> On Wed, Feb 18, 2015 at 10:15 AM, Lee Jones <lee.jones@linaro.org> wrote:
>> >> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
>> >> > ---
>> >> >  .../devicetree/bindings/clock/clk-domain.txt       | 35 ++++++++++++++++++++++
>> >> >  1 file changed, 35 insertions(+)
>> >> >  create mode 100644 Documentation/devicetree/bindings/clock/clk-domain.txt
>> >> >
>> >> > diff --git a/Documentation/devicetree/bindings/clock/clk-domain.txt b/Documentation/devicetree/bindings/clock/clk-domain.txt
>> >> > new file mode 100644
>> >> > index 0000000..b86772f5
>> >> > --- /dev/null
>> >> > +++ b/Documentation/devicetree/bindings/clock/clk-domain.txt
>> >> > @@ -0,0 +1,35 @@
>> >> > +Always-on Clock Domain
>> >> > +
>> >> > +Some hardware is contains bunches of clocks which must never be
>> >> > +turned off.  If drivers a) fail to obtain a reference to any of
>> >> > +these or b) give up a previously obtained reference during suspend,
>> >> > +the common clk framework will attempt to disable them and the
>> >> > +hardware can fail irrecoverably.  Usually, the only way to recover
>> >> > +from these failures is to restart.
>> >>
>> >> How is (b) not a bug?
>> >
>> > Clocks are normally disabled during suspend.  When clocks are disabled
>> > they give up their reference.  If references reach 0, the clock is
>> > gated.  If one of these clocks is gated, the system will never come
>> > out of suspend.
>> >
>> > How is it a bug?
>>
>> It a clock needs to be enabled during suspend, then the driver using
>> it should not disable it. Anyway, suspend is a bit orthogonal to this
>> issue.
>
> IMO, it's not the driver's responsibility to know which clock they are
> using and whether it's a critical clock or not.

Certainly drivers should not know about clocks outside of their h/w
block, but they absolutely should know if a clock is needed for
wake-up.

>> >> While I think we need something here, I worry that this will be abused
>> >> to be a list of clocks you have not gotten around to managing. We
>> >
>> > You can say that about any framework.  It's our responsibility to ask
>> > the right questions and to disallow it from being abused.  The clocks
>> > I use in the (real-world) example in this set are _really_ always-on.
>> > If any of them are turned off the system will cease to perform in any
>> > meaningful way.
>>
>> You cannot tell here up front whether clocks are really always-on. A
>> reviewer is not going to know, and the submitter may not even have all
>> the documentation and know the answer. Getting it wrong here means you
>> have to change the dtb to fix it. Granted, it doesn't really break
>> things in this case.
>
> We should make it clear in the documentation that this framework
> should only be used if the clock is a critical "if it's turned off it
> will cripple the system" one.
>
>> >> cannot be changing the DT every time the kernel starts managing a
>> >> clock. I think this should operate more as always on until claimed.
>> >
>> > The point of this is that even when these clocks are claimed, there is
>> > an issue that when unclaimed (i.e. during suspend) the clk framework
>> > will attempt to gate them, and when they do *boom*.
>> >
>> >> But then you get into drivers having to be aware that the clock
>> >> started enabled.
>> >
>> > This has nothing to do with the initial state of the clock.  It's
>> > whether the clock is integral (i.e. is part of a vital interconnect)
>> > that's important.  For instance, ST's bootloader turns on lots of
>> > clocks which can be safely gated if unused.  The clocks we're
>> > registering with this always-on framework cannot.
>>
>> It does because you have to assume either the initial state is wrong
>> and you need to disable it, or that the initial state is correct and
>> you need to leave the clock enabled.
>
> I think the kernel's policy is a good one i.e. wait until all devices
> are probed and have had the opportunity to take the clocks they need,
> at which point we can usually safely gate the remainder.  These types
> of clocks are the exception however; hence the need for this driver.
> There are other vendors which have similar issues with their h/w.
> These are currently using bespoke versions of this implementation, but
> IMO a generic solution would be better.
>
>> There are also other usecases such as simplefb where you want to leave
>> clocks on until the real fb driver takes over. Consoles have a similar
>> issue.
>
> Why wouldn't these devices have taken references by the time
> clk_disable_unused() is called?

Not if the drivers are modules.

>> Perhaps you need to model your buses more completely?
>
> Would you mind explaining this a little more please?
>
>> Does simple-pm-bus help you?
>
> I have no idea what this is, and I'm struggling to grep for it too?

http://lwn.net/Articles/632058/

I'm not saying this works as-is for you, but people are starting to
add bus properties to buses.

>> >> Also, I feel like we are using DT to work around kernel policy (of
>> >> turning off clocks). If the policy was to leave on clocks, then we
>> >> would be trying to put a list of clocks to disable in DT.
>> >
>> > I'm not sure I understand your point.  The current policy is correct
>> > if it's power that you care about, which is invariably the point of
>> > disabling clocks in the first place, right?  Also, this has nothing to
>> > do with DT per say.  It's just another framework driver.
>>
>> It does have something to do with DT because you are designing a
>> binding around what the kernel does. Should the kernel assume it can
>> disable clocks safely?
>
> I guess it depends on what you're trying to achieve.  Personally I
> think the kernel's policy is a good one, especually with regards to
> power saving.  What are you suggesting?  A new policy?

No. The binding just has to work no matter what the OS policy.

>> Another OS may do the opposite and assume it
>> cannot turn-off unused clocks. Then you would have a list of clocks
>> safe to disable in DT.
>
> Sounds bananas.  What's good about that kind of policy?  It wouldn't
> matter anyway, both of these implementations can live harmoniously in
> the same tree.

Your systems won't go *boom*.

>> This is also completely solvable within the framework driver by
>> claiming those clocks in the clock controller driver.
>
> This conversation has now gone full circle.  This was an earlier
> suggestion, but it was considered hacky, and I'm inclined to agree.

The clock maintainer doesn't want hacks in the clock framework and the
DT maintainer doesn't want them in DT... We should put them in MFD. ;)

> An always-on power domain was deemed to be a much more elegant
> solution.

Now you are mixing in power domains?

I'm not saying we can't put something in DT. I'm okay with that, but
it needs to handle the case of the clocks do get claimed either after
boot (e.g. by a module) or in later kernels without a dtb change.

Rob
