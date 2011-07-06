From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jul 2011 12:04:39 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <1309945678-18813-2-git-send-email-bs14@csr.com>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<1309945678-18813-2-git-send-email-bs14@csr.com>
Message-ID: <20110706110439.GP8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 06, 2011 at 02:47:56AM -0700, Barry Song wrote:
> +static int sirfsoc_timer_set_next_event(unsigned long delta,
> +	struct clock_event_device *ce)
> +{
> +	unsigned long now, next;
> +
> +	writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
> +	now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
> +	do {
> +		next = now + delta;
> +		writel_relaxed(next, sirfsoc_timer_base + SIRFSOC_TIMER_MATCH_0);
> +		writel_relaxed(SIRFSOC_TIMER_LATCH_BIT, sirfsoc_timer_base + SIRFSOC_TIMER_LATCH);
> +		now = readl_relaxed(sirfsoc_timer_base + SIRFSOC_TIMER_LATCHED_LO);
> +	} while ((next - now) > delta);
> +
> +	return 0;
> +}

Please have a look at any of the callsites of clockevents_program_event()
in kernel/time/.  You'll notice that they loop in some fashion should your
set_next_event() return -ETIME.

As there is the possibility that if you can't program the event (because
it has already passed) then it is likely that there is some work which
needs to be done before the next event is set.  So the repeat logic should
stay in the common code and not be duplicated in each platform.
