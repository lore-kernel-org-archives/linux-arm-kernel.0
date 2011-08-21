From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 10:14:52 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <alpine.LFD.2.00.1108191101560.20358@xanadu.home>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
	<20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
Message-ID: <20110821091452.GH12028@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 11:49:10AM -0400, Nicolas Pitre wrote:
> On Fri, 19 Aug 2011, Will Deacon wrote:
> > On Fri, Aug 19, 2011 at 12:37:41PM +0100, Shawn Guo wrote:
> > > On Fri, Aug 19, 2011 at 12:08:22PM +0100, Will Deacon wrote:
> > > > @@ -74,7 +78,12 @@ config DEBUG_LL
> > > >  
> > > >  choice
> > > >         prompt "Kernel low-level debugging port"
> > > > -       depends on DEBUG_LL
> > > > +       depends on DEBUG_LL_UART && (FOOTBRIDGE || ARCH_CLPS711X || \
> > > > +                                    PLAT_SAMSUNG || ARCH_REALVIEW)
> > > 
> > > We will have to list a lot of ARCH/PLAT symbols here.  This is what
> > > I meant overkilled actually.
> > 
> > Ultimately, we will want to have all the platforms using this mechanism so
> > this list of symbols could eventually be removed. I take your point though;
> > so I'll leave the patch series as it is for now.
> 
> Well, ultimately I'd like to see something even better than that.  We 
> should have the bootloader provide the required information to the 
> kernel for it to be able to send bytes to a debug device.  It should be 
> rather simple, especially for a serial UART.  All we need in that case 
> is:
> 
>  - physical address of the transmit FIFO register
> 
>  - physical address of the register indicating "FIFO full" with a 
>    corresponding bit mask
> 
>  - physical address of the register indicating "FIFO empty" with a
>    corresponding bit mask

You're missing something there.  It's not always about FIFO full and FIFO
empty.  On some platforms, we want _reliable_ debugging, so the debug
stuff waits while CTS is inactive.

Plus you need the virtual address too, because the LL debug stuff is
there to debug around places like the initial assembly, before C code
is setup.

Plus its not just about bitmasks, but also about size of access, and
polarity of bits.  So actually you'd need:

- virtual and physical address and size of transmit register
- virtual and physical address, mask and value of transmit status
- virtual and physical address, mask and value of CTS status

but then, we have debugging which doesn't have a physical address
associated with it (the jtag stuff) so this doesn't cover the full
story either.  Not only that of course, but boot loaders should not
be passing virtual addresses to the kernel.

So all in all, passing this information in from a boot loader is just
a plain and simple bad idea.
