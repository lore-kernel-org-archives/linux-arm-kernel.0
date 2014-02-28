From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 27 Feb 2014 18:19:49 -0800
Subject: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <530FEAA9.7040601@ti.com>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org>
 <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org>
 <530FD3CF.2040900@codeaurora.org> <530FEAA9.7040601@ti.com>
Message-ID: <530FF245.7070300@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/14 17:47, Russ Dill wrote:
> On 02/27/2014 04:09 PM, Stephen Boyd wrote:
>> On 02/27/14 15:57, Sebastian Capella wrote:
>>> diff --git a/arch/arm/include/asm/memory.h
>>> b/arch/arm/include/asm/memory.h index 8756e4b..1079ea8 100644 ---
>>> a/arch/arm/include/asm/memory.h +++
>>> b/arch/arm/include/asm/memory.h @@ -291,6 +291,7 @@ static inline
>>> void *phys_to_virt(phys_addr_t x) */ #define __pa(x)
>>> __virt_to_phys((unsigned long)(x)) #define __va(x)			((void
>>> *)__phys_to_virt((phys_addr_t)(x))) +#define __pa_symbol(x)
>>> __pa(RELOC_HIDE((unsigned long)(x), 0))
>> Just curious, is there a reason for the RELOC_HIDE() here? Or 
>> __pa_symbol() for that matter? It looks like only x86 uses this on
>> the __nosave_{begin,end} symbol. Maybe it's copy-pasta?
> From my understanding this needs to stick around so long as gcc 3.x is
> supported (did it get dropped yet?) on ARM Linux since it doesn't
> support -fno-strict-overflow.

I don't think it's been dropped yet but I wonder if anyone has tried
recent kernels with such a compiler?

Would the usage of &__pv_table_begin in arch/arm/mm/mmu.c also need the
same treatment? Or the tagtable loop in atags_parse.c? Do the other
architectures also need to be fixed? That link Sebastian points to says
that ppc originally needed it but pfn_is_nosave() on ppc doesn't use
RELOC_HIDE anywhere in their __pa() macro from what I can tell.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
