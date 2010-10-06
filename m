From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Oct 2010 11:47:12 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286379197.22265.95.camel@m0nster>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<alpine.LFD.2.00.1010052246380.3107@xanadu.home>
	<1286372886.22265.63.camel@m0nster>
	<alpine.LFD.2.00.1010061016280.3107@xanadu.home>
	<1286376581.22265.85.camel@m0nster>
	<alpine.LFD.2.00.1010061109110.3107@xanadu.home>
	<1286379197.22265.95.camel@m0nster>
Message-ID: <alpine.LFD.2.00.1010061144560.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Oct 2010, Daniel Walker wrote:

> On Wed, 2010-10-06 at 11:21 -0400, Nicolas Pitre wrote:
> 
> > static inline char
> > __dcc_getchar(void)
> > {
> >      char __c;
> > 
> > #if !defined(CONFIG_CPU_V7)
> >      asm("mrc p14, 0, %0, c0, c5, 0  @ read comms data reg"
> >              : "=r" (__c) : : "cc");
> > #else
> >      asm(
> >      "get_wait:      mrc p14, 0, pc, c0, c1, 0                       \n\
> >                      bne get_wait                                    \n\
> >                      mrc p14, 0, %0, c0, c5, 0       @ read comms data reg"
> >              : "=r" (__c) : : "cc");
> > #endif
> > 
> >      return __c;
> > }
> > 
> > static inline void
> > __dcc_putchar(char c)
> > {
> > #if !defined(CONFIG_CPU_V7)
> >      asm("mcr p14, 0, %0, c0, c5, 0  @ write a char"
> >              : /* no output register */
> >              : "r" (c) : "cc");
> > #else
> >      asm(
> >      "put_wait:      mrc p14, 0, pc, c0, c1, 0                   \n\
> >                      bcs put_wait                                \n\
> >                      mcr p14, 0, %0, c0, c5, 0                   "
> >      : : "r" (c) : "cc");
> > #endif
> > }
> > 
> > To me the above is easier to read.  Not a big deal since the functions 
> > are rather small, but still an improvement.  Searching for __dcc_putchar 
> > would produce a single hit, and if the prototype has to change it is 
> > done in only one place, etc.
> 
> It makes the internals of the function much more busy. There's more
> stuff that could be executing that you have to think about while
> reviewing the function.

I still stand by my opinion that the above is better.  Feel free to 
ignore me.

> > BTW the cc clobber in the asm for __dcc_putchar() is unneeded.
> 
> Without it caused a crash in __dcc_getchar() ..

It is the wrong fix nevertheless.  And in this case it isn't a question 
of opinion.


Nicolas
