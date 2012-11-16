From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 16 Nov 2012 15:42:13 -0500 (EST)
Subject: [RFC PATCH v2 2/2] ARM: kernel: update cpuinfo to print all
 online CPUs features
In-Reply-To: <alpine.LFD.2.02.1211161229190.1238@xanadu.home>
References: <1353066105-19486-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1353066105-19486-3-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.02.1211161229190.1238@xanadu.home>
Message-ID: <alpine.LFD.2.02.1211161534220.1238@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Nov 2012, Nicolas Pitre wrote:

> On Fri, 16 Nov 2012, Lorenzo Pieralisi wrote:
> 
> > Currently, reading /proc/cpuinfo provides userspace with CPU ID of
> > the CPU carrying out the read from the file. This is fine as long as all
> > CPUs in the system are the same. With the advent of big.LITTLE and
> > heterogenous ARM systems this approach provides user space with incorrect
> > bits of information since CPU ids in the system might differ from the one
> > provided by the CPU reading the file.
> > 
> > This patch updates the cpuinfo show function so that a read from
> > /proc/cpuinfo prints HW information for all online CPUs at once, mirroring
> >  x86 behaviour.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Sorry, let me take this back.  There are a few issues with the output.

First, the "processor" line is doubled for each core.  If glibc actually 
looks at those lines to determine the number of CPUs like the nearby 
comment says then it'll get twice the actual number of processors.

And then, there is an annoying empty line between the BogoMIPS line and 
the rest of the information for each core.

So, I'd suggest folding this into your patch, with my ACK of course.

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 53e532704c..bfa673de9e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -859,18 +859,18 @@ static int c_show(struct seq_file *m, void *v)
 	u32 cpuid;
 
 	for_each_online_cpu(i) {
-		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
-		seq_printf(m, "Processor\t: %s rev %d (%s)\n",
-			   cpu_name, cpuid & 15, elf_platform);
-
-#if defined(CONFIG_SMP)
 		/*
 		 * glibc reads /proc/cpuinfo to determine the number of
 		 * online processors, looking for lines beginning with
 		 * "processor".  Give glibc what it expects.
 		 */
 		seq_printf(m, "processor\t: %d\n", i);
-		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n\n",
+		cpuid = is_smp() ? per_cpu(cpu_data, i).cpuid : read_cpuid_id();
+		seq_printf(m, "model name\t: %s rev %d (%s)\n",
+			   cpu_name, cpuid & 15, elf_platform);
+
+#if defined(CONFIG_SMP)
+		seq_printf(m, "BogoMIPS\t: %lu.%02lu\n",
 			   per_cpu(cpu_data, i).loops_per_jiffy / (500000UL/HZ),
 			   (per_cpu(cpu_data, i).loops_per_jiffy / (5000UL/HZ)) % 100);
 #else


Nicolas
