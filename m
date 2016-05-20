From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 May 2016 10:55:15 +0100
Subject: [PATCH] arm64: cpuinfo: add AArch64 & elf platform for app
 compatibility
In-Reply-To: <573E8300.7060106@hisilicon.com>
References: <1463625873-60016-1-git-send-email-saberlily.xia@hisilicon.com>
 <20160519104925.GL22378@e104818-lin.cambridge.arm.com>
 <573D9E40.4000705@hisilicon.com>
 <20160519125039.GN22378@e104818-lin.cambridge.arm.com>
 <20160519131832.GO22378@e104818-lin.cambridge.arm.com>
 <573E8300.7060106@hisilicon.com>
Message-ID: <20160520095515.GC11974@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2016 at 11:22:40AM +0800, Xiaqing (A) wrote:
> ? 2016/5/19 21:18, Catalin Marinas ??:
> >diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> >index 3808470486f3..6bda9d30a769 100644
> >--- a/arch/arm64/kernel/cpuinfo.c
> >+++ b/arch/arm64/kernel/cpuinfo.c
> >@@ -22,6 +22,7 @@
> >
> >  #include <linux/bitops.h>
> >  #include <linux/bug.h>
> >+#include <linux/elf.h>
> >  #include <linux/init.h>
> >  #include <linux/kernel.h>
> >  #include <linux/personality.h>
> >@@ -104,6 +105,8 @@ static const char *const compat_hwcap2_str[] = {
> >  static int c_show(struct seq_file *m, void *v)
> >  {
> >  	int i, j;
> >+	bool compat = is_compat_task() ||
> >+		personality(current->personality) == PER_LINUX32;
> >
> >  	for_each_online_cpu(i) {
> >  		struct cpuinfo_arm64 *cpuinfo = &per_cpu(cpu_data, i);
> >@@ -115,6 +118,9 @@ static int c_show(struct seq_file *m, void *v)
> >  		 * "processor".  Give glibc what it expects.
> >  		 */
> >  		seq_printf(m, "processor\t: %d\n", i);
> >+		if (compat)
> >+			seq_printf(m, "model name\t: ARMv8 Processor rev %d (%s)\n",
> >+				   MIDR_REVISION(midr), COMPAT_ELF_PLATFORM);
> >
> >  		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
> >  			   loops_per_jiffy / (500000UL/HZ),
> >@@ -127,7 +133,7 @@ static int c_show(struct seq_file *m, void *v)
> >  		 * software which does already (at least for 32-bit).
> >  		 */
> >  		seq_puts(m, "Features\t:");
> >-		if (personality(current->personality) == PER_LINUX32) {
> >+		if (compat) {
> >  #ifdef CONFIG_COMPAT
> >  			for (j = 0; compat_hwcap_str[j]; j++)
> >  				if (compat_elf_hwcap & (1 << j))
> >------------------8<---------------------
> >
> >With the above, a compat task or a native one with PER_LINUX32
> >personality would get:
> >
> >processor       : 0
> >model name      : ARMv8 Processor rev 0 (v8l)
> >BogoMIPS        : 100.00
> >Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpv4 idiva idivt lpae evtstrm aes pmull sha1 sha2 crc32
> >CPU implementer : 0x41
> >CPU architecture: 8
> >CPU variant     : 0x0
> >CPU part        : 0xd03
> >CPU revision    : 0
> 
> I have tested with your patch, the app still can not start up at all.
> 
> I'm sorry I didn't explan this exactly before, those apps are 32-bit android
> apps(com.tencent.pao etc.). They want to get the information as
>   "*D m3e : GetCPUType:AArch64 Processor rev 0 (aarch64)*"
> and I'm sure the process is forked by zygote not zygote64 in android M.

So, these 32-bit applications would never run on an arm32 kernel
(because with my patch, compat /proc/cpuinfo is the same as the native
arm32 kernel)? How did they get into this situation?

I recall from some past discussions with Google on this aspect that
there are indeed applications parsing /proc/cpuinfo but the 32-bit
zygote would set PER_LINUX32 so that child processes would inherit it
and always get the compat /proc/cpuinfo. I don't follow the Android
developments, so I can't tell whether this personality setting is in
place.

While we did change the /proc/cpuinfo 64-bit format slightly in 3.19, I
find it insane that there are 32-bit applications relying on always
running under a 64-bit kernel.

-- 
Catalin
