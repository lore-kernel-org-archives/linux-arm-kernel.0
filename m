From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 09:56:28 +0000
Subject: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
In-Reply-To: <5150D54D.1070004@linaro.org>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <201303252236.23270.arnd@arndb.de> <5150D54D.1070004@linaro.org>
Message-ID: <201303260956.28784.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, John Stultz wrote:
> On 03/25/2013 03:36 PM, Arnd Bergmann wrote:
> > On Monday 25 March 2013, Rob Herring wrote:
> >> I count integrator-cp, realview, versatile and non-DT VExpress that do
> >> this (not surprisingly) and 25 platforms or timer implementations plus
> >> arm64 that do sched_clock setup in time_init. What's broken by not
> >> moving these earlier?
> > timekeeping_init() will leave the persistent_clock_exist variable as "false",
> > which is read in rtc_suspend() and timekeeping_inject_sleeptime().
> 
> Are you mixing up the persistent_clock and sched_clock here? From a 
> generic stand-point they have different requirements.

Ah, sorry about that. I had stumbled over the persistent_clock
issue earlier and was confusing the two.

> > For all I can tell, you will get a little jitter every time you
> > do a suspend in that case. Or perhaps it means the system clock
> > will be forwarded by the amount of time spent in suspend twice
> > after wakeup, but I'm probably misreading the code for that case.
> 
> No, you shouldn't see timekeeping being incremented twice, we check in 
> rtc_resume code if the persistent clock is present if so we won't inject 
> any measured suspend time there. But you're probably right that we're 
> being a little overly paranoid checking the same value twice.

Well, the point is that has_persistent_clock() returns false because
it is not yet active when the flag gets set in timekeeping_init(),
but when we call read_persistent_clock() in timekeeping_suspend(),
it will actually return a non-zero time.
 
> As far as the benefit to the persistent clock: it is just a little 
> better to use, since we can access it earlier in resume, prior to 
> interrupts being enabled. So we should see less time error introduced 
> each suspend.

Ok.

	Arnd
