From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 3 Oct 2012 11:05:10 -0400
Subject: [kvmarm] [PATCH v2 08/10] ARM: KVM: VGIC initialisation code
In-Reply-To: <20121003100205.GL22445@mudshark.cambridge.arm.com>
References: <20121001091244.49503.96318.stgit@ubuntu>
 <20121001091426.49503.94722.stgit@ubuntu>
 <20121002092412.GB8847@mudshark.cambridge.arm.com>
 <b4b11d71544812cff978b3457a99b90e@localhost>
 <C24866D7-ED20-402F-B769-1FE4D5561C77@virtualopensystems.com>
 <CAFEAcA8Mvh3QzVYTAhLjjbgCqd_AjJ7ji9z7NoLWnM4YUW0OQw@mail.gmail.com>
 <20121002192806.GC20411@mudshark.cambridge.arm.com>
 <CAFEAcA-KL36kwaFFrOA0NG0y1qGhkXZ+bm5FA0LhJsmKDk66Hg@mail.gmail.com>
 <20121003100205.GL22445@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJR-5x7Oj=MzQ+Vd1B_xxwSUTi9kdv6dZx5ASozeniDxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 3, 2012 at 6:02 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Oct 02, 2012 at 08:45:54PM +0100, Peter Maydell wrote:
>> On 2 October 2012 20:28, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Oct 02, 2012 at 07:31:43PM +0100, Peter Maydell wrote:
>> >> We probably want to be passing in the "base of the cpu-internal
>> >> peripherals", rather than "base of the GIC" specifically. For the
>> >> A15 these are the same thing, but that's not inherent [compare the
>> >> A9 which has more devices at fixed offsets from a configurable
>> >> base address].
>> >
>> > If you do that, userspace will need a way to probe the emulated CPU so
>> > that is knows exactly which set of peripherals there are and which ones it
>> > needs to emulate. This feels pretty nasty, given that the vgic is handled
>> > more or less completely by the kernel-side of things.
>>
>> Userspace knows what the emulated CPU is because it tells the
>> kernel which CPU to provide -- the kernel can say "yes" or "no" but
>> it can't provide a different CPU to the one we ask for, or
>> one with bits mising...
>
> Aha, ok, I didn't realise that's how it works. Does userspace just pass the
> CPUID or is there an identifier provided by kvm?
>
> /me jumps back into the code.
>
Userspace provides an identifier (0 for Cortex-A15). This changed in
the last patch series, so as to only have one (public and internal)
identifier used to index into the array of core-specific coprocessor
handlings.
