From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 29 Sep 2011 00:21:29 -0400 (EDT)
Subject: [PATCH 2/2] msm: Support DEBUG_LL on MSM8660 and MSM8960
In-Reply-To: <1317243959-26383-3-git-send-email-sboyd@codeaurora.org>
References: <1317243959-26383-1-git-send-email-sboyd@codeaurora.org>
	<1317243959-26383-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <alpine.LFD.2.02.1109290012400.9106@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Sep 2011, Stephen Boyd wrote:

> Add support for DEBUG_LL on the 8660 and 8960 development boards.
> While we're here, cleanup the uncompress.h code a bit.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

[...]

>  	.macro	senduart,rd,rx
> +#ifdef CONFIG_MSM_HAS_DEBUG_UART_HS
> +	@ Clear TX_READY by writing to the UARTDM_CR register
> +	mov	r12, #0x300
> +	str	r12, [\rx, #0x10]
> +	@ Write 0x1 to NCF register
> +	mov 	r12, #0x1
> +	str	r12, [\rx, #0x40]
> +	@ UARTDM reg. Read to induce delay
> +	ldr	r12, [\rx, #0x08]
> +	@ Write the 1 character to UARTDM_TF
> +	str	\rd, [\rx, #0x70]

This is a really bad idea to pick a register (r12) when the calling code 
is completely unaware of that.  This _will_ break on you someday.

Except for the last line, why didn't you simply fold this code into the 
waituart macro instead?


Nicolas
