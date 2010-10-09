From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 08 Oct 2010 20:57:12 -0400 (EDT)
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <20101008214953.GR7558@atomide.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
	<alpine.LFD.2.00.1010072121530.3107@xanadu.home>
	<20101008203221.GM7558@atomide.com>
	<alpine.LFD.2.00.1010081654190.3107@xanadu.home>
	<20101008214953.GR7558@atomide.com>
Message-ID: <alpine.LFD.2.00.1010082026220.3107@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Oct 2010, Tony Lindgren wrote:

> Thanks for the info. Hmm, there seems to a section for XScale
> in arch/arm/kernel/debug.S for elif defined(CONFIG_CPU_XSCALE) for
> CONFIG_DEBUG_ICEDCC:
> 
> #elif defined(CONFIG_CPU_XSCALE)
> 
> 		.macro	addruart, rx, tmp
> 		.endm
> 
> 		.macro	senduart, rd, rx
> 		mcr	p14, 0, \rd, c8, c0, 0
> 		.endm
> 
> 		.macro	busyuart, rd, rx
> 1001:
> 		mrc	p14, 0, \rx, c14, c0, 0
> 		tst	\rx, #0x10000000
> 		beq	1001b
> 		.endm
> 
> 		.macro	waituart, rd, rx
> 		mov	\rd, #0x10000000
> 1001:
> 		subs	\rd, \rd, #1
> 		bmi	1002f
> 		mrc	p14, 0, \rx, c14, c0, 0
> 		tst	\rx, #0x10000000
> 		bne	1001b
> 1002:
> 		.endm
> 
> #else
> 
> Is that broken for XScale then?

Probably not broken, but simplistic.  In a fully debug enabled setup, 
this channel is used to multiplex messages used by the special software 
on the target and the external debugger.  In this case it is used for 
raw string output only.

For example, here's the code for the debugging stubs that gets injected 
into the target by OpenOCD:

http://openocd.git.sourceforge.net/git/gitweb.cgi?p=openocd/openocd;a=blob;f=src/target/xscale/debug_handler.S;h=73f3a9d5e44a87


Nicolas
