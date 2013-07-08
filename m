From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 8 Jul 2013 13:52:31 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v2
In-Reply-To: <201306271401.13198.arnd@arndb.de>
References: <20130626235837.11576.86389.sendpatchset@w520>
 <201306271401.13198.arnd@arndb.de>
Message-ID: <CANqRtoRR-pyCpXYwKXRYSfVOewv+dXf=ntofJJsKQ0defF5-MQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Jun 27, 2013 at 9:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 27 June 2013, Magnus Damm wrote:
>
>> +#include <asm/cacheflush.h>
>> +#include <asm/cp15.h>
>> +#include <asm/smp_plat.h>
>> +
>> +#define SYSC 0xe6180000
>> +#define SYSCSR  0x0000
>> +
>> +#define RST  0xe6160000
>> +#define CA15BAR      0x6020
>> +#define CA15RESCNT 0x0040
>> +#define CA7BAR       0x4030
>> +#define CA7RESCNT 0x0044
>> +#define RESCNT       0x0050
>> +
>> +#define APMU 0xe6150000
>> +#define CA15WUPCR 0x2010
>> +#define CA7WUPCR 0x1010
>> +
>> +#define MERAM        0xe8080000
>
> Please get the base addresses from device tree if you can,
> using of_iomap().

Yes, that is my plan. Actually, I was hoping of moving out the APMU
and SYSC bits from this file in the future.

>> +#define r8a7790_clst_id(cpu) (cpu_logical_map((cpu)) >> 8)
>> +#define r8a7790_cpu_id(cpu) (cpu_logical_map((cpu)) & 0xff)
>> +
>> +static void r8a7790_deassert_reset(unsigned int cpu)
>> +{
>> +     void __iomem *p, *carescnt;
>> +     u32 bar, mask, magic;
>> +     unsigned int clst_id = r8a7790_clst_id(cpu);
>> +
>> +     /* setup reset vectors */
>> +     p = ioremap_nocache(RST, 0x7000);
>> +     bar = (MERAM >> 8) & 0xfffffc00;
>> +     __raw_writel(bar, p + r8a7790_clst[clst_id].cabar);
>> +     __raw_writel(bar | 0x10, p + r8a7790_clst[clst_id].cabar);
>> +
>> +     /* enable clocks for cluster */
>> +     if (r8a7790_clst[clst_id].use_count++ == 0) {
>> +             mask = 1 << r8a7790_clst[clst_id].rescnt_bit;
>> +             __raw_writel(__raw_readl(p + RESCNT) & ~mask, p + RESCNT);
>> +     }
>
> If you cannot use writel_relaxed() here, add a comment. Otherwise
> change it to writel or writel_relaxed.

Ok, I will git that a go.

>> +static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +     void __iomem *p;
>> +     unsigned int k;
>> +
>> +     shmobile_boot_fn = virt_to_phys(shmobile_invalidate_start);
>> +
>> +     /* MERAM for jump stub, because BAR requires 256KB aligned address */
>> +     p = ioremap_nocache(MERAM, 16);
>> +     memcpy(p, shmobile_boot_vector, 16);
>> +     iounmap(p);
>
> On the other hand here you have to use __raw_writel() or
> memcpy_toio() because memcpy cannot operate on __iomem tokens.
>
> Also, if this is actually memory, you probably want to use ioremap_cached
> or ioremap_writecombine.

Yeah, I realize this may be a bit of a mess. So say that I used
ioremap_cached() here, I think I still need to flush the cache to make
sure the secondary processors have valid code available then they
boot. I suppose you're fine with that?

Thanks,

/ magnus
