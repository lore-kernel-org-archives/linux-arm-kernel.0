From: dave.hansen@intel.com (Dave Hansen)
Date: Wed, 09 Jul 2014 13:26:16 -0700
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <53BDA568.5030607@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/2014 04:29 AM, Andrey Ryabinin wrote:
> Address sanitizer dedicates 1/8 of the low memory to the shadow memory and uses direct
> mapping with a scale and offset to translate a memory address to its corresponding
> shadow address.
> 
> Here is function to translate address to corresponding shadow address:
> 
>      unsigned long kasan_mem_to_shadow(unsigned long addr)
>      {
>                 return ((addr - PAGE_OFFSET) >> KASAN_SHADOW_SCALE_SHIFT)
>                              + kasan_shadow_start;
>      }

How does this interact with vmalloc() addresses or those from a kmap()?
