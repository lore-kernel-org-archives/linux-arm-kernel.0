From: bhupinder.thakur@linaro.org (Bhupinder Thakur)
Date: Fri, 8 Dec 2017 12:57:54 +0530
Subject: [PATCH] arm64: mm: Fix pte_mkclean, pte_mkdirty semantics
In-Reply-To: <20171201174429.6azrpma5ypltlgcs@armageddon.cambridge.arm.com>
References: <20171201172214.6834-1-steve.capper@arm.com>
 <20171201174429.6azrpma5ypltlgcs@armageddon.cambridge.arm.com>
Message-ID: <CACtJ1JRvOY1CSBQD7wjdFiJLrDY7fz9PLdFih+eLmrbYpqR2xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2017 at 23:14, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Dec 01, 2017 at 05:22:14PM +0000, Steve Capper wrote:
>> On systems with hardware dirty bit management, the ltp madvise09 unit
>> test fails due to dirty bit information being lost and pages being
>> incorrectly freed.
>>
>> This was bisected to:
>>       arm64: Ignore hardware dirty bit updates in ptep_set_wrprotect()
>>
>> Reverting this commit leads to a separate problem, that the unit test
>> retains pages that should have been dropped due to the function
>> madvise_free_pte_range(.) not cleaning pte's properly.
>>
>> Currently pte_mkclean only clears the software dirty bit, thus the
>> following code sequence can appear:
>>
>>       pte = pte_mkclean(pte);
>>       if (pte_dirty(pte))
>>               // this condition can return true with HW DBM!
>>
>> This patch also adjusts pte_mkclean to set PTE_RDONLY thus effectively
>> clearing both the SW and HW dirty information.
>>
>> In order for this to function on systems without HW DBM, we need to
>> also adjust pte_mkdirty to remove the read only bit from writable pte's
>> to avoid infinite fault loops.
>>
>> Reported-by: Bhupinder Thakur <bhupinder.thakur@linaro.org>
>> Fixes: 64c26841b349 ("arm64: Ignore hardware dirty bit updates in
>> ptep_set_wrprotect()")
>> Signed-off-by: Steve Capper <steve.capper@arm.com>
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I verified that with this patch the madvise09 test passes.
