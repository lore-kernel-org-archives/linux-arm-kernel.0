From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 27 Aug 2014 17:10:55 +0200
Subject: [RFC 0/9] KVM-VFIO IRQ forward control
In-Reply-To: <1409075342.2906.96.camel@ul30vt.home>
References: <1408973264-30384-1-git-send-email-eric.auger@linaro.org>
 <1409075342.2906.96.camel@ul30vt.home>
Message-ID: <53FDF4FF.1060809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2014 07:49 PM, Alex Williamson wrote:
> On Mon, 2014-08-25 at 15:27 +0200, Eric Auger wrote:
>> This RFC proposes an integration of "ARM: Forwarding physical
>> interrupts to a guest VM" (http://lwn.net/Articles/603514/) in
>> KVM.
>>
>> It enables to transform a VFIO platform driver IRQ into a forwarded
>> IRQ. The direct benefit is that, for a level sensitive IRQ, a VM
>> switch can be avoided on guest virtual IRQ completion. Before this
>> patch, a maintenance IRQ was triggered on the virtual IRQ completion.
>>
>> When the IRQ is forwarded, the VFIO platform driver does not need to
>> disable the IRQ anymore. Indeed when returning from the IRQ handler
>> the IRQ is not deactivated. Only its priority is lowered. This means
>> the same IRQ cannot hit before the guest completes the virtual IRQ
>> and the GIC automatically deactivates the corresponding physical IRQ.
>>
>> Besides, the injection still is based on irqfd triggering. The only
>> impact on irqfd process is resamplefd is not called anymore on
>> virtual IRQ completion since this latter becomes "transparent".
>>
>> The current integration is based on an extension of the KVM-VFIO
>> device, previously used by KVM to interact with VFIO groups. The
>> patch serie now enables KVM to directly interact with a VFIO
>> platform device. The VFIO external API was extended for that purpose.
>>
>> Th KVM-VFIO device can get/put the vfio platform device, check its
>> integrity and type, get the IRQ number associated to an IRQ index.
>>
>> The KVM-VFIO is extended with an architecture specific implementation.
>> IRQ forward control is implemented in the ARM specific part.
>>
>> from a user point of view, the functionality is provided through new
>> KVM-VFIO device commands, KVM_DEV_VFIO_DEVICE_(DE)ASSIGN_IRQ
>> and the capability can be checked with KVM_HAS_DEVICE_ATTR.
>> Assignment can only be changed when the physical IRQ is not active.
>> It is the responsability of the user to do this check.
>>
>> This patch serie has the following dependencies:
>> - "ARM: Forwarding physical interrupts to a guest VM"
>>   (http://lwn.net/Articles/603514/) in
>> - [PATCH v2] irqfd for ARM
>>   which itself depends on
>>   - arm/arm64: KVM: Various VGIC cleanups and improvements
>>     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263685.html
>> - and obviously the VFIO platform driver serie:
>>   [RFC PATCH v6 00/20] VFIO support for platform devices on ARM
>>   https://www.mail-archive.com/kvm at vger.kernel.org/msg103247.html
>>
>> Integrated pieces can be found at
>> git://git.linaro.org/people/eric.auger/linux.git
>> on branch 3.17rc1_forward_integ_v0
>>
>> This was was tested on Calxeda Miday, assigning the xgmac main IRQ.
> 
> Presumably this optimization should provide lower interrupt exit latency
> and lower CPU overhead since we avoid the entire EOI path of the
> resampler.  Does it?  It seems like there should be a measurable
> improvement with something like netperf TCP_RR with this series.
> Thanks,

Hi Alex,

I will publish some performance figures soon. I am currently missing a
second node to run netserver.

My preliminary understanding is perf improvement will come from
1) reduction of EOI latency
2) potential saving of VM switches,

with 2) depending on  thephysical IRQ rate.

VERY HIGH RATE:
Without the patch (traditional irqfd on ARM with maintenance IRQ):
guest completes the vIRQ -> maintenance IRQ handler -> guest->host VM
switch -> resamplefd trigger (virqfd) -> enable physical IRQ -> new
physical IRQ hits -> VFIO handler -> fd trigger -> injection in guest ->
host->guest VM switch

with the patch
guest completes the vIRQ -> GIC completes the physical IRQ -> new
physical IRQ hits -> guest->host VM switch -> VFIO handler -> fd trigger
-> injection in guest -> host->guest VM switch

=> Same number of VM switches

SLOWER RATE:
Without the patch:
guest completes the vIRQ -> maintenance IRQ handler -> guest->host VM
switch -> resamplefd trigger (virqfd) -> enable physical IRQ
[host ..]
host->guest VM switch
[guest ..]
physical IRQ hits -> guest->host VM switch -> VFIO handler -> fd trigger
-> injection in guest -> host->guest VM switch

With that patch:
guest completes the vIRQ -> GIC completes the physical IRQ
[guest ..]
physical IRQ hits -> guest->host VM switch -> VFIO handler -> fd trigger
-> injection in guest -> host->guest VM switch

Hence less VM switches with that patch. But it is also related to
scheduling, relative load of host/guest...

Any comment welcome!

Best Regards

Eric
> 
> Alex
> 
>> Eric Auger (9):
>>   KVM: ARM: VGIC: fix multiple injection of level sensitive forwarded
>>     IRQ
>>   KVM: ARM: VGIC: add forwarded irq rbtree lock
>>   VFIO: platform: handler tests whether the IRQ is forwarded
>>   KVM: KVM-VFIO: update user API to program forwarded IRQ
>>   VFIO: Extend external user API
>>   KVM: KVM-VFIO: allow arch specific implementation
>>   KVM: KVM-VFIO: add new VFIO external API hooks
>>   KVM: KVM-VFIO: add kvm_vfio_arch_data and accessors
>>   KVM: KVM_VFIO: ARM: implement irq forwarding control
>>
>>  Documentation/virtual/kvm/devices/vfio.txt |  25 ++
>>  arch/arm/include/asm/kvm_host.h            |  16 +
>>  arch/arm/include/uapi/asm/kvm.h            |   6 +
>>  arch/arm/kvm/Makefile                      |   2 +-
>>  arch/arm/kvm/kvm_vfio_arm.c                | 599 +++++++++++++++++++++++++++++
>>  drivers/vfio/platform/vfio_platform_irq.c  |   7 +-
>>  drivers/vfio/vfio.c                        |  35 ++
>>  include/kvm/arm_vgic.h                     |   1 +
>>  include/linux/kvm_host.h                   |  30 ++
>>  include/linux/vfio.h                       |   4 +
>>  include/uapi/linux/kvm.h                   |   3 +
>>  virt/kvm/arm/vgic.c                        |  55 ++-
>>  virt/kvm/vfio.c                            |  92 +++++
>>  13 files changed, 862 insertions(+), 13 deletions(-)
>>  create mode 100644 arch/arm/kvm/kvm_vfio_arm.c
>>
> 
> 
> 
