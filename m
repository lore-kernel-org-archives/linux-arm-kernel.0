From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Aug 2013 13:11:50 -0400 (EDT)
Subject: Build error: versatile express
In-Reply-To: <20130812170652.GF23006@n2100.arm.linux.org.uk>
References: <20130812124801.GB2823@localhost.localdomain>
 <alpine.LFD.2.03.1308121125420.14472@syhkavp.arg>
 <20130812170652.GF23006@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1308121309180.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Aug 2013, Russell King - ARM Linux wrote:

> On Mon, Aug 12, 2013 at 12:55:23PM -0400, Nicolas Pitre wrote:
> > On Mon, 12 Aug 2013, Dave Martin wrote:
> > 
> > > On Mon, Aug 12, 2013 at 11:28:04AM +0100, Russell King - ARM Linux wrote:
> > > > arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down.clone.0':
> > > > arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here
> > > > 
> > > > This is caused by the assembly code in this file clobbering R11, which
> > > > is incompatible with having CONFIG_FRAME_POINTER=y.
> > > 
> > > Is there any reason not to fix this just by pushing/popping r11 inside
> > > the asm and removing it from the clobber list?
> > 
> > That's most likely the best fix.  What about this?
> > 
> > ---- >8
> > 
> > From: Nicolas Pitre <nicolas.pitre@linaro.org>
> > Date: Mon, 12 Aug 2013 12:47:13 -0400
> > Subject: [PATCH] ARM: vexpress/MCPM: fix cache disable sequence when
> >  CONFIG_FRAME_POINTER=y
> > 
> > If CONFIG_FRAME_POINTER=y we hget the following error:
> > 
> > arch/arm/mach-vexpress/tc2_pm.c: In function 'tc2_pm_down':
> > arch/arm/mach-vexpress/tc2_pm.c:200:1: error: fp cannot be used in asm here
> > 
> > Let's fix that by explicitly preserving r11 on the stack and removing it
> > from the clobber list.
> > 
> > Reported-by: Russell King <linux@arm.linux.org.uk>
>                              ^^^^^^^^^^^^^^^^^^^^^^
> rmk+kernel at arm.linux.org.uk please

Sure.

By default I simply picked up the email address the report was sent with.


Nicolas
