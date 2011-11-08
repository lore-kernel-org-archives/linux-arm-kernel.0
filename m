From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Nov 2011 14:08:58 -0500 (EST)
Subject: [PATCHv3 2/2] msm: Support DEBUG_LL on MSM8660 and MSM8960
In-Reply-To: <1320777184-22446-3-git-send-email-sboyd@codeaurora.org>
References: <1320777184-22446-1-git-send-email-sboyd@codeaurora.org>
 <1320777184-22446-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1111081406220.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Nov 2011, Stephen Boyd wrote:

> Add support for DEBUG_LL on the 8660 and 8960 development boards.
> While we're here cleanup the uncompress.h code a bit. Avoid
> the use of readl/writel as those are Linux specific APIs that
> aren't guaranteed to work in the decompressor.
> 
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Nicolas Pitre <nico@linaro.org>

Independently from this patch, I was wondering about this code:

> +	.macro	senduart, rd, rx
> +#ifdef CONFIG_MSM_HAS_DEBUG_UART_HS
> +	@ Write the 1 character to UARTDM_TF
> +	str	\rd, [\rx, #0x70]
> +#else
>  	teq	\rx, #0
>  	strne	\rd, [\rx, #0x0C]
> +#endif
>  	.endm

Why testing for zero in the #else part?  The upper level code should 
never call this macro with a null byte.


Nicolas
