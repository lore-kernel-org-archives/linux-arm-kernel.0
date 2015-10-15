From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Oct 2015 14:34:27 +0200
Subject: [PATCH] KVM: arm: use GIC support unconditionally
In-Reply-To: <6276915.O3N4ZN0iPv@wuerfel>
References: <6276915.O3N4ZN0iPv@wuerfel>
Message-ID: <20151015123427.GE21930@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 03:22:31PM +0200, Arnd Bergmann wrote:
> The vgic code on ARM is built for all configurations that enable KVM,
> but the parent_data field that it references is only present when
> CONFIG_IRQ_DOMAIN_HIERARCHY is set:
> 
> virt/kvm/arm/vgic.c: In function 'kvm_vgic_map_phys_irq':
> virt/kvm/arm/vgic.c:1781:13: error: 'struct irq_data' has no member named 'parent_data'
> 
> This flag is implied by the GIC driver, and indeed the VGIC code only
> makes sense if a GIC is present. This changes the CONFIG_KVM symbol
> to always select GIC, which avoids the issue.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 662d9715840 ("arm/arm64: KVM: Kill CONFIG_KVM_ARM_{VGIC,TIMER}")
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 210eccadb69a..356970f3b25e 100644
> --- a/arch/arm/kvm/Kconfig
> +++ b/arch/arm/kvm/Kconfig
> @@ -21,6 +21,7 @@ config KVM
>  	depends on MMU && OF
>  	select PREEMPT_NOTIFIERS
>  	select ANON_INODES
> +	select ARM_GIC
>  	select HAVE_KVM_CPU_RELAX_INTERCEPT
>  	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
>  	select KVM_MMIO
> 

Applied.

Thanks,
-Christoffer
