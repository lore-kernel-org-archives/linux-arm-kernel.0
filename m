From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Oct 2010 13:02:54 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286383243.22265.124.camel@m0nster>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<alpine.LFD.2.00.1010052246380.3107@xanadu.home>
	<1286372886.22265.63.camel@m0nster>
	<alpine.LFD.2.00.1010061016280.3107@xanadu.home>
	<1286376581.22265.85.camel@m0nster>
	<alpine.LFD.2.00.1010061109110.3107@xanadu.home>
	<1286379197.22265.95.camel@m0nster>
	<alpine.LFD.2.00.1010061144560.3107@xanadu.home>
	<1286380480.22265.109.camel@m0nster>
	<alpine.LFD.2.00.1010061207090.3107@xanadu.home>
	<1286383243.22265.124.camel@m0nster>
Message-ID: <alpine.LFD.2.00.1010061257080.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Oct 2010, Daniel Walker wrote:

> On Wed, 2010-10-06 at 12:22 -0400, Nicolas Pitre wrote:
> > On Wed, 6 Oct 2010, Daniel Walker wrote:
> > 
> > > On Wed, 2010-10-06 at 11:47 -0400, Nicolas Pitre wrote:
> > > 
> > > > It is the wrong fix nevertheless.  And in this case it isn't a question 
> > > > of opinion.
> > > 
> > > I'm not saying your wrong, I'm sure you know more about it than I do. I
> > > was just letting you know why I added it .
> > 
> > Sure.  However it is best to _understand_ why such things may apparently 
> > fix things.  In this case it would have been by accident, and the code 
> > could be broken again with a different gcc version.
> > 
> > Adding "cc" in the clobber list is needed only when the asm code is 
> > modifying the condition flags.
> > 
> > I'd suggest you look at the disassembly difference with and without it. 
> > My guess is that the whole thing gets optimized away as there is no 
> > dependencies to be dependent on, in which case the proper fix would be 
> > to mark it with "volatile".
> 
> Are you saying it's not needed for either the __dcc_putchar or
> __dcc_getchar ?

I'm saying that "CC" is unneeded in those cases where the condition flag 
is unmodified.  Those are the !CONFIG_CPU_V7 cases.

> With __dcc_getchar() Jeff O. (who is CC'd) discovered that the assembly
> was setup in a way that assumed the condition bits were not touched, but
> since they did get touched we ended up missing a branch in dcc_rx_chars
> for checking if "tty" is set. Since we're branching in the assembly I'm
> assuming we must be setting condition bits with the mrc instruction. 

Yep.

> So for __dcc_getchar it seems like it for sure is need .. 
> 
> For  __dcc_putchar I add "cc" also because again we're branching, so I'm
> assuming we're also setting condition bits.

I was talking about the non-branching cases.


Nicolas
