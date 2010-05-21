From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 21 May 2010 19:05:51 +0800
Subject: L2 cache support for pxa16x
In-Reply-To: <1274350676.6926.58.camel@pe-dt434>
References: <1273658181.6926.27.camel@pe-dt434>
	<AANLkTiky2tG7-n5bmMBqhKBIn7tq1tIT0KeWpkUee5YK@mail.gmail.com>
	<1274350676.6926.58.camel@pe-dt434>
Message-ID: <AANLkTilYrgroqxaL0uGnpmTXmUznkijtFmNmkSuFL89V@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 20, 2010 at 6:17 PM, Siddarth Gore <gores@marvell.com> wrote:
> On Wed, 2010-05-12 at 03:11 -0700, Eric Miao wrote:
>> On Wed, May 12, 2010 at 11:56 AM, Siddarth Gore <gores@marvell.com> wrote:
>> > Hi Eric/Haojian,
>> >
>> > Can the Tauros2 support be used for pxa168 as well? The one difference I
>> > can see is that L2 Enable is in control register instead of extra
>> > feature register. But rest of the things look very similar to me.
>> >
>
> I tried doing this. It works when I enable L2 before turning the MMU on,
> i.e. in __mohawk_setup
>
> But when I do the following in tauros2_init(), the kernel crashes.
> 1. flush and disable dcache
> 2. invalidate and disable icache
> 3. drain write buffer
> 4. invalidate TLB
> 5. invalidate L2
> 6. enable L2
> 7. enable icache
> 8. enable dcache
>
> I think the right place to enable L2 is in tauros2_init, so any idea
> what I am doing wrong here?
>
> -siddarth
>
>

I didn't meet any failure on enabling L2. What I do is in below. Which
kernel version are you using?


diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 652ae66..689e0d5 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -15,6 +15,7 @@
 #include <linux/io.h>
 #include <linux/clk.h>

+#include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/cputype.h>
@@ -101,6 +102,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 static int __init pxa168_init(void)
 {
        if (cpu_is_pxa168()) {
+               tauros2_init();
                mfp_init_base(MFPR_VIRT_BASE);
                mfp_init_addr(pxa168_mfp_addr_map);
                pxa_init_dma(IRQ_PXA168_DMA_INT0, 32);
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 5086865..79f49f5 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -120,7 +120,11 @@ static inline u32 __init read_extra_features(void)

 static inline void __init write_extra_features(u32 u)
 {
+       volatile u32 cp15;
        __asm__("mcr p15, 1, %0, c15, c1, 0" : : "r" (u));
+       __asm__("mrc p15, 0, %0, c1, c0, 0" : "=r" (cp15));
+       cp15 |= (1 << 26);
+       __asm__("mcr p15, 0, %0, c1, c0, 0" : : "r" (cp15));
 }
