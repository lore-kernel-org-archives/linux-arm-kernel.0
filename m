From: cdall@kernel.org (Christoffer Dall)
Date: Fri, 2 Mar 2018 10:37:09 +0100
Subject: [PATCH] KVM: arm/arm64: reduce verbosity of KVM init log
In-Reply-To: <20180302081630.6385-1-ard.biesheuvel@linaro.org>
References: <20180302081630.6385-1-ard.biesheuvel@linaro.org>
Message-ID: <CAEDV+gKSPcsab=fK9URupuV+AzAq_CDwPLkM65WF23__X4H5PQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 9:16 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On my GICv3 system, the following is printed to the kernel log at boot:
>
>    kvm [1]: 8-bit VMID
>    kvm [1]: IDMAP page: d20e35000
>    kvm [1]: HYP VA range: 800000000000:ffffffffffff
>    kvm [1]: vgic-v2 at 2c020000
>    kvm [1]: GIC system register CPU interface enabled
>    kvm [1]: vgic interrupt IRQ1
>    kvm [1]: virtual timer IRQ4
>    kvm [1]: Hyp mode initialized successfully
>
> The KVM IDMAP is a mapping of a statically allocated kernel structure,
> and so printing its physical address leaks the physical placement of
> the kernel when physical KASLR in effect. So change the kvm_info() to
> kvm_debug() to remove it from the log output.
>
> While at it, trim the output a bit more: IRQ numbers can be found in
> /proc/interrupts, and the HYP VA and vgic-v2 lines are not highly
> informational either.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  virt/kvm/arm/arch_timer.c     | 2 +-
>  virt/kvm/arm/mmu.c            | 6 +++---
>  virt/kvm/arm/vgic/vgic-init.c | 2 +-
>  virt/kvm/arm/vgic/vgic-v2.c   | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 70268c0bec79..0bf76ab1ec0b 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -755,7 +755,7 @@ int kvm_timer_hyp_init(bool has_gic)
>                 }
>         }
>
> -       kvm_info("virtual timer IRQ%d\n", host_vtimer_irq);
> +       kvm_debug("virtual timer IRQ%d\n", host_vtimer_irq);
>
>         cpuhp_setup_state(CPUHP_AP_KVM_ARM_TIMER_STARTING,
>                           "kvm/arm/timer:starting", kvm_timer_starting_cpu,
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index ec62d1cccab7..b960acdd0c05 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -1810,9 +1810,9 @@ int kvm_mmu_init(void)
>          */
>         BUG_ON((hyp_idmap_start ^ (hyp_idmap_end - 1)) & PAGE_MASK);
>
> -       kvm_info("IDMAP page: %lx\n", hyp_idmap_start);
> -       kvm_info("HYP VA range: %lx:%lx\n",
> -                kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
> +       kvm_debug("IDMAP page: %lx\n", hyp_idmap_start);
> +       kvm_debug("HYP VA range: %lx:%lx\n",
> +                 kern_hyp_va(PAGE_OFFSET), kern_hyp_va(~0UL));
>
>         if (hyp_idmap_start >= kern_hyp_va(PAGE_OFFSET) &&
>             hyp_idmap_start <  kern_hyp_va(~0UL) &&
> diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
> index 743ca5cb05ef..f99ff0f33ef0 100644
> --- a/virt/kvm/arm/vgic/vgic-init.c
> +++ b/virt/kvm/arm/vgic/vgic-init.c
> @@ -520,7 +520,7 @@ int kvm_vgic_hyp_init(void)
>                 goto out_free_irq;
>         }
>
> -       kvm_info("vgic interrupt IRQ%d\n", kvm_vgic_global_state.maint_irq);
> +       kvm_debug("vgic interrupt IRQ%d\n", kvm_vgic_global_state.maint_irq);
>         return 0;
>
>  out_free_irq:
> diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
> index c32d7b93ffd1..e9d840a75e7b 100644
> --- a/virt/kvm/arm/vgic/vgic-v2.c
> +++ b/virt/kvm/arm/vgic/vgic-v2.c
> @@ -410,7 +410,7 @@ int vgic_v2_probe(const struct gic_kvm_info *info)
>         kvm_vgic_global_state.type = VGIC_V2;
>         kvm_vgic_global_state.max_gic_vcpus = VGIC_V2_MAX_CPUS;
>
> -       kvm_info("vgic-v2@%llx\n", info->vctrl.start);
> +       kvm_debug("vgic-v2@%llx\n", info->vctrl.start);
>
>         return 0;
>  out:
> --
> 2.11.0
>

Acked-by: Christoffer Dall <cdall@kernel.org>
