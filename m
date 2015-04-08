From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 8 Apr 2015 14:05:20 +0100
Subject: [v3 2/5] arm64: kvm: allow EL2 context to be reset on shutdown
In-Reply-To: <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
References: <1427953216-11737-1-git-send-email-takahiro.akashi@linaro.org>
 <1427953216-11737-3-git-send-email-takahiro.akashi@linaro.org>
Message-ID: <20150408130520.GB5977@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 06:40:13AM +0100, AKASHI Takahiro wrote:
> The current kvm implementation keeps EL2 vector table installed even
> when the system is shut down. This prevents kexec from putting the system
> with kvm back into EL2 when starting a new kernel.
> 
> This patch resolves this issue by calling a cpu tear-down function via
> reboot notifier, kvm_reboot_notify(), which is invoked by
> kernel_restart_prepare() in kernel_kexec().
> While kvm has a generic hook, kvm_reboot(), we can't use it here because
> a cpu teardown function will not be invoked, under current implementation,
> if no guest vm has been created by kvm_create_vm().
> Please note that kvm_usage_count is zero in this case.
> 
> We'd better, in the future, implement cpu hotplug support and put the
> arch-specific initialization into kvm_arch_hardware_enable/disable().
> This way, we would be able to revert this patch.

Why can't we use kvm_arch_hardware_enable/disable() currently?

> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  arch/arm/kvm/arm.c     |   21 +++++++++++++++++++++
>  arch/arm64/kvm/Kconfig |    1 -
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index 39df694..f64713e 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -25,6 +25,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/fs.h>
>  #include <linux/mman.h>
> +#include <linux/reboot.h>
>  #include <linux/sched.h>
>  #include <linux/kvm.h>
>  #include <trace/events/kvm.h>
> @@ -1100,6 +1101,23 @@ struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr)
>  	return NULL;
>  }
>  
> +static int kvm_reboot_notify(struct notifier_block *nb,
> +			     unsigned long val, void *v)
> +{
> +	/*
> +	 * Reset each CPU in EL2 to initial state.
> +	 */
> +	on_each_cpu(kvm_cpu_reset, NULL, 1);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block kvm_reboot_nb = {
> +	.notifier_call		= kvm_reboot_notify,
> +	.next			= NULL,
> +	.priority		= 0, /* FIXME */

It would be helpful for the comment to explain why this is wrong, and
what needs fixing.

Mark.
