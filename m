From: vladimir.danushevsky@oracle.com (Vladimir Danushevsky)
Date: Fri, 12 Apr 2013 16:58:43 -0400
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <20130408155749.GS17476@mudshark.cambridge.arm.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
 <20130408155749.GS17476@mudshark.cambridge.arm.com>
Message-ID: <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On Apr 8, 2013, at 11:57 AM, Will Deacon wrote:

> Hi Russell,
> 
> On Mon, Apr 08, 2013 at 03:24:06PM +0100, Russell King - ARM Linux wrote:
>> I think we're heading towards running out of hwcap bits to represent all
>> these different features.  Not there yet, but after this we only have 11
>> spare bits.
>> 
>> Maybe we need to switch to a more x86-centric method where we report this
>> stuff in /proc/cpuinfo, and userspace parses this information out.  If
>> glibc already has code in there for x86, maybe we can reuse that?
> 
> Why can't we just pass multiple AT_HWCAP entries in the auxv? It would
> require a small change to the ELF loader to allow an architecture to provide
> more than just ELF_HWCAP, but it's fairly straightforward and easy to
> propogate without breaking backwards compatibility.
> 
>>> +        if (((read_cpuid_ext(CPUID_EXT_MMFR3) >> 28) & 0xf) > 0)
>>> 
>>> +          elf_hwcap |= HWCAP_ATOMICD;
>> 
>> We use tabs for indentation, not two spaces.  Also, on the face of it
>> ATOMICD isn't obvious what it means.  Maybe HWCAP_LDRDSTRD would be
>> better - it's only one character longer and truely reflects what you're
>> trying to report - the presence of these two instructions.
> 
> Actually, it's not just the presence of those instructions -- it's their
> behaviour wrt atomicity. They are only guaranteed to be atomic if the CPU in
> question supports LPAE. We could call it "lpae" but it might be set even
> when the kernel is using the short-descriptor format.

I also think that ATOMICD would describe the intended behavior better.

Below is a modified patch based on suggestions so far:


Signed-off-by: Vladimir Danushevsky <vladimir.danushevsky@oracle.com>

 include/uapi/asm/hwcap.h |    1 +
 kernel/setup.c           |   13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)


diff -uprN -X linux-3.9-rc6/Documentation/dontdiff linux-3.9-rc6-vanilla/arch/arm/include/uapi/asm/hwcap.h linux-3.9-rc6/arch/arm/include/uapi/asm/hwcap.h
--- linux-3.9-rc6-vanilla/arch/arm/include/uapi/asm/hwcap.h	2013-04-07 23:49:54.000000000 -0400
+++ linux-3.9-rc6/arch/arm/include/uapi/asm/hwcap.h	2013-04-08 12:01:24.952168593 -0400
@@ -25,6 +25,7 @@
 #define HWCAP_IDIVT	(1 << 18)
 #define HWCAP_VFPD32	(1 << 19)	/* set if VFP has 32 regs (not 16) */
 #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
+#define HWCAP_ATOMICD	(1 << 20)	/* atomic behavior of ldrd/strd */
 
 
 #endif /* _UAPI__ASMARM_HWCAP_H */
diff -uprN -X linux-3.9-rc6/Documentation/dontdiff linux-3.9-rc6-vanilla/arch/arm/kernel/setup.c linux-3.9-rc6/arch/arm/kernel/setup.c
--- linux-3.9-rc6-vanilla/arch/arm/kernel/setup.c	2013-04-07 23:49:54.000000000 -0400
+++ linux-3.9-rc6/arch/arm/kernel/setup.c	2013-04-08 12:42:26.145583364 -0400
@@ -355,7 +355,7 @@ void __init early_print(const char *str,
 
 static void __init cpuid_init_hwcaps(void)
 {
-	unsigned int divide_instrs;
+	unsigned int divide_instrs, vmsa;
 
 	if (cpu_architecture() < CPU_ARCH_ARMv7)
 		return;
@@ -368,6 +368,14 @@ static void __init cpuid_init_hwcaps(voi
 	case 1:
 		elf_hwcap |= HWCAP_IDIVT;
 	}
+
+        /*
+         * LDRD/STRD instructions are single-copy atomic on LPAE enabled targets
+         * as long as double-word alignment is kept. Report that feature.
+         */
+        vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
+        if (vmsa >= 5)
+                elf_hwcap |= HWCAP_ATOMICD;
 }
 
 static void __init feat_v6_fixup(void)
@@ -506,7 +514,7 @@ static void __init setup_processor(void)
 #ifndef CONFIG_ARM_THUMB
 	elf_hwcap &= ~(HWCAP_THUMB | HWCAP_IDIVT);
 #endif

 	feat_v6_fixup();
 
 	cacheid_init();
@@ -864,6 +872,7 @@ static const char *hwcap_str[] = {
 	"vfpv4",
 	"idiva",
 	"idivt",
+	"atomicd",
 	NULL
 };
 



> 
> Will
