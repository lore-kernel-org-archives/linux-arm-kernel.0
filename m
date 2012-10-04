From: avi@redhat.com (Avi Kivity)
Date: Thu, 04 Oct 2012 15:44:50 +0200
Subject: [kvmarm] [PATCH 06/15] KVM: ARM: Initial skeleton to compile
 KVM support
In-Reply-To: <20120925152055.GC28728@mudshark.cambridge.arm.com>
References: <20120915153359.21241.86002.stgit@ubuntu>
 <20120915153508.21241.47712.stgit@ubuntu>
 <20120925152055.GC28728@mudshark.cambridge.arm.com>
Message-ID: <506D92D2.5020805@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2012 05:20 PM, Will Deacon wrote:
>> +       case KVM_GET_REG_LIST: {
>> +               struct kvm_reg_list __user *user_list = argp;
>> +               struct kvm_reg_list reg_list;
>> +               unsigned n;
>> +
>> +               if (copy_from_user(&reg_list, user_list, sizeof reg_list))
>> +                       return -EFAULT;
>> +               n = reg_list.n;
>> +               reg_list.n = kvm_arm_num_regs(vcpu);
>> +               if (copy_to_user(user_list, &reg_list, sizeof reg_list))
>> +                       return -EFAULT;
>> +               if (n < reg_list.n)
>> +                       return -E2BIG;
>> +               return kvm_arm_copy_reg_indices(vcpu, user_list->reg);
> 
> kvm_reg_list sounds like it could be done using a regset instead.

Wouldn't those regsets be userspace oriented?

For example, the GPRs returned here include all the shadowed interrupt
registers (or however they're called) while most user oriented APIs
would only include the user visible registers.

FWIW, we're trying to move to an architecture independent ABI for KVM
registers, but that's a lot of work since we need to make sure all the
weird x86 registers (and non-register state) fit into that.  Maybe that
ABI will be regset based, but I don't want to block the ARM port on this.

-- 
error compiling committee.c: too many arguments to function
