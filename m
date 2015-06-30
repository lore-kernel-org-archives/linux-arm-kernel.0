From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Jun 2015 17:09:53 +0100
Subject: [PATCH v4 07/10] limit number of VCPUs on demand
In-Reply-To: <1435324578-21832-8-git-send-email-andre.przywara@arm.com>
References: <1435324578-21832-1-git-send-email-andre.przywara@arm.com>
 <1435324578-21832-8-git-send-email-andre.przywara@arm.com>
Message-ID: <20150630160949.GR27725@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 26, 2015 at 02:16:15PM +0100, Andre Przywara wrote:
> Currently the ARM GIC checks the number of VCPUs against a fixed
> limit, which is GICv2 specific. Don't pretend we know better than the
> kernel and let's get rid of that explicit check.
> Instead be more relaxed about KVM_CREATE_VCPU failing with EINVAL,
> which is the way the kernel communicates having reached a VCPU limit.
> If we see this and have at least brought up one VCPU already
> successfully, then don't panic, but limit the number of VCPUs instead.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c     | 6 ------
>  arm/kvm-cpu.c | 7 ++++++-
>  kvm-cpu.c     | 7 +++++++
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/arm/gic.c b/arm/gic.c
> index 99f0d2b..05f85a2 100644
> --- a/arm/gic.c
> +++ b/arm/gic.c
> @@ -84,12 +84,6 @@ int gic__create(struct kvm *kvm)
>  {
>  	int err;
>  
> -	if (kvm->nrcpus > GIC_MAX_CPUS) {
> -		pr_warning("%d CPUS greater than maximum of %d -- truncating\n",
> -				kvm->nrcpus, GIC_MAX_CPUS);
> -		kvm->nrcpus = GIC_MAX_CPUS;
> -	}
> -
>  	/* Try the new way first, and fallback on legacy method otherwise */
>  	err = gic__create_device(kvm);
>  	if (err)
> diff --git a/arm/kvm-cpu.c b/arm/kvm-cpu.c
> index 7780251..b2fd6ed 100644
> --- a/arm/kvm-cpu.c
> +++ b/arm/kvm-cpu.c
> @@ -51,8 +51,13 @@ struct kvm_cpu *kvm_cpu__arch_init(struct kvm *kvm, unsigned long cpu_id)
>  		return NULL;
>  
>  	vcpu->vcpu_fd = ioctl(kvm->vm_fd, KVM_CREATE_VCPU, cpu_id);
> -	if (vcpu->vcpu_fd < 0)
> +	if (vcpu->vcpu_fd < 0) {
> +		if (errno == EINVAL) {
> +			free(vcpu);
> +			return NULL;
> +		}

Hmm, but EINVAL can mean all sorts of other failures too, surely? I'm
not against removing the nrcpus check, but I think we should die if ioctls
start failing rather than silently ignore them.

Will
