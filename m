From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 15 Apr 2015 21:04:37 +0300
Subject: [PATCH 2/2] arm64: add KASan support
In-Reply-To: <552DCED9.40207@codeaurora.org>
References: <1427208544-8232-1-git-send-email-a.ryabinin@samsung.com>
 <1427208544-8232-3-git-send-email-a.ryabinin@samsung.com>
 <20150401122843.GA28616@e104818-lin.cambridge.arm.com>
 <551E993E.5060801@samsung.com> <552DCED9.40207@codeaurora.org>
Message-ID: <552EA835.5070704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2015 05:37 AM, David Keitel wrote:
>>>> +	pgd = __pgd(__pa(kasan_zero_pmd) | PAGE_KERNEL);
>>>> +#else
>>>> +	pgd = __pgd(__pa(kasan_zero_pte) | PAGE_KERNEL);
>>>> +#endif
>>>> +
>>>> +	for (i = pgd_index(start); start < end; i++) {
>>>> +		set_pgd(&pgdp[i], pgd);
>>>> +		start += PGDIR_SIZE;
>>>> +	}
>>>> +}
>>>
>>> Same problem as above with PAGE_KERNEL. You should just use
>>> pgd_populate().
> 
> Any suggestion what the correct flag setting would be here for a 4K mapping?
> 
> I tried fixing this by changing this to pud and setting the PMD_TYPE_TABLE flag for kasan_zero_pmd. However the MMU doesn't like it and I get a first level address translation fault.
> 
> If you have any updated patches to share I'd be glad to try them out.
> 

Sorry, I didn't have much time on work on this yet.

I've pushed the most fresh thing that I have in git:
	git://github.com/aryabinin/linux.git kasan/arm64v1

It's the same patches with two simple but important fixes on top of it.
