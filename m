From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Sun, 7 Feb 2016 19:00:40 -0500
Subject: [PATCH 1/5] ARM: add EXPORT_SYMBOL of hook_fault_code for PCI host
 modularization
In-Reply-To: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <1454889644-27830-2-git-send-email-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a discussion of a previous patch set[1], it was suggested that
modularizing some of the PCI host support would be good to keep
multi platform bzImage sizes smaller.

Two of the files that are candidates for conversion to tristate
from bool are:

drivers/pci/host/pci-imx6.c
drivers/pci/host/pci-keystone.c

However, doing the conversion reveals that they are going to fail
at modpost time since hook_fault_code isn't currently exported.

Since we are now going to export it we also need to remove the
__init tag, as the fcn needs to be present at insmod time.

[1] https://lkml.kernel.org/r/20160108203102.GH5354 at localhost

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Ley Foon Tan <lftan@altera.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/arm/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index daafcf121ce0..e0696a5ecc9b 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -525,7 +525,7 @@ struct fsr_info {
 #include "fsr-2level.c"
 #endif
 
-void __init
+void
 hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *),
 		int sig, int code, const char *name)
 {
@@ -537,6 +537,7 @@ hook_fault_code(int nr, int (*fn)(unsigned long, unsigned int, struct pt_regs *)
 	fsr_info[nr].code = code;
 	fsr_info[nr].name = name;
 }
+EXPORT_SYMBOL(hook_fault_code);
 
 /*
  * Dispatch a data abort to the relevant handler.
-- 
2.6.1
