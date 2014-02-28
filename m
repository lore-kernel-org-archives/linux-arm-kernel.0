From: Russ.Dill@ti.com (Russ Dill)
Date: Thu, 27 Feb 2014 17:47:21 -0800
Subject: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <530FD3CF.2040900@codeaurora.org>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org>
 <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org>
 <530FD3CF.2040900@codeaurora.org>
Message-ID: <530FEAA9.7040601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/27/2014 04:09 PM, Stephen Boyd wrote:
> On 02/27/14 15:57, Sebastian Capella wrote:
>> diff --git a/arch/arm/include/asm/memory.h
>> b/arch/arm/include/asm/memory.h index 8756e4b..1079ea8 100644 ---
>> a/arch/arm/include/asm/memory.h +++
>> b/arch/arm/include/asm/memory.h @@ -291,6 +291,7 @@ static inline
>> void *phys_to_virt(phys_addr_t x) */ #define __pa(x)
>> __virt_to_phys((unsigned long)(x)) #define __va(x)			((void
>> *)__phys_to_virt((phys_addr_t)(x))) +#define __pa_symbol(x)
>> __pa(RELOC_HIDE((unsigned long)(x), 0))
> 
> Just curious, is there a reason for the RELOC_HIDE() here? Or 
> __pa_symbol() for that matter? It looks like only x86 uses this on
> the __nosave_{begin,end} symbol. Maybe it's copy-pasta?

>From my understanding this needs to stick around so long as gcc 3.x is
supported (did it get dropped yet?) on ARM Linux since it doesn't
support -fno-strict-overflow.

> I also wonder if anyone has thought about making a __weak 
> pfn_is_nosave() function so that architectures don't need to
> implement the same thing every time. Consolidating those shouldn't
> be part of this patch though.
> 

Yes, I think just a couple of the architectures do anything besides
checking if the address falls within the nosave section.
