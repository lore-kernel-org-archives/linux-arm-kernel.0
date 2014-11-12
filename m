From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 12 Nov 2014 11:12:32 -0600
Subject: [PATCH] arm64: efi: Fix stub cache maintenance
In-Reply-To: <1415810351-3462-1-git-send-email-mark.rutland@arm.com>
References: <1415810351-3462-1-git-send-email-mark.rutland@arm.com>
Message-ID: <54639500.5010309@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>  
> +	/*
> +	 * Ensure that the rest of this function (in the original Image) is
> +	 * visible when the caches are disabled. The I-cache can't have stale
> +	 * entries for the VA range of the current image, so no maintenance is
> +	 * necessary.
> +	 */
> +	adr	x0, efi_stub_entry
> +	adr	x1, efi_stub_entry_end
> +	sub	x1, x1, x0
> +	bl	__flush_dcache_area
It is my understdanding that you also need an isb here.  Tom's testing
confirms this on my patch with the dsb and without the isb. 

Also, since this is not a performance critical path it seems more
straightforward to just flush everything.  I'm happy either way.  We
will test your patch as is and let you know.
