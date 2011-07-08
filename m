From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jul 2011 17:27:18 +0100
Subject: [PATCH 1/3] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <alpine.LFD.2.00.1107080937440.14596@xanadu.home>
References: <1309945678-18813-1-git-send-email-bs14@csr.com>
	<201107071343.03591.arnd@arndb.de>
	<20110707123707.GN8286@n2100.arm.linux.org.uk>
	<201107071521.07070.arnd@arndb.de>
	<20110707141254.GR8286@n2100.arm.linux.org.uk>
	<CAGsJ_4wsc=Jx6+thKriX+x5KdX2m8O9HfrnC_MGYAXTUe-DoRg@mail.gmail.com>
	<20110708090302.GB2414@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107080937440.14596@xanadu.home>
Message-ID: <20110708162718.GI4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2011 at 09:38:56AM -0400, Nicolas Pitre wrote:
> On Fri, 8 Jul 2011, Russell King - ARM Linux wrote:
> 
> > On Fri, Jul 08, 2011 at 10:18:57AM +0800, Barry Song wrote:
> > > simply adding a UL suffix will make compiling fail since
> > > arch/arm/kernel/debug.S will refer to the macro calculating virtual
> > > address of SIRFSOC_UART1_VA_BASE and UL is not legal in asm.
> > 
> > A solution for VMALLOC_END would be to include linux/const.h and use
> > _AC(value, UL).  I think you're the only one who bases their IO
> > addressing off VMALLOC_END.
> 
> This is also a bad idea to use VMALLOC_END like that since this is 
> another per-architecture constant which is targetted for a global 
> removal.

Let's get the story straight and avoid confusion...

Using _AC(value, UL) is not a bad idea, nor is adding UL as a suffix for
VMALLOC_END.  Basing IO addresses off VMALLOC_END is questionable, but
we have to have some value for this.

Rather than trying to convert everything to a variable, I think some
effort needs to be spent trying to keep this as a constant.  We've
grown too much to have lots of variances in the kernel memory layout
and we really should be trying to standardize on this stuff.

Part of that is helped with your patch for the StrongARM cache flushing.
We just need to take that further.
