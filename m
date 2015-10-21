From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 21 Oct 2015 15:20:00 +0200
Subject: [GIT PULL 3/6] KVM: arm: use GIC support unconditionally
In-Reply-To: <672714208.55851501.1445370665940.JavaMail.zimbra@zmail13.collab.prod.int.phx2.redhat.com>
References: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
 <1445357947-6022-4-git-send-email-christoffer.dall@linaro.org>
 <672714208.55851501.1445370665940.JavaMail.zimbra@zmail13.collab.prod.int.phx2.redhat.com>
Message-ID: <20151021132000.GA13488@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 20, 2015 at 03:51:05PM -0400, Paolo Bonzini wrote:
> Should this be "select" or "depends on"? Not a blocker, can always be fixed in 4.4.
> 
Hmm, I don't know actually.  I trusted Arnd to make the right call and
given Marc's ack as well, I didn't pay too much attention to that
particular detail.

Arnd, any comments?

Thanks,
-Christoffer

> 
> 
> -----Original Message-----
> From: Christoffer Dall [christoffer.dall at linaro.org]
> Received: marted?, 20 ott 2015, 18:18
> To: Paolo Bonzini [pbonzini at redhat.com]; kvmarm at lists.cs.columbia.edu, kvm at vger.kernel.org, linux-arm-kernel at lists.infradead.org
> CC: Marc Zyngier [marc.zyngier at arm.com]; Arnd Bergmann [arnd at arndb.de]; Christoffer Dall [christoffer.dall at linaro.org]
> Subject: [GIT PULL 3/6] KVM: arm: use GIC support unconditionally
> 
> From: Arnd Bergmann <arnd@arndb.de>
> 
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
> Fixes: 662d9715840 ("arm/arm64: KVM: Kill CONFIG_KVM_ARM_{VGIC,TIMER}")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
> index 210ecca..356970f 100644
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
> -- 
> 2.1.2.330.g565301e.dirty
> 
