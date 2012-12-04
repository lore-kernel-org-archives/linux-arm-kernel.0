From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 4 Dec 2012 21:37:32 +0800
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <CAFEAcA-ETqp=Pvz4cq6YbXMNhLbE_HS7GLxwSpmWfoza3F__UQ@mail.gmail.com>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
 <CAFEAcA827i0RYShk+nV5_iSnqU_fF1nf8-YnUME9nD8Fj=JOtQ@mail.gmail.com>
 <20121204122747.GB7450@b29396-Latitude-E6410>
 <CAFEAcA-ETqp=Pvz4cq6YbXMNhLbE_HS7GLxwSpmWfoza3F__UQ@mail.gmail.com>
Message-ID: <20121204133731.GD7450@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 04, 2012 at 12:45:12PM +0000, Peter Maydell wrote:
> On 4 December 2012 12:27, Dong Aisheng <b29396@freescale.com> wrote:
> > On Mon, Dec 03, 2012 at 01:22:07PM +0000, Peter Maydell wrote:
> >> What we're really providing the guest here is a hardware-accelerated
> >> software emulation of a no-virtualization GICv2. So it's better for
> >> the state we expose to userspace to be the state of that emulated
> >> hardware, and not to expose details of exactly what that hardware
> >> acceleration is.
> >
> > It looks like a good idea.
> > Then in which format? User space qemu and kernel space vgic are using
> > different data format to describe gic state.
> > We definitely need a standard one to use with good compatibility.
> > One simple way may be just registers value of no-virtualization GICv2.
> 
> "Values of registers" and "state of a device" are not identical
> (though the internal state is often made visible via registers).
> We care about the latter, not the former.
> 

I agree your point, the problem is how to define a standard "state of
gic device"?
The gic registers format is the exist one and both kernel or user space
state code changes do not affect each other.

Or what your suggestion?

> > User space could convert the register value to whatever format it wants
> > if needed. But that means we need to emulate gic cpu interface registers
> > in kernel for user space to read which is also not so conveniently.
> 
> Yes, conversion code is tedious for somebody. My argument is that
> the correct 'somebody' is the kernel.
> 

Yes, if that, we could hide gic hw accel to user space.

> >> The hw accel is a property of the host CPU,
> >> not of the guest VM environment, so it could be different on
> >> different kernels or host CPUs, which would make migration potentially
> >> tedious. For instance, consider migration where the source machine
> >> has a VGIC with more list registers than the destination machine.
> >>
> >
> > Per my understanding,  qemu is a part of hypervisor, right?
> > The it should be able to handle hw difference to support gic
> > state saving running on different host.
> 
> No, it's userspace support code for the hypervisor. In particular,
> it is the kernel that cares about the specific details of
> exact host hardware we're running on. Userspace doesn't generally
> see that level of detail.
> 
> > So i can not see big issue on exporting hw accel to qemu.
> 
> It could be done that way. I'm just arguing that the other
> way is better: see my final paragraph quoted below.
> 
> >> Obviously you could convert between different representations
> >> in a number of places (source kernel, source qemu, destination
> >> qemu, destination kernel), but I think it makes sense for the
> >> canonical representation to be the guest-visible representation
> >> of the emulated hardware, rather than privileging any one
> >> acceleration implementation above another.
> 

One concern is that i'm still not sure if there will be no issue
if not saving virtual interface control registers.
It may need some time to research.

Maybe we convert it into standard state and restore it back then.
But some bits of them may not be exported.

> PS: you don't need to quote my signature and the mailing list
> footer in your reply emails...
> 

I missed it.

Regards
Dong Aisheng
