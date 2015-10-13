From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Oct 2015 12:51:45 +0100
Subject: [PATCH v2 17/17] irqdomain: Documentation updates
In-Reply-To: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
References: <1444737105-31573-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1444737105-31573-18-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the IRQ domain documentation to reflect the changes made
while divorcing the domain infrastructure from Device Tree.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/IRQ-domain.txt |  9 +++++----
 include/linux/irqdomain.h    | 23 ++++++++++-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/Documentation/IRQ-domain.txt b/Documentation/IRQ-domain.txt
index 3a8e15c..c9af908 100644
--- a/Documentation/IRQ-domain.txt
+++ b/Documentation/IRQ-domain.txt
@@ -32,9 +32,9 @@ top of the irq_alloc_desc*() API.  An irq_domain to manage mapping is
 preferred over interrupt controller drivers open coding their own
 reverse mapping scheme.
 
-irq_domain also implements translation from Device Tree interrupt
-specifiers to hwirq numbers, and can be easily extended to support
-other IRQ topology data sources.
+irq_domain also implements translation from an abstract irq_fwspec
+structure to hwirq numbers (Device Tree and ACPI GSI so far), and can
+be easily extended to support other IRQ topology data sources.
 
 === irq_domain usage ===
 An interrupt controller driver creates and registers an irq_domain by
@@ -184,7 +184,7 @@ There are four major interfaces to use hierarchy irq_domain:
    related resources associated with these interrupts.
 3) irq_domain_activate_irq(): activate interrupt controller hardware to
    deliver the interrupt.
-3) irq_domain_deactivate_irq(): deactivate interrupt controller hardware
+4) irq_domain_deactivate_irq(): deactivate interrupt controller hardware
    to stop delivering the interrupt.
 
 Following changes are needed to support hierarchy irq_domain.
@@ -221,3 +221,4 @@ needs to:
 
 Hierarchy irq_domain may also be used to support other architectures,
 such as ARM, ARM64 etc.
+
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2b3340ae..d5e5c5b 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -5,9 +5,10 @@
  * helpful for interrupt controllers to implement mapping between hardware
  * irq numbers and the Linux irq number space.
  *
- * irq_domains also have a hook for translating device tree interrupt
- * representation into a hardware irq number that can be mapped back to a
- * Linux irq number without any extra platform support code.
+ * irq_domains also have hooks for translating device tree or other
+ * firmware interrupt representations into a hardware irq number that
+ * can be mapped back to a Linux irq number without any extra platform
+ * support code.
  *
  * Interrupt controller "domain" data structure. This could be defined as a
  * irq domain controller. That is, it handles the mapping between hardware
@@ -17,16 +18,12 @@
  * model). It's the domain callbacks that are responsible for setting the
  * irq_chip on a given irq_desc after it's been mapped.
  *
- * The host code and data structures are agnostic to whether or not
- * we use an open firmware device-tree. We do have references to struct
- * device_node in two places: in irq_find_host() to find the host matching
- * a given interrupt controller node, and of course as an argument to its
- * counterpart domain->ops->match() callback. However, those are treated as
- * generic pointers by the core and the fact that it's actually a device-node
- * pointer is purely a convention between callers and implementation. This
- * code could thus be used on other architectures by replacing those two
- * by some sort of arch-specific void * "token" used to identify interrupt
- * controllers.
+ * The host code and data structures use a fwnode_handle pointer to
+ * identify the domain. In some cases, and in order to preserve source
+ * code compatibility, this fwnode pointer is "upgraded" to a DT
+ * device_node. For those firmware infrastructures that do not provide
+ * a unique identifier for an interrupt controller, the irq_domain
+ * code offers a fwnode allocator.
  */
 
 #ifndef _LINUX_IRQDOMAIN_H
-- 
2.1.4
