From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 17 Oct 2013 10:57:06 +1030
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <525BE53C.6010100@arm.com>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <87d2n88dps.fsf@rustcorp.com.au> <525BE53C.6010100@arm.com>
Message-ID: <87zjq891yd.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier <marc.zyngier@arm.com> writes:
> On 14/10/13 09:21, Rusty Russell wrote:
>> Marc Zyngier <marc.zyngier@arm.com> writes:
>>> This small patch series adds just enough kernel infrastructure and
>>> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
>>> that the host actually supports such madness.
>>>
>>> This has been tested on arm64, with some fixes to KVM and a set of
>>> changes to kvmtool, both which I am posting separately.
>> 
>> OK, so I already have a patch which supports config space accessors.
>> I've posted the series below, and since you want it, I'll put it in
>> virtio-next after more testing and rebasing...
>
> Yes, that's definitely something I'd like to see being merged, as it
> would allow me to drop a significant chunk of changes.

OK, I've just put them into virtio-next.

>> But we won't be using feature bits for endianness, since we're defining
>> endian in the 1.0 spec (whether LE-everywhere or LE-for-mmio-and-PCI is
>> still debated).  Since we need to guess for backwards compat anyway,
>> let's keep doing this until v1.0?
>
> When is 1.0 going to happen? When will actual implementation of drivers
> and devices show up in my favourite platform emulation?

1.0 won't be finalized until early next year.  We aim to publish the
first draft next month, but noone should finalize implementations until
the feedback process is complete.

> Having a grand plan for the future is great, but I need something
> working right now, or at least fairly soonish... And I need it to be
> backward compatible, as none of the above is going to show up overnight.

Well, mmio BE won't work at all right now due to the signature check
being wrong in Linux.  So there are two choices: (1) fix it, and use
heuristics to figure out if the guest is BE, or (2) say there's no BE
mmio, and wait for 1.0.

I don't know what your timeline is: you might need to chat with Pawel
internally.

BTW, for qemu and PPC (though virtio-pci, not mmio) I look at the guest
interrupt delivery endian bit upon any virtio device reset to guess
endian.  Since Linux guests reset the device before doing anything else,
this works well, and supports crazy stuff like "kexec a kernel in the
other endian".

>> (Yeah, I made this mess with "native endian".  I promise I have learnt
>> my lesson).
>
> Paracetamol bill coming you way... ;-)

Now I just have to figure out where to send my equivalent bill...

Cheers,
Rusty.
