From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Feb 2018 15:22:44 +0000
Subject: [PATCH v4] arm64: Add support for new control bits CTR_EL0.DIC
 and CTR_EL0.IDC
In-Reply-To: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
References: <1519311090-19998-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20180222152244.zozx2tlptgnnfu6b@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 22, 2018 at 08:51:30AM -0600, Shanker Donthineni wrote:
> +#define CTR_B31_SHIFT		31

Since this is just a RES1 bit, I think we don't need a mnemonic for it,
but I'll defer to Will and Catalin on that.

>  ENTRY(invalidate_icache_range)
> +#ifdef CONFIG_ARM64_SKIP_CACHE_POU
> +alternative_if ARM64_HAS_CACHE_DIC
> +	mov	x0, xzr
> +	dsb	ishst
> +	isb
> +	ret
> +alternative_else_nop_endif
> +#endif

As commented on v3, I don't believe you need the DSB here. If prior
stores haven't been completed at this point, the existing implementation
would not work correctly here.

Otherwise, this looks ok to me.

Thanks,
Mark.
