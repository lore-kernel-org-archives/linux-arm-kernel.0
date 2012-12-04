From: b29396@freescale.com (Dong Aisheng)
Date: Tue, 4 Dec 2012 20:27:48 +0800
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <CAFEAcA827i0RYShk+nV5_iSnqU_fF1nf8-YnUME9nD8Fj=JOtQ@mail.gmail.com>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
 <CAFEAcA827i0RYShk+nV5_iSnqU_fF1nf8-YnUME9nD8Fj=JOtQ@mail.gmail.com>
Message-ID: <20121204122747.GB7450@b29396-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 03, 2012 at 01:22:07PM +0000, Peter Maydell wrote:
> On 3 December 2012 12:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> > By far the largest part of the save/restore work here is figuring out
> > what the right state to expose to userspace is so we can retain that
> > compatibility guarantee.
> 
> Some further thoughts on this...
> 
> What we're really providing the guest here is a hardware-accelerated
> software emulation of a no-virtualization GICv2. So it's better for
> the state we expose to userspace to be the state of that emulated
> hardware, and not to expose details of exactly what that hardware
> acceleration is.

It looks like a good idea.
Then in which format? User space qemu and kernel space vgic are using
different data format to describe gic state.
We definitely need a standard one to use with good compatibility.
One simple way may be just registers value of no-virtualization GICv2.
User space could convert the register value to whatever format it wants
if needed. But that means we need to emulate gic cpu interface registers
in kernel for user space to read which is also not so conveniently.

> The hw accel is a property of the host CPU,
> not of the guest VM environment, so it could be different on
> different kernels or host CPUs, which would make migration potentially
> tedious. For instance, consider migration where the source machine
> has a VGIC with more list registers than the destination machine.
> 

Per my understanding,  qemu is a part of hypervisor, right?
The it should be able to handle hw difference to support gic state saving
running on different host.
So i can not see big issue on exporting hw accel to qemu.
Do i understand correctly?

> Obviously you could convert between different representations
> in a number of places (source kernel, source qemu, destination
> qemu, destination kernel), but I think it makes sense for the
> canonical representation to be the guest-visible representation
> of the emulated hardware, rather than privileging any one
> acceleration implementation above another.
> 
> -- PMM
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
