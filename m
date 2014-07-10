From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 16:12:35 +0400
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <53BDA568.5030607@intel.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
 <53BDA568.5030607@intel.com>
Message-ID: <53BE8333.6060404@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/14 00:26, Dave Hansen wrote:
> On 07/09/2014 04:29 AM, Andrey Ryabinin wrote:
>> Address sanitizer dedicates 1/8 of the low memory to the shadow memory and uses direct
>> mapping with a scale and offset to translate a memory address to its corresponding
>> shadow address.
>>
>> Here is function to translate address to corresponding shadow address:
>>
>>      unsigned long kasan_mem_to_shadow(unsigned long addr)
>>      {
>>                 return ((addr - PAGE_OFFSET) >> KASAN_SHADOW_SCALE_SHIFT)
>>                              + kasan_shadow_start;
>>      }
> 
> How does this interact with vmalloc() addresses or those from a kmap()?
> 

It's used only for lowmem:

static inline bool addr_is_in_mem(unsigned long addr)
{
	return likely(addr >= PAGE_OFFSET && addr < (unsigned long)high_memory);
}



static __always_inline void check_memory_region(unsigned long addr,
						size_t size, bool write)
{

	....
	if (!addr_is_in_mem(addr))
		return;
	// check shadow here
