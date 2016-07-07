From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 7 Jul 2016 09:42:17 +0200 (CEST)
Subject: [PATCH 1/9] mm: Hardened usercopy
In-Reply-To: <1467843928-29351-2-git-send-email-keescook@chromium.org>
References: <1467843928-29351-1-git-send-email-keescook@chromium.org>
 <1467843928-29351-2-git-send-email-keescook@chromium.org>
Message-ID: <alpine.DEB.2.11.1607070938430.4083@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2016, Kees Cook wrote:
> +
> +#if defined(CONFIG_FRAME_POINTER) && defined(CONFIG_X86)
> +	const void *frame = NULL;
> +	const void *oldframe;
> +#endif

That's ugly

> +
> +	/* Object is not on the stack at all. */
> +	if (obj + len <= stack || stackend <= obj)
> +		return 0;
> +
> +	/*
> +	 * Reject: object partially overlaps the stack (passing the
> +	 * the check above means at least one end is within the stack,
> +	 * so if this check fails, the other end is outside the stack).
> +	 */
> +	if (obj < stack || stackend < obj + len)
> +		return -1;
> +
> +#if defined(CONFIG_FRAME_POINTER) && defined(CONFIG_X86)
> +	oldframe = __builtin_frame_address(1);
> +	if (oldframe)
> +		frame = __builtin_frame_address(2);
> +	/*
> +	 * low ----------------------------------------------> high
> +	 * [saved bp][saved ip][args][local vars][saved bp][saved ip]
> +	 *		     ^----------------^
> +	 *             allow copies only within here
> +	 */
> +	while (stack <= frame && frame < stackend) {
> +		/*
> +		 * If obj + len extends past the last frame, this
> +		 * check won't pass and the next frame will be 0,
> +		 * causing us to bail out and correctly report
> +		 * the copy as invalid.
> +		 */
> +		if (obj + len <= frame)
> +			return obj >= oldframe + 2 * sizeof(void *) ? 2 : -1;
> +		oldframe = frame;
> +		frame = *(const void * const *)frame;
> +	}
> +	return -1;
> +#else
> +	return 1;
> +#endif

I'd rather make that a weak function returning 1 which can be replaced by
x86 for CONFIG_FRAME_POINTER=y. That also allows other architectures to
implement their specific frame checks.

Thanks,

	tglx
