From: alex.bennee@linaro.org (Alex =?utf-8?Q?Benn=C3=A9e?=)
Date: Wed, 25 Jul 2018 16:58:30 +0100
Subject: [RFC PATCH 13/16] KVM: Allow 2048-bit register access via
 KVM_{GET, SET}_ONE_REG
In-Reply-To: <1529593060-542-14-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
 <1529593060-542-14-git-send-email-Dave.Martin@arm.com>
Message-ID: <874lgntihl.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Dave Martin <Dave.Martin@arm.com> writes:

> The Arm SVE architecture defines registers that are up to 2048 bits
> in size (with some possibility of further future expansion).
>
> In order to avoid the need for an excessively large number of
> ioctls when saving and restoring a vcpu's registers, this patch
> adds a #define to make support for individual 2048-bit registers
> through the KVM_{GET,SET}_ONE_REG ioctl interface official.  This
> will allow each SVE register to be accessed in a single call.
>
> There are sufficient spare bits in the register id size field for
> this change, so there is no ABI impact providing that
> KVM_GET_REG_LIST does not enumerate any 2048-bit register unless
> userspace explicitly opts in to the relevant architecture-specific
> features.

Does it? It's not in this patch and looking at the final tree:

  unsigned long kvm_arm_num_regs(struct kvm_vcpu *vcpu)
  {
          unsigned long res = 0;

          res += num_core_regs();
          res += num_sve_regs(vcpu);
          res += kvm_arm_num_sys_reg_descs(vcpu);
          res += kvm_arm_get_fw_num_regs(vcpu);
          res += NUM_TIMER_REGS;

          return res;
  }


which leads to:

  static int enumerate_sve_regs(const struct kvm_vcpu *vcpu, u64 __user **uind)
  {
          unsigned int n, i;
          int err = 0;
          int total = 0;
          unsigned int slices;

          if (!vcpu_has_sve(&vcpu->arch))
                  return 0;

Which enumerates the SVE regs if vcpu_has_sve() which AFAICT is true if
the host supports it, not if the user has requested it.

I'll have to check what but given the indirection of kvm_one_reg I
wonder if existing binaries might end up spamming a badly sized array
when run on a new SVE supporting kernel?

>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  include/uapi/linux/kvm.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index b6270a3..345be88 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1106,6 +1106,7 @@ struct kvm_dirty_tlb {
>  #define KVM_REG_SIZE_U256	0x0050000000000000ULL
>  #define KVM_REG_SIZE_U512	0x0060000000000000ULL
>  #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
> +#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
>
>  struct kvm_reg_list {
>  	__u64 n; /* number of regs */


--
Alex Benn?e
