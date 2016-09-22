From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Sep 2016 11:01:40 +0100
Subject: [PATCH v4 05/10] KVM: arm: vgic: Fix compiler warnings when built
 for 32-bit
In-Reply-To: <1473691764-29424-6-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-6-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57E3AC04.1070101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/16 15:49, Vladimir Murzin wrote:
> Well, this patch is looking ahead of time, but we'll get following
> compiler warnings as soon as we introduce vgic-v3 to 32-bit world
> 
>   CC      arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.o
> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.c: In function 'vgic_mmio_read_v3r_typer':
> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.c:184:35: warning: left shift count >= width of type [-Wshift-count-overflow]
>   value = (mpidr & GENMASK(23, 0)) << 32;
>                                    ^
> In file included from ./include/linux/kernel.h:10:0,
>                  from ./include/asm-generic/bug.h:13,
>                  from ./arch/arm/include/asm/bug.h:59,
>                  from ./include/linux/bug.h:4,
>                  from ./include/linux/io.h:23,
>                  from ./arch/arm/include/asm/arch_gicv3.h:23,
>                  from ./include/linux/irqchip/arm-gic-v3.h:411,
>                  from arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.c:14:
> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.c: In function 'vgic_v3_dispatch_sgi':
> ./include/linux/bitops.h:6:24: warning: left shift count >= width of type [-Wshift-count-overflow]
>  #define BIT(nr)   (1UL << (nr))
>                         ^
> arch/arm/kvm/../../../virt/kvm/arm/vgic/vgic-mmio-v3.c:614:20: note: in expansion of macro 'BIT'
>   broadcast = reg & BIT(ICC_SGI1R_IRQ_ROUTING_MODE_BIT);
>                     ^
> Let's fix them now.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  virt/kvm/arm/vgic/vgic-mmio-v3.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
