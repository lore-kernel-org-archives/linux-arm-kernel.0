From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 25 Mar 2013 18:00:07 +0000
Subject: [PATCHv3 01/10] clocksource: add generic dummy timer driver
In-Reply-To: <5150800E.2000905@codeaurora.org>
References: <1363198676-30417-1-git-send-email-sboyd@codeaurora.org>
 <1363198676-30417-2-git-send-email-sboyd@codeaurora.org>
 <20130321180922.GB10716@e106331-lin.cambridge.arm.com>
 <514B4DBD.4060403@codeaurora.org>
 <20130322180305.GB1436@e106331-lin.cambridge.arm.com>
 <5150800E.2000905@codeaurora.org>
Message-ID: <20130325180007.GA4065@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 04:49:18PM +0000, Stephen Boyd wrote:
> On 03/22/13 11:03, Mark Rutland wrote:
> > On Thu, Mar 21, 2013 at 06:13:17PM +0000, Stephen Boyd wrote:
> >> On 03/21/13 11:09, Mark Rutland wrote:
> >>> Hi Stephen,
> >>>
> >>> I've just been trying to test the dummy timer, and realised it's broken, as it
> >>> registers a cpu notifier from a device_initcall (after SMP's been brought up),
> >>> and doesn't ensure all active CPUs have been set up. Evidently no-one else has
> >>> attempted to test it thus far, and I'm not able to throughly test it at the
> >>> moment.
> >> Would it be sufficient to register as a pre-smp initcall?
> > I've looked a bit further into the problem, and I believe using early_initcall
> > will make it work as well as the current arm-specific dummy timers work with a
> > rating of 100 (this means the recent patch lowering the rating broke tc2 as
> > explained below).
> 
> Yes, moving to early_initcall() should make the dummy timer equivalent
> to the code that is already in the arm directory. It sounds like there
> is a problem with mainline though?

Sorry, I rushed writing my earlier email in an attempt to get something on the
list, I should've spent some time making it clearer.

Using early_initcall will make it equivalent to the current code.

Unfortunately the existing code's current rating of 100 (as of Santosh's patch
[1]) breaks running an SMP system without local timers (at least using the
sp804 as a broadcast source on tc2 with architected timer support disabled).

It seems my patch making the timer core always reject dummy timers as broadcast
sources hasn't gotten to mainline yet, so we can't revert the patch without
breaking the platform Santosh noticed the problem on.

Thomas, do you have an idea of if/when tip/timers/urgent will hit mainline?

> 
> >
> > I've spent the last few hours trying to get the dummy_timer driver working on
> > tc2 with the sp804 as the broadcast source (with architected timer support
> > disabled). It turns out that having dummy timer's rating so low means that it
> > won't be selected as the tick device on cpu0 in preference to the sp804, and
> > thus won't push the sp804 out of that spot (allowing it to become the broadcast
> > source). This leads to boot stalling.
> 
> I'm not following here. Why would we want to remove sp804 from the tick
> duty?

To run an SMP system without local timers, we need the sp804 to be the
broadcast timer. Unfortunately the tick device and broadcast timer are mutually
exclusive positions, so we need to have a dummy timer knock the sp804 out of
tick device duty to enable broadcast.

When the dummy timer's rating was 400 (against the sp804's 350), this worked.
The sp804 would be registered, and would become cpu0's tick device. Later the
dummy would get registered, knocking the sp804 out (whereupon it would get
cycled back through tick_check_new_device and become the broadcast timer).

With the dummy timer's rating lower, the sp804 stays as cpu0's tick device, all
other cpus get dummy timers, but there's no broadcast source, so the system
locks up waiting for secondary cpus.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/154582.html
