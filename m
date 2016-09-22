From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 10:58:22 +0100
Subject: [PATCH v4 10/10] ARM: KVM: Support vgic-v3
In-Reply-To: <1473691764-29424-11-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-11-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3AB3E.4060706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> This patch allows to build and use vgic-v3 in 32-bit mode.
> 
> Unfortunately, it can not be split in several steps without extra
> stubs to keep patches independent and bisectable.  For instance,
> virt/kvm/arm/vgic/vgic-v3.c uses function from vgic-v3-sr.c, handling
> access to GICv3 cpu interface from the guest requires vgic_v3.vgic_sre
> to be already defined.
> 
> It is how support has been done:
> 
> * handle SGI requests from the guest
> 
> * report configured SRE on access to GICv3 cpu interface from the guest
> 
> * required vgic-v3 macros are provided via uapi.h
> 
> * static keys are used to select GIC backend
> 
> * to make vgic-v3 build KVM_ARM_VGIC_V3 guard is removed along with
>   the static inlines
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/include/asm/kvm_asm.h      |    3 ++
>  arch/arm/include/asm/kvm_host.h     |    5 ++++
>  arch/arm/include/asm/kvm_hyp.h      |    3 ++
>  arch/arm/include/uapi/asm/kvm.h     |    7 +++++
>  arch/arm/kvm/Makefile               |    2 ++
>  arch/arm/kvm/coproc.c               |   35 +++++++++++++++++++++++
>  arch/arm/kvm/hyp/Makefile           |    1 +
>  arch/arm/kvm/hyp/switch.c           |   12 ++++++--
>  arch/arm64/kvm/Kconfig              |    4 ---
>  include/kvm/arm_vgic.h              |    8 ------
>  virt/kvm/arm/vgic/vgic-kvm-device.c |    8 ------
>  virt/kvm/arm/vgic/vgic-mmio.c       |    2 --
>  virt/kvm/arm/vgic/vgic-mmio.h       |    2 --
>  virt/kvm/arm/vgic/vgic.h            |   54 -----------------------------------
>  14 files changed, 66 insertions(+), 80 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
