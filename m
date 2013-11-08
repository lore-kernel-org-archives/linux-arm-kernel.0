From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 08 Nov 2013 10:53:12 -0800
Subject: [PATCH] ARM: Use udiv/sdiv for __aeabi_{u}idiv library functions
In-Reply-To: <20131108165223.GL16735@n2100.arm.linux.org.uk>
References: <1383852042-10780-1-git-send-email-sboyd@codeaurora.org>
 <20131108095842.GG28304@ns203013.ovh.net>
 <20131108165223.GL16735@n2100.arm.linux.org.uk>
Message-ID: <527D3318.2050003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/13 08:52, Russell King - ARM Linux wrote:
> On Fri, Nov 08, 2013 at 10:58:42AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> On 11:20 Thu 07 Nov     , Stephen Boyd wrote:
>>> @@ -381,6 +384,13 @@ static void __init cpuid_init_hwcaps(void)
>>>  		elf_hwcap |= HWCAP_IDIVT;
>>>  	}
>>>  
>>> +#ifdef CONFIG_THUMB2_KERNEL
>> if (IS_ENABLED(CONFIG_THUMB2_KERNEL) && elf_hwcap & HWCAP_IDIVT)
>>> +	if (elf_hwcap & HWCAP_IDIVT)
>>> +#else
>>> +	if (elf_hwcap & HWCAP_IDIVA)
>>> +#endif
> Take another look, and you'll see the change that you're suggesting is
> wrong.  Instead, the following may be a more reasonable suggestion as
> a suitable replacement:
>
> 	if (elf_hwcap & (IS_ENABLED(CONFIG_THUMB2_KERNEL) ?
> 				HWCAP_IDIVT : HWCAP_IDIVA))

I can use IS_ENABLED() but I'd prefer a local variable to make it
simpler in the conditional.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
