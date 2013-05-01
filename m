From: anup@brainfault.org (Anup Patel)
Date: Wed, 1 May 2013 10:31:32 +0530
Subject: [PATCH 0/2] Early printk support for virtio console devices.
In-Reply-To: <2A4B3F6B-55DA-44F3-87DB-064DB4A8D8F8@suse.de>
References: <1366974299-17877-1-git-send-email-pranavkumar@linaro.org>
 <BA2076A6-0688-4E5C-85F9-A9CA8FD75782@suse.de>
 <87obcyc9sh.fsf@rustcorp.com.au>
 <336C59AA-D5D7-472E-A8DA-EEB413DD6C68@suse.de>
 <87r4hsameo.fsf@rustcorp.com.au>
 <2A4B3F6B-55DA-44F3-87DB-064DB4A8D8F8@suse.de>
Message-ID: <CAAhSdy3A_aYKXhGVkWdK4amC14PduccyrGsPNEYKvue=T74_sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 1, 2013 at 5:56 AM, Alexander Graf <agraf@suse.de> wrote:
>
> On 30.04.2013, at 02:32, Rusty Russell wrote:
>
>> Alexander Graf <agraf@suse.de> writes:
>>> Am 29.04.2013 um 05:09 schrieb Rusty Russell <rusty@rustcorp.com.au>:
>>>
>>>> Alexander Graf <agraf@suse.de> writes:
>>>>> On 26.04.2013, at 13:04, Pranavkumar Sawargaonkar wrote:
>>>>>
>>>>>> This patch-set implements early printk support for virtio console devices without using any hypercalls.
>>>>>>
>>>>>> The current virtio early printk code in kernel expects that hypervisor will provide some mechanism generally a hypercall to support early printk. This patch-set does not break existing hypercall based early print support.
>>>>>>
>>>>>> This implementation adds:
>>>>>> 1. Early writeonly register named early_wr in virtio console's config space.
>>>>>> 2. Host feature flags namely VIRTIO_CONSOLE_F_EARLY_WRITE for telling guest about early-write capability in console device.
>>>>>>
>>>>>> Early write mechanism:
>>>>>> 1. When a guest wants to out some character, it has to simply write the character to early_wr register in config space of virtio console device.
>>>>>
>>>>> I won't nack this patch set, but I'll definitely express that I'm not happy with it.
>>>>>
>>>>> MMIO registers are handled by a different layer than the virtio console itself. After the virtio refactoring in QEMU, they will be completely separate drivers. So we'll be in a similar mess with early printk as we are on the s390-virtio machine, where early printk is done through hypercalls and thus we can't directly link it to the console output.
>>>>>
>>>>> I still don't see what the issue is with just implementing a small irq-less virtio driver for early printk.
>>>>
>>>> Well, this shouldn't be mmio-specific, but I kind of get what you mean.
>>>>
>>>> I consider this misnamed: it's an emergency write facility.  Linux may
>>>> use it for an early console,
>>>
>>> If Linux uses it for early console, you won't see any messages from before the virtio-console driver is initialized, because Linux thinks that it's all been printed out.
>>
>> If you can't support it, don't offer the feature.
>
> Fair enough.
>
>>
>>>> but it's also useful for bringup and to
>>>> give a method of emitting errors like "the console ring is corrupt".
>>>>
>>>> A valid implementation may well be to only offer it with some magic
>>>> qemu developer-only commandline and dump it to stdout.
>>>
>>> Why implement it differently from other machines? There are facilities to call into firmware, so you could use that. There's the special Foundation model call that you could implement and reuse for this.
>>
>> Sure, for ARM.  We *have* a console device.  It's the logical place to
>> provide a simple write mechanism.  eg. consider bhyve on FreeBSD.
>
> I don't quite see the point. The reason early printk works so well for x86 is that you have a UART at a predefined place.
>
>>
>>> I don't see why anything like this has to live in virtio-mmio. Oh, and it should default to off.
>>
>> virtio-console, not virtio-mmio.
>
> How will it live in virtio-console? Virtio-console speaks virtio, not register values. If you put this into the config space you break the s390 virtio model.

This is a small limitation of QEMU VirtIO implementation and it can be
easily fixed in QEMU VirtIO.

The VirtIO spec does not tell that VirtIO device specific config
registers are to be emulated by VirtIO transport device (MMIO or PCI).

As per VirtIO spec, the only register that should be emulated by
transport device are the generic VirtIO registers and the VirtIO
device specific config registers should be emulated by VirtIO device
backend.

>
>
> Alex
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--Anup
