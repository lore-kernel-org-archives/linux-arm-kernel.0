From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 10:40:26 +0100
Subject: [RFC/PATCH 3/7] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <1404147116-4598-4-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-4-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140701094026.GJ28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

On Mon, Jun 30, 2014 at 05:51:52PM +0100, Olav Haugan wrote:
> From: Matt Wagantall <mattw@codeaurora.org>
> 
> It is sometimes necessary to poll a memory-mapped register until its
> value satisfies some condition. Introduce a family of convenience macros
> that do this. Tight-loop and sleeping versions are provided with and
> without timeouts.

We could certainly use something like this in the SMMU and GICv3 drivers, so
I agree that it makes sense for this to be in generic code.

> +/**
> + * readl_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @sleep_us: Maximum time to sleep between reads in uS (0 tight-loops)
> + * @timeout_us: Timeout in uS, 0 means never timeout

I think 0 should actually mean `use the default timeout', which could be
something daft like 1s. Removing the timeout is asking for kernel lock-ups.
We could also have a version without the timeout parameter at all, which
acts like a timeout of 0.

> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> + * case, the last read value at @addr is stored in @val. Must not
> + * be called from atomic context if sleep_us or timeout_us are used.
> + */
> +#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
> +({ \
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> +	might_sleep_if(timeout_us); \
> +	for (;;) { \
> +		(val) = readl(addr); \
> +		if (cond) \
> +			break; \
> +		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
> +			(val) = readl(addr); \
> +			break; \
> +		} \
> +		if (sleep_us) \
> +			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
> +	} \
> +	(cond) ? 0 : -ETIMEDOUT; \
> +})
> +
> +/**
> + * readl_poll_timeout_noirq - Periodically poll an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @max_reads: Maximum number of reads before giving up

I don't think max_reads is a useful tunable.

> + * @time_between_us: Time to udelay() between successive reads
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout.
> + */
> +#define readl_poll_timeout_noirq(addr, val, cond, max_reads, time_between_us) \

Maybe readl_poll_[timeout_]atomic is a better name?

> +({ \
> +	int count; \
> +	for (count = (max_reads); count > 0; count--) { \
> +		(val) = readl(addr); \
> +		if (cond) \
> +			break; \
> +		udelay(time_between_us); \
> +	} \
> +	(cond) ? 0 : -ETIMEDOUT; \
> +})
> +
> +/**
> + * readl_poll - Periodically poll an address until a condition is met
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @sleep_us: Maximum time to sleep between reads in uS (0 tight-loops)
> + *
> + * Must not be called from atomic context if sleep_us is used.
> + */
> +#define readl_poll(addr, val, cond, sleep_us) \
> +	readl_poll_timeout(addr, val, cond, sleep_us, 0)

Good idea ;)

> +/**
> + * readl_tight_poll_timeout - Tight-loop on an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @timeout_us: Timeout in uS, 0 means never timeout
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
> + * case, the last read value at @addr is stored in @val. Must not
> + * be called from atomic context if timeout_us is used.
> + */
> +#define readl_tight_poll_timeout(addr, val, cond, timeout_us) \
> +	readl_poll_timeout(addr, val, cond, 0, timeout_us)
> +
> +/**
> + * readl_tight_poll - Tight-loop on an address until a condition is met
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + *
> + * May be called from atomic context.
> + */
> +#define readl_tight_poll(addr, val, cond) \
> +	readl_poll_timeout(addr, val, cond, 0, 0)

This would be readl_poll_timeout_atomic if you went with my suggestion (i.e.
readl_poll_timeout would have an unconditional might_sleep).

What do you reckon?

Will
