From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 30 Jun 2014 21:46:37 +0200
Subject: [RFC/PATCH 3/7] iopoll: Introduce memory-mapped IO polling macros
In-Reply-To: <1404147116-4598-4-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-4-git-send-email-ohaugan@codeaurora.org>
Message-ID: <20140630194631.GD32594@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 09:51:52AM -0700, Olav Haugan wrote:
[...]
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
[...]
> +/**
> + * readl_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
> + * @addr: Address to poll
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @sleep_us: Maximum time to sleep between reads in uS (0 tight-loops)

s/uS/us/ here and elsewhere. S is the symbol for Siemens.

> + * @timeout_us: Timeout in uS, 0 means never timeout
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

Why can't these be functions?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140630/67f196b9/attachment.sig>
