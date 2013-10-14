From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Oct 2013 15:52:04 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <525BEBB4.4050603@redhat.com> <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
 <525BF089.9050408@arm.com> <2CDDB541-0E92-4452-831E-0B29B24A7C89@suse.de>
 <525BF656.7020207@arm.com> <20131014140527.GB5106@redhat.com>
 <525BFBF9.5010804@arm.com> <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>
Message-ID: <525C0514.5030103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/13 15:16, Alexander Graf wrote:
> 
> On 14.10.2013, at 16:13, Marc Zyngier <marc.zyngier@arm.com> wrote:
> 
>> On 14/10/13 15:05, Michael S. Tsirkin wrote:
>>> On Mon, Oct 14, 2013 at 02:49:10PM +0100, Marc Zyngier wrote:
>>>> On 14/10/13 14:39, Alexander Graf wrote:
>>>>>
>>>>> On 14.10.2013, at 15:24, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>>>>
>>>>>> On 14/10/13 14:10, Alexander Graf wrote:
>>>>>>>
>>>>>>> On 14.10.2013, at 15:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>>>>
>>>>>>>> Il 11/10/2013 16:36, Marc Zyngier ha scritto:
>>>>>>>>> This small patch series adds just enough kernel infrastructure and
>>>>>>>>> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
>>>>>>>>> that the host actually supports such madness.
>>>>>>>>
>>>>>>>> More precisely, it allows the guest drivers to pick the endianness they
>>>>>>>> prefer.  Mixed-endian virtio works fine on QEMU with e.g. a mips guest
>>>>>>>> in emulation mode, because then any given QEMU binary will always use
>>>>>>>> the same endianness (e.g. big for qemu-system-mips).
>>>>>>>
>>>>>>> We have the same problem (runtime switchable endianness) on PowerPC. IBM POWER is gaining Little Endian support in Linux now, so we could easily end up with an LE guest on a BE host.
>>>>>>>
>>>>>>> IIRC the way we're going to solve this is to hack up virtio_is_big_endian() to evaluate the first CPU's endianness mode (which will always be the same as all other CPU's endianness mode due to hypercall restrictions).
>>>>>>
>>>>>> I have implemented something similar for MMIO emulation in KVM/arm
>>>>>> (except that I only care about the faulting CPU).
>>>>>>
>>>>>> See my initial patch for that:
>>>>>> https://lists.cs.columbia.edu/pipermail/kvmarm/2013-October/007359.html
>>>>>>
>>>>>> That doesn't really change the non-trapping virtio accesses, though.
>>>>>> Where is this virtio_is_big_endian() thing?
>>>>>
>>>>> It's in QEMU's exec.c. It only gets used for config space access that goes through PCI though. Is there any other place where virtio specifies native endianness today?
>>>>
>>>> That's the main problem. Today's virtio flavour doesn't specify anything
>>>> about endianness, and that is what I'm adding. Or rather (as Paolo put
>>>> it), the prefered endianness of the virtio driver.
>>>>
>>>> So once (and if) this flags are in place, you always know what you're
>>>> dealing with. And because it is virtio-centric, you can implement it in
>>>> an architecture independent way.
>>>>
>>>> Also, most of my life revolves around kvmtool. QEMU is hardly on my
>>>> radar, these days (for reasons that are neither technical, nor relevant
>>>> to this forum). So it is important to me that the solution is platform
>>>> emulation agnostic.
>>>>
>>>> 	M.
>>>
>>> f you like, you should be able to implement virtio_is_big_endian
>>> in kvmtool too.
>>
>> Sure. And I imagine this traps back into the kernel to read some
>> register and find out what the endianness of the accessing CPU is?
> 
> Not yet. To be exact, it does the below today. But all virtio device
> emulation is 100% guest endianness unaware. This helper is the only
> piece of code where it gets any idea what endianness the guest has. So
> by checking for references to it in the code you know where endianness
> is an issue. And that's only in the config space.

Only config space? How do you deal with virtio ring descriptors, for
example?

	M.
-- 
Jazz is not dead. It just smells funny...
