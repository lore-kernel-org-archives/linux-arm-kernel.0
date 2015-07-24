From: feng.wu@intel.com (Wu, Feng)
Date: Fri, 24 Jul 2015 01:27:29 +0000
Subject: [RFC v2 0/6] IRQ bypass manager and irqfd consumer
In-Reply-To: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
Message-ID: <E959C4978C3B6342920538CF579893F00264820D@SHSMSX104.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org
> [mailto:linux-kernel-owner at vger.kernel.org] On Behalf Of Eric Auger
> Sent: Monday, July 06, 2015 8:11 PM
> To: eric.auger at st.com; eric.auger at linaro.org;
> linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu;
> kvm at vger.kernel.org; christoffer.dall at linaro.org; marc.zyngier at arm.com;
> alex.williamson at redhat.com; pbonzini at redhat.com; avi.kivity at gmail.com;
> mtosatti at redhat.com; Wu, Feng; joro at 8bytes.org;
> b.reynal at virtualopensystems.com
> Cc: linux-kernel at vger.kernel.org; patches at linaro.org
> Subject: [RFC v2 0/6] IRQ bypass manager and irqfd consumer
> 
> This series introduces and extends the IRQ bypass manager written
> by Alex and transforms irqfd into an IRQ bypass manager consumer.
> The producer part, in my case the VFIO platform driver will be introduced
> separately. That code should be usable by both ARM IRQ forwarding
> and Intel Posted Interrupts.
> 
> The IRQ bypass manager enables to setup a negotiated link between an
> IRQ producer and an IRQ consumer (typically the VFIO driver and KVM irqfd).
> 
> The series currently includes Alex's code which was sent my email.
> Its structure obvioulsy will adapt to Alex's will.
> 
> Also the irq bypass manager gets compiled/linked on arm/arm64 along
> with KVM and VFIO platform driver.
> 
> can be found at:
> https://git.linaro.org/people/eric.auger/linux.git/shortlog/refs/heads/v4.2-rc1-
> bypass-fwd-v2
> 
> Best Regards
> 
> Eric
> 
> History:
> v1 -> v2:
> - isolate the bypass manager and irqfd consumer in this series
> - take into account Paolo's comments and use container_of strategy and
>   remove additional fields introduced in v1.
> - create kvm_irqfd.h
> - add unregistration in irqfd_shutdown

Hi Eric,

[4/6], [5/6], and [6/6] of this series are common to forwarded irq and posted
interrupts, did you have a chance to get a new version of them based on
Alex's latest irqbypass manager patch:

https://lkml.org/lkml/2015/7/16/810

Thanks a lot!

Thanks,
Feng

> 
> v1: originally part of [RFC 00/17] ARM IRQ forward control based on IRQ
>     bypass manager (https://lkml.org/lkml/2015/7/2/268)
> 
> 
> Eric Auger (6):
>   KVM: arm/arm64: select IRQ_BYPASS_MANAGER
>   VFIO: platform: select IRQ_BYPASS_MANAGER
>   irq: bypass: Extend skeleton for ARM forwarding control
>   KVM: create kvm_irqfd.h
>   KVM: introduce kvm_arch functions for IRQ bypass
>   KVM: eventfd: add irq bypass consumer management
> 
>  arch/arm/kvm/Kconfig          |   1 +
>  arch/arm64/kvm/Kconfig        |   1 +
>  drivers/vfio/platform/Kconfig |   1 +
>  include/linux/irqbypass.h     |  19 ++++++--
>  include/linux/kvm_host.h      |  37 ++++++++++++++
>  include/linux/kvm_irqfd.h     |  70 +++++++++++++++++++++++++++
>  kernel/irq/bypass.c           |  44 +++++++++++++++--
>  virt/kvm/Kconfig              |   3 ++
>  virt/kvm/eventfd.c            | 109 +++++++++++++-----------------------------
>  9 files changed, 203 insertions(+), 82 deletions(-)
>  create mode 100644 include/linux/kvm_irqfd.h
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
