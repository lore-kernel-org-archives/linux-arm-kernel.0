From: nm@ti.com (Nishanth Menon)
Date: Tue, 12 May 2015 12:22:33 -0500
Subject: [PATCH 5/7] ARM: re-implement physical address space switching
In-Reply-To: <20150511195933.GI2067@n2100.arm.linux.org.uk>
References: <20150506103000.GF2067@n2100.arm.linux.org.uk>
 <E1YpwbF-0000wd-MP@rmk-PC.arm.linux.org.uk>
 <5550FBD8.3070103@ti.com>
 <20150511195933.GI2067@n2100.arm.linux.org.uk>
Message-ID: <CAGo_u6ph1L7=+DDUZSzXjv6z1CtjBfuhPpLLppO_OxKZhyjQVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 2:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, May 11, 2015 at 01:58:32PM -0500, Nishanth Menon wrote:
>> On 05/06/2015 05:30 AM, Russell King wrote:
>> [...]
>> > @@ -1436,75 +1435,32 @@ void __init early_paging_init(const struct machine_desc *mdesc,
>>
>> [...]
>> > -   /* Finally flush any stale TLB values. */
>> > -   local_flush_bp_all();
>> > -   local_flush_tlb_all();
>> > +   /* Re-enable the caches and cacheable TLB walks */
>> > +   asm volatile("mcr p15, 0, %0, c2, c0, 2" : : "ttbcr");
>> ^^
>> on next-20150511, echo
>> "CONFIG_ARM_LPAE=y">>arch/arm/configs/multi_v7_defconfig ;make
>> multi_v7_defconfig;make arch/arm/mm/mmu.o
>> #
>> # configuration written to .config
>> #
>> scripts/kconfig/conf  --silentoldconfig Kconfig
>>
>> <snip>
>>   CC      arch/arm/mm/mmu.o
>> arch/arm/mm/mmu.c: In function ?early_paging_init?:
>> arch/arm/mm/mmu.c:1461:54: error: expected ?(? before ?)? token
>> make[1]: *** [arch/arm/mm/mmu.o] Error 1
>> make: *** [arch/arm/mm/mmu.o] Error 2
>> this was using [1]
>
> That's why I said I'd send you an updated version.  Just replace the
> "ttbcr" with "r" (ttbcr)...

Was reporting regression on 20150511. 20150512 seems to have built fine.

---
Regards,
Nishanth Menon
