From: leoy@marvell.com (Leo Yan)
Date: Tue, 24 Dec 2013 14:18:56 +0800
Subject: [PATCH RFC v3 04/12] arm64: kernel: cpu_{suspend/resume}
 implementation
In-Reply-To: <20131223140415.GB2967@e102568-lin.cambridge.arm.com>
References: <1385033059-25896-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1385033059-25896-5-git-send-email-lorenzo.pieralisi@arm.com>
 <52B42A48.5090202@marvell.com>
 <20131223140415.GB2967@e102568-lin.cambridge.arm.com>
Message-ID: <52B92750.80405@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/23/2013 10:04 PM, Lorenzo Pieralisi wrote:
> On Fri, Dec 20, 2013 at 11:30:16AM +0000, Leo Yan wrote:
>> On 11/21/2013 07:24 PM, Lorenzo Pieralisi wrote:
>>
>>> +/*
>>> + * x0 must contain the sctlr value retrieved from restored context
>>> + */
>>> +ENTRY(cpu_resume_mmu)
>>> +	ldr	x3, =cpu_resume_after_mmu
>>> +	msr	sctlr_el1, x0		// restore sctlr_el1
>>> +	isb
>>> +	br	x3			// global jump to virtual address
>>> +ENDPROC(cpu_resume_mmu)
>>> +cpu_resume_after_mmu:
>>> +	mov	x0, #0			// return zero on success
>>> +	ldp	x19, x20, [sp, #16]
>>> +	ldp	x21, x22, [sp, #32]
>>> +	ldp	x23, x24, [sp, #48]
>>> +	ldp	x25, x26, [sp, #64]
>>> +	ldp	x27, x28, [sp, #80]
>>> +	ldp	x29, lr, [sp], #96
>>> +	ret
>>> +ENDPROC(cpu_resume_after_mmu)
>>> +
>>> +	.data
>>> +ENTRY(cpu_resume)
>>> +	bl	el2_setup		// if in EL2 drop to EL1 cleanly
>>
>> Compare to v2's patch set, here remove the calculation fro the offset
>> b/t PHYS_OFFSET - PAGE_OFFSET; so when i verify the patch set, i saw x28
>> is zero and finally introduce the EL2's sync exception. Below are pasted
>> v2's code for reference.
>
> What kernel are you testing against ? The offset is not needed anymore
> in el2_setup, that is why the x28 computation is not there.
>
>> do u want use firmware to set the x28 for the offset value? :-) IMHO,
>> v2's implementation is more reasonable and it's better keep the code.
>
> The point is not whether to set it in firmware or in the kernel, see above.
>
> Lorenzo
>

Catalin and Lorenzo, Thanks a lot for u point out.

Now i'm back porting patches to 3.10, but the cpu_suspend/resume patches 
are dependent on BE related patches on the latest mainline code base. 
After apply below missing patches, now the cpu_suspend/resume can work 
well. :-)

arm64: asm: add CPU_LE & CPU_BE assembler helpers
arm64: head: create a new function for setting the boot_cpu_mode flag
arm64: big-endian: set correct endianess on kernel entry
arm64: kernel: add code to set cpu boot mode to secondary_entry shim

>>
>> ENTRY(cpu_resume)
>>             adr     x4, sleep_save_sp
>>             ldr     x5, =sleep_save_sp
>>             sub     x28, x4, x5             // x28 = PHYS_OFFSET -
>> PAGE_OFFSET
>>             /*
>>              * make sure el2 is sane, el2_setup expects:
>>              * x28 = PHYS_OFFSET - PAGE_OFFSET
>>              */
>>             bl      el2_setup               // if in EL2 drop to EL1 cleanly
>>
>>
>>> +#ifdef CONFIG_SMP
>>> +	mrs	x1, mpidr_el1
>>> +	adr	x4, mpidr_hash_ptr
>>> +	ldr	x5, [x4]
>>> +	add	x8, x4, x5		// x8 = struct mpidr_hash phys address
>>> +        /* retrieve mpidr_hash members to compute the hash */
>>> +	ldr	x2, [x8, #MPIDR_HASH_MASK]
>>> +	ldp	w3, w4, [x8, #MPIDR_HASH_SHIFTS]
>>> +	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
>>> +	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
>>> +        /* x7 contains hash index, let's use it to grab context pointer */
>>> +#else
>>> +	mov	x7, xzr
>>> +#endif
>>> +	adr	x0, sleep_save_sp
>>> +	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
>>> +	ldr	x0, [x0, x7, lsl #3]
>>> +	/* load sp from context */
>>> +	ldr	x2, [x0, #CPU_CTX_SP]
>>> +	adr	x1, sleep_idmap_phys
>>> +	/* load physical address of identity map page table in x1 */
>>> +	ldr	x1, [x1]
>>> +	mov	sp, x2
>>> +	/*
>>> +	 * cpu_do_resume expects x0 to contain context physical address
>>> +	 * pointer and x1 to contain physical address of 1:1 page tables
>>> +	 */
>>> +	bl	cpu_do_resume		// PC relative jump, MMU off
>>> +	b	cpu_resume_mmu		// Resume MMU, never returns
>>> +ENDPROC(cpu_resume)
>>> +
>>
>
