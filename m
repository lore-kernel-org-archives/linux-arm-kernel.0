From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu, 13 Oct 2011 16:43:10 +0100
Subject: [PATCH v3.1-rc9] ARM: populate processor tag in proc-cpuinfo for
	Uni-processor.
Message-ID: <1318520590-24372-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch populates processor tag in /proc/cpuinfo for uni-processor too.
All the processors in kernel code do that.

Without this patch tools like cyclesoak which use processor tag to determine number of
cpus will be broken.

run cyclesoak -C on uniprocessor system to reproduce.

originally detected as part of 
https://bugzilla.stlinux.com/show_bug.cgi?id=14674 triage.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
Signed-off-by: Chris Smith <chris.smith@st.com>
---
Hi All, 
We recently encountered issue while running cyclesoak on ARM-uniprocessor system, 
What we have noticed it that /proc/cpuinfo does not have "processor" tag when its uniprocessor, which looked incorrect.
All the processors code in kernel do populate this tag for both uni and multi processor systems.

This patch just add processor tag for cpuinfo for ARM uni-processor systems.

Thanks,
srini



 arch/arm/kernel/setup.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 621acad..4364071 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -807,7 +807,7 @@ static const char *hwcap_str[] = {
 
 static int c_show(struct seq_file *m, void *v)
 {
-	int i;
+	int i = 0;
 
 	seq_printf(m, "Processor\t: %s rev %d (%s)\n",
 		   cpu_name, read_cpuid_id() & 15, elf_platform);
@@ -825,6 +825,7 @@ static int c_show(struct seq_file *m, void *v)
 			   (per_cpu(cpu_data, i).loops_per_jiffy / (5000UL/HZ)) % 100);
 	}
 #else /* CONFIG_SMP */
+	seq_printf(m, "processor\t: %d\n", i);
 	seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 		   loops_per_jiffy / (500000/HZ),
 		   (loops_per_jiffy / (5000/HZ)) % 100);
-- 
1.6.3.3
