From: jussi.kivilinna@iki.fi (Jussi Kivilinna)
Date: Tue, 13 May 2014 21:58:51 +0300
Subject: [PATCH resend 13/15] arm64/crypto: add voluntary preemption to
 Crypto Extensions SHA1
In-Reply-To: <1398959486-8222-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1398959486-8222-1-git-send-email-ard.biesheuvel@linaro.org>
 <1398959486-8222-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <53726B6B.6070007@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.05.2014 18:51, Ard Biesheuvel wrote:
> The Crypto Extensions based SHA1 implementation uses the NEON register file,
> and hence runs with preemption disabled. This patch adds a TIF_NEED_RESCHED
> check to its inner loop so we at least give up the CPU voluntarily when we
> are running in process context and have been tagged for preemption by the
> scheduler.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
<snip>
> @@ -42,6 +42,7 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
>  	sctx->count += len;
>  
>  	if ((partial + len) >= SHA1_BLOCK_SIZE) {
> +		struct thread_info *ti = NULL;
>  		int blocks;
>  
>  		if (partial) {
> @@ -52,16 +53,30 @@ static int sha1_update(struct shash_desc *desc, const u8 *data,
>  			len -= p;
>  		}
>  
> +		/*
> +		 * Pass current's thread info pointer to sha1_ce_transform()
> +		 * below if we want it to play nice under preemption.
> +		 */
> +		if ((IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY) ||
> +		     IS_ENABLED(CONFIG_PREEMPT)) && !in_interrupt())
> +			ti = current_thread_info();
> +
>  		blocks = len / SHA1_BLOCK_SIZE;
>  		len %= SHA1_BLOCK_SIZE;
>  
> -		kernel_neon_begin_partial(16);
> -		sha1_ce_transform(blocks, data, sctx->state,
> -				  partial ? sctx->buffer : NULL, 0);
> -		kernel_neon_end();
> +		do {
> +			int rem;
> +
> +			kernel_neon_begin_partial(16);
> +			rem = sha1_ce_transform(blocks, data, sctx->state,
> +						partial ? sctx->buffer : NULL,
> +						0, ti);
> +			kernel_neon_end();
>  
> -		data += blocks * SHA1_BLOCK_SIZE;
> -		partial = 0;
> +			data += (blocks - rem) * SHA1_BLOCK_SIZE;
> +			blocks = rem;
> +			partial = 0;
> +		} while (unlikely(ti && blocks > 0));
>  	}
>  	if (len)
>  		memcpy(sctx->buffer + partial, data, len);
> @@ -94,6 +109,7 @@ static int sha1_finup(struct shash_desc *desc, const u8 *data,
>  		      unsigned int len, u8 *out)
>  {
>  	struct sha1_state *sctx = shash_desc_ctx(desc);
> +	struct thread_info *ti = NULL;
>  	__be32 *dst = (__be32 *)out;
>  	int blocks;
>  	int i;
> @@ -111,9 +127,20 @@ static int sha1_finup(struct shash_desc *desc, const u8 *data,
>  	 */
>  	blocks = len / SHA1_BLOCK_SIZE;
>  
> -	kernel_neon_begin_partial(16);
> -	sha1_ce_transform(blocks, data, sctx->state, NULL, len);
> -	kernel_neon_end();
> +	if ((IS_ENABLED(CONFIG_PREEMPT_VOLUNTARY) ||
> +	     IS_ENABLED(CONFIG_PREEMPT)) && !in_interrupt())
> +		ti = current_thread_info();
> +
> +	do {
> +		int rem;
> +
> +		kernel_neon_begin_partial(16);
> +		rem = sha1_ce_transform(blocks, data, sctx->state,
> +					NULL, len, ti);
> +		kernel_neon_end();
> +		data += (blocks - rem) * SHA1_BLOCK_SIZE;
> +		blocks = rem;
> +	} while (unlikely(ti && blocks > 0));
>  

These seem to be similar, how about renaming assembly function to __sha1_ce_transform
and moving this loop to new sha1_ce_transform.

Otherwise, patches looks good.

-Jussi
