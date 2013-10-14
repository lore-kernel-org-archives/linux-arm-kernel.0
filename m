From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Oct 2013 16:12:17 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <525C0622.8040504@redhat.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <525BEBB4.4050603@redhat.com> <FAC2ABD2-F4AE-49D5-A787-F28391D910D7@suse.de>
 <525BF089.9050408@arm.com> <2CDDB541-0E92-4452-831E-0B29B24A7C89@suse.de>
 <525BF656.7020207@arm.com> <20131014140527.GB5106@redhat.com>
 <525BFBF9.5010804@arm.com> <8C68DB9E-8391-4CF2-BB82-A49BDA26998B@suse.de>
 <525C0514.5030103@arm.com> <525C0622.8040504@redhat.com>
Message-ID: <525C09D1.8060103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/13 15:56, Paolo Bonzini wrote:
> Il 14/10/2013 16:52, Marc Zyngier ha scritto:
>>>> Sure. And I imagine this traps back into the kernel to read some
>>>> register and find out what the endianness of the accessing CPU is?
>>>
>>> Not yet. To be exact, it does the below today. But all virtio device
>>> emulation is 100% guest endianness unaware. This helper is the only
>>> piece of code where it gets any idea what endianness the guest has. So
>>> by checking for references to it in the code you know where endianness
>>> is an issue. And that's only in the config space.
>>
>> Only config space? How do you deal with virtio ring descriptors, for
>> example?
> 
> They also use guest endianness, but do not use virtio_is_big_endian()
> (yet?) so Alex missed them.

Yeah, I thought as much. There is a whole bunch of things that need byte
swapping, both at the virtio level itself, and at the device level as well.

Grep-ing for __u{16,32,64} through include/uapi/linux/virtio* shows the
extent of the disaster.

	M.
-- 
Jazz is not dead. It just smells funny...
