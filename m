From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 07 Jun 2017 18:47:05 +0100
Subject: [PATCH v2 2/3] arm64: hwpoison: add VM_FAULT_HWPOISON[_LARGE]
 handling
In-Reply-To: <20170607135913.GH30263@arm.com> (Will Deacon's message of "Wed,
 7 Jun 2017 14:59:13 +0100")
References: <20170517152336.6052-1-punit.agrawal@arm.com>
 <20170517152336.6052-3-punit.agrawal@arm.com>
 <20170607135913.GH30263@arm.com>
Message-ID: <877f0n1yhy.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:

> On Wed, May 17, 2017 at 04:23:35PM +0100, Punit Agrawal wrote:
>> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>> 
>> Add VM_FAULT_HWPOISON[_LARGE] handling to the arm64 page fault
>> handler. Handling of VM_FAULT_HWPOISON[_LARGE] is very similar
>> to VM_FAULT_OOM, the only difference is that a different si_code
>> (BUS_MCEERR_AR) is passed to user space and si_addr_lsb field is
>> initialized.
>> 
>> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
>> Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
>> (fix new __do_user_fault call-site)
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Acked-by: Steve Capper <steve.capper@arm.com>
>> ---
>>  arch/arm64/mm/fault.c | 22 +++++++++++++++++++---
>>  1 file changed, 19 insertions(+), 3 deletions(-)
>> 
>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 37b95dff0b07..a85b44343ac6 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -31,6 +31,7 @@
>>  #include <linux/highmem.h>
>>  #include <linux/perf_event.h>
>>  #include <linux/preempt.h>
>> +#include <linux/hugetlb.h>
>>  
>>  #include <asm/bug.h>
>>  #include <asm/cpufeature.h>
>> @@ -239,10 +240,11 @@ static void __do_kernel_fault(struct mm_struct *mm, unsigned long addr,
>>   */
>>  static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>>  			    unsigned int esr, unsigned int sig, int code,
>> -			    struct pt_regs *regs)
>> +			    struct pt_regs *regs, int fault)
>>  {
>>  	struct siginfo si;
>>  	const struct fault_info *inf;
>> +	unsigned int lsb = 0;
>>  
>>  	if (unhandled_signal(tsk, sig) && show_unhandled_signals_ratelimited()) {
>>  		inf = esr_to_fault_info(esr);
>> @@ -259,6 +261,17 @@ static void __do_user_fault(struct task_struct *tsk, unsigned long addr,
>>  	si.si_errno = 0;
>>  	si.si_code = code;
>>  	si.si_addr = (void __user *)addr;
>> +	/*
>> +	 * Either small page or large page may be poisoned.
>> +	 * In other words, VM_FAULT_HWPOISON_LARGE and
>> +	 * VM_FAULT_HWPOISON are mutually exclusive.
>> +	 */
>> +	if (fault & VM_FAULT_HWPOISON_LARGE)
>> +		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
>> +	else if (fault & VM_FAULT_HWPOISON)
>> +		lsb = PAGE_SHIFT;
>> +	si.si_addr_lsb = lsb;
>> +
>
> If we're going to start handling poison faults, then we should probably
> rejig the perf page fault accounting around here so that we follow x86:
>
>   * Always report PERF_COUNT_SW_PAGE_FAULTS,
>   * Don't report anything else for VM_FAULT_ERROR
>   * Report PERF_COUNT_SW_PAGE_FAULTS_MAJ if VM_FAULT_MAJOR
>   * Otherwise, report PERF_COUNT_SW_PAGE_FAULTS_MIN
>
> at the moment, I think you're accounting VM_FAULT_ERROR as
> PERF_COUNT_SW_PAGE_FAULTS_MIN, which doesn't feel right at all.

Ok. I'd missed the implication of enabling poisoned pages fault handling
on the perf accounting. I'll add a patch to update the reporting.

>
> Will
