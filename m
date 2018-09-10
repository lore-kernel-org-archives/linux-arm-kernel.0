From: julien.thierry@arm.com (Julien Thierry)
Date: Mon, 10 Sep 2018 09:00:57 +0100
Subject: [PATCH v2 1/9] ARM: signal: copy registers using __copy_to_user()
In-Reply-To: <20180906165015.GQ30658@n2100.armlinux.org.uk>
References: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
 <1536251888-8302-2-git-send-email-julien.thierry@arm.com>
 <20180906165015.GQ30658@n2100.armlinux.org.uk>
Message-ID: <fa57d18f-2dd8-2aad-f921-8131886da843@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 06/09/18 17:50, Russell King - ARM Linux wrote:
> On Thu, Sep 06, 2018 at 05:38:00PM +0100, Julien Thierry wrote:
>> When saving the ARM integer registers, use __copy_to_user() to
>> copy them into user signal frame, rather than __put_user_error().
>> This has the benefit of disabling/enabling PAN once for the whole copy
>> intead of once per write.
> 
> Looks fine, but please note:
> 
>> +	struct sigcontext context;
>>   	int err = 0;
>>   
>> +	context = (struct sigcontext) {
>> +		.arm_r0        = regs->ARM_r0,
>> +		.arm_r1        = regs->ARM_r1,
>> +		.arm_r2        = regs->ARM_r2,
>> +		.arm_r3        = regs->ARM_r3,
>> +		.arm_r4        = regs->ARM_r4,
>> +		.arm_r5        = regs->ARM_r5,
>> +		.arm_r6        = regs->ARM_r6,
>> +		.arm_r7        = regs->ARM_r7,
>> +		.arm_r8        = regs->ARM_r8,
>> +		.arm_r9        = regs->ARM_r9,
>> +		.arm_r10       = regs->ARM_r10,
>> +		.arm_fp        = regs->ARM_fp,
>> +		.arm_ip        = regs->ARM_ip,
>> +		.arm_sp        = regs->ARM_sp,
>> +		.arm_lr        = regs->ARM_lr,
>> +		.arm_pc        = regs->ARM_pc,
>> +		.arm_cpsr      = regs->ARM_cpsr,
>> +
>> +		.trap_no       = current->thread.trap_no,
>> +		.error_code    = current->thread.error_code,
>> +		.fault_address = current->thread.address,
>> +		.oldmask       = set->sig[0],
>> +	};
>> +
>> +	err |= __copy_to_user(&sf->uc.uc_mcontext, &context, sizeof(context));
> 
> This construct is safe here, because struct sigcontext will have
> no padding.
> 
> However, in the case of a struct that does contain padding, doing
> the above will leave the padding uninitialised, and therefore the
> __copy_to_user() will end up leaking information from the kernel
> stack into userspace - which is bad news.
> 

Thanks for pointing this out. I wrongly assumed this would be 
initialized the same way unspecified fields get initialized to 0. But 
you're right, there is no guaranty about the padding getting initialized.

I'll fix the patches affected.

About the ones where there is currently no padding, are 
preserve_iwmmxt_context and setup_sigframe called in performance 
critical paths? (I don't think that is the case but I prefer to be sure)
If not I would prefer adding the memset to those as well just in case 
the corresponding structs get a new field introducing padding. Unless 
you really feel this would be unnecessary.

Thanks,

> So, such constructs are best avoided in generic code (where it's
> less known whether padding is present), and only in arch code after
> careful review.
> 

-- 
Julien Thierry
