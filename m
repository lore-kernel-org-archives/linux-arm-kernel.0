From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 11 Mar 2015 11:19:08 +0000
Subject: [PATCH v2 0/5] GICv3: add 32bit compatibility
In-Reply-To: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
References: <1425320432-6325-1-git-send-email-jean-philippe.brucker@arm.com>
Message-ID: <550024AC.2070901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/15 18:20, Jean-Philippe Brucker wrote:
> This series adds 32bit compatibility to Marc's GICv3 driver. Only SGIs,
> PPIs and SPIs support is present, no ITS.
> 
> It is now based on Linux 4.0-rc1, which contains Andre's GICv3 emulation
> series for KVM [1]. With this support along with the kvmtool patches
> mentioned in [1], it is possible to run ARM guests that use GICv3.
> 
> Changes since v1 [2]:
> * rebased on 4.0-rc1
> * fix the mistakes pointed out by Russell and Vladimir
> * add a patch to select ARM_GIC_V3 under ARCH_VIRT, as suggested by Marc
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/316230.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310124.htm
> 

Hi Jean,

In case CONFIG_KVM_ARM_VGIC=y there is build error:

  CC      arch/arm/kvm/../../../virt/kvm/arm/vgic.o
 arch/arm/kvm/../../../virt/kvm/arm/vgic.c: In function 'kvm_vgic_addr':
 arch/arm/kvm/../../../virt/kvm/arm/vgic.c:1703:7: error:
'KVM_VGIC_V3_ADDR_TYPE_DIST' undeclared (first use in this function)
   case KVM_VGIC_V3_ADDR_TYPE_DIST:
        ^
 arch/arm/kvm/../../../virt/kvm/arm/vgic.c:1703:7: note: each undeclared
identifier is reported only once for each function it appears in
 arch/arm/kvm/../../../virt/kvm/arm/vgic.c:1706:16: error:
'KVM_VGIC_V3_DIST_SIZE' undeclared (first use in this function)
    block_size = KVM_VGIC_V3_DIST_SIZE;
                 ^
 arch/arm/kvm/../../../virt/kvm/arm/vgic.c:1709:7: error:
'KVM_VGIC_V3_ADDR_TYPE_REDIST' undeclared (first use in this function)
   case KVM_VGIC_V3_ADDR_TYPE_REDIST:
        ^
 arch/arm/kvm/../../../virt/kvm/arm/vgic.c:1712:16: error:
'KVM_VGIC_V3_REDIST_SIZE' undeclared (first use in this function)
    block_size = KVM_VGIC_V3_REDIST_SIZE;
                 ^
 make[1]: *** [arch/arm/kvm/../../../virt/kvm/arm/vgic.o] Error 1
 make: *** [arch/arm/kvm] Error 2

Thanks
Vladimir

> Cheers,
> Jean
> 
> 
> Jean-Philippe Brucker (5):
>   arm64: GICv3: refactor the AArch64 specific parts
>   arm64: GICv3: change unsigned types for AArch32 compatibility
>   arm64: GICv3: Specialize readq and writeq accesses
>   ARM: add 32bit support to GICv3
>   ARM: virt: select ARM_GIC_V3
> 
>  arch/arm/Kconfig                    |   1 +
>  arch/arm/include/asm/arch_gicv3.h   | 182 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/arch_gicv3.h | 141 ++++++++++++++++++++++++++++
>  drivers/irqchip/irq-gic-v3.c        |  69 ++++----------
>  include/linux/irqchip/arm-gic-v3.h  | 115 ++++++-----------------
>  5 files changed, 369 insertions(+), 139 deletions(-)
>  create mode 100644 arch/arm/include/asm/arch_gicv3.h
>  create mode 100644 arch/arm64/include/asm/arch_gicv3.h
> 
