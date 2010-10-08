From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 07 Oct 2010 21:25:06 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <20101007212707.GI7558@atomide.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
Message-ID: <alpine.LFD.2.00.1010072121530.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 7 Oct 2010, Tony Lindgren wrote:

> Hi,
> 
> * Daniel Walker <dwalker@codeaurora.org> [101005 11:59]:
> > +#if !defined(CONFIG_CPU_V7)
> > +static inline char
> > +__dcc_getchar(void)
> > +{
> > +	char __c;
> > +
> > +	asm("mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> > +		: "=r" (__c) : : "cc");
> > +
> > +	return __c;
> > +}
> > +#else
> > +static inline char
> > +__dcc_getchar(void)
> > +{
> > +	char __c;
> > +
> > +	asm(
> > +	"get_wait:	mrc p14, 0, pc, c0, c1, 0                   \n\
> > +			bne get_wait                                    \n\
> > +			mrc p14, 0, %0, c0, c5, 0	@ read comms data reg"
> > +		: "=r" (__c) : : "cc");
> > +
> > +	return __c;
> > +}
> > +#endif
> > +
> > +#if !defined(CONFIG_CPU_V7)
> > +static inline void
> > +__dcc_putchar(char c)
> > +{
> > +	asm("mcr p14, 0, %0, c0, c5, 0	@ write a char"
> > +		: /* no output register */
> > +		: "r" (c) : "cc");
> > +}
> > +#else
> > +static inline void
> > +__dcc_putchar(char c)
> > +{
> > +	asm(
> > +	"put_wait:	mrc p14, 0, pc, c0, c1, 0                   \n\
> > +			bcs put_wait                                \n\
> > +			mcr p14, 0, %0, c0, c5, 0                   "
> > +	: : "r" (c) : "cc");
> > +}
> > +#endif
> 
> Can you please pass the read and write functions to the driver
> in platform_data? We are already booting kernels with both
> ARMv6 and 7 compiled in.

No.  This has nothing to do with platform as this can be determined 
within the driver itself.  Would be much better to simply determine 
which flavor to use at driver init time and assign two function pointers.


Nicolas
