From: david.vrabel@citrix.com (David Vrabel)
Date: Wed, 7 May 2014 12:46:00 +0100
Subject: [PATCH] arm/xen: Remove definiition of virt_to_pfn in
 asm/xen/page.h
In-Reply-To: <alpine.DEB.2.02.1405071234010.14596@kaball.uk.xensource.com>
References: <1397836474-10478-1-git-send-email-julien.grall@linaro.org>
 <535901F0.3010908@citrix.com> <53590845.1090405@linaro.org>
 <53591B8F.8070300@citrix.com>
 <alpine.DEB.2.02.1404251801060.8072@kaball.uk.xensource.com>
 <alpine.DEB.2.02.1405071234010.14596@kaball.uk.xensource.com>
Message-ID: <536A1CF8.5000309@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/14 12:41, Stefano Stabellini wrote:
> On Fri, 25 Apr 2014, Stefano Stabellini wrote:
>> On Thu, 24 Apr 2014, David Vrabel wrote:
>>> On 24/04/14 13:49, Julien Grall wrote:
>>>> Hi David,
>>>>
>>>> On 04/24/2014 01:22 PM, David Vrabel wrote:
>>>>> On 18/04/14 16:54, Julien Grall wrote:
>>>>>> virt_to_pfn has been defined in asm/memory.h by the commit e26a9e0 "ARM: Better
>>>>>> virt_to_page() handling"
>>>>>>
>>>>>> This will result of a compilation warning when CONFIG_XEN is enabled.
>>>>>>
>>>>>> arch/arm/include/asm/xen/page.h:80:0: warning: "virt_to_pfn" redefined [enabled by default]
>>>>>>  #define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
>>>>>>  ^
>>>>>> In file included from arch/arm/include/asm/page.h:163:0,
>>>>>>                  from arch/arm/include/asm/xen/page.h:4,
>>>>>>                  from include/xen/page.h:4,
>>>>>>                  from arch/arm/xen/grant-table.c:33:
>>>>>>
>>>>>> The definition in memory.h is nearly the same (it directly expand PFN_DOWN),
>>>>>> so we can safely drop virt_to_pfn in xen include.
>>>>>
>>>>>
>>>>> This breaks the arm build for me.
>>>>>
>>>>> /local/davidvr/work/k.org/tip/drivers/block/xen-blkfront.c: In function
>>>>> ?setup_blkring?:
>>>>> /local/davidvr/work/k.org/tip/drivers/block/xen-blkfront.c:1236:2:
>>>>> error: implicit declaration of function ?virt_to_pfn?
>>>>> [-Werror=implicit-function-declaration]
>>>>>   err = xenbus_grant_ring(dev, virt_to_mfn(info->ring.sring));
>>>>>   ^
>>>>
>>>> I don't have any issue to build the following branch with this patch on:
>>>> 	- v3.15-rc2
>>>> 	- xentip master
>>>> 	- xentip for-linus-3.16
>>>
>>> Applied to devel/for-linus-3.16.
>>>
>>> If something else turns up for 3.15 (and I remember) I'll take it for
>>> 3.15 instead.
>>
>> David,
>> thank you very much for taking the patch in my absence.
>>
>> Considering that the problem is affecting everybody enabling CONFIG_XEN
>> on ARM on v3.15, I don't think we can wait for the next merge window to
>> send this fix upstream.
>> Too many warnings for too many people.
> 
> Unfortunately this commit breaks arm64 compilation, as virt_to_pfn has
> not been introduced to arm64/include/asm/memory.h.
> Has the patch been sent upstream yet?

No.

> We need this additional change for arm64:
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index e94f945..993bce5 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -138,6 +138,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define __pa(x)			__virt_to_phys((unsigned long)(x))
>  #define __va(x)			((void *)__phys_to_virt((phys_addr_t)(x)))
>  #define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
> +#define virt_to_pfn(x)      __phys_to_pfn(__virt_to_phys(x))

This would need an ack from an arm64 maintainer.

David
