From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 22 Nov 2016 17:03:29 +0000
Subject: [RFC PATCH 09/11] ARM: NOMMU: define SECTION_xxx macros
In-Reply-To: <20161122115456.GX1041@n2100.armlinux.org.uk>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-10-git-send-email-vladimir.murzin@arm.com>
 <20161122100713.GW1041@n2100.armlinux.org.uk> <58343121.4030906@arm.com>
 <20161122115456.GX1041@n2100.armlinux.org.uk>
Message-ID: <58347A61.306@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/16 11:54, Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2016 at 11:50:57AM +0000, Vladimir Murzin wrote:
>> On 22/11/16 10:07, Russell King - ARM Linux wrote:
>>> On Tue, Nov 22, 2016 at 09:26:06AM +0000, Vladimir Murzin wrote:
>>>> Pickup defines from pgtable-2level.h to make NOMMU build happy.
>>>
>>> This needs more detail.
>>>
>>
>> It comes from
>>
>>   CC      arch/arm/kernel/setup.o
>> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
>> arch/arm/kernel/setup.c:1001:25: error: 'SECTION_SIZE' undeclared (first use in this function)
>>              crash_size, SECTION_SIZE);
>>                          ^
>> arch/arm/kernel/setup.c:1001:25: note: each undeclared identifier is reported only once for each function it appears in
>> make[1]: *** [arch/arm/kernel/setup.o] Error 1
>> make: *** [arch/arm/kernel] Error 2
> 
> Hmm, I decided not to use CRASH_ALIGN there because I didn't want to
> break anyone's existing setup unnecessarily, however arguably it
> should be CRASH_ALIGN to ensure that the new kernel is properly
> positioned.
> 
> I wonder if we can get away with changing that, rather than
> unnecessarily introducing these otherwise meaningless definitions
> for R-class.
> 

CRASH_ALIGN works fine but it seems not only user of SECTION_SIZE

In file included from ./include/linux/cache.h:4:0,
                 from ./include/linux/printk.h:8,
                 from ./include/linux/kernel.h:13,
                 from arch/arm/mach-omap2/omap-secure.c:15:
arch/arm/mach-omap2/omap-secure.c: In function 'omap_secure_ram_reserve_memblock':
arch/arm/mach-omap2/omap-secure.c:65:21: error: 'SECTION_SIZE' undeclared (first use in this function)
  size = ALIGN(size, SECTION_SIZE);
                     ^
./include/uapi/linux/kernel.h:10:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
 #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                               ^
./include/linux/kernel.h:48:22: note: in expansion of macro '__ALIGN_KERNEL'
 #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                      ^
arch/arm/mach-omap2/omap-secure.c:65:9: note: in expansion of macro 'ALIGN'
  size = ALIGN(size, SECTION_SIZE);
         ^
arch/arm/mach-omap2/omap-secure.c:65:21: note: each undeclared identifier is reported only once for each function it appears in
  size = ALIGN(size, SECTION_SIZE);
                     ^
./include/uapi/linux/kernel.h:10:47: note: in definition of macro '__ALIGN_KERNEL_MASK'
 #define __ALIGN_KERNEL_MASK(x, mask) (((x) + (mask)) & ~(mask))
                                               ^
./include/linux/kernel.h:48:22: note: in expansion of macro '__ALIGN_KERNEL'
 #define ALIGN(x, a)  __ALIGN_KERNEL((x), (a))
                      ^
arch/arm/mach-omap2/omap-secure.c:65:9: note: in expansion of macro 'ALIGN'
  size = ALIGN(size, SECTION_SIZE);
         ^
make[1]: *** [arch/arm/mach-omap2/omap-secure.o] Error 1

Cheers
Vladimir
