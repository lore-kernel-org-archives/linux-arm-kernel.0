From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 05 Oct 2010 22:55:04 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1010052246380.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Oct 2010, Daniel Walker wrote:

> +#if !defined(CONFIG_CPU_V7)
> +static inline char
> +__dcc_getchar(void)
> +{
> +	char __c;
> +
> +	asm("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> +		: "=r" (__c) : : "cc");
> +
> +	return __c;
> +}
> +#else
> +static inline char
> +__dcc_getchar(void)
> +{
> +	char __c;
> +
> +	asm(
> +	"get_wait:	mrc p14, 0, pc, c0, c1, 0                   \n\
> +			bne get_wait                                    \n\
> +			mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> +		: "=r" (__c) : : "cc");
> +
> +	return __c;
> +}
> +#endif
> +
> +#if !defined(CONFIG_CPU_V7)
> +static inline void
> +__dcc_putchar(char c)
> +{
> +	asm("mcr p14, 0, %0, c0, c5, 0	@ write a char"
> +		: /* no output register */
> +		: "r" (c) : "cc");
> +}
> +#else
> +static inline void
> +__dcc_putchar(char c)
> +{
> +	asm(
> +	"put_wait:	mrc p14, 0, pc, c0, c1, 0                   \n\
> +			bcs put_wait                                \n\
> +			mcr p14, 0, %0, c0, c5, 0                   "
> +	: : "r" (c) : "cc");
> +}
> +#endif

Please move the #ifdef conditionals inside the respective functions so 
to have only one function pair with the various alternatives embedded 
into them.


Nicolas
