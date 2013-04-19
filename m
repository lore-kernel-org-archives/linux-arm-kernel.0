From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Apr 2013 17:27:02 +0100
Subject: [PATCH v2 3/3] ARM: arch_timer: use full 64-bit counter for
 sched_clock
In-Reply-To: <1364849914-26420-4-git-send-email-robherring2@gmail.com>
References: <1364849914-26420-1-git-send-email-robherring2@gmail.com>
 <1364849914-26420-4-git-send-email-robherring2@gmail.com>
Message-ID: <20130419162702.GW14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 01, 2013 at 03:58:34PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Only 32-bits of the arch timer were being used and wrapping was needlessly
> being done in s/w. By using the full counter (56-64 bits), we don't need
> to deal with wrapping and can simplify the implementation when using
> arch timer.

Remember that you _must_ provide the full 64-bit nsec value to the
scheduler.  A 56-bit value will not do, it has to be the full 64-bits
of nsecs.  So:

> +static unsigned long long notrace arch_timer_sched_clock(void)
>  {
> -	return arch_timer_read_counter();
> +	return arch_timer_read_counter() * sched_clock_mult;
...
> +	/* Cache the sched_clock multiplier to save a divide in the hot path. */
> +	sched_clock_mult = NSEC_PER_SEC / arch_timer_rate;

If the counter is 56-bit and the multiplier is not larger than 255,
then you have a potential problem here.  That basically translates
into a clock rate of no more than 3.9MHz for the architected timer
if it is 56-bit.
