From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Oct 2010 14:49:53 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010081654190.3107@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
	<alpine.LFD.2.00.1010072121530.3107@xanadu.home>
	<20101008203221.GM7558@atomide.com>
	<alpine.LFD.2.00.1010081654190.3107@xanadu.home>
Message-ID: <20101008214953.GR7558@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [101008 14:16]:
> On Fri, 8 Oct 2010, Tony Lindgren wrote:
> 
> > * Nicolas Pitre <nico@fluxnic.net> [101007 18:16]:
> > > On Thu, 7 Oct 2010, Tony Lindgren wrote:
> > > > 
> > > > Can you please pass the read and write functions to the driver
> > > > in platform_data? We are already booting kernels with both
> > > > ARMv6 and 7 compiled in.
> > > 
> > > No.  This has nothing to do with platform as this can be determined 
> > > within the driver itself.  Would be much better to simply determine 
> > > which flavor to use at driver init time and assign two function pointers.
> > 
> > In the long run some platform init code is needed for powering
> > up the JTAG interface and take care of pin multiplexing etc.
> 
> Really?  That would be really strange and rather different from all the 
> JTAG setups I've seen where the power-up of the interface is done 
> externally i.e. controlled by the JTAG dongle.

Well on omaps JTAG is powered by the EMU powerdomain. The docs say
it's software controllable or "automatically on JTAG plug detection".
So yeah JTAG power may be automatic.

But the pin selection is board specific. Some boards may need to use
the JTAG pins for GPIO etc.
 
> > Also, isn't DCC (Debug Communications Channel) a JTAG standard?
> 
> No.
> 
> > At least the following does not say anything about DCC being ARM 
> > specific:
> > 
> > http://en.wikipedia.org/wiki/Joint_Test_Action_Group
> 
> So called DCC may be part of an extension built on top of JTAG which is 
> not "standardized".  Each vendor implements their own extensions, which 
> may or may not include something that can be described as DCC.  The JTAG 
> standard concerns itself with only the basic stuff in the full stack.  
> You may have a look at OpenOCD to see how wildly different the debugging 
> interfaces implemented on top of JTAG are.
> 
> Furthermore, the DCC access from within the target are implementation 
> specific.  In this case, it is a particular ARM coprocessor access, 
> which as the patch shows is not even the same across all ARM versions.  
> And that's valid only for those ARM flavors that implement the 
> EmbeddedICE or CoreSight.  On XScale, the debug facility built on top of 
> the JTAG interface is completely different from the ARM Ltd one, relying 
> mostly on software support injected in a special i-cache.  In that case, 
> the notion of a DCC would be implemented in software instead of relying 
> on a specific hardware register, multiplexed with other messages sent 
> over the JTAG interface.

Thanks for the info. Hmm, there seems to a section for XScale
in arch/arm/kernel/debug.S for elif defined(CONFIG_CPU_XSCALE) for
CONFIG_DEBUG_ICEDCC:

#elif defined(CONFIG_CPU_XSCALE)

		.macro	addruart, rx, tmp
		.endm

		.macro	senduart, rd, rx
		mcr	p14, 0, \rd, c8, c0, 0
		.endm

		.macro	busyuart, rd, rx
1001:
		mrc	p14, 0, \rx, c14, c0, 0
		tst	\rx, #0x10000000
		beq	1001b
		.endm

		.macro	waituart, rd, rx
		mov	\rd, #0x10000000
1001:
		subs	\rd, \rd, #1
		bmi	1002f
		mrc	p14, 0, \rx, c14, c0, 0
		tst	\rx, #0x10000000
		bne	1001b
1002:
		.endm

#else

Is that broken for XScale then?

Regards,

Tony
