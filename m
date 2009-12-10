From: daniel@caiaq.de (Daniel Mack)
Date: Thu, 10 Dec 2009 15:12:08 +0800
Subject: [PATCH] pxa/zeus: Allow use of 8250-compatible UART in uncompress
In-Reply-To: <20091210073922.79f6e841@taxman.wild-wind.fr.eu.org>
References: <20091210073922.79f6e841@taxman.wild-wind.fr.eu.org>
Message-ID: <20091210071208.GL28375@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 07:39:22AM +0100, Marc Zyngier wrote:
> Zeus console port is wired to a 8250-compatible device
> (pxa UARTs are reserved to other uses). This patch
> allows such a configuration in the uncompress sequence.

Was that tested for regressions with PXA UARTs?

I didn't, but ...

> diff --git a/arch/arm/mach-pxa/include/mach/uncompress.h b/arch/arm/mach-pxa/include/mach/uncompress.h
> index 237734b..dc94a34 100644
> --- a/arch/arm/mach-pxa/include/mach/uncompress.h
> +++ b/arch/arm/mach-pxa/include/mach/uncompress.h
> @@ -13,17 +13,21 @@
>  #include <mach/regs-uart.h>
>  #include <asm/mach-types.h>
>  
> -#define __REG(x)       ((volatile unsigned long *)x)
> +#define __REG(x)       ((volatile char *)x)
>  
> -static volatile unsigned long *UART = FFUART;
> +static volatile char *UART = FFUART;
> +static int shift = 2;
> +static int is_pxa_uart = 1;
> +
> +#define UART_REG(x)	UART[(x) << shift]

... with UART being char* now (and as UART_REG is just a macro) it will
only be 8 bits in width, and hence all logic that accesses bits beyond
that scope wil fail. Tricky casting might help here, but your
referencing that as an array, so the value will be &= 0xff.
Or did I overlook anything?

I'd say you'll need an inline function for that.

Daniel
