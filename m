From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 16 May 2015 21:51:03 +0100
Subject: [PATCH v7 08/13] ARM: unify MMU/!MMU addruart calls
In-Reply-To: <1431769465-26867-9-git-send-email-stefan@agner.ch>
References: <1431769465-26867-1-git-send-email-stefan@agner.ch>
 <1431769465-26867-9-git-send-email-stefan@agner.ch>
Message-ID: <20150516205103.GO2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 16, 2015 at 11:44:20AM +0200, Stefan Agner wrote:
> Remove the needless differences between MMU/!MMU addruart calls.
> This allows to use the same addruart macro on SoC level. Useful
> for SoC consisting of multiple CPUs with and without MMU such as
> Freescale Vybrid.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Depending on the merge plan for the remainder (has tglx reviewed the IRQ
changes yet?  I think he needs to before this can be merged)... if it's
not going to go in for the next merge window, this should find its way
into the patch system so it can be applied anyway.

> ---
>  arch/arm/include/debug/efm32.S | 2 +-
>  arch/arm/kernel/debug.S        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/debug/efm32.S b/arch/arm/include/debug/efm32.S
> index 2265a19..660fa1e 100644
> --- a/arch/arm/include/debug/efm32.S
> +++ b/arch/arm/include/debug/efm32.S
> @@ -16,7 +16,7 @@
>  
>  #define	UARTn_TXDATA		0x0034
>  
> -		.macro	addruart, rx, tmp
> +		.macro	addruart, rx, tmp, tmp2
>  		ldr	\rx, =(CONFIG_DEBUG_UART_PHYS)
>  
>  		/*
> diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
> index 78c91b5..ea9646c 100644
> --- a/arch/arm/kernel/debug.S
> +++ b/arch/arm/kernel/debug.S
> @@ -35,7 +35,7 @@
>  
>  #else /* !CONFIG_MMU */
>  		.macro	addruart_current, rx, tmp1, tmp2
> -		addruart	\rx, \tmp1
> +		addruart	\rx, \tmp1, \tmp2
>  		.endm
>  
>  #endif /* CONFIG_MMU */
> -- 
> 2.4.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
