From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2011 21:15:35 +0200
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <1319040118-29773-2-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1319040118-29773-1-git-send-email-zoss@devai.org>
	<1319040118-29773-2-git-send-email-zoss@devai.org>
Message-ID: <1409922.Ostx0EbfK3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 October 2011 18:01:54 Zoltan Devai wrote:
> Files needed for the basic machine support of SPMP8000
> 
> Signed-off-by: Zoltan Devai <zoss@devai.org>

Hi Zoltan,

This version looks very nice, only a few small things remain that I noticed
reading through it again:

> +
> +void __iomem *spmp8000_wdt_base;
> +EXPORT_SYMBOL(spmp8000_wdt_base);

This should really be EXPORT_SYMBOL_GPL.

> +#define SERIAL_BASE	((volatile unsigned char *)SPMP8000_UARTC0_BASE)

drop this, then

> +static void putc(const char c)
> +{
> +	volatile unsigned char *base = SERIAL_BASE;

make this a "unsigned char __iomem *".

> +	int i;
> +
> +	for (i = 0; i < 0x1000; i++) {
> +		if (base[UART_LSR << 2] & UART_LSR_THRE)
> +			break;
> +		barrier();
> +	}
> +
> +	base[UART_TX << 2] = c;
> +}

and use readb_relaxed/writeb_relaxed to do the access. You should
never just dereference volatile pointers to do an MMIO access.

Best check your code by running 'sparse' over it (make C=1). It will warn
about things like this. Try to fix all warnings that sparse reports.

	Arnd
