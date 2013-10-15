From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Oct 2013 10:19:57 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <20131015063831.GA19143@redhat.com>
References: <525BFBF9.5010804@arm.com>
 <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>	<525C0514.5030103@arm.com>
 <525C0622.8040504@redhat.com>	<525C09D1.8060103@arm.com>
 <525C0C21.2070001@redhat.com>	<525C0F99.8030909@arm.com>
 <525C20E8.6080409@redhat.com>	<20131014171022.GA13807@redhat.com>
 <874n8jbfoa.fsf@rustcorp.com.au> <20131015063831.GA19143@redhat.com>
Message-ID: <525D08BD.6060405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/13 07:38, Michael S. Tsirkin wrote:
> On Tue, Oct 15, 2013 at 09:53:17AM +1030, Rusty Russell wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>>> On Mon, Oct 14, 2013 at 06:50:48PM +0200, Paolo Bonzini wrote:
>>>> Il 14/10/2013 17:36, Marc Zyngier ha scritto:
>>>>>>>
>>>>>>> Devices are fine in QEMU, it's only the "generic" parts (rings) that are
>>>>>>> missing AFAICT.
>>>>> So if I understand correctly how it works, target endianness is set at
>>>>> compile time, and you have a BE specific QEMU?
>>>>
>>>> Yes.  Though as Alex said, this will have to change for PPC
>>>> little-endian support.
>>>>
>>>> Paolo
>>>
>>> Or we'll just say that this platform requires virtio 1.0.
>>
>> To come full circle, I have implemented virtio support for BE PPC in
>> qemu :) And we'll be supporting pre-1.0 for the moment. I'm awaiting
>> some ppc-specific hooks, but it could be merged without them.
>>
>> It's icky: we don't really want to use the current endianness of the
>> CPU, since in theory a BE kernel could be running an LE process.  So at
>> the time of virtio device reset (the first thing the Linux drivers do)
>> we read the endianness of the interrupt entry point, which is presumably
>> the OS endianness.
> 
> Indeed, ick.
> The next thing after reset is status write:
> 
>         /* We always start by resetting the device, in case a previous
>          * driver messed it up.  This also tests that code path a
>          * little. */
>         dev->config->reset(dev);
> 
>         /* Acknowledge that we've seen the device. */
>         add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> 
> and mmio happens to use a 32 bit register for this:
> 
> 	static void vm_set_status(struct virtio_device *vdev, u8 status)
> 	{
> 		struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
> 
> 		/* We should never be setting status to 0. */
> 		BUG_ON(status == 0);
> 
> 		writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> 	}
> 
> so if we only care about mmio, we can use the status write
> to detect endian-ness: low byte set means LE, high byte set
> means BE, which seems cleaner.
> 
> Hmm?

Don't think it works. MMIO is LE only, so the interesting byte will
always be at the same location (writel will do the swap).

	M.
-- 
Jazz is not dead. It just smells funny...
