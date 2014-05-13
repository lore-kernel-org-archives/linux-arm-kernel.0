From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 13:11:34 -0700
Subject: [PATCH v2 5/7] ARM: KVM: one_reg coproc set and get BE fixes
In-Reply-To: <20140320011139.GK1297@cbox>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-6-git-send-email-victor.kamensky@linaro.org>
 <20140320011139.GK1297@cbox>
Message-ID: <CAA3XUr0ELPxFsoQ+FyWXkoMEbOi=2VHGyhx_KU0bUz1ukAKx8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

In just posted update on ARM BE KVM series. I posted
new version of this patch [1] where I could not address
all below comments. Please see my responses inline

On 19 March 2014 18:11, Christoffer Dall <christoffer.dall@linaro.org> wrote:
> On Tue, Feb 11, 2014 at 09:41:31PM -0800, Victor Kamensky wrote:
>> Fix code that handles KVM_SET_ONE_REG, KVM_GET_ONE_REG ioctls to work in BE
>> image. Before this fix get/set_one_reg functions worked correctly only in
>> LE case - reg_from_user was taking 'void *' kernel address that actually could
>> be target/source memory of either 4 bytes size or 8 bytes size, and code copied
>> from/to user memory that could hold either 4 bytes register, 8 byte register
>> or pair of 4 bytes registers.
>>
>> For example note that there was a case when 4 bytes register was read from
>> user-land to kernel target address of 8 bytes value. Because it was working
>> in LE, least significant word was memcpy(ied) and it just worked. In BE code
>> with 'void *' as target/source 'val' type it is impossible to tell whether
>> 4 bytes register from user-land should be copied to 'val' address itself
>> (4 bytes target) or it should be copied to 'val' + 4 (least significant word
>> of 8 bytes value). So first change was to introduce strongly typed
>> functions, where type of target/source 'val' is strongly defined:
>>
>> reg_from_user64 - reads register from user-land to kernel 'u64 *val'
>>                   address; register size could be 4 or 8 bytes
>> reg_from_user32 - reads register(s) from user-land to kernel 'u32 *val'
>>                   address; note it could be one or two 4 bytes registers
>> reg_to_user64 -   writes reigster from kernel 'u64 *val' address to
>
> s/reigster/register/

Done

>>                   user-land register memory; register size could be
>>                   4 or 8 bytes
>> ret_to_user32 -   writes register(s) from kernel 'u32 *val' address to
>>                   user-land register(s) memory; note it could be
>>                   one or two 4 bytes registers
>
> If we are really going to keep this scheme, then please add these
> comments to functions themselves.

Done

