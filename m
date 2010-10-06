From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Oct 2010 11:21:24 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286376581.22265.85.camel@m0nster>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<alpine.LFD.2.00.1010052246380.3107@xanadu.home>
	<1286372886.22265.63.camel@m0nster>
	<alpine.LFD.2.00.1010061016280.3107@xanadu.home>
	<1286376581.22265.85.camel@m0nster>
Message-ID: <alpine.LFD.2.00.1010061109110.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Oct 2010, Daniel Walker wrote:

> On Wed, 2010-10-06 at 10:22 -0400, Nicolas Pitre wrote:
> > On Wed, 6 Oct 2010, Daniel Walker wrote:
> > 
> > > From my perspective there are pluses an minuses to both. Your method
> > > reduces lines, and duplication. My method makes the code easier to read.
> > 
> > I disagree.  In reviewing your patch I had to go back and forth between 
> > the different versions just to figure out what was actually different to 
> > justify this #ifdef in the first place.  If the #ifdef..#endif was 
> > surrounding only the different inline asm statements then the difference 
> > would have been more obvious.
> 
> You would have had to go back and forth either way , wouldn't you? In
> this case the functions are actually totally different.

static inline char
__dcc_getchar(void)
{
     char __c;

#if !defined(CONFIG_CPU_V7)
     asm("mrc p14, 0, %0, c0, c5, 0  @ read comms data reg"
             : "=r" (__c) : : "cc");
#else
     asm(
     "get_wait:      mrc p14, 0, pc, c0, c1, 0                       \n\
                     bne get_wait                                    \n\
                     mrc p14, 0, %0, c0, c5, 0       @ read comms data reg"
             : "=r" (__c) : : "cc");
#endif

     return __c;
}

static inline void
__dcc_putchar(char c)
{
#if !defined(CONFIG_CPU_V7)
     asm("mcr p14, 0, %0, c0, c5, 0  @ write a char"
             : /* no output register */
             : "r" (c) : "cc");
#else
     asm(
     "put_wait:      mrc p14, 0, pc, c0, c1, 0                   \n\
                     bcs put_wait                                \n\
                     mcr p14, 0, %0, c0, c5, 0                   "
     : : "r" (c) : "cc");
#endif
}

To me the above is easier to read.  Not a big deal since the functions 
are rather small, but still an improvement.  Searching for __dcc_putchar 
would produce a single hit, and if the prototype has to change it is 
done in only one place, etc.

BTW the cc clobber in the asm for __dcc_putchar() is unneeded.


Nicolas
