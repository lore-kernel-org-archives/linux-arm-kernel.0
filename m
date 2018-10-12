From: bp@alien8.de (Borislav Petkov)
Date: Fri, 12 Oct 2018 20:10:01 +0200
Subject: [PATCH v6 05/18] ACPI / APEI: Make estatus queue a Kconfig symbol
In-Reply-To: <52228145-f024-0ee1-01c7-da92023d53cc@arm.com>
References: <20180921221705.6478-1-james.morse@arm.com>
 <20180921221705.6478-6-james.morse@arm.com>
 <20181001175956.GF7269@zn.tnic>
 <a562d7c4-2e74-3a18-7fb0-ba8f40d2dce4@arm.com>
 <20181004173416.GC5149@zn.tnic>
 <52228145-f024-0ee1-01c7-da92023d53cc@arm.com>
Message-ID: <20181012181001.GF12328@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 06:17:48PM +0100, James Morse wrote:
> Ripping out the existing #ifdefs and replacing them with IS_ENABLED() would let
> the compiler work out the estatus stuff is unused, and saves us describing the
> what-uses-it logic in Kconfig.
> 
> But this does expose the x86 nmi stuff on arm64, which doesn't build today.

Gah, that ifdeffery is one big mess. ;-\

One fine day...

> Dragging NMI_HANDLED and friends up to the 'linux' header causes a fair amount
> of noise under arch/x86 (include the new header in 22 files). Adding dummy
> declarations to arm64 fixes this, and doesn't affect the other architectures
> that have an asm/nmi.h
> 
> Alternatively we could leave {un,}register_nmi_handler() under
> CONFIG_HAVE_ACPI_APEI_NMI. I think we need to keep the NOTIFY_NMI kconfig symbol
> around, as its one of the two I can't work out how to fix without the TLBI-IPI.

Hmm, so I just tried the diff below with my arm64 cross compiler and a
defconfig with

CONFIG_ACPI_APEI_GHES=y
CONFIG_EDAC_GHES=y

and it did build fine. What am I missing?

---
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 2b191e09b647..52ae5438edeb 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -4,7 +4,6 @@ config HAVE_ACPI_APEI
 
 config HAVE_ACPI_APEI_NMI
 	bool
-	select ACPI_APEI_GHES_ESTATUS_QUEUE
 
 config ACPI_APEI
 	bool "ACPI Platform Error Interface (APEI)"
@@ -34,10 +33,6 @@ config ACPI_APEI_GHES
 	  by firmware to produce more valuable hardware error
 	  information for Linux.
 
-config ACPI_APEI_GHES_ESTATUS_QUEUE
-	bool
-	depends on ACPI_APEI_GHES && ARCH_HAVE_NMI_SAFE_CMPXCHG
-
 config ACPI_APEI_PCIEAER
 	bool "APEI PCIe AER logging/recovering support"
 	depends on ACPI_APEI && PCIEAER
@@ -48,7 +43,6 @@ config ACPI_APEI_PCIEAER
 config ACPI_APEI_SEA
 	bool "APEI Synchronous External Abort logging/recovering support"
 	depends on ARM64 && ACPI_APEI_GHES
-	select ACPI_APEI_GHES_ESTATUS_QUEUE
 	default y
 	help
 	  This option should be enabled if the system supports
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 463c8e6d1bb5..8191d711564b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -683,7 +683,6 @@ static void ghes_estatus_cache_add(
 	rcu_read_unlock();
 }
 
-#ifdef CONFIG_ACPI_APEI_GHES_ESTATUS_QUEUE
 /*
  * Handlers for CPER records may not be NMI safe. For example,
  * memory_failure_queue() takes spinlocks and calls schedule_work_on().
@@ -862,10 +861,6 @@ static void ghes_nmi_init_cxt(void)
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
 }
 
-#else
-static inline void ghes_nmi_init_cxt(void) { }
-#endif /* CONFIG_ACPI_APEI_GHES_ESTATUS_QUEUE */
-
 static int ghes_ack_error(struct acpi_hest_generic_v2 *gv2)
 {
 	int rc;


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