>>
>> All places where reg_from_user, reg_to_user functions were used, were changed
>> to use either corresponding 64 or 32 bit variant of functions depending on
>> type of source/target kernel memory variable.
>>
>> In case of 'u64 *val' and register size equals 4 bytes, reg_from_user64
>> and reg_to_user64 work only with least siginificant word of target/source
>> kernel value.
>>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> ---
>>  arch/arm/kvm/coproc.c | 94 +++++++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 69 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
>> index 78c0885..64b2b94 100644
>> --- a/arch/arm/kvm/coproc.c
>> +++ b/arch/arm/kvm/coproc.c
>> @@ -634,17 +634,61 @@ static struct coproc_reg invariant_cp15[] = {
>>       { CRn( 0), CRm( 0), Op1( 1), Op2( 7), is32, NULL, get_AIDR },
>>  };
>>
>> -static int reg_from_user(void *val, const void __user *uaddr, u64 id)
>> +static int reg_from_user64(u64 *val, const void __user *uaddr, u64 id)
>> +{
>> +     unsigned long regsize = KVM_REG_SIZE(id);
>> +     union {
>> +             u32     word;
>> +             u64     dword;
>> +     } tmp = {0};
>> +
>> +     if (copy_from_user(&tmp, uaddr, regsize) != 0)
>> +             return -EFAULT;
>> +
>> +     switch (regsize) {
>> +     case 4:
>> +             *val = tmp.word;
>> +             break;
>> +     case 8:
>> +             *val = tmp.dword;
>> +             break;
>> +     }
>> +     return 0;
>> +}
>
> instead of allowing this 'packing 32 bit values in 64 bit values and
> packing two 32 bit values in 64 bit values' kernel implementation'y
> stuff to be passed to these user-space ABI catering function, I really
> think you want to make reg_from_user64 deal with 64-bit registers, that
> is, BUG_ON(KVM_REG_SIZE(id) != 8.

Example of kernel storing value in u64 but register is 32bit is
set/get_invariant_cp15. Note this function passes struct coproc_reg
val field address into reg_to_user_xxx function. Since struct coproc_reg
is generic structure used to describe both 32bit and 64bit coproc registers
val type cannot be changed to u32. One may try to describe
val as union of u32 and u64 but I have concern that it would
create bunch of 'if (KVM_REG_SIZE(id) == 4) { ... } else {  ..}'
pieces all over the place. I think it is better to have function that
just can read/write 32bit register from/to u64 value in kernel.

> If the kernel stores what user space sees as a 32-bit register in a
> 64-bit register, then let the caller deal with this mess.
>
> If the kernel stores what user space sees as a 64-bit register in two
> 32-bit registers, then let the caller deal with that mess.

Example of above is TTBR0 register. It is accessed by user land as 64bit
register but in kernel it is stored as two u32 register TTBR0_low and
TTBR0_high. Note code that stores and restores those does not treat as
one 64bit register instead it is a pair

> Imagine someone who hasn't been through the development of this code
> seeing these two functions for the first time without having read your
> commit message, I think the margin for error here is too large.

I understand concern. I added comments around reg_to/from_user_xx functions
and I think I picked better name for functions. Hopefully it is enough if
this approach is followed.

Also I could be missing better way to address your comments,
if if you have ideas how it should be implemented please let me know.

> If you can share these functions like Alex suggests, then that would
> make for a much cleaner function API as well.

I'll looked at approach that Alex suggested, I will describe issues with it
in separate email.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/255856.html

>> +
>> +/* Note it may really copy two u32 registers */
>> +static int reg_from_user32(u32 *val, const void __user *uaddr, u64 id)
>>  {
>> -     /* This Just Works because we are little endian. */
>>       if (copy_from_user(val, uaddr, KVM_REG_SIZE(id)) != 0)
>>               return -EFAULT;
>>       return 0;
>>  }
>>
>> -static int reg_to_user(void __user *uaddr, const void *val, u64 id)
>> +static int reg_to_user64(void __user *uaddr, const u64 *val, u64 id)
>> +{
>> +     unsigned long regsize = KVM_REG_SIZE(id);
>> +     union {
>> +             u32     word;
>> +             u64     dword;
>> +     } tmp;
>> +
>> +     switch (regsize) {
>> +     case 4:
>> +             tmp.word = *val;
>> +             break;
>> +     case 8:
>> +             tmp.dword = *val;
>> +             break;
>> +     }
>> +
>> +     if (copy_to_user(uaddr, &tmp, regsize) != 0)
>> +             return -EFAULT;
>> +     return 0;
>> +}
>> +
>> +/* Note it may really copy two u32 registers */
>> +static int reg_to_user32(void __user *uaddr, const u32 *val, u64 id)
>>  {
>> -     /* This Just Works because we are little endian. */
>>       if (copy_to_user(uaddr, val, KVM_REG_SIZE(id)) != 0)
>>               return -EFAULT;
>>       return 0;
>> @@ -662,7 +706,7 @@ static int get_invariant_cp15(u64 id, void __user *uaddr)
>>       if (!r)
>>               return -ENOENT;
>>
>> -     return reg_to_user(uaddr, &r->val, id);
>> +     return reg_to_user64(uaddr, &r->val, id);
>>  }
>>
>>  static int set_invariant_cp15(u64 id, void __user *uaddr)
>> @@ -678,7 +722,7 @@ static int set_invariant_cp15(u64 id, void __user *uaddr)
>>       if (!r)
>>               return -ENOENT;
>>
>> -     err = reg_from_user(&val, uaddr, id);
>> +     err = reg_from_user64(&val, uaddr, id);
>>       if (err)
>>               return err;
>>
>> @@ -846,7 +890,7 @@ static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
>>       if (vfpid < num_fp_regs()) {
>>               if (KVM_REG_SIZE(id) != 8)
>>                       return -ENOENT;
>> -             return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
>> +             return reg_to_user64(uaddr, &vcpu->arch.vfp_guest.fpregs[vfpid],
>>                                  id);
>>       }
>>
>> @@ -856,22 +900,22 @@ static int vfp_get_reg(const struct kvm_vcpu *vcpu, u64 id, void __user *uaddr)
>>
>>       switch (vfpid) {
>>       case KVM_REG_ARM_VFP_FPEXC:
>> -             return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
>> +             return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpexc, id);
>>       case KVM_REG_ARM_VFP_FPSCR:
>> -             return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
>> +             return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpscr, id);
>>       case KVM_REG_ARM_VFP_FPINST:
>> -             return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
>> +             return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpinst, id);
>>       case KVM_REG_ARM_VFP_FPINST2:
>> -             return reg_to_user(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
>> +             return reg_to_user32(uaddr, &vcpu->arch.vfp_guest.fpinst2, id);
>>       case KVM_REG_ARM_VFP_MVFR0:
>>               val = fmrx(MVFR0);
>> -             return reg_to_user(uaddr, &val, id);
>> +             return reg_to_user32(uaddr, &val, id);
>>       case KVM_REG_ARM_VFP_MVFR1:
>>               val = fmrx(MVFR1);
>> -             return reg_to_user(uaddr, &val, id);
>> +             return reg_to_user32(uaddr, &val, id);
>>       case KVM_REG_ARM_VFP_FPSID:
>>               val = fmrx(FPSID);
>> -             return reg_to_user(uaddr, &val, id);
>> +             return reg_to_user32(uaddr, &val, id);
>>       default:
>>               return -ENOENT;
>>       }
>> @@ -890,8 +934,8 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
>>       if (vfpid < num_fp_regs()) {
>>               if (KVM_REG_SIZE(id) != 8)
>>                       return -ENOENT;
>> -             return reg_from_user(&vcpu->arch.vfp_guest.fpregs[vfpid],
>> -                                  uaddr, id);
>> +             return reg_from_user64(&vcpu->arch.vfp_guest.fpregs[vfpid],
>> +                                    uaddr, id);
>>       }
>>
>>       /* FP control registers are all 32 bit. */
>> @@ -900,28 +944,28 @@ static int vfp_set_reg(struct kvm_vcpu *vcpu, u64 id, const void __user *uaddr)
>>
>>       switch (vfpid) {
>>       case KVM_REG_ARM_VFP_FPEXC:
>> -             return reg_from_user(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
>> +             return reg_from_user32(&vcpu->arch.vfp_guest.fpexc, uaddr, id);
>>       case KVM_REG_ARM_VFP_FPSCR:
>> -             return reg_from_user(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
>> +             return reg_from_user32(&vcpu->arch.vfp_guest.fpscr, uaddr, id);
>>       case KVM_REG_ARM_VFP_FPINST:
>> -             return reg_from_user(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
>> +             return reg_from_user32(&vcpu->arch.vfp_guest.fpinst, uaddr, id);
>>       case KVM_REG_ARM_VFP_FPINST2:
>> -             return reg_from_user(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
>> +             return reg_from_user32(&vcpu->arch.vfp_guest.fpinst2, uaddr, id);
>>       /* These are invariant. */
>>       case KVM_REG_ARM_VFP_MVFR0:
>> -             if (reg_from_user(&val, uaddr, id))
>> +             if (reg_from_user32(&val, uaddr, id))
>>                       return -EFAULT;
>>               if (val != fmrx(MVFR0))
>>                       return -EINVAL;
>>               return 0;
>>       case KVM_REG_ARM_VFP_MVFR1:
>> -             if (reg_from_user(&val, uaddr, id))
>> +             if (reg_from_user32(&val, uaddr, id))
>>                       return -EFAULT;
>>               if (val != fmrx(MVFR1))
>>                       return -EINVAL;
>>               return 0;
>>       case KVM_REG_ARM_VFP_FPSID:
>> -             if (reg_from_user(&val, uaddr, id))
>> +             if (reg_from_user32(&val, uaddr, id))
>>                       return -EFAULT;
>>               if (val != fmrx(FPSID))
>>                       return -EINVAL;
>> @@ -968,7 +1012,7 @@ int kvm_arm_coproc_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>               return get_invariant_cp15(reg->id, uaddr);
>>
>>       /* Note: copies two regs if size is 64 bit. */
>> -     return reg_to_user(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
>> +     return reg_to_user32(uaddr, &vcpu->arch.cp15[r->reg], reg->id);
>>  }
>>
>>  int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>> @@ -987,7 +1031,7 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
>>               return set_invariant_cp15(reg->id, uaddr);
>>
>>       /* Note: copies two regs if size is 64 bit */
>> -     return reg_from_user(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
>> +     return reg_from_user32(&vcpu->arch.cp15[r->reg], uaddr, reg->id);
>>  }
>>
>>  static unsigned int num_demux_regs(void)
>> --
>> 1.8.1.4
>>
>
> Thanks,
> --
> Christoffer
