From: nico@fluxnic.net (Nicolas Pitre)
Date: Thu, 28 Oct 2010 14:43:16 -0400 (EDT)
Subject: [PATCH] msm: fix debug-macro.S build failure
In-Reply-To: <20101028182851.GI3122@n2100.arm.linux.org.uk>
References: <1288216688-718-1-git-send-email-dwalker@codeaurora.org>
	<20101027221428.GB28391@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1010272227380.31220@xanadu.home>
	<1288283413.2683.2.camel@c-dwalke-linux.qualcomm.com>
	<20101028163518.GG3122@n2100.arm.linux.org.uk>
	<1288284066.2683.9.camel@c-dwalke-linux.qualcomm.com>
	<20101028174653.GH3122@n2100.arm.linux.org.uk>
	<1288288824.2683.24.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010281422190.3227@xanadu.home>
	<20101028182851.GI3122@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1010281441540.3227@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Oct 2010, Russell King - ARM Linux wrote:

> On Thu, Oct 28, 2010 at 02:24:33PM -0400, Nicolas Pitre wrote:
> > On Thu, 28 Oct 2010, Daniel Walker wrote:
> > 
> > > This is what the function currently has,
> > > 
> > >         .macro  addruart, rp, rv
> > >         ldr     \rp, =MSM_DEBUG_UART_PHYS
> > >         ldr     \rv, =MSM_DEBUG_UART_BASE
> > >         .endm
> > > 
> > > So if we have a MSM_DEBUG_UART_PHYS and MSM_DEBUG_UART_BASE we're
> > > returning it. We don't actually have those values for all the boards
> > > tho. My understanding was that there are some generic arm changes
> > > needed, but I need to confirm that.
> > 
> > Just return 0 in both registers when you have nothing better to return.
> 
> That's not a good idea - it'll cause 512MB of 1:1 mappings to be setup
> at virtual location 0 using the IO flags, which may conflict on ARMv6+.
> A better idea would be to return 0xfff00000, which'll cause it to only
> populate the top-most 1MB.

Given that this a phony address, better test for 0 explicitly and skip 
the mapping as well as bailing out early from putchar, etc.


Nicolas
