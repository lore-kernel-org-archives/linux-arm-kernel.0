From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 05 Jul 2010 10:12:04 +0100
Subject: [patch 2/2] arm: Implement l2x0 cache disable function
In-Reply-To: <20100704190913.GA8596@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1007021658300.2525@localhost.localdomain>
	<1278087010.10162.271.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1007021835512.2525@localhost.localdomain>
	<1278089680.10162.279.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF1D@dbde02.ent.ti.com>
	<20100704190913.GA8596@n2100.arm.linux.org.uk>
Message-ID: <1278321124.11315.6.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-07-04 at 20:09 +0100, Russell King - ARM Linux wrote:
> On Sat, Jul 03, 2010 at 12:31:53PM +0530, Shilimkar, Santosh wrote:
> > > -----Original Message-----
> > > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> > > kernel-bounces at lists.infradead.org] On Behalf Of Catalin Marinas
> > > Sent: Friday, July 02, 2010 10:25 PM
> > > To: Thomas Gleixner
> > > Cc: Tony Lindgren; LAK
> > > Subject: Re: [patch 2/2] arm: Implement l2x0 cache disable function
> > >
> > > On Fri, 2010-07-02 at 17:39 +0100, Thomas Gleixner wrote:
> > > > Simply because you need to flush the cache in the decompressor of the
> > > > new kernel before jumping into it and I doubt that Russell will be
> > > > happy about adding an utter L2 mess to the decompressor.
> > >
> > > The decompressor can create mappings as inner cacheable outer
> > > non-cacheable and it would not pollute the L2 cache.
> > >
> > > I wonder how the OMAP guys deal with an already enabled L2 cache during
> > > decompressing.
> >
> > $L2 isn't enabled during the decompression. It's done " __v7_setup" on OMAP3
> > and just before " l2x0_init" on OMAP4
[...]
> I think it's overkill to add L2 support to the decompressor - and I
> also think it's overkill to teach the decompressor about the XP format
> tables, 

Even if we did this, the secure software needs to be aware of OS
rebooting since it may have a non-secure cacheable mapping which is
speculatively fetched (and I was also told that the L2 treats the secure
access bit as an address one - so you get separate cache lines for
secure and non-secure).

> Also consider the case where the kernel you're booting into doesn't
> have L2 support enabled - maybe you disabled L2 support because it's
> causing problems.  If you boot with L2 already enabled, then this
> kernel is going to struggle because it can't handle the enabled L2.

You could have an outer non-cacheable cache policy and set the page
table bits accordingly. But I agree with you, it's not worth the extra
effort.

> Let's ensure that we bring L2 to a clean and disabled state prior to
> invoking a boot loader or subsequent kernel - even if that means we
> have to make SMC calls to achieve that.

So Thomas' original patches are pretty much OK, with the exception of
using clean+invalidate instead of just invalidate during disabling.

An additional question - do we need to flush the L2 cache again after it
was disabled, just in case we got some speculative loads?

-- 
Catalin
