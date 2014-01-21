From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 20 Jan 2014 17:18:43 -0800
Subject: [PATCH REPOST 3/5] ARM: kvm one_reg coproc set and get BE fixes
In-Reply-To: <1387558125-3460-4-git-send-email-victor.kamensky@linaro.org>
References: <1387558125-3460-1-git-send-email-victor.kamensky@linaro.org>
 <1387558125-3460-4-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20140121011843.GK13432@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Victor,

On Fri, Dec 20, 2013 at 08:48:43AM -0800, Victor Kamensky wrote:
> This patch fixes issue of reading and writing

interesting line break.

an issue with

> ARM V7 registers values from/to user land. Existing code was designed to
> work only in LE case.

The existing code...

'LE case'?  'little-endian'?

> 
> struct kvm_one_reg
> ------------------
> 
> registers value passed through kvm_one_reg structure. It is used by

registers value passed through?  What are you trying to say?

> KVM_SET_ONE_REG, KVM_GET_ONE_REG ioctls. Note by looking at structure

by the KVM...

the structure

> itself we cannot tell what is size of register. Note that structure carries

the size of the register

> address of user memory, 'addr' where register should be read or written

I'm a little confused as to the value of this Section of the commit
text.  I believe the ONE_REG interface is quite well documented
already...

> 
> Setting register (from user-land to kvm)
> ----------------------------------------
> 
> kvm_arm_set_reg takes vcpu and pointer to struct kvm_one_reg which already
> read from user space

I think you could ditch this first sentence

> 
> kvm_arm_set_reg calls set_core_reg or kvm_arm_coproc_set_reg

nit: adding kvm_arm_set_reg() makes it clear that this is the function
you're refering to, and not the ioctl as a concept.

> 
> set_core_reg deals only with 4 bytes registers, it just reads 4 bytes from
> user space and store it properly into vcpu->arch.regs

stores

> 
> kvm_arm_coproc_set_reg deals with registers of different size. At certain

different sizes

At a certain point

> point code reaches phase where it retrieves description of register by id

the description of a register

> and it knows register size, which could be either 4 or 8 bytes. Kernel code

s/could be/is/

Kernel code is ready?

> is ready to read values from user space, but destination type may vary. It
> could be pointer to 32 bit integer or it could be pointer to 64 bit
> integer. And all possible permutation of size and destination pointer are

permutations

> possible.  Depending on destination pointer type, 4 bytes or 8 bytes, two

the destination pointer type

> new helper functions are introduced  - reg_from_user32 and reg_from_user64.
> They are used instead of reg_from_user function which could work only in
> LE case.

which only worked in

> 
> Size  sizeof(*DstInt)   Function used to read from user
>    4                4   reg_from_user32
>    8                4   reg_from_user32 - read two registers
>    4                8   reg_from_user64 - need special handling for BE
>    8                8   reg_from_user64
> 
> Getting register (to user-land from kvm)
> ----------------------------------------
> 
> Situation with reading registers is similar to writing. Integer pointer

The situation

> type of register to be copied could be 4 or 8 bytes. And size passed in

The integer pointer

pointer to be copied?  Please clarify what you are referring to.

> struct kvm_one_reg could be 4 or 8. And any permutation is possible.

Any permutation of source pointer type and size is possible.

> Depending on src pointer type, 4 bytes or 8 bytes, two new helper functions
> are introduced - reg_from_user32 and reg_to_user64. They are used instead

reg_to_user32?

> of reg_to_user function, which could work only in LE case.

the reg_to_user, which worked only for LE.

> 
> Size  sizeof(*SrcInt)   Function used to write to user
>    4                4   reg_to_user32
>    8                4   reg_to_user32 - writes two registers
>    4                8   reg_to_user64 - need special handleing for BE
>    8                8   reg_to_user64

I think it could be slightly more helpful to put a comment on the
functions, like "Write to 32-bit user pointer" on reg_to_user32, but
it's up to you.

> 
> Note code does assume that it can only deals with 4 or 8 byte registers.

Note: We only support register sizes of 4 or 8 bytes.

> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

