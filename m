From: dkeitel@codeaurora.org (David Keitel)
Date: Tue, 14 Apr 2015 19:37:13 -0700
Subject: [PATCH 2/2] arm64: add KASan support
In-Reply-To: <551E993E.5060801@samsung.com>
References: <1427208544-8232-1-git-send-email-a.ryabinin@samsung.com>
 <1427208544-8232-3-git-send-email-a.ryabinin@samsung.com>
 <20150401122843.GA28616@e104818-lin.cambridge.arm.com>
 <551E993E.5060801@samsung.com>
Message-ID: <552DCED9.40207@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> +	pgd = __pgd(__pa(kasan_zero_pmd) | PAGE_KERNEL);
>>> +#else
>>> +	pgd = __pgd(__pa(kasan_zero_pte) | PAGE_KERNEL);
>>> +#endif
>>> +
>>> +	for (i = pgd_index(start); start < end; i++) {
>>> +		set_pgd(&pgdp[i], pgd);
>>> +		start += PGDIR_SIZE;
>>> +	}
>>> +}
>>
>> Same problem as above with PAGE_KERNEL. You should just use
>> pgd_populate().

Any suggestion what the correct flag setting would be here for a 4K mapping?

I tried fixing this by changing this to pud and setting the PMD_TYPE_TABLE flag for kasan_zero_pmd. However the MMU doesn't like it and I get a first level address translation fault.

If you have any updated patches to share I'd be glad to try them out.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
