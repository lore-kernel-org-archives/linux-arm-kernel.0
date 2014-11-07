From: cornelia.huck@de.ibm.com (Cornelia Huck)
Date: Fri, 7 Nov 2014 10:07:21 +0100
Subject: [PATCH v13 2/7] KVM: Add generic support for dirty page logging
In-Reply-To: <1415320848-13813-3-git-send-email-m.smarduch@samsung.com>
References: <1415320848-13813-1-git-send-email-m.smarduch@samsung.com>
 <1415320848-13813-3-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141107100721.44c34175.cornelia.huck@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 06 Nov 2014 16:40:43 -0800
Mario Smarduch <m.smarduch@samsung.com> wrote:

> kvm_get_dirty_log() provides generic handling of dirty bitmap, currently reused
> by several architectures. Building on that we intrdoduce 
> kvm_get_dirty_log_protect() adding write protection to mark these pages dirty
> for future write access, before next KVM_GET_DIRTY_LOG ioctl call from user
> space.
> 
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>
> ---
>  include/linux/kvm_host.h |    9 +++++
>  virt/kvm/kvm_main.c      |   95 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+)
> 

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 887df87..f017760 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -981,6 +981,101 @@ out:
>  }
>  EXPORT_SYMBOL_GPL(kvm_get_dirty_log);
> 
> +#if defined(CONFIG_S390) || defined(CONFIG_PPC) || defined(CONFIG_MIPS) || \
> +    defined(CONFIG_IA64) || defined(CONFIG_X86) || defined(CONFIG_ARM) || \
> +    defined(CONFIG_ARM64)

Does this deserve a config symbol that can be selected by architectures
actually using kvm_get_dirty_log_protect()? I.e.,

#ifndef CONFIG_KVM_ARCH_DIRTY_LOG_PROTECT

or so?

> +/*
> + * For architectures that don't use kvm_get_dirty_log_protect() for dirty page
> + * logging, calling this function is illegal. Otherwise the function is defined
> + * in arch subtree and this restriction is removed.
> + */

What about

/*
 * For architectures that don't use kvm_get_dirty_log_protect() for dirty page
 * logging, we must never end up calling this function. Architectures that do
 * use it define their own version of this function.
 */

instead?

> +void kvm_arch_mmu_write_protect_pt_masked(struct kvm *kvm,
> +					struct kvm_memory_slot *slot,
> +					gfn_t gfn_offset,
> +					unsigned long mask)
> +{
> +	BUG();
> +}
> +#endif
> +
(...)
