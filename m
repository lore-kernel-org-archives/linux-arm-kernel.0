From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 10 Jul 2011 11:47:40 +0100
Subject: [PATCH V3 1/4] ARM: smp_twd: Fix typo in 'twd_timer_rate' printing
In-Reply-To: <4E15DCE1.8010201@mvista.com>
References: <1310041339-2348-1-git-send-email-vkuzmichev@mvista.com>
	<1310041396-2461-1-git-send-email-vkuzmichev@mvista.com>
	<20110707123907.GP8286@n2100.arm.linux.org.uk>
	<4E15DCE1.8010201@mvista.com>
Message-ID: <20110710104740.GD4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 08:20:49PM +0400, Vitaly Kuzmichev wrote:
> Hi Russell,
> 
> On 07/07/2011 04:39 PM, Russell King - ARM Linux wrote:
> > On Thu, Jul 07, 2011 at 04:23:13PM +0400, Vitaly Kuzmichev wrote:
> >> To get hundredths of MHz the rate needs to be divided by 10'000.
> >> Here is an example:
> >>  twd_timer_rate = 123456789
> >>  Before the patch:
> >>     twd_timer_rate / 1000000 = 123
> >>     (twd_timer_rate / 1000000) % 100 = 23
> >>     Result: 123.23MHz.
> >>  After being fixed:
> >>     twd_timer_rate / 1000000 = 123
> >>     (twd_timer_rate / 10000) % 100 = 45
> >>     Result: 123.45MHz.
> >>
> >> Signed-off-by: Vitaly Kuzmichev <vkuzmichev@mvista.com>
> > 
> > -> patch system please.
> 
> Should I submit other patches into this system too?

No, the other patches I've yet to look at, and I think there's issues
still to be resolved.

Eg, ISTR a patch to make smp_twd.c selectable on non-SMP platforms so
that the mpcore watchdog can be used on non-SMP platforms.  While that
fixes the build issues, functionally its broken.  I don't think that
the mpcore watchdog should be asking the smp_twd code in any case for
the clock rate.

If we get the issue with knowing the TWD clock rate on ARMs development
platforms sorted out, then we can provide a struct clk for it, which
means everyone can finally move to using the clk API to get the mpcore
watchdog/twd clock rate.
