From: joel.schopp@amd.com (Joel Schopp)
Date: Mon, 11 Aug 2014 10:20:41 -0500
Subject: [PATCH v3] arm64: fix VTTBR_BADDR_MASK
In-Reply-To: <20140808204612.GC14205@cbox>
References: <20140804143845.2851.85441.stgit@joelaarch64.amd.com>
 <20140808204612.GC14205@cbox>
Message-ID: <53E8DF49.4080002@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for the detailed review.
> the last case would be case 5 and the default case would be a BUG().
I agree with the case, but rather than do a BUG() I'm going to print an
error and return -EINVAL.  Not worth stopping the host kernel just
because kvm is messed up when we can gracefully exit from it.
>
>> +
>> +	/*
>> +	 * See Table D4-23 and Table D4-25 in ARM DDI 0487A.b to figure out
>> +	 * the origin of the hardcoded values, 38 and 37.
>> +	 */
>> +#ifdef CONFIG_ARM64_64K_PAGES
>> +	/*
>> +	 * 16 <= T0SZ <= 21 is valid under 3 level of translation tables
>> +	 * 18 <= T0SZ <= 34 is valid under 2 level of translation tables
>> +	 * 31 <= T0SZ <= 39 is valid under 1 level of transltaion tables
>> +	 */
> so this scheme is with concatenated initial level stage-2 page tables.
>
> But we only ever allocate the amount of pages for our pgd according to
> what the host has, so I think this allocation needs to be locked down
> more tight, because the host is always using the appropriate amount for
> 39 bits virtual addresses.
I'll narrow the sanity check of the range.  I'll narrow it based on a 39
- 48 bit VA host range in anticipation of the 4 level 4k and 3 level 64k
host patches going in.

>> +		kvm_err("Cannot support %d-bit address space\n", 64 - t0sz);
>> +		return -EINVAL;
>> +	}
>> +	vttbr_x = 37 - t0sz;
>> +#endif
>> +	vttbr_baddr_mask = (((1LLU << (48 - vttbr_x)) - 1) << (vttbr_x - 1));
>> +#endif
> This nested ifdef is really quite horrible.  Can you either factor these
> out into some static inlines in arch/arm[64]/include/asm/kvm_mmu.h or
> provide a per-architecture implementation in a .c file?
I'll factor it out in the file to make it more readable and do away with
the nested ifdef.  My theory on putting things into .h files is to only
do it if there is actually another file that uses it.
>
>> +	return 0;
>> +}
>> +
>> +/**
>>   * update_vttbr - Update the VTTBR with a valid VMID before the guest runs
>>   * @kvm	The guest that we are about to run
>>   *
>> @@ -429,8 +502,16 @@ static void update_vttbr(struct kvm *kvm)
>>  	/* update vttbr to be used with the new vmid */
>>  	pgd_phys = virt_to_phys(kvm->arch.pgd);
>>  	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
>> -	kvm->arch.vttbr = pgd_phys & VTTBR_BADDR_MASK;
>> -	kvm->arch.vttbr |= vmid;
>> +
>> +	/*
>> +	 * If the VTTBR isn't aligned there is something wrong with the system
>> +	 * or kernel.  It is better to just fail and not mask it. But no need
>> +	 * to panic the host kernel with a BUG_ON(), instead just log the error.
>> +	 */
> These last two sentences are not very helpful, because they don't
> describe the rationale for what you're doing, only what you are (and are
> not) doing.
I'll reword the comment.
>
> That said, I don't think this is doing the right thing.  I think you
> want to refuse running the VM and avoid any stage-2 entried being
> created if this is not the case (actually, we may want to check this
> after set_vttbr_baddr_mask() or right aftert allocating the stage-2
> pgd), because otherwise I think we may be overwriting memory not
> belonging to us with concatenated page tables in a 42-bit 4KB system,
> for example.
My experience here was that the hardware actually catches the error on
the first instruction load of the guest kernel and does a stage 2
translation abort.  However, to be extra safe we could just log the
error with the address of the vttbr and then zero out the pgd_phys part
of vttbr altogether, leaving only the vmid.  The guest would then die of
natural causes and we wouldn't have to worry about the outside
possibility of memory getting overwritten.

