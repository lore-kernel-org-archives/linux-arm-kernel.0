From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2011 18:38:36 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110824170953.GA8883@n2100.arm.linux.org.uk>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
	<20110824135109.GP32688@e102144-lin.cambridge.arm.com>
	<20110824170953.GA8883@n2100.arm.linux.org.uk>
Message-ID: <20110824173836.GV32688@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 06:09:53PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 24, 2011 at 02:51:09PM +0100, Will Deacon wrote:
> > I think it's important to separate the problems of secure boot with the
> > problems of installing a hypervisor. Whatever happens in secure world, we can
> > expect to be dropped at either HYP mode or non-secure SVC mode. Sure, on a dev
> > board you might run directly in the secure world so there's a bit of extra
> > work to do to get out of that but then we can just drop into HVC mode and
> > forget about it.
> 
> I think you're painting a very simple picture there.

Yes, I was trying to avoid derailing the discussion because the secure -
non-secure transition should be treated separately to the hypervisor stuff.

> If the kernel has been handed over to while in secure mode, that's
> probably because there is no secure monitor implemented.  If there's
> no secure monitor implemented, there's no code in place to handle
> SMC instructions.  To make things worse, if we drop out into non-secure
> mode, due to the lack of working SMC instructions, we have no way to
> access the various registers we need to.
> 
> So, if the kernel is booted in secure mode and wants to drop into non-
> secure mode, we need a separate blob of code to install as our own
> secure monitor to provide these services.

Indeed. I'm not aware of any open-source monitor implementations and I'm not
sure whether it's something worth investing effort in.

> > Unlike the fragmented secure monitor API that currently exists across
> > different platforms, it's really in the interests of the vendor to
> > standardise on the HYP interface and provide calls to install code, otherwise
> > they run the risk of producing what is essentially a closed system.
> 
> On the other hand, I'm sure vendors are already thinking along those
> lines - the precident has been set by the secure monitor API mess, so
> if it can be made to "work" there...

That's partly why I'm trying to keep the two problems separate (but I doubt
it will make any difference!). That said, I firmly believe that whatever we
do, we *will* see platforms which install a hypervisor before dropping to
NS-SVC and booting Linux. We can either give up in these cases (which is
fine until the hardware becomes available and people want to use it) or we
can define a simple HVC interface that the kernel can use and hope people
implement that. If they don't, we'll end up in the same situation where
we are for the secure stuff but at least we tried. Unlike the SVC mess, you
can get away with a single (custom) HVC to bootstrap the thing with an
interface that we understand.

Will