I don't mean to hammer on your commit message with all my comments.  I
really do appreciate you taking the time to document your changes.
However, with the level of detail you are providing in the commit, I
think you have to be slightly more careful with the language, so that it
doesn't end up being misleading instead of helpful.  I think you could
sum this up much shorter to simply say that core register handling is
already endian-safe, but coprocessors and vfpregs use reg_to_user which
is not endian-safe, and therefore needs changing.

The motivation about the pointer types and register sizes being
arbitrarily different is important though, so I appreciate you listing
that.


> ---
>  arch/arm/kvm/coproc.c | 94 +++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 69 insertions(+), 25 deletions(-)
> 
> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
> index 78c0885..64b2b94 100644
> --- a/arch/arm/kvm/coproc.c
> +++ b/arch/arm/kvm/coproc.c
> @@ -634,17 +634,61 @@ static struct coproc_reg invariant_cp15[] = {
>  	{ CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
>  };
>  
> -static int reg_from_user(void *val, const void __user *uaddr, u64 id)
> +static int reg_from_user64(u64 *val, const void __user *uaddr, u64 id)
> +{
> +	unsigned long regsize = KVM_REG_SIZE(id);
> +	union {
> +		u32	word;
> +		u64	dword;
> +	} tmp = {0};
> +
> +	if (copy_from_user(&tmp, uaddr, regsize) != 0)
> +		return -EFAULT;
> +
> +	switch (regsize) {
> +	case 4:
> +		*val = tmp.word;
> +		break;
> +	case 8:
> +		*val = tmp.dword;
> +		break;
> +	}
> +	return 0;
> +}

You stated in the commit message that any permutation of
KVM_REG_SIZE(id) and sizeof(*val) is possible.

So doesn't this totally mess up the the kernel if I pass a 32-bit
pointer to reg_from_user64?  Or is that not really the case and that's
an exception to all of the permutations?

Basically you KVM_REG_SIZE(id) and sizeof your destination pointer type
should always match, but we abuse this slightly so far.  I don't think
you should cater to that, but just require callers to always provide a
consistent size/type pair (you could also add a union you use as a
parameter instead, or have two typed parameter) and simplify into a
single function.

The only special cases you now have to deal with are in:
set_invariant_cp15(): declare two temp variables of u32 and u64 sizes
get_invariant_cp15(): either have temporary values or change val in
                      corproc_reg to be a union

The current scheme is pretty hard to understand and to make sure we're
not breaking anything...

> +
> +/* Note it may really copy two u32 registers */
> +static int reg_from_user32(u32 *val, const void __user *uaddr, u64 id)
>  {
> -	/* This Just Works because we are little endian. */
>  	if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
>  		return -EFAULT;
>  	return 0;
>  }
>  
> -static int reg_to_user(void __user *uaddr, const void *val, u64 id)
> +static int reg_to_user64(void __user *uaddr, const u64 *val, u64 id)
> +{
> +	unsigned long regsize = KVM_REG_SIZE(id);
> +	union {
> +		u32	word;
> +		u64	dword;
> +	} tmp;
> +
> +	switch (regsize) {
> +	case 4:
> +		tmp.word = *val;
> +		break;
> +	case 8:
> +		tmp.dword = *val;
> +		break;
> +	}
> +
> +	if (copy_to_user(uaddr, &tmp, regsize) != 0)
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +/* Note it may really copy two u32 registers */
> +static int reg_to_user32(void __user *uaddr, const u32 *val, u64 id)
>  {
> -	/* This Just Works because we are little endian. */
>  	if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
>  		return -EFAULT;
>  	return 0;
> @@ -662,7 +706,7 @@ static int get_invariant_cp15(u64 id, void __user *uaddr)
>  	if (!r)
>  		return -ENOENT;
>  
> -	return reg_to_user(uaddr, &r->val, id);
> +	return reg_to_user64(uaddr, &r->val, id);
>  }
>  
>  static int set_invariant_cp15(u64 id, void __user *uaddr)
> @@ -678,7 +722,7 @@ static int set_invariant_cp15(u64 id, void __user *uaddr)
>  	if (!r)
>  		return -ENOENT;
>  
> -	err = reg_from_user(&val, uaddr, id);
> +	err = reg_from_user64(&val, uaddr, id);
>  	if (err)
>  		return err;
>  
> @@ -846,7 +890,7 @@ static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
>  	if (vfpid < num_fp_regs()) {
>  		if (KVM_REG_SIZE(id) != 8)
>  			return -ENOENT;
> -		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
> +		return reg_to_user64(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
>  				   id);
>  	}
>  
> @@ -856,22 +900,22 @@ static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
>  
>  	switch (vfpid) {
>  	case KVM_REG_ARM_VFP_FPEXC:
> -		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
> +		return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
>  	case KVM_REG_ARM_VFP_FPSCR:
> -		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
> +		return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
>  	case KVM_REG_ARM_VFP_FPINST:
> -		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
> +		return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
>  	case KVM_REG_ARM_VFP_FPINST2:
> -		return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
> +		return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
>  	case KVM_REG_ARM_VFP_MVFR0:
>  		val = fmrx(MVFR0);
> -		return reg_to_user(uaddr, &val, id);
> +		return reg_to_user32(uaddr, &val, id);
>  	case KVM_REG_ARM_VFP_MVFR1:
>  		val = fmrx(MVFR1);
> -		return reg_to_user(uaddr, &val, id);
> +		return reg_to_user32(uaddr, &val, id);
>  	case KVM_REG_ARM_VFP_FPSID:
>  		val = fmrx(FPSID);
> -		return reg_to_user(uaddr, &val, id);
> +		return reg_to_user32(uaddr, &val, id);
>  	default:
>  		return -ENOENT;
>  	}
> @@ -890,8 +934,8 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
>  	if (vfpid < num_fp_regs()) {
>  		if (KVM_REG_SIZE(id) != 8)
>  			return -ENOENT;
> -		return reg_from_user(&vcpu->arch.vfp_guest.fpregs[vfpid],
> -				     uaddr, id);
> +		return reg_from_user64(&vcpu->arch.vfp_guest.fpregs[vfpid],
> +				       uaddr, id);
>  	}
>  
>  	/* FP control registers are all 32 bit. */
> @@ -900,28 +944,28 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
>  
>  	switch (vfpid) {
>  	case KVM_REG_ARM_VFP_FPEXC:
> -		return reg_from_user(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
> +		return reg_from_user32(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
>  	case KVM_REG_ARM_VFP_FPSCR:
> -		return reg_from_user(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
> +		return reg_from_user32(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
>  	case KVM_REG_ARM_VFP_FPINST:
> -		return reg_from_user(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
> +		return reg_from_user32(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
>  	case KVM_REG_ARM_VFP_FPINST2:
> -		return reg_from_user(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
> +		return reg_from_user32(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
>  	/* These are invariant. */
>  	case KVM_REG_ARM_VFP_MVFR0:
> -		if (reg_from_user(&val, uaddr, id))
> +		if (reg_from_user32(&val, uaddr, id))
>  			return -EFAULT;
>  		if (val != fmrx(MVFR0))
>  			return -EINVAL;
>  		return 0;
>  	case KVM_REG_ARM_VFP_MVFR1:
> -		if (reg_from_user(&val, uaddr, id))
> +		if (reg_from_user32(&val, uaddr, id))
>  			return -EFAULT;
>  		if (val != fmrx(MVFR1))
>  			return -EINVAL;
>  		return 0;
>  	case KVM_REG_ARM_VFP_FPSID:
> -		if (reg_from_user(&val, uaddr, id))
> +		if (reg_from_user32(&val, uaddr, id))
>  			return -EFAULT;
>  		if (val != fmrx(FPSID))
>  			return -EINVAL;
> @@ -968,7 +1012,7 @@ int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  		return get_invariant_cp15(reg->id, uaddr);
>  
>  	/* Note: copies two regs if size is 64 bit. */
> -	return reg_to_user(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
> +	return reg_to_user32(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
>  }
>  
>  int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> @@ -987,7 +1031,7 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>  		return set_invariant_cp15(reg->id, uaddr);
>  
>  	/* Note: copies two regs if size is 64 bit */
> -	return reg_from_user(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
> +	return reg_from_user32(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
>  }
>  
>  static unsigned int num_demux_regs(void)
> -- 
> 1.8.1.4
> 

Thanks,
-- 
Christoffer
