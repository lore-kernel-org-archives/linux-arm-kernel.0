From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 22 Feb 2011 21:26:42 +0100
Subject: [PATCH] ARM: fix build failure
In-Reply-To: <20110222201842.GB31275@n2100.arm.linux.org.uk>
References: <20110222201842.GB31275@n2100.arm.linux.org.uk>
Message-ID: <1298406402-31572-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit

	06824ba (ARM: tlb: delay page freeing for SMP and ARMv7 CPUs)

introduced a build failure for builds with CONFIG_SWAP=n:

	In file included from arch/arm/mm/init.c:27:
	arch/arm/include/asm/tlb.h: In function 'tlb_flush_mmu':
	arch/arm/include/asm/tlb.h:101: error: implicit declaration of function 'release_pages'
	arch/arm/include/asm/tlb.h: In function 'tlb_remove_page':
	arch/arm/include/asm/tlb.h:165: error: implicit declaration of function 'page_cache_release'

Fix that by #including <linux/pagemap.h> in <asm/pgalloc.h> as it's done
by x86.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/include/asm/pgalloc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index 9763be0..22de005 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -10,6 +10,8 @@
 #ifndef _ASMARM_PGALLOC_H
 #define _ASMARM_PGALLOC_H
 
+#include <linux/pagemap.h>
+
 #include <asm/domain.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/processor.h>
-- 
1.7.2.3
