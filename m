From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jan 2010 19:36:41 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v3)
In-Reply-To: <000001ca8f05$2fbb4150$8f31c3f0$@lindholm@arm.com>
References: <20100105182447.5374.79579.stgit@e101986-lin>
	<20100105194328.GG14376@shareable.org>
	<000001ca8f05$2fbb4150$8f31c3f0$@lindholm@arm.com>
Message-ID: <20100106193641.GD1728@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2010 at 07:19:36PM -0000, Leif Lindholm wrote:
> Good point, will do that in the next version.
>  
> > > +#ifndef CONFIG_ALIGNMENT_TRAP
> > > +	res = proc_mkdir("cpu", NULL);
> 
> > ?  Is that to work with different kernel versions?
> 
> It's to ensure it would work (without console warnings) even if someone
> decides to disable ALIGNMENT_TRAP. An alternative would be to strip the
> creation of /proc/cpu out from mm/alignment.c and put it somewhere else
> (or move the stats file somewhere else - but it seemed logical to group
> with /proc/alignment).

As I said when you previously posted this patch, that's definitely on
the cards.  In fact, I'm about to commit the following patch for doing
exactly this.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 233a222..faeee3e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -50,6 +50,9 @@ config HAVE_TCM
 	bool
 	select GENERIC_ALLOCATOR
 
+config HAVE_PROC_CPU
+	bool
+
 config NO_IOPORT
 	bool
 
@@ -1226,6 +1229,7 @@ config ALIGNMENT_TRAP
 	bool
 	depends on CPU_CP15_MMU
 	default y if !ARCH_EBSA110
+	select HAVE_PROC_CPU if PROC_FS
 	help
 	  ARM processors cannot fetch/store information which is not
 	  naturally aligned on the bus, i.e., a 4 byte fetch must start at an
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c6c57b6..5357e48 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/smp.h>
 #include <linux/fs.h>
+#include <linux/proc_fs.h>
 
 #include <asm/unified.h>
 #include <asm/cpu.h>
@@ -782,9 +783,21 @@ static int __init topology_init(void)
 
 	return 0;
 }
-
 subsys_initcall(topology_init);
 
+#ifdef CONFIG_HAVE_PROC_CPU
+static int __init proc_cpu_init(void)
+{
+	struct proc_dir_entry *res;
+
+	res = proc_mkdir("cpu", NULL);
+	if (!res)
+		return -ENOMEM;
+	return 0;
+}
+fs_initcall(proc_cpu_init);
+#endif
+
 static const char *hwcap_str[] = {
 	"swp",
 	"half",
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index b270d62..0c5eb69 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -898,11 +898,7 @@ static int __init alignment_init(void)
 #ifdef CONFIG_PROC_FS
 	struct proc_dir_entry *res;
 
-	res = proc_mkdir("cpu", NULL);
-	if (!res)
-		return -ENOMEM;
-
-	res = create_proc_entry("alignment", S_IWUSR | S_IRUGO, res);
+	res = create_proc_entry("cpu/alignment", S_IWUSR | S_IRUGO, NULL);
 	if (!res)
 		return -ENOMEM;
 
