From: james.morse@arm.com (James Morse)
Date: Mon, 25 Apr 2016 10:19:11 +0100
Subject: [PATCH v7 15/16] arm64: kernel: Add support for
 hibernate/suspend-to-disk
In-Reply-To: <20160422102954.GB2998@e104818-lin.cambridge.arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1459529620-22150-16-git-send-email-james.morse@arm.com>
 <20160422102954.GB2998@e104818-lin.cambridge.arm.com>
Message-ID: <571DE10F.10905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

Thanks for your comments,

On 22/04/16 11:29, Catalin Marinas wrote:
> On Fri, Apr 01, 2016 at 05:53:39PM +0100, James Morse wrote:
>> --- /dev/null
>> +++ b/arch/arm64/kernel/hibernate-asm.S

>> +	copy_page	x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
>> +
>> +	add	x1, x10, #PAGE_SIZE
>> +	/* Clean the copied page to PoU - based on flush_icache_range() */
>> +	dcache_line_size x2, x3
>> +	sub	x3, x2, #1
>> +	bic	x4, x10, x3
>> +2:	dc	cvau, x4	/* clean D line / unified line */
>> +	add	x4, x4, x2
>> +	cmp	x4, x1
>> +	b.lo	2b
>> +
>> +	ldr	x19, [x19, #HIBERN_PBE_NEXT]
>> +	cbnz	x19, 1b
>> +
>> +
>> +	/* switch to the restored kernels page tables, to reconfigure el2 */
>> +	msr	ttbr1_el1, x21  /* physical address of swapper page tables */
>> +	isb
>> +	tlbi	vmalle1is	/* invalidate intermediate caching entries */
>> +	ic	ialluis
>> +	dsb	ish		/* also waits for PoU cleaning to finish */
>> +	isb
> 
> The waiting for PoU cleaning needs to happen before the IC instruction.

Done, to check I understand why:
The 'ic ialluis' may finish before the PoU cleaning, sharing a barrier means in
this case we may speculatively load stale values back into the icache while we
wait for the cleaning to finish.

[ ... ]

>> +
>> +	/* Load our new page tables */
>> +	asm volatile("msr	ttbr0_el1, %0;"
>> +		     "isb;"
>> +		     "tlbi	vmalle1is;"
>> +		     "dsb	ish" : : "r"(virt_to_phys(pgd)));
> 
> Do we expect anything to have used ttbr0_el1 at this point?

EFI for the virt_efi_get_time() call when we setup the rtc. There may also be
device drivers out there that try to load firmware before the
late_initcall_sync() call that triggers resume.

[ ... ]

>> +int swsusp_arch_suspend(void)
>> +{
>> +	int ret = 0;
>> +	unsigned long flags;
>> +	struct sleep_stack_data state;
>> +
>> +	local_dbg_save(flags);
>> +
>> +	if (__cpu_suspend_enter(&state)) {
>> +		ret = swsusp_save();
>> +	} else {
>> +		void *lm_kernel_start;
>> +
>> +		/* Clean kernel to PoC for secondary core startup */
>> +		lm_kernel_start = LMADDR(KERNEL_START);
>> +		__flush_dcache_area(lm_kernel_start, KERNEL_END - KERNEL_START);
> 
> We don't need to use LMADDR here. The KERNEL_START is already mapped at
> the caches are PIPT (-like), so flushing any of the aliases would do.

With kaslr the range KERNEL_START -> KERNEL_END has holes in it. I think this is
where the __init text or alternatives used to be. Cleaning the corresponding
range in the linear map avoids the fault...


> But I'm not sure we even need to flush the whole kernel. The secondary
> cores would only execute certain areas before they enable the MMU, at
> which point they have visibility over the whole cache. Is this needed
> for secondary core startup on resume from hibernate?

I haven't hit this as an issue, but I think its needed for any mmu-off code.
The list is:
*  secondary startup after resume
*  hyp-stub and kvm's el2-init code,
*  and cpu_resume() (if a core goes into idle soon after resume).

I agree cleaning the whole kernel is excessive. I guess the right thing to do is
to collect all these functions into a single section and clean that.

[ ... ]

Thanks for the detailed comments!


James
