From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 6 Dec 2012 15:45:58 +0000
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <20121204133731.GD7450@b29396-Latitude-E6410>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
 <CAFEAcA827i0RYShk+nV5_iSnqU_fF1nf8-YnUME9nD8Fj=JOtQ@mail.gmail.com>
 <20121204122747.GB7450@b29396-Latitude-E6410>
 <CAFEAcA-ETqp=Pvz4cq6YbXMNhLbE_HS7GLxwSpmWfoza3F__UQ@mail.gmail.com>
 <20121204133731.GD7450@b29396-Latitude-E6410>
Message-ID: <CAFEAcA9TCnXHJPn8yso-pSykaTajgXZzUevy2yab03zHPdUKQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2012 13:37, Dong Aisheng <b29396@freescale.com> wrote:
> On Tue, Dec 04, 2012 at 12:45:12PM +0000, Peter Maydell wrote:
>> On 4 December 2012 12:27, Dong Aisheng <b29396@freescale.com> wrote:
>> > On Mon, Dec 03, 2012 at 01:22:07PM +0000, Peter Maydell wrote:
>> >> What we're really providing the guest here is a hardware-accelerated
>> >> software emulation of a no-virtualization GICv2. So it's better for
>> >> the state we expose to userspace to be the state of that emulated
>> >> hardware, and not to expose details of exactly what that hardware
>> >> acceleration is.
>> >
>> > It looks like a good idea.
>> > Then in which format? User space qemu and kernel space vgic are using
>> > different data format to describe gic state.
>> > We definitely need a standard one to use with good compatibility.
>> > One simple way may be just registers value of no-virtualization GICv2.
>>
>> "Values of registers" and "state of a device" are not identical
>> (though the internal state is often made visible via registers).
>> We care about the latter, not the former.

> I agree your point, the problem is how to define a standard "state of
> gic device"?

Yes, indeed; that is exactly the major design question which
your patch needs to solve.

> The gic registers format is the exist one and both kernel or user space
> state code changes do not affect each other.

Just to be clear here, "the gic registers format" is not a
sufficient definition of the GIC internal state. To
take a simple example, the distributor registers include a set
of "set-enable" registers GICD_ISENABLERn and a set of "clear
enable" registers GICD_ICENABLERn. These are two views (and
ways to alter) a single set of underlying "enable" bits.
What we want from userspace is a way to read and write the
enable bits. We do not want an interface that has the
"write 1 to set/write 1 to clear" semantics of the hardware
registers. Obviously often registers are a simple read/write
view of underlying state, but this isn't always true.

> One concern is that i'm still not sure if there will be no issue
> if not saving virtual interface control registers.
> It may need some time to research.
>
> Maybe we convert it into standard state and restore it back then.
> But some bits of them may not be exported.

Yes, confirming that the state as exposed via the virtual
interface control registers can be correctly converted into
our canonical state representation is a good cross-check
that we have got it right. We definitely mustn't lose
information, or migration won't work right in some edge case.

-- PMM
