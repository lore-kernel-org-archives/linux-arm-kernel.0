From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 23 Dec 2009 13:43:12 -0500
Subject: [PATCH 1/2] arm: add /proc/cpuinfo extension core support
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200F378@mi8nycmail19.Mi8.com>
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
index c6c57b6..ef050fd 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -695,6 +695,8 @@ static int __init customize_machine(void)
 }
 arch_initcall(customize_machine);
 
+static void (*arch_cpuinfo)(struct seq_file *m, void *v);
+
 void __init setup_arch(char **cmdline_p)
 {
 	struct tag *tags = (struct tag *)&init_tags;
@@ -758,6 +760,7 @@ void __init setup_arch(char **cmdline_p)
 	init_arch_irq = mdesc->init_irq;
 	system_timer = mdesc->timer;
 	init_machine = mdesc->init_machine;
+	arch_cpuinfo = mdesc->arch_cpuinfo;
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
@@ -864,6 +867,12 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "Serial\t\t: %08x%08x\n",
 		   system_serial_high, system_serial_low);
 
+	/* dump out any architecture specific features */
+	if (arch_cpuinfo) {
+		seq_puts(m, "\n");
+		arch_cpuinfo(m, v);
+	}
+
 	return 0;
 }
  
