From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Jul 2010 11:43:58 +0100
Subject: [PATCH v3 0/3] Ordered I/O accessors
In-Reply-To: <002d01cb2e55$bf328c90$3d97a5b0$@deacon@arm.com>
References: <20100714145802.16555.48563.stgit@e102109-lin.cambridge.arm.com>
	<20100727110310.GA11468@n2100.arm.linux.org.uk>
	<20100728124846.GA24466@bnru02.bnr.st.com>
	<002d01cb2e55$bf328c90$3d97a5b0$@deacon@arm.com>
Message-ID: <20100729104358.GA15621@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 28, 2010 at 02:06:52PM +0100, Will Deacon wrote:
> Hi Russell, Rabin,
> 
> > On Tue, Jul 27, 2010 at 13:03:10 +0200, Russell King - ARM Linux wrote:
> > > On Wed, Jul 14, 2010 at 04:01:12PM +0100, Catalin Marinas wrote:
> > > > This version replaces the do { ... } while (0) constructs in the final
> > > > patch with ({ ... }) to avoid errors in drivers putting brackets around
> > > > the write*() accessors. To avoid the write*() macro having a non-void
> > > > type (and possibly the compiler generating code to read a register), the
> > > > first patch explicitly casts the __raw_write*() accessors to (void).
> > >
> > > Ok.  Can you please put this in the patch system?  I think we need to
> > > get this in prior to 2.6.35 being released.
> 
> Catalin's away at the moment and I'm not sure if he's picking up mail.
> 
> > ux500 is using writel() inside uncompress.h, so this series triggers a
> > build failure there:
> > 
> >   arch/arm/boot/compressed/misc.o: In function `putc':
> >   arch/arm/mach-ux500/include/mach/uncompress.h:41:
> >   undefined reference to `outer_cache'
> 
> There's also an issue with the iowrite* macros, which need a (void)
> cast in the same way as the write* guys.

I've fixed the io* macros up too.  We need a patch to fix ux500 ASAP
though.
