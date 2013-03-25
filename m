From: john.stultz@linaro.org (John Stultz)
Date: Mon, 25 Mar 2013 15:53:01 -0700
Subject: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
In-Reply-To: <201303252236.23270.arnd@arndb.de>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <20130325172633.GP30923@n2100.arm.linux.org.uk> <5150C16A.3040208@gmail.com>
 <201303252236.23270.arnd@arndb.de>
Message-ID: <5150D54D.1070004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 03:36 PM, Arnd Bergmann wrote:
> On Monday 25 March 2013, Rob Herring wrote:
>> I count integrator-cp, realview, versatile and non-DT VExpress that do
>> this (not surprisingly) and 25 platforms or timer implementations plus
>> arm64 that do sched_clock setup in time_init. What's broken by not
>> moving these earlier?
> timekeeping_init() will leave the persistent_clock_exist variable as "false",
> which is read in rtc_suspend() and timekeeping_inject_sleeptime().

Are you mixing up the persistent_clock and sched_clock here? From a 
generic stand-point they have different requirements.

> For all I can tell, you will get a little jitter every time you
> do a suspend in that case. Or perhaps it means the system clock
> will be forwarded by the amount of time spent in suspend twice
> after wakeup, but I'm probably misreading the code for that case.

No, you shouldn't see timekeeping being incremented twice, we check in 
rtc_resume code if the persistent clock is present if so we won't inject 
any measured suspend time there. But you're probably right that we're 
being a little overly paranoid checking the same value twice.

As far as the benefit to the persistent clock: it is just a little 
better to use, since we can access it earlier in resume, prior to 
interrupts being enabled. So we should see less time error introduced 
each suspend.

thanks
-john
