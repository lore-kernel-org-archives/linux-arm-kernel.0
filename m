From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Dec 2014 23:17:01 -0200
Subject: [PATCH] arm64: Provide a namespace to NCAPS
Message-ID: <1417655821-22892-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Building arm64.allmodconfig leads to the following warning:

usb/gadget/function/f_ncm.c:203:0: warning: "NCAPS" redefined
 #define NCAPS (USB_CDC_NCM_NCAP_ETH_FILTER | USB_CDC_NCM_NCAP_CRC_MODE)
 ^
In file included from /home/build/work/batch/arch/arm64/include/asm/io.h:32:0,
                 from /home/build/work/batch/include/linux/clocksource.h:19,
                 from /home/build/work/batch/include/clocksource/arm_arch_timer.h:19,
                 from /home/build/work/batch/arch/arm64/include/asm/arch_timer.h:27,
                 from /home/build/work/batch/arch/arm64/include/asm/timex.h:19,
                 from /home/build/work/batch/include/linux/timex.h:65,
                 from /home/build/work/batch/include/linux/sched.h:19,
                 from /home/build/work/batch/arch/arm64/include/asm/compat.h:25,
                 from /home/build/work/batch/arch/arm64/include/asm/stat.h:23,
                 from /home/build/work/batch/include/linux/stat.h:5,
                 from /home/build/work/batch/include/linux/module.h:10,
                 from /home/build/work/batch/drivers/usb/gadget/function/f_ncm.c:19:
arch/arm64/include/asm/cpufeature.h:27:0: note: this is the location of the previous definition
 #define NCAPS     2

So add a ARM64 prefix to avoid such problem.

Reported-by: Olof's autobuilder <build@lixom.net>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm64/include/asm/cpufeature.h | 10 +++++-----
 arch/arm64/kernel/setup.c           |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 0362f80..07547cc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -24,11 +24,11 @@
 #define ARM64_WORKAROUND_CLEAN_CACHE		0
 #define ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE	1
 
-#define NCAPS					2
+#define ARM64_NCAPS				2
 
 #ifndef __ASSEMBLY__
 
-extern DECLARE_BITMAP(cpu_hwcaps, NCAPS);
+extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
 static inline bool cpu_have_feature(unsigned int num)
 {
@@ -37,16 +37,16 @@ static inline bool cpu_have_feature(unsigned int num)
 
 static inline bool cpus_have_cap(unsigned int num)
 {
-	if (num >= NCAPS)
+	if (num >= ARM64_NCAPS)
 		return false;
 	return test_bit(num, cpu_hwcaps);
 }
 
 static inline void cpus_set_cap(unsigned int num)
 {
-	if (num >= NCAPS)
+	if (num >= ARM64_NCAPS)
 		pr_warn("Attempt to set an illegal CPU capability (%d >= %d)\n",
-			num, NCAPS);
+			num, ARM64_NCAPS);
 	else
 		__set_bit(num, cpu_hwcaps);
 }
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 1de0e8a..b809911 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -80,7 +80,7 @@ unsigned int compat_elf_hwcap __read_mostly = COMPAT_ELF_HWCAP_DEFAULT;
 unsigned int compat_elf_hwcap2 __read_mostly;
 #endif
 
-DECLARE_BITMAP(cpu_hwcaps, NCAPS);
+DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
 static const char *cpu_name;
 phys_addr_t __fdt_pointer __initdata;
-- 
1.9.1
