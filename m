From: cov@codeaurora.org (Christopher Covington)
Date: Tue, 31 Jan 2017 12:48:25 -0500
Subject: [PATCH v4 2/4] arm64: Work around Falkor erratum 1003
In-Reply-To: <20170131123735.GD11191@leverpostej>
References: <20170125155232.10277-1-cov@codeaurora.org>
 <20170125155232.10277-2-cov@codeaurora.org>
 <20170131123735.GD11191@leverpostej>
Message-ID: <36478002-4cd8-7f1c-1a25-8bfe35022a47@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/31/2017 07:37 AM, Mark Rutland wrote:
> On Wed, Jan 25, 2017 at 10:52:30AM -0500, Christopher Covington wrote:
>> The Qualcomm Datacenter Technologies Falkor v1 CPU may allocate TLB entries
>> using an incorrect ASID when TTBRx_EL1 is being updated. When the erratum
>> is triggered, page table entries using the new translation table base
>> address (BADDR) will be allocated into the TLB using the old ASID. All
>> circumstances leading to the incorrect ASID being cached in the TLB arise
>> when software writes TTBRx_EL1[ASID] and TTBRx_EL1[BADDR], a memory
>> operation is in the process of performing a translation using the specific
>> TTBRx_EL1 being written, and the memory operation uses a translation table
>> descriptor designated as non-global. EL2 and EL3 code changing the EL1&0
>> ASID is not subject to this erratum because hardware is prohibited from
>> performing translations from an out-of-context translation regime.
>>
>> Consider the following pseudo code.
>>
>>   write new BADDR and ASID values to TTBRx_EL1
>>
>> Replacing the above sequence with the one below will ensure that no TLB
>> entries with an incorrect ASID are used by software.
>>
>>   write reserved value to TTBRx_EL1[ASID]
>>   ISB
>>   write new value to TTBRx_EL1[BADDR]
>>   ISB
>>   write new value to TTBRx_EL1[ASID]
>>   ISB
>>
>> When the above sequence is used, page table entries using the new BADDR
>> value may still be incorrectly allocated into the TLB using the reserved
>> ASID. Yet this will not reduce functionality, since TLB entries incorrectly
>> tagged with the reserved ASID will never be hit by a later instruction.
> 
> Based on my understanding that entries allocated to the reserved ASID
> will not be used for subsequent page table walks (and so we don't have
> asynchronous behaviour to contend with), this sounds fine to me.
> 
> Thanks for taking the time to clarify the details on that.
> 
>> Based on work by Shanker Donthineni <shankerd@codeaurora.org>
>>
>> Signed-off-by: Christopher Covington <cov@codeaurora.org>
>> ---
>>  Documentation/arm64/silicon-errata.txt |  1 +
>>  arch/arm64/Kconfig                     | 11 +++++++++++
>>  arch/arm64/include/asm/assembler.h     | 23 +++++++++++++++++++++++
>>  arch/arm64/include/asm/cpucaps.h       |  3 ++-
>>  arch/arm64/include/asm/mmu_context.h   |  8 +++++++-
>>  arch/arm64/kernel/cpu_errata.c         |  7 +++++++
>>  arch/arm64/mm/context.c                | 11 +++++++++++
>>  arch/arm64/mm/proc.S                   |  1 +
>>  8 files changed, 63 insertions(+), 2 deletions(-)
> 
> Don't we need to use pre_ttbr0_update_workaround in <asm/asm-uaccess.h>
> for CONFIG_ARM64_SW_TTBR0_PAN? We implicitly switch to the reserved ASID
> for the empty table in __uaccess_ttbr0_disable.
> 
> That also means we have to invalidate the reserved ASID so as to not
> accidentally hit while uaccess is disabled.

The CPU in question (Falkor v1) has hardware PAN support. Do we need
to worry about including the workaround in the SW PAN code in that case?

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
