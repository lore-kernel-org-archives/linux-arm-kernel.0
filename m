From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Nov 2010 15:28:33 +0000
Subject: [PATCH v3 15/20] ARM: LPAE: use phys_addr_t instead of unsigned
	long for physical addresses
In-Reply-To: <201011171218.13910.arnd@arndb.de>
References: <1289842829-3027-1-git-send-email-catalin.marinas@arm.com>
	<20101116193335.GD21926@n2100.arm.linux.org.uk>
	<AANLkTinDGk2HPg7py9nzsqmM3_AbSG_GJJYwsiMr+wQL@mail.gmail.com>
	<201011171218.13910.arnd@arndb.de>
Message-ID: <AANLkTik39iqXsLJiJ7cWwweO2VBoJ0Y4ymwKqx7X5ziA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2010 11:18, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 17 November 2010, Catalin Marinas wrote:
>> >
>> > It may make sense to mark it const volatile, as that's the most
>> > permissive set of attributes possible (iow, it'll accept any pointer
>> > without warning.) ?However, might be an idea to check what other
>> > arches do.
>>
>> The majority of architectures use volatile and a few add both const
>> and volatile.
>>
>> I usually use the generic headers as reference for function prototypes
>> and that's just using volatile without a const (cc'ing Arnd for any
>> view on this).
>
> const volatile sounds right here, I can also change the generic header
> if we agree to do the same in arm.

That's what I plan to add, though it may be better to push as a
separate patch to fix compiler warnings now. I don't know when the
LPAE patches would go in.

--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -189,7 +189,7 @@
  * translation for translating DMA addresses.  Use the driver
  * DMA support - see dma-mapping.h.
  */
-static inline phys_addr_t virt_to_phys(void *x)
+static inline phys_addr_t virt_to_phys(const volatile void *x)
 {
 	return __virt_to_phys((unsigned long)(x));
 }

-- 
Catalin
