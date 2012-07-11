From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Jul 2012 15:09:12 +0100
Subject: [PATCH 9/9] ARM: vexpress: Config option for early printk console
In-Reply-To: <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
References: <1342013791-19516-1-git-send-email-pawel.moll@arm.com>
 <1342013791-19516-10-git-send-email-pawel.moll@arm.com>
Message-ID: <20120711140912.GC13498@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawel,

On Wed, Jul 11, 2012 at 02:36:31PM +0100, Pawel Moll wrote:
> +#else /* CONFIG_DEBUG_LL_UART_NONE */
> +
> +		.macro	addruart, rp, rv, tmp
> +		/*
> +		 * Have to provide reasonable dummy values,
> +		 * otherwise code in head.S crashes badly...
> +		 */
> +		mov	\rp, #0
> +		mov	\rv, #0
> +		.endm

Eek, this means we take out an I/O section mapping at zero, doesn't it?
Is that really a good idea? It scares me because (a) it's below PAGE_OFFSET
and (b) we don't know consistently what's at physical address 0.

Perhaps we could change head.S to avoid the mapping if addruart returns a
NULL virtual address?

Will
