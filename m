From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 25 Nov 2013 18:48:55 -0500
Subject: Build breakage from 'ARM: mm: use phys_addr_t appropriately in
 p2v and v2p conversions'
In-Reply-To: <20131125233929.GW16735@n2100.arm.linux.org.uk>
References: <20131125223636.GA20822@obsidianresearch.com>
 <20131125232003.GU16735@n2100.arm.linux.org.uk>
 <20131125233458.GA19852@obsidianresearch.com>
 <20131125233929.GW16735@n2100.arm.linux.org.uk>
Message-ID: <5293E1E7.9030800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 25 November 2013 06:39 PM, Russell King - ARM Linux wrote:
> On Mon, Nov 25, 2013 at 04:34:58PM -0700, Jason Gunthorpe wrote:
>> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
>> index eaf428c..b886eba 100644
>> --- a/arch/arm/include/asm/memory.h
>> +++ b/arch/arm/include/asm/memory.h
>> @@ -239,15 +239,8 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
>>  
>>  #else
>>  
>> -static inline phys_addr_t __virt_to_phys(unsigned long x)
>> -{
>> -       return (phys_addr_t)x - PAGE_OFFSET + PHYS_OFFSET;
>> -}
>> -
>> -static inline unsigned long __phys_to_virt(phys_addr_t x)
>> -{
>> -       return x - PHYS_OFFSET + PAGE_OFFSET;
>> -}
>> +#define __virt_to_phys(x)      ((phys_addr_t)(x) - PAGE_OFFSET + PHYS_OFFSET)
>> +#define __phys_to_virt(x)      ((unsigned long)((phys_addr_t)(x) - PHYS_OFFSET + PAGE_OFFSET))
>>
>>  #endif
>>  #endif
>>
>> I don't seen an obvious major downside to loosing the inline, static
>> checking will have to be done with the ARM_PATCH_PHYS_VIRT branch..
> 
> Well, at this point I'm seriously thinking that killing the __ versions
> of this is the right thing to do: the original idea was that the __
> versions were the underlying mathematical conversions, with all the
> casting kept out of them - thereby making it easy for them to be
> overridden without introducing subtle bugs.
> 
> That's been lost now with all the casting, so there's little point them
> really existing.
> 
Just saw the thread. I was assuming that ARM_PATCH_PHYS_VIRT is always
enabled when the PLAT_PHYS_OFFSET was killed. Sorry for the build breakage.
NoMMU and machines with mach/memory.h still don't have ARM_PATCH_PHYS_VIRT
enabled so they would break.

Looks like you have proposed already a patch with PLAT_PHYS_OFFSET
which should help the case. Thanks.

Regards,
Santosh
