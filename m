From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 22:11:44 +0000
Subject: [PATCH 1/4] ARM: sa1100: fix sa1100 after sparse irq conversion
In-Reply-To: <1329449534-23811-2-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
 <1329449534-23811-2-git-send-email-robherring2@gmail.com>
Message-ID: <20120223221144.GA15494@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 16, 2012 at 09:32:11PM -0600, Rob Herring wrote:
> diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
> index 0dba050..0c16c0a 100644
> --- a/drivers/net/ethernet/smsc/smc91x.c
> +++ b/drivers/net/ethernet/smsc/smc91x.c
> @@ -89,6 +89,10 @@ static const char version[] =
>  
>  #include <asm/io.h>
>  
> +#if defined(CONFIG_SA1100_ASSABET)
> +#include <mach/neponset.h>
> +#endif
> +
>  #include "smc91x.h"
>  
>  #ifndef SMC_NOWAIT

Why do you need this include when smc91x.h just below does this:

#elif defined(CONFIG_SA1100_ASSABET)

#include <mach/neponset.h>

/* We can only do 8-bit reads and writes in the static memory space. */
#define SMC_CAN_USE_8BIT        1
#define SMC_CAN_USE_16BIT       0
#define SMC_CAN_USE_32BIT       0
#define SMC_NOWAIT              1

/* The first two address lines aren't connected... */
#define SMC_IO_SHIFT            2

#define SMC_inb(a, r)           readb((a) + (r))
#define SMC_outb(v, a, r)       writeb(v, (a) + (r))
#define SMC_insb(a, r, p, l)    readsb((a) + (r), p, (l))
#define SMC_outsb(a, r, p, l)   writesb((a) + (r), p, (l))
#define SMC_IRQ_FLAGS           (-1)    /* from resource */

My guess is you have PLEB enabled which overrides this definition.  Yes,
this driver is rather horrible in this regard...
