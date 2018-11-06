From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 06 Nov 2018 12:38:34 +0000
Subject: [PATCH 1/5] ARM: make lookup_processor_type() non-__init
In-Reply-To: <20181106123700.GA30658@n2100.armlinux.org.uk>
References: <20181106123700.GA30658@n2100.armlinux.org.uk>
Message-ID: <E1gK0cs-0007In-5g@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move lookup_processor_type() out of the __init section so it is callable
from (eg) the secondary startup code during hotplug.

Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/head-common.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head-common.S b/arch/arm/kernel/head-common.S
index 6e0375e7db05..997b02302c31 100644
--- a/arch/arm/kernel/head-common.S
+++ b/arch/arm/kernel/head-common.S
@@ -145,6 +145,9 @@ ENDPROC(__mmap_switched)
 #endif
 	.size	__mmap_switched_data, . - __mmap_switched_data
 
+	__FINIT
+	.text
+
 /*
  * This provides a C-API version of __lookup_processor_type
  */
@@ -156,9 +159,6 @@ ENTRY(lookup_processor_type)
 	ldmfd	sp!, {r4 - r6, r9, pc}
 ENDPROC(lookup_processor_type)
 
-	__FINIT
-	.text
-
 /*
  * Read processor ID register (CP#15, CR0), and look up in the linker-built
  * supported processor list.  Note that we can't use the absolute addresses
-- 
2.7.4
