From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Aug 2014 16:38:04 +0200
Subject: [PATCH v2 2/3] arm64: add helper functions to read I-cache
 attributes
In-Reply-To: <20140806143430.GU25953@arm.com>
References: <1407230757-15305-1-git-send-email-ard.biesheuvel@linaro.org>
 <1407230757-15305-2-git-send-email-ard.biesheuvel@linaro.org>
 <20140806130026.GR25953@arm.com>
 <CAKv+Gu_T+FuoS4jEyrG8b5WN8E9=N6nDUL7JC_=9VhaJV-2Pzg@mail.gmail.com>
 <CAKv+Gu-iGZMLgWHEPoc1w8HW3gUyuJXb6uerXg_kGQOhbqySSg@mail.gmail.com>
 <20140806143430.GU25953@arm.com>
Message-ID: <CAKv+Gu88=4OBQARb94C2H1eaJhgxfGdJETEzOPu2BBWBoNX+9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2014 16:34, Will Deacon <will.deacon@arm.com> wrote:
> On Wed, Aug 06, 2014 at 02:27:55PM +0100, Ard Biesheuvel wrote:
>> On 6 August 2014 15:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> > On 6 August 2014 15:00, Will Deacon <will.deacon@arm.com> wrote:
>> >> On Tue, Aug 05, 2014 at 10:25:56AM +0100, Ard Biesheuvel wrote:
>> >>> This adds helper functions and #defines to <asm/cachetype.h> to read the
>> >>> line size and the number of sets from the level 1 instruction cache.
>> >>>
>> >>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> >>> ---
>
> [...]
>
>> >>> +static inline __attribute_const__ u64 icache_get_ccsidr(void)
>> >>> +{
>> >>> +     u64 ccsidr;
>> >>> +
>> >>> +     /* Select L1 I-cache and read its size ID register */
>> >>> +     asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
>> >>> +         : "=r"(ccsidr) : "r"(1L));
>> >>> +     return ccsidr;
>> >>
>> >> Is it worth having a WARN_ON(preemptible()) here?
>> >>
>> >
>> > Sure, why not.
>>
>> ... if it weren't for the fact that this triggers recursive header
>> inclusion hell
>>
>>   CC      kernel/bounds.s
>> In file included from /home/ard/linux-2.6/include/asm-generic/preempt.h:4:0,
>>                  from arch/arm64/include/generated/asm/preempt.h:1,
>>                  from /home/ard/linux-2.6/include/linux/preempt.h:18,
>>                  from /home/ard/linux-2.6/arch/arm64/include/asm/cachetype.h:21,
>
> [...]
>
>> i.e., linux/bug,h and linux/preempt.h already implicitly #include
>> cachetype.h, so including the former from the latter to import the
>> declaration of WARN_ON() and/or preemptible respectively produces this
>> error.
>
> Damn, that's a real shame. I'm always dubious about adding code like this
> which isn't obviously broken from preemptible context when you're just
> looking at the function name.
>
> Ho-hum.
>

Moving icache_get_ccsidr() into cpuinfo.c does work, as in the patch below

diff --git a/arch/arm64/include/asm/cachetype.h
b/arch/arm64/include/asm/cachetype.h
index 7a2e0762cb40..4c631a0a3609 100644
--- a/arch/arm64/include/asm/cachetype.h
+++ b/arch/arm64/include/asm/cachetype.h
@@ -39,6 +39,26 @@

 extern unsigned long __icache_flags;

+#define CCSIDR_EL1_LINESIZE_MASK 0x7
+#define CCSIDR_EL1_LINESIZE(x) ((x) & CCSIDR_EL1_LINESIZE_MASK)
+
+#define CCSIDR_EL1_NUMSETS_SHIFT 13
+#define CCSIDR_EL1_NUMSETS_MASK (0x7fff << CCSIDR_EL1_NUMSETS_SHIFT)
+#define CCSIDR_EL1_NUMSETS(x) \
+ (((x) & CCSIDR_EL1_NUMSETS_MASK) >> CCSIDR_EL1_NUMSETS_SHIFT)
+
+extern u64 __attribute_const__ icache_get_ccsidr(void);
+
+static inline int icache_get_linesize(void)
+{
+ return 16 << CCSIDR_EL1_LINESIZE(icache_get_ccsidr());
+}
+
+static inline int icache_get_numsets(void)
+{
+ return 1 + CCSIDR_EL1_NUMSETS(icache_get_ccsidr());
+}
+
 /*
  * Whilst the D-side always behaves as PIPT on AArch64, aliasing is
  * permitted in the I-cache.
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index f798f66634af..319255ff536d 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -20,8 +20,10 @@
 #include <asm/cputype.h>

 #include <linux/bitops.h>
+#include <linux/bug.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/preempt.h>
 #include <linux/printk.h>
 #include <linux/smp.h>

@@ -190,3 +192,15 @@ void __init cpuinfo_store_boot_cpu(void)

  boot_cpu_data = *info;
 }
+
+u64 __attribute_const__ icache_get_ccsidr(void)
+{
+ u64 ccsidr;
+
+ WARN_ON(preemptible());
+
+ /* Select L1 I-cache and read its size ID register */
+ asm("msr csselr_el1, %1; isb; mrs %0, ccsidr_el1"
+    : "=r"(ccsidr) : "r"(1L));
+ return ccsidr;
+}
