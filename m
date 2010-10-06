From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 06 Oct 2010 06:48:06 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010052246380.3107@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<alpine.LFD.2.00.1010052246380.3107@xanadu.home>
Message-ID: <1286372886.22265.63.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-10-05 at 22:55 -0400, Nicolas Pitre wrote:
> On Tue, 5 Oct 2010, Daniel Walker wrote:
> 
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
> Please move the #ifdef conditionals inside the respective functions so 
> to have only one function pair with the various alternatives embedded 
> into them.

My typical clean up policy is do to the inverse of what your suggesting.
Mainly because that's the method that I see used extensive in generic
parts of the kernel.

>From my perspective there are pluses an minuses to both. Your method
reduces lines, and duplication. My method makes the code easier to read.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
