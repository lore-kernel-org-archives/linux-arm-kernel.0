From: drjones@redhat.com (Andrew Jones)
Date: Thu, 19 Jul 2018 16:12:32 +0200
Subject: [RFC PATCH 15/16] KVM: arm64: Enumerate SVE register indices for
 KVM_GET_REG_LIST
In-Reply-To: <1529593060-542-16-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-16-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180719141232.hm2vjld5ztfrtter@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 03:57:39PM +0100, Dave Martin wrote:
> This patch includes the SVE register IDs in the list returned by
> KVM_GET_REG_LIST, as appropriate.
> 
> On a non-SVE-enabled vcpu, no extra IDs are added.
> 
> On an SVE-enabled vcpu, the appropriate number of slide IDs are
> enumerated for each SVE register, depending on the maximum vector
> length for the vcpu.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/kvm/guest.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
> 
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 005394b..5152362 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -21,6 +21,7 @@
>  
>  #include <linux/errno.h>
>  #include <linux/err.h>
> +#include <linux/kernel.h>
>  #include <linux/kvm_host.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> @@ -253,6 +254,73 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  	return err;
>  }
>  
> +static void copy_reg_index_to_user(u64 __user **uind, int *total, int *cerr,
> +				   u64 id)
> +{
> +	int err;
> +
> +	if (*cerr)
> +		return;
> +
> +	if (uind) {
> +		err = put_user(id, *uind);
> +		if (err) {
> +			*cerr = err;
> +			return;
> +		}
> +	}
> +
> +	++*total;
> +	if (uind)
> +		++*uind;
> +}
> +
> +static int enumerate_sve_regs(const struct kvm_vcpu *vcpu, u64 __user **uind)
> +{
> +	unsigned int n, i;
> +	int err = 0;
> +	int total = 0;
> +	unsigned int slices;
> +
> +	if (!vcpu_has_sve(&vcpu->arch))
> +		return 0;
> +
> +	slices = DIV_ROUND_UP(vcpu->arch.sve_max_vl,
> +			      KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));
> +
> +	for (n = 0; n < SVE_NUM_ZREGS; ++n)
> +		for (i = 0; i < slices; ++i)
> +			copy_reg_index_to_user(uind, &total, &err,
> +					       KVM_REG_ARM64_SVE_ZREG(n, i));
> +
> +	for (n = 0; n < SVE_NUM_PREGS; ++n)
> +		for (i = 0; i < slices; ++i)
> +			copy_reg_index_to_user(uind, &total, &err,
> +					       KVM_REG_ARM64_SVE_PREG(n, i));
> +
> +	for (i = 0; i < slices; ++i)
> +		copy_reg_index_to_user(uind, &total, &err,
> +				       KVM_REG_ARM64_SVE_FFR(i));
> +
> +	if (err)
> +		return -EFAULT;
> +
> +	return total;
> +}
> +
> +static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
> +{
> +	return enumerate_sve_regs(vcpu, NULL);
> +}
> +
> +static int copy_sve_reg_indices(const struct kvm_vcpu *vcpu, u64 __user **uind)
> +{
> +	int err;
> +
> +	err = enumerate_sve_regs(vcpu, uind);
> +	return err < 0 ? err : 0;
> +}

I see the above functions were inspired by walk_sys_regs(), but, IMHO,
they're a bit overcomplicated. How about this untested approach?

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 56a0260ceb11..0188a8b30d46 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -130,6 +130,52 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
 	return err;
 }
 
+static int enumerate_sve_regs(const struct kvm_vcpu *vcpu, u64 __user *uind)
+{
+	unsigned int slices = DIV_ROUND_UP(vcpu->arch.sve_max_vl,
+				KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));
+	unsigned int n, i;
+
+	if (!vcpu_has_sve(&vcpu->arch))
+		return 0;
+
+	for (n = 0; < SVE_NUM_ZREGS; ++n) {
+		for (i = 0; i < slices; ++i) {
+			if (put_user(KVM_REG_ARM64_SVE_ZREG(n, i), uind++))
+				return -EFAULT;
+		}
+	}
+
+	for (n = 0; < SVE_NUM_PREGS; ++n) {
+		for (i = 0; i < slices; ++i) {
+			if (put_user(KVM_REG_ARM64_SVE_PREG(n, i), uind++))
+				return -EFAULT;
+		}
+	}
+
+	for (i = 0; i < slices; ++i) {
+		if (put_user(KVM_REG_ARM64_SVE_FFR(i), uind++))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+static unsigned long num_sve_regs(const struct kvm_vcpu *vcpu)
+{
+	unsigned int slices = DIV_ROUND_UP(vcpu->arch.sve_max_vl,
+				KVM_REG_SIZE(KVM_REG_ARM64_SVE_ZREG(0, 0)));
+
+	if (vcpu_has_sve(&vcpu->arch))
+		return (SVE_NUM_ZREGS + SVE_NUM_PREGS + 1) * slices;
+
+	return 0;
+}
+

> +
>  static int sve_reg_bounds(struct reg_bounds_struct *b,
>  			  const struct kvm_vcpu *vcpu,
>  			  const struct kvm_one_reg *reg)
> @@ -403,6 +471,7 @@ unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
>  	unsigned long res = 0;
>  
>  	res += num_core_regs();
> +	res += num_sve_regs(vcpu);
>  	res += kvm_arm_num_sys_reg_descs(vcpu);
>  	res += kvm_arm_get_fw_num_regs(vcpu);
>  	res += NUM_TIMER_REGS;
> @@ -427,6 +496,10 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices)
>  		uindices++;
>  	}
>  
> +	ret = copy_sve_reg_indices(vcpu, &uindices);
> +	if (ret)
> +		return ret;
> +
>  	ret = kvm_arm_copy_fw_reg_indices(vcpu, uindices);
>  	if (ret)
>  		return ret;
> -- 
> 2.1.4
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
