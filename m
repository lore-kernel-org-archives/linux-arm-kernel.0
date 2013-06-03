From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Jun 2013 23:12:11 +0100
Subject: [PATCHv2 4/6] sched_clock: Add support for >32 bit sched_clock
In-Reply-To: <51AD069F.1060308@codeaurora.org>
References: <1370155183-31421-1-git-send-email-sboyd@codeaurora.org>
 <1370155183-31421-5-git-send-email-sboyd@codeaurora.org>
 <20130603093938.GG18614@n2100.arm.linux.org.uk>
 <51AD069F.1060308@codeaurora.org>
Message-ID: <20130603221210.GO18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 03, 2013 at 02:11:59PM -0700, Stephen Boyd wrote:
> On 06/03/13 02:39, Russell King - ARM Linux wrote:
> > On Sat, Jun 01, 2013 at 11:39:41PM -0700, Stephen Boyd wrote:
> >> +}
> >> +
> >> +void __init
> >> +setup_sched_clock_64(u64 (*read)(void), int bits, unsigned long rate)
> >> +{
> >> +	if (cd.rate > rate)
> >> +		return;
> >> +
> >> +	BUG_ON(bits <= 32);
> >> +	WARN_ON(!irqs_disabled());
> >> +	read_sched_clock_64 = read;
> >> +	sched_clock_func = sched_clock_64;
> >> +	cd.rate = rate;
> >> +	cd.mult = NSEC_PER_SEC / rate;
> > Here, you don't check that the (2^bits) * mult results in a wrap of the
> > resulting 64-bit number, which is a _basic_ requirement for sched_clock
> > (hence all the code for <=32bit clocks, otherwise we wouldn't need this
> > complexity in the first place.)
> 
> Ok I will use clocks_calc_mult_shift() here.

No, that's not the problem.

If you have a 56-bit clock which ticks at a period of 1ns, then
cd.rate = 1, and your sched_clock() values will be truncated to 56-bits.
The scheduler always _requires_ 64-bits from sched_clock.  That's why we
have the complicated code to extend the 32-bits-or-less to a _full_
64-bit value.

Let me make this clearer: sched_clock() return values _must_ without
exception monotonically increment from zero to 2^64-1 and then wrap
back to zero.  No other behaviour is acceptable for sched_clock().
