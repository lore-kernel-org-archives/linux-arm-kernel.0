From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 4 Jul 2010 20:09:13 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1D@dbde02.ent.ti.com>
References: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
	<1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007021835512.2525@localhost.localdomain>
	<1278089680.10162.279.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1D@dbde02.ent.ti.com>
Message-ID: <20100704190913.GA8596@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 03, 2010 at 12:31:53PM +0530, Shilimkar, Santosh wrote:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> > Sent: Friday, July 02, 2010 10:25 PM
> > To: Thomas Gleixner
> > Cc: Tony Lindgren; LAK
> > Subject: Re: [patch 2/2] arm: Implement l2x0 cache disable function
> > 
> > On Fri, 2010-07-02 at 17:39 +0100, Thomas Gleixner wrote:
> > > Simply because you need to flush the cache in the decompressor of the
> > > new kernel before jumping into it and I doubt that Russell will be
> > > happy about adding an utter L2 mess to the decompressor.
> > 
> > The decompressor can create mappings as inner cacheable outer
> > non-cacheable and it would not pollute the L2 cache.
> > 
> > I wonder how the OMAP guys deal with an already enabled L2 cache during
> > decompressing.
> 
> $L2 isn't enabled during the decompression. It's done " __v7_setup" on OMAP3
> and just before " l2x0_init" on OMAP4

Not on the initial kernel, but on subsequent kernels booted via kexec,
because of this issue, L2 will be enabled.

So when the decompressor comes to set up its own page tables - it uses
the non-XP format - it ends up with tables setup with C=B=1, which
is interpreted as fully cacheable.  As the L2 unit is still enabled,
this causes the region to be cacheable at L2 as well as L1 - which
is not what the decompressor expects.

The result is that cache lines get loaded into L2, and marked dirty.
When the decompressor then turns off the cache in order to call the
kernel, things go awol because the dirty lines in L2 haven't been
flushed out.

I think it's overkill to add L2 support to the decompressor - and I
also think it's overkill to teach the decompressor about the XP format
tables, especially as the booting documents clearly state that caches
shall be disabled before calling the kernel.  Also, we really can't
insist that this is the case for boot loaders, and then do something
different when we call the next kernel.

Also consider the case where the kernel you're booting into doesn't
have L2 support enabled - maybe you disabled L2 support because it's
causing problems.  If you boot with L2 already enabled, then this
kernel is going to struggle because it can't handle the enabled L2.

As I've already said, the boot loader case won't expect to be called
via its reset vector with L2 enabled either - and could well go wrong
if this is done.

So, all the ways you look at it, having L2 enabled when you're exiting
the kernel to call some other piece of code (such as boot loader or
decompressor) is asking for trouble.

Let's ensure that we bring L2 to a clean and disabled state prior to
invoking a boot loader or subsequent kernel - even if that means we
have to make SMC calls to achieve that.
