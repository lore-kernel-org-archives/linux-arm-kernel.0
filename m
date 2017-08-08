From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Aug 2017 16:31:12 +0100
Subject: [PATCHv2 1/7] arm64: Add ASM_BUG()
In-Reply-To: <1501093110-3844-2-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
 <1501093110-3844-2-git-send-email-mark.rutland@arm.com>
Message-ID: <20170808153112.GF19207@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 07:18:24PM +0100, Mark Rutland wrote:
> +#define __BUG_ENTRY(flags) 				\
> +		.pushsection __bug_table,"a";		\
> +		.align 2;				\
> +	0:	.long 1f - 0b;				\
> +_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
> +		.short flags; 				\
> +		.popsection;				\
> +	1:
> +#else
> +#define __BUG_ENTRY(flags)
> +#endif
> +
> +#define ASM_BUG_FLAGS(flags)				\
> +	__BUG_ENTRY(0)					\
> +	brk	BUG_BRK_IMM

I accidentally dropped the flags here, which turns all WARN*s into BUGs.

I've fixed this up to pass the flags to __BUG_ENTRY(). I've pushed out
updated arm64/exception-stack and arm64/vmap-stack branches.

Thanks,
Mark.
