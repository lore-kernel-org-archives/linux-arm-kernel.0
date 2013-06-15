From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 15 Jun 2013 15:38:56 +0200
Subject: [RFC PATCH] ARM: Add .init_platform() callback to machine descriptor
Message-ID: <1371303536-12250-1-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most ARM platforms have parts that should be initialized as early as
possible, which usually means as soon as memory management (kmalloc,
ioremap) starts to work,

However, currently there is no appropriate callback in machine_desc
struct to use for such initialization and platforms tend to stuff things
up .init_irq() and .init_time() callbacks.

Since all the DT-based platforms are going towards generic IRQ and time
initialization (using irqchip_init and clocksource_of_init) and current
code assumes that if custom callbacks are not provided in machine_desc
then generic ones should be used, this problem has become a bit more
inconvenient.

This patch tries to solve this issue by introducing new callback called
.init_platform(), where any custom low level initialization of platform
can be done safely.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/include/asm/mach/arch.h | 1 +
 arch/arm/kernel/irq.c            | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/mach/arch.h b/arch/arm/include/asm/mach/arch.h
index 75bf079..76ac800 100644
--- a/arch/arm/include/asm/mach/arch.h
+++ b/arch/arm/include/asm/mach/arch.h
@@ -51,6 +51,7 @@ struct machine_desc {
 	void			(*reserve)(void);/* reserve mem blocks	*/
 	void			(*map_io)(void);/* IO mapping function	*/
 	void			(*init_early)(void);
+	void			(*init_platform)(void);
 	void			(*init_irq)(void);
 	void			(*init_time)(void);
 	void			(*init_machine)(void);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 9723d17..61e2000 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -115,6 +115,9 @@ EXPORT_SYMBOL_GPL(set_irq_flags);
 
 void __init init_IRQ(void)
 {
+	if (machine_desc->init_platform)
+		machine_desc->init_platform();
+
 	if (IS_ENABLED(CONFIG_OF) && !machine_desc->init_irq)
 		irqchip_init();
 	else
-- 
1.8.2.1
