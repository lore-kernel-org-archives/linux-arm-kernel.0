From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 May 2014 18:24:59 +0100
Subject: [PATCH v2 09/11] arm64/crypto: add voluntary preemption to
 Crypto Extensions SHA1
In-Reply-To: <1400091451-9117-10-git-send-email-ard.biesheuvel@linaro.org>
References: <1400091451-9117-1-git-send-email-ard.biesheuvel@linaro.org>
 <1400091451-9117-10-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140515172458.GE1499@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 07:17:29PM +0100, Ard Biesheuvel wrote:
> The Crypto Extensions based SHA1 implementation uses the NEON register file,
> and hence runs with preemption disabled. This patch adds a TIF_NEED_RESCHED
> check to its inner loop so we at least give up the CPU voluntarily when we
> are running in process context and have been tagged for preemption by the
> scheduler.

Sorry, I haven't got to the bottom of your series earlier and I now
realised that the last patches are not just new crypto algorithms.

> +static u8 const *sha1_do_update(struct shash_desc *desc, const u8 *data,
> +				int blocks, u8 *head, unsigned int len)
> +{
> +	struct sha1_state *sctx = shash_desc_ctx(desc);
> +	struct thread_info *ti = NULL;
> +
> +	/*
> +	 * Pass current's thread info pointer to sha1_ce_transform()
> +	 * below if we want it to play nice under preemption.
> +	 */
> +	if ((IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY) || IS_ENABLED(CONFIG_PREEMPT))
> +	    && (desc->flags & CRYPTO_TFM_REQ_MAY_SLEEP))
> +		ti = current_thread_info();
> +
> +	do {
> +		int rem;
> +
> +		kernel_neon_begin_partial(16);
> +		rem = sha1_ce_transform(blocks, data, sctx->state, head, 0, ti);
> +		kernel_neon_end();
> +
> +		data += (blocks - rem) * SHA1_BLOCK_SIZE;
> +		blocks = rem;
> +		head = NULL;
> +	} while (unlikely(ti && blocks > 0));
> +	return data;
> +}

What latencies are we talking about? Would it make sense to always
call cond_resched() even if preemption is disabled?

With PREEMPT_VOLUNTARY I don't think the above code does any voluntary
preemption. The preempt_enable() in kernel_neon_end() only reschedules
if PREEMPT.

But I think we should have this loop always rescheduling if
CRYPTO_TFM_REQ_MAY_SLEEP. I can see there is a crypto_yield() function
that conditionally reschedules. What's the overhead of calling
sha1_ce_transform() in a loop vs a single call for the entire data?

-- 
Catalin
