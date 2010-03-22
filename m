From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 22 Mar 2010 13:38:48 -0500
Subject: [PATCH 1/3] arm: add /proc/cpuinfo extension core support
Message-ID: <0D753D10438DA54287A00B02708426976368DDCD35@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the necessary core support to allow a platform specific
callback to /proc/cpuinfo.

All platform specific data is dumped after the normal /proc/cpuinfo
information and will not effect glibc or other parsers of this file.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>

---

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index c59842d..ca8bd71 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -13,6 +13,7 @@
 struct tag;
 struct meminfo;
 struct sys_timer;
+struct seq_file;
 
 struct machine_desc {
 	/*
@@ -41,6 +42,7 @@ struct machine_desc {
 	void			(*init_irq)(void);
 	struct sys_timer	*timer;		/* system tick timer	*/
 	void			(*init_machine)(void);
+	void			(*arch_cpuinfo)(struct seq_file *m, void *v);
 };
 
 /*
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index c91c77b..9092978 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -661,6 +661,8 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
+static void (*arch_cpuinfo)(struct seq_file *m, void *v);
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
@@ -730,6 +732,7 @@ void __init setup_arch(char **cmdline_p)
 	init_arch_irq = mdesc->init_irq;
 	system_timer = mdesc->timer;
 	init_machine = mdesc->init_machine;
+	arch_cpuinfo = mdesc->arch_cpuinfo;
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
@@ -848,6 +851,10 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "Serial\t\t: %08x%08x\n",
 		   system_serial_high, system_serial_low);
 
+	/* dump out any architecture specific features */
+	if (arch_cpuinfo)
+		arch_cpuinfo(m, v);
+
 	return 0;
 }
 
