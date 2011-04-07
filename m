From: mattias.wallin@stericsson.com (Mattias Wallin)
Date: Thu, 7 Apr 2011 09:30:43 +0200
Subject: [PATCHv5 3/3] ARM: Implement a timer based __delay() loop
In-Reply-To: <1302047800-26720-4-git-send-email-sboyd@codeaurora.org>
References: <1302047800-26720-1-git-send-email-sboyd@codeaurora.org>
	<1302047800-26720-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <4D9D6823.70704@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/2011 01:56 AM, Stephen Boyd wrote:
> udelay() can be incorrect on SMP machines that scale their CPU
> frequencies independently of one another (as pointed out here
> http://article.gmane.org/gmane.linux.kernel/977567). The delay
> loop can either be too fast or too slow depending on which CPU the
> loops_per_jiffy counter is calibrated on and which CPU the delay
> loop is running on. udelay() can also be incorrect if the
> CPU frequency switches during the __delay() loop, causing the loop
> to either terminate too early, or too late.
>
> Forcing udelay() to run on one CPU is unreasonable and taking the
> penalty of a rather large loops_per_jiffy in udelay() when the
> CPU is actually running slower is bad for performance. Solve the
> problem by adding a timer based__delay() loop unaffected by CPU
> frequency scaling. Machines should set this loop as their
> __delay() implementation by calling set_timer_fn() during their
> timer initialization.
>
> The kernel is already prepared for a timer based approach
> (evident by the read_current_timer() function). If an arch
> implements read_current_timer(), calibrate_delay() will use
> calibrate_delay_direct() to calculate loops_per_jiffy (in which
> case loops_per_jiffy should really be renamed to
> timer_ticks_per_jiffy). Since the loops_per_jiffy will be based
> on timer ticks, __delay() should be implemented as a loop around
> read_current_timer().
>
> Doing this makes the expensive loops_per_jiffy calculation go
> away (saving ~150ms on boot time on my machine) and fixes
> udelay() by making it safe in the face of independently scaling
> CPUs. The only prerequisite is that read_current_timer() is
> monotonically increasing across calls (and doesn't overflow
> within ~2000us).
>
> There is a downside to this approach though. BogoMIPS is no
> longer "accurate" in that it reflects the BogoMIPS of the timer
> and not the CPU. On most SoC's the timer isn't running anywhere
> near as fast as the CPU so BogoMIPS will be ridiculously low (my
> timer runs at 4.8 MHz and thus my BogoMIPS is 9.6 compared to my
> CPU's 800). This shouldn't be too much of a concern though since
> BogoMIPS are bogus anyway (hence the name).
>
> This loop is pretty much a copy of AVR's version.

Tested-by: Mattias Wallin <mattias.wallin@stericsson.com>

Yours,
Mattias Wallin
