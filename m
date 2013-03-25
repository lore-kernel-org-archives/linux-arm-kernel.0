From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Mar 2013 22:36:23 +0000
Subject: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
In-Reply-To: <5150C16A.3040208@gmail.com>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <20130325172633.GP30923@n2100.arm.linux.org.uk> <5150C16A.3040208@gmail.com>
Message-ID: <201303252236.23270.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 March 2013, Rob Herring wrote:
> I count integrator-cp, realview, versatile and non-DT VExpress that do
> this (not surprisingly) and 25 platforms or timer implementations plus
> arm64 that do sched_clock setup in time_init. What's broken by not
> moving these earlier?

timekeeping_init() will leave the persistent_clock_exist variable as "false",
which is read in rtc_suspend() and timekeeping_inject_sleeptime().

For all I can tell, you will get a little jitter every time you
do a suspend in that case. Or perhaps it means the system clock
will be forwarded by the amount of time spent in suspend twice
after wakeup, but I'm probably misreading the code for that case.

	Arnd
