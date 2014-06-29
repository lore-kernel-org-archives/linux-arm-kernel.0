From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Sun, 29 Jun 2014 18:04:35 -0500
Subject: [PATCH v7 7/9] ARM: add vdso user-space code
In-Reply-To: <20140629160751.GQ32514@n2100.arm.linux.org.uk>
References: <1403493118-7597-1-git-send-email-nathan_lynch@mentor.com>
 <1403493118-7597-8-git-send-email-nathan_lynch@mentor.com>
 <20140628152609.GH32514@n2100.arm.linux.org.uk> <53AEE9B6.7000609@mentor.com>
 <20140628181212.GJ32514@n2100.arm.linux.org.uk> <53AF1B65.5000904@mentor.com>
 <20140628201120.GK32514@n2100.arm.linux.org.uk> <53AF3510.7030707@mentor.com>
 <20140629083415.GL32514@n2100.arm.linux.org.uk> <53B0353D.1080705@mentor.com>
 <20140629160751.GQ32514@n2100.arm.linux.org.uk>
Message-ID: <53B09B83.6020009@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/29/2014 11:07 AM, Russell King - ARM Linux wrote:
> On Sun, Jun 29, 2014 at 10:48:13AM -0500, Nathan Lynch wrote:
>> On 06/29/2014 03:34 AM, Russell King - ARM Linux wrote:
>>> On Sat, Jun 28, 2014 at 04:35:12PM -0500, Nathan Lynch wrote:
>>>> That's consistent with my results on iMX6.  The reported 1.00x "speedup"
>>>> for clock-gettime-monotonic etc indicates the VDSO is falling back to
>>>> syscall.
>>>>
>>>> Thanks for testing.
>>>
>>> Here's another issue which cropped up when I ran this patch set through
>>> the autobuilder last night - allnoconfig's now fail with:
>>>
>>> mm/memory.c: In function 'gate_vma_init':
>>> mm/memory.c:3410:22: error: 'FIXADDR_USER_START' undeclared (first use in this function)
>>> mm/memory.c:3411:20: error: 'FIXADDR_USER_END' undeclared (first use in this function)
>>> mm/memory.c: In function 'in_gate_area_no_mm':
>>> mm/memory.c:3432:15: error: 'FIXADDR_USER_START' undeclared (first use in this function)
>>> mm/memory.c:3432:46: error: 'FIXADDR_USER_END' undeclared (first use in this function)
>>> make[2]: *** [mm/memory.o] Error 1
>>
>> arch/arm/include/page.h:
>> #ifdef CONFIG_KUSER_HELPERS
>> #define __HAVE_ARCH_GATE_AREA 1
>> #endif
>>
>> mm/memory.c:
>> #if !defined(__HAVE_ARCH_GATE_AREA)
>>
>> #if defined(AT_SYSINFO_EHDR)
>> static struct vm_area_struct gate_vma;
>>
>> static int __init gate_vma_init(void)
>> {
>> 	gate_vma.vm_mm = NULL;
>> 	gate_vma.vm_start = FIXADDR_USER_START;
>> 	gate_vma.vm_end = FIXADDR_USER_END;
>> ...
>>
>> The vdso patches add an ARM definition for AT_SYSINFO_EHDR.  So when
>> CONFIG_KUSER_HELPERS=n, this code is pulled in now...
>>
>> Not sure what the fix would be right now.  I don't understand why there
>> is this relationship between AT_SYSINFO_EHDR and gate vma code.
> 
> Me neither.  It looks like changing those tests for AT_SYSINFO_EHDR to
> something like __HAVE_GATE_VMA or CONFIG_HAVE_GATE_VMA would be a good
> step, so we can keep this disabled on ARM.  I don't see a need for the
> gate VMA stuff just because we have a vDSO.

How about the following as an additonal preparatory patch?  It's not as
good as cleaning up interaction between the core mm and architecture code
with respect to the gate vma APIs, but it has the advantage of not
blocking the ARM VDSO code.

(sorry if it's mangled, I swear I'm going to stop using this mail client soon)

============

>From 4ad05345625d6f6a045ebe5ed355e3a2c2272fd4 Mon Sep 17 00:00:00 2001
From: Nathan Lynch <nathan_lynch@mentor.com>
Date: Sun, 29 Jun 2014 17:20:46 -0500
Subject: [PATCH] ARM: provide gate vma API stubs when CONFIG_KUSER_HELPERS
 disabled

If an architecture defines AT_SYSINFO_EHDR and does not define
__HAVE_ARCH_GATE_AREA, code in mm/memory.c (gate_vma_init,
get_gate_vma, etc) is enabled which is unbuildable unless the
architecure provides FIXADDR_USER_START and FIXADDR_USER_END.

This situation can arise with arch/arm with the introduction of VDSO
support, which adds a definition for AT_SYSINFO_EHDR.
__HAVE_ARCH_GATE_AREA is conditional on CONFIG_KUSER_HELPERS, so if
that config option is disabled, the ARM build fails.  We don't want to
enable this code on ARM.

Other architectures (arm64, powerpc, s390, tile) define
__HAVE_ARCH_GATE_AREA unconditionally, and provide stub
implementations of the gate vma APIs.  This avoids building the
default gate vma code in the core mm, which appears to be useful only
for ia64 and user-mode x86.

Make ARM work similarly, except we provide real implementations of the
gate APIs when the kuser helper page is enabled.  When it's disabled,
use stubs like the other architectures.  Define __HAVE_ARCH_GATE_AREA
unconditionally.

Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>
---
 arch/arm/include/asm/page.h |  2 --
 arch/arm/kernel/process.c   | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 4355f0ec44d6..6363f3d1d505 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -142,9 +142,7 @@ extern void __cpu_copy_user_highpage(struct page *to, struct page *from,
 #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
 extern void copy_page(void *to, const void *from);
 
-#ifdef CONFIG_KUSER_HELPERS
 #define __HAVE_ARCH_GATE_AREA 1
-#endif
 
 #ifdef CONFIG_ARM_LPAE
 #include <asm/pgtable-3level-types.h>
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 39b0d68aa068..35f4cb54bb14 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -467,9 +467,25 @@ int in_gate_area_no_mm(unsigned long addr)
 	return in_gate_area(NULL, addr);
 }
 #define is_gate_vma(vma)	((vma) == &gate_vma)
-#else
+
+#else /* !CONFIG_KUSER_HELPERS */
+
+struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
+{
+	return NULL;
+}
+
+int in_gate_area(struct mm_struct *mm, unsigned long addr)
+{
+	return 0;
+}
+
+int in_gate_area_no_mm(unsigned long addr)
+{
+	return 0;
+}
 #define is_gate_vma(vma)	0
-#endif
+#endif /* CONFIG_KUSER_HELPERS */
 
 const char *arch_vma_name(struct vm_area_struct *vma)
 {
-- 
1.9.3
