From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 19 Aug 2011 11:49:10 -0400 (EDT)
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting DEBUG_LL
	UART
In-Reply-To: <20110819123238.GD8918@e102144-lin.cambridge.arm.com>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
	<20110818161105.GA12527@S2100-06.ap.freescale.net>
	<20110818160712.GA26691@e102144-lin.cambridge.arm.com>
	<20110819045956.GB12527@S2100-06.ap.freescale.net>
	<20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.00.1108191101560.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Aug 2011, Will Deacon wrote:
> On Fri, Aug 19, 2011 at 12:37:41PM +0100, Shawn Guo wrote:
> > On Fri, Aug 19, 2011 at 12:08:22PM +0100, Will Deacon wrote:
> > > @@ -74,7 +78,12 @@ config DEBUG_LL
> > >  
> > >  choice
> > >         prompt "Kernel low-level debugging port"
> > > -       depends on DEBUG_LL
> > > +       depends on DEBUG_LL_UART && (FOOTBRIDGE || ARCH_CLPS711X || \
> > > +                                    PLAT_SAMSUNG || ARCH_REALVIEW)
> > 
> > We will have to list a lot of ARCH/PLAT symbols here.  This is what
> > I meant overkilled actually.
> 
> Ultimately, we will want to have all the platforms using this mechanism so
> this list of symbols could eventually be removed. I take your point though;
> so I'll leave the patch series as it is for now.

Well, ultimately I'd like to see something even better than that.  We 
should have the bootloader provide the required information to the 
kernel for it to be able to send bytes to a debug device.  It should be 
rather simple, especially for a serial UART.  All we need in that case 
is:

 - physical address of the transmit FIFO register

 - physical address of the register indicating "FIFO full" with a 
   corresponding bit mask

 - physical address of the register indicating "FIFO empty" with a
   corresponding bit mask

The bootloader should be able to pass that info into an ATAG or a DT 
node just fine.

But in the mean time, for legacy boards, the best we have is this 
Kconfig approach.


Nicolas
