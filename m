From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Jun 2018 13:53:19 +0200
Subject: [PATCH] ARM: rpc: use designated initializers in ecard_default_ops
Message-ID: <20180605115330.1733640-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When the randstruct plugin is enabled, we get a warning about the
use of traditional struct initializers for this structure, which
results in incorrect behavior:

arch/arm/mach-rpc/ecard.c:416:2: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
  ecard_def_irq_enable,
  ^~~~~~~~~~~~~~~~~~~~
arch/arm/mach-rpc/ecard.c:416:2: note: (near initialization for 'ecard_default_ops')
arch/arm/mach-rpc/ecard.c:416:2: error: invalid initializer
arch/arm/mach-rpc/ecard.c:416:2: note: (near initialization for 'ecard_default_ops.<anonymous>')
arch/arm/mach-rpc/ecard.c:417:2: error: positional initialization of field in 'struct' declared with 'designated_init' attribute [-Werror=designated-init]
  ecard_def_irq_disable,
  ^~~~~~~~~~~~~~~~~~~~~

This changes it to use designated initializers like we do for all
other structures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-rpc/ecard.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 39aef4876ed4..d0c4e20de4f3 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -413,12 +413,12 @@ static int ecard_def_fiq_pending(ecard_t *ec)
 }
 
 static expansioncard_ops_t ecard_default_ops = {
-	ecard_def_irq_enable,
-	ecard_def_irq_disable,
-	ecard_def_irq_pending,
-	ecard_def_fiq_enable,
-	ecard_def_fiq_disable,
-	ecard_def_fiq_pending
+	.irqenable  = ecard_def_irq_enable,
+	.irqdisable = ecard_def_irq_disable,
+	.irqpending = ecard_def_irq_pending,
+	.fiqenable  = ecard_def_fiq_enable,
+	.fiqdisable = ecard_def_fiq_disable,
+	.fiqpending = ecard_def_fiq_pending
 };
 
 /*
-- 
2.9.0
