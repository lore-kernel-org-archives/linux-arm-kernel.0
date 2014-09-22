From: will.deacon@arm.com (Will Deacon)
Date: Mon, 22 Sep 2014 16:23:28 +0100
Subject: [PATCH 1/2] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <1410460244-18943-2-git-send-email-mitchelh@codeaurora.org>
References: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
 <1410460244-18943-2-git-send-email-mitchelh@codeaurora.org>
Message-ID: <20140922152328.GO25809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mitch, Matt,

On Thu, Sep 11, 2014 at 07:30:43PM +0100, Mitchel Humpherys wrote:
> From: Matt Wagantall <mattw@codeaurora.org>
> 
> It is sometimes necessary to poll a memory-mapped register until its
> value satisfies some condition. Introduce a family of convenience macros
> that do this. Tight-loop and sleeping versions are provided with and
> without timeouts.

[...]

> +/**
> + * readl_poll_timeout_noirq - Periodically poll an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @max_reads: Maximum number of reads before giving up
> + * @time_between_us: Time to udelay() between successive reads
> + *
> + * Returns 0 on success and -ETIMEDOUT upon a timeout.
> + */
> +#define readl_poll_timeout_noirq(addr, val, cond, max_reads, time_between_us) \
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

I think I'd just name this one readl_poll_timeout_atomic, then drop the
helper macros you define later on. Drivers should be able to figure out the
parameters they want pretty easily and it makes it more explicit imo.

Anyway, the rest of the patch looks fine.

Will
