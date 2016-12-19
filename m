From: cov@codeaurora.org (Christopher Covington)
Date: Mon, 19 Dec 2016 16:27:28 -0500
Subject: [PATCH 2/3] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161208103115.GF33075@MBP.local>
References: <20161207200028.4420-1-cov@codeaurora.org>
 <20161207200028.4420-2-cov@codeaurora.org> <20161208103115.GF33075@MBP.local>
Message-ID: <495f2ae6-156d-4b69-1fcb-d9052898b185@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 12/08/2016 05:31 AM, Catalin Marinas wrote:
> On Wed, Dec 07, 2016 at 03:00:26PM -0500, Christopher Covington wrote:
>> From: Shanker Donthineni <shankerd@codeaurora.org>
>>
>> On the Qualcomm Datacenter Technologies Falkor v1 CPU, memory accesses may
>> allocate TLB entries using an incorrect ASID when TTBRx_EL1 is being
>> updated. Changing the TTBRx_EL1[ASID] and TTBRx_EL1[BADDR] fields
>> separately using a reserved ASID will ensure that there are no TLB entries
>> with incorrect ASID after changing the the ASID.
>>
>> Pseudo code:
>>   write TTBRx_EL1[ASID] to a reserved value
>>   ISB
>>   write TTBRx_EL1[BADDR] to a desired value
>>   ISB
>>   write TTBRx_EL1[ASID] to a desired value
>>   ISB
> 
> While the new ASID probably won't have incorrect TLB entries, the
> reserved ASID will have random entries from all over the place. That's
> because in step 1 you change the ASID to the reserved one while leaving
> the old BADDR in place. There is a brief time before changing the ASID
> when speculative page table walks will populate the TLB with entries
> tagged with the reserved ASID. Such entries are never removed during TLB
> shoot-down for the real ASID, so, depending on how this CPU implements
> the walk cache, you could end up with intermediate level entries still
> active and pointing to freed/reused pages. It will eventually hit an
> entry that looks global with weird consequences.
> 
> We've been bitten by this in the past on arm32: 52af9c6cd863 ("ARM:
> 6943/1: mm: use TTBR1 instead of reserved context ID").

Thanks for bringing this up, but I'm told the scenario you describe won't
happen on the Falkor 1.0 CPU.

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