I don't like the option of just calling BUG() because stopping the host
kernel from running just because we can't run a guest seems a bit
extreme.  On the other hand adding a return code to update_vttbr and
checking it (even with unlikely) in the kvm_arch_vcpu_ioctl_run() loop
doesn't thrill me either just from a wasted cpu cycles point of view. 
>
>> +	if (pgd_phys & ~vttbr_baddr_mask)
>> +		kvm_err("VTTBR not aligned, expect guest to fail");
>> +
>> +	kvm->arch.vttbr = pgd_phys | vmid;
>>  
>>  	spin_unlock(&kvm_vmid_lock);
>>  }
>> @@ -1015,6 +1096,12 @@ int kvm_arch_init(void *opaque)
>>  		}
>>  	}
>>  
>> +	err = set_vttbr_baddr_mask();
>> +	if (err) {
>> +		kvm_err("Cannot set vttbr_baddr_mask\n");
>> +		return -EINVAL;
>> +	}
>> +
>>  	cpu_notifier_register_begin();
>>  
>>  	err = init_hyp_mode();
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index cc83520..ff4a4fa 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -95,7 +95,6 @@
>>  /* TCR_EL2 Registers bits */
>>  #define TCR_EL2_TBI	(1 << 20)
>>  #define TCR_EL2_PS	(7 << 16)
>> -#define TCR_EL2_PS_40B	(2 << 16)
>>  #define TCR_EL2_TG0	(1 << 14)
>>  #define TCR_EL2_SH0	(3 << 12)
>>  #define TCR_EL2_ORGN0	(3 << 10)
>> @@ -104,8 +103,6 @@
>>  #define TCR_EL2_MASK	(TCR_EL2_TG0 | TCR_EL2_SH0 | \
>>  			 TCR_EL2_ORGN0 | TCR_EL2_IRGN0 | TCR_EL2_T0SZ)
>>  
>> -#define TCR_EL2_FLAGS	(TCR_EL2_PS_40B)
>> -
>>  /* VTCR_EL2 Registers bits */
>>  #define VTCR_EL2_PS_MASK	(7 << 16)
>>  #define VTCR_EL2_TG0_MASK	(1 << 14)
>> @@ -120,36 +117,28 @@
>>  #define VTCR_EL2_SL0_MASK	(3 << 6)
>>  #define VTCR_EL2_SL0_LVL1	(1 << 6)
>>  #define VTCR_EL2_T0SZ_MASK	0x3f
>> -#define VTCR_EL2_T0SZ_40B	24
>> +#define VTCR_EL2_T0SZ(bits)	(64 - (bits))
>>  
>>  #ifdef CONFIG_ARM64_64K_PAGES
>>  /*
>>   * Stage2 translation configuration:
>> - * 40bits output (PS = 2)
>> - * 40bits input  (T0SZ = 24)
>>   * 64kB pages (TG0 = 1)
>>   * 2 level page tables (SL = 1)
>>   */
>>  #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
>>  				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
>> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
>> -#define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
>> +				 VTCR_EL2_SL0_LVL1)
>>  #else
>>  /*
>>   * Stage2 translation configuration:
>> - * 40bits output (PS = 2)
>> - * 40bits input  (T0SZ = 24)
>>   * 4kB pages (TG0 = 0)
>>   * 3 level page tables (SL = 1)
>>   */
>>  #define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
>>  				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
>> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B)
>> -#define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
>> +				 VTCR_EL2_SL0_LVL1)
>>  #endif
>>  
>> -#define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
>> -#define VTTBR_BADDR_MASK  (((1LLU << (40 - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
>>  #define VTTBR_VMID_SHIFT  (48LLU)
>>  #define VTTBR_VMID_MASK	  (0xffLLU << VTTBR_VMID_SHIFT)
>>  
>> diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
>> index d968796..c0f7634 100644
>> --- a/arch/arm64/kvm/hyp-init.S
>> +++ b/arch/arm64/kvm/hyp-init.S
>> @@ -63,17 +63,21 @@ __do_hyp_init:
>>  	mrs	x4, tcr_el1
>>  	ldr	x5, =TCR_EL2_MASK
>>  	and	x4, x4, x5
>> -	ldr	x5, =TCR_EL2_FLAGS
>> -	orr	x4, x4, x5
>> -	msr	tcr_el2, x4
>> -
>> -	ldr	x4, =VTCR_EL2_FLAGS
>>  	/*
>>  	 * Read the PARange bits from ID_AA64MMFR0_EL1 and set the PS bits in
>> -	 * VTCR_EL2.
>> +	 * TCR_EL2 and both PS bits and T0SZ bits in VTCR_EL2.
>>  	 */
>>  	mrs	x5, ID_AA64MMFR0_EL1
>>  	bfi	x4, x5, #16, #3
>> +	msr	tcr_el2, x4
>> +
>> +	ldr	x4, =VTCR_EL2_FLAGS
>> +	bfi	x4, x5, #16, #3
>> +	and	x5, x5, #0xf
>> +	adr	x6, t0sz
>> +	add	x6, x6, x5, lsl #2
>> +	ldr	w5, [x6]
>> +	orr	x4, x4, x5
>>  	msr	vtcr_el2, x4
>>  
>>  	mrs	x4, mair_el1
>> @@ -109,6 +113,10 @@ target: /* We're now in the trampoline code, switch page tables */
>>  
>>  	/* Hello, World! */
>>  	eret
>> +
>> +t0sz:
>> +	.word	VTCR_EL2_T0SZ(32), VTCR_EL2_T0SZ(36), VTCR_EL2_T0SZ(40)
>> +	.word	VTCR_EL2_T0SZ(42), VTCR_EL2_T0SZ(44), VTCR_EL2_T0SZ(48)
>>  ENDPROC(__kvm_hyp_init)
>>  
>>  	.ltorg
>>
> Thanks for picking this up!
Thanks for the detailed review.  I'll try to turnaround v4 quickly.
> -Christoffer
