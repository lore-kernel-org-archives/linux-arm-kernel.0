From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 2 Oct 2012 19:31:43 +0100
Subject: [kvmarm] [PATCH v2 08/10] ARM: KVM: VGIC initialisation code
In-Reply-To: <C24866D7-ED20-402F-B769-1FE4D5561C77@virtualopensystems.com>
References: <20121001091244.49503.96318.stgit@ubuntu>
 <20121001091426.49503.94722.stgit@ubuntu>
 <20121002092412.GB8847@mudshark.cambridge.arm.com>
 <b4b11d71544812cff978b3457a99b90e@localhost>
 <C24866D7-ED20-402F-B769-1FE4D5561C77@virtualopensystems.com>
Message-ID: <CAFEAcA8Mvh3QzVYTAhLjjbgCqd_AjJ7ji9z7NoLWnM4YUW0OQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2 October 2012 18:55, Christoffer Dall <c.dall@virtualopensystems.com> wrote:
> On Oct 2, 2012, at 6:25 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Tue, 2 Oct 2012 10:24:13 +0100, Will Deacon <will.deacon@arm.com>
>>> We really don't want the physical memory map for the guest hardwired in
>> the
>>> kernel. Please find a way to parameterise this from userspace.
>>
>> Yes, this is a known problem. KVM doesn't offer a standard way of passing
>> the address of an interrupt controller (none of the other architectures
>> have it memory mapped).
>>
>> We probably need a separate ioctl
>
> Thoughts on how to make this API flexible enough?
>
> Can we somehow provide a device tree to the host kernel, which would
> be the same device tree the guest uses, which may also describe virtio
> features, or is this completely sci fi?

I'm not really in favour of trying to shoehorn device trees in here
(among other things, the virtual machine we create should be the actual
machine matching the hardware, not something randomly generated
from the device tree. Also requiring userspace to manufacture a
device tree from scratch is kind of awkward: there's no reason
the guest has to be using one, and it's a lot of effort to go to
to pass a single address into the kernel...)

We probably want to be passing in the "base of the cpu-internal
peripherals", rather than "base of the GIC" specifically. For the
A15 these are the same thing, but that's not inherent [compare the
A9 which has more devices at fixed offsets from a configurable
base address].

On hardware this is done by having an input signal that's sampled
at reset that tells the CPU where the peripherals are; is there
an equivalent of that for any other CPU properties that we have
already in the KVM API?

-- PMM
