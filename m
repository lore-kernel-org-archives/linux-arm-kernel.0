From: dianders@chromium.org (Doug Anderson)
Date: Wed, 20 Aug 2014 13:49:20 -0700
Subject: [PATCH 1/4] ARM: rockchip: rk3288: Switch to use the proper PWM IP
In-Reply-To: <9118476.CpedIJMoMR@phil>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
 <2927513.T62GI7nq9T@phil>
 <CAD=FV=U_TEi7zh=LcnfTz07yFCrOXo1SsGJ0h6-VFCVdy1GDEA@mail.gmail.com>
 <9118476.CpedIJMoMR@phil>
Message-ID: <CAD=FV=WcZKyMa3Megire6Zmd7ipFVTEH3iFinGZURHXwBH0ghg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Wed, Aug 20, 2014 at 11:03 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Mittwoch, 20. August 2014, 09:27:02 schrieb Doug Anderson:
>> Heiko,
>>
>> On Wed, Aug 20, 2014 at 9:20 AM, Heiko St?bner <heiko@sntech.de> wrote:
>> > Am Mittwoch, 20. August 2014, 08:55:09 schrieb Doug Anderson:
>> >> Thierry,
>> >>
>> >> On Wed, Aug 20, 2014 at 8:38 AM, Thierry Reding
>> >>
>> >> <thierry.reding@gmail.com> wrote:
>> >> > On Wed, Aug 20, 2014 at 08:20:53AM -0700, Doug Anderson wrote:
>> >> >> Thierry,
>> >> >>
>> >> >> On Tue, Aug 19, 2014 at 11:08 PM, Thierry Reding
>> >> >>
>> >> >> <thierry.reding@gmail.com> wrote:
>> >> >> > On Tue, Aug 19, 2014 at 08:18:54AM -0700, Doug Anderson wrote:
>> >> >> >> Thierry,
>> >> >> >>
>> >> >> >> On Tue, Aug 19, 2014 at 12:10 AM, Thierry Reding
>> >> >> >>
>> >> >> >> <thierry.reding@gmail.com> wrote:
>> >> >> >> > On Mon, Aug 18, 2014 at 10:09:06AM -0700, Doug Anderson wrote:
>> >> >> >> >> The rk3288 SoC has an option to switch all of the PWMs in the
>> >> >> >> >> system
>> >> >> >> >> between the old IP block and the new IP block.  The new IP block
>> >> >> >> >> is
>> >> >> >> >> working and tested and the suggested PWM to use, so setup the
>> >> >> >> >> SoC
>> >> >> >> >> to
>> >> >> >> >> use it and then we can pretend that the other IP block doesn't
>> >> >> >> >> exist.
>> >> >> >
>> >> >> > A few more questions as to how this actually works. Does it mean
>> >> >> > there
>> >> >> > are two physically separate blocks (with different physical
>> >> >> > addresses)
>> >> >> > to control the same PWM? And this register simply causes some of the
>> >> >> > pins to be routed to one or another? As far as I recall there are a
>> >> >> > number of instances of the PWM block, so the above would need to
>> >> >> > count
>> >> >> > for all of them. Or are there separate bits for each of them?
>> >> >>
>> >> >> All I have is the TRM (technical reference manual) which doesn't give
>> >> >> me much more info than I've provided you.  But I can answer some of
>> >> >> your questoins:
>> >> >>
>> >> >> 1. If there are two physically separate blocks then the "old" block is
>> >> >> not documented in my TRM.
>> >> >>
>> >> >> 1a) It's entirely possible it's located at some memory address that is
>> >> >> marked "Reserved" in the TRM, but I have no idea.
>> >> >>
>> >> >> 1b) It's entirely possible that the old IP block and the new IP block
>> >> >> are supposed to be "compatible" but that the old block is broken and
>> >> >> thus isn't behaving properly.
>> >> >>
>> >> >> 1c) It's entirely possible that the old IP block and the new IP block
>> >> >> are located at the same physical addresses but somehow work
>> >> >> differently.  If so, the old IP block isn't documented.
>> >> >>
>> >> >>
>> >> >> 2. As per the patch description, there is a single bit that controls
>> >> >> all of the PWMs.  My guess is that there's actually a single IP block
>> >> >> that implements all 4 PWMs.
>> >> >
>> >> > Looking at the register offsets in the device tree that seems likely.
>> >> > At
>> >> > least PWMs 0 and 1 as well as 2 and 3 seem like they could be in the
>> >> >
>> >> > same IP block. Their placement in the register map is somewhat strange:
>> >> >         pwm0: pwm at 20030000 {
>> >> >
>> >> >                 ...
>> >> >                 reg = <0x20030000 0x10>;
>> >> >                 ...
>> >> >                 clocks = <&cru PCLK_PWM01>;
>> >> >                 ...
>> >> >
>> >> >         };
>> >> >
>> >> >         pwm1: pwm at 20030010 {
>> >> >
>> >> >                 ...
>> >> >                 reg = <0x20030010 0x10>;
>> >> >                 ...
>> >> >                 clocks = <&cru PCLK_PWM01>;
>> >> >                 ...
>> >> >
>> >> >         };
>> >> >
>> >> >         ...
>> >> >
>> >> >         pwm2: pwm at 20050020 {
>> >> >
>> >> >                 ...
>> >> >                 reg = <0x20050020 0x10>;
>> >> >                 ...
>> >> >                 clocks = <&cru PCLK_PWM23>;
>> >> >                 ...
>> >> >
>> >> >         };
>> >> >
>> >> >         pwm3: pwm at 20050030 {
>> >> >
>> >> >                 ...
>> >> >                 reg = <0x20050030 0x10>;
>> >> >                 ...
>> >> >                 clocks = <&cru PCLK_PWM23>;
>> >> >                 ...
>> >> >
>> >> >         };
>> >>
>> >> Ah, you're looking at "rk3xxx.dtsi".  That doesn't apply to rk3288
>> >> (the downsides of trying to guess ahead of time what SoC vendors will
>> >> name new models).
>> >
>> > It did sound like a nice idea at the time to hold the common stuff of
>> > rk3066/rk3188 and all their derivatives and I assumed a SoC that changed
>> > dramatically (including the core) would be called 4xxx or so :-) .
>>
>> Yes, I've fallen into the same trap.  Now I jump on the bandwagon and
>> name things arbitrarily by the first machine that had them.  It's
>> confusing, but sorta less confusing too.
>
> the problem was in this case, that there also is rk3066-specific material which
> made it all the more difficult.
>
> I guess rk3066-common would have been a possibility but still sounds somewhat
> strange, or something else entirely.
>
> I'm not sure but don't think dtsi file-naming counts as API, so we can rename
> the rk3xxx.dtsi file if this gets to confusing in the future.

Yup.  Sorry, didn't mean to bring it up.  It's not a huge deal IMHO,
but if you want to submit a patch to rename I'm happy to support it.
Since the dts issues are all around people shipping device tree files
in firmware, I don't think a rename will affect anything...

-Doug
