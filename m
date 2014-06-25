From: joel.schopp@amd.com (Joel Schopp)
Date: Wed, 25 Jun 2014 16:18:03 -0500
Subject: [PATCH v2 9/9] arm64: KVM: vgic: deal with GIC sub-page alignment
In-Reply-To: <CAFEAcA-bRXrnoXbpV0RbD_QX4PVxCoxAB2Lt869itQZMrSr-KA@mail.gmail.com>
References: <1403169693-13982-1-git-send-email-marc.zyngier@arm.com>
 <1403169693-13982-10-git-send-email-marc.zyngier@arm.com>
 <53A9D14D.2020802@amd.com>
 <CAFEAcA-8vOz34NPPqkh1trU5C1irGatcJjAr1f-wWEPzhpy95w@mail.gmail.com>
 <53AAE31C.2060506@amd.com>
 <CAFEAcA-5CaE6T2JkNdf7M9t3LTqv05Um-nWbWjSDVbu_Bo+a2w@mail.gmail.com>
 <53AB245B.8080409@amd.com>
 <CAFEAcA-bRXrnoXbpV0RbD_QX4PVxCoxAB2Lt869itQZMrSr-KA@mail.gmail.com>
Message-ID: <53AB3C8B.9040703@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 06/25/2014 03:45 PM, Peter Maydell wrote:
> On 25 June 2014 20:34, Joel Schopp <joel.schopp@amd.com> wrote:
>> It doesn't work for me.  Maybe I'm doing something wrong, but I can't see
>> what.  I am unique in that I'm running a gic-400 (gicv2m) on aarch64
>> hardware with 64k pages.  I'm also unique in that my hardware maps each 4K
>> gic entry to a 64K page (aliasing each 4k of gic 16 times in a 64K page, ie
>> the gic virtual ic is at 0xe1140000 and 0xe1141000 and 0xe1142000, etc).
>>
>> This is inline with appendix F of the server base system architecture.  This
>> is inconvenient when the size is 0x2000 (8K).  As a result all the offsets
>> in the device tree entries are to the last 4K in the page so that an 8K read
>> will read the last 4k from one page and the first 4k from the next and
>> actually get 8k of the gic.
>>
>>
>>          gic: interrupt-controller at e1101000 {
>>                  compatible = "arm,gic-400";
>>                  #interrupt-cells = <3>;
>>                  #address-cells = <0>;
>>                  interrupt-controller;
>>                  msi-controller;
>>                  reg = <0x0 0xe1110000 0 0x1000>, /* gic dist */
>>                        <0x0 0xe112f000 0 0x2000>, /* gic cpu */
>>                        <0x0 0xe114f000 0 0x2000>, /* gic virtual ic*/
>>                        <0x0 0xe116f000 0 0x2000>, /* gic virtual cpu*/
>>                        <0x0 0xe1180000 0 0x1000>; /* gic msi */
> Right, this is the oddball case we don't yet support for 64K pages
> (though as you say it is a permitted configuration per the SBSA).
At least I know I'm not going crazy.
>
>>                  interrupts = <1 8 0xf04>;
>>          };
>>
>>
>> My concern here is that if userspace is going to look at 8k starting at the
>> beginning of the page, guest offset 0 in your terminology, (say 0xe1140000)
>> instead of starting at the last 4k of the page, offset 0xf000 (say
>> 0xe114f000) it is going to get the second 4k wrong by reading 0xe1141000
>> instead of 0xe1150000.
> Userspace doesn't actually look at anything in the GICC. It just asks
> the kernel to put the guest GICC (ie the mapping of the host GICV)
> at a particular base address which happens to be a multiple of 64K.
> In this case if the host kernel is using 64K pages then the KVM
> kernel code ought to say "sorry, can't do that" when we tell it the
> base address. (That is, it's impossible to give the guest a VM
> where the GICC it sees is at a 64K boundary on your hardware
> and host kernel config, and hopefully we report that in a not totally
> opaque fashion.)
The errors I'm seeing look like:
from qemu:
error: kvm run failed Bad address
Aborted (core dumped)

from kvm:
[ 7931.722965] kvm [1208]: Unsupported fault status: EC=0x20 DFCS=0x14

from kvmtool:
from lkvm (kvmtool):
   Warning: /extra/rootfs/boot/Image is not a bzImage. Trying to load it 
as a flat binary...
   Info: Loaded kernel to 0x80080000 (10212384 bytes)
   Info: Placing fdt at 0x8fe00000 - 0x8fffffff
   Info: virtio-mmio.devices=0x200 at 0x10000:36

KVM_RUN failed: Bad address


>
> If you hack QEMU's memory map for the virt board so instead of
>      [VIRT_GIC_CPU] = { 0x8010000, 0x10000 },
> we have
>      [VIRT_GIC_CPU] = { 0x801f000, 0x2000 },
No change in result, not to say that this wouldn't work if some other 
unknown problem were fixed.
>
> does it work? If QEMU supported this VGIC_GRP_ADDR_OFFSET
> query then all it would do would be to change that offset and size.
> It would be good to know if there are other problems beyond that...
>
> (Conveniently, Linux guests won't currently try to look at the second
> 4K page of their GICC...)
That's handy.
