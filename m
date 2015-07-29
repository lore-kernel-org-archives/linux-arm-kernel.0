From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 29 Jul 2015 15:21:56 -0700
Subject: [PATCH v2 24/25] arch: remove ioremap_wt,
 replace with arch_memremap
In-Reply-To: <20150727080347.GA18599@lst.de>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725024015.8664.42950.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150727080347.GA18599@lst.de>
Message-ID: <CAPcyv4icZ4aWgPeYnmuj0eeK6wm36A=D2qHW0e3FJBvzpeEWaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 27, 2015 at 1:03 AM, Christoph Hellwig <hch@lst.de> wrote:
>> +++ b/arch/frv/include/asm/io.h
>> @@ -17,8 +17,6 @@
>>
>>  #ifdef __KERNEL__
>>
>> -#define ARCH_HAS_IOREMAP_WT
>> -
>>  #include <linux/types.h>
>>  #include <asm/virtconvert.h>
>>  #include <asm/string.h>
>> @@ -267,20 +265,17 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr, unsigned lon
>>       return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
>>  }
>>
>> -static inline void __iomem *ioremap_wt(unsigned long physaddr, unsigned long size)
>> -{
>> -     return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
>> -}
>> -
>> -static inline void __iomem *ioremap_fullcache(unsigned long physaddr, unsigned long size)
>> -{
>> -     return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
>> -}
>
>
>> +void *arch_memremap(resource_size_t offset, size_t size, unsigned long flags)
>> +{
>> +     return (void *) offset;
>> +}
>> +EXPORT_SYMBOL(arch_memremap);
>
> This doesn't look like a correct replacement.

It doesn't, but frv jumps through a lot of hoops to give the illusion
it actually supports different mapping types only to do this simple
case in the end.  Given we don't want fallback semantics I will simply
remove these false wrappers in the next revision of the patches.

> Also shouldn't the replacements of ioremap_fullcache or ioremap_wc be
> in the previous patch?
>
> A few more similar issues pop up for other architectures as well.

I went ahead and moved the deletion of ioremap_cached() and
ioremap_fullcache() to their own patches.
