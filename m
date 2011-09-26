From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 26 Sep 2011 15:32:39 +0100
Subject: [RFC PATCH 1/3] ARM: mm: add outercache resume hook
In-Reply-To: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1317047561-11020-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1317047561-11020-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to support L2 resume functions in a generic way in the kernel, this
patch adds a resume hook to the outercache layer and a simple wrapper
to simplify the function pointer check and the resume function call.

Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Barry Song <Baohua.Song@csr.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/include/asm/outercache.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index d838743..1b70d86 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -34,6 +34,7 @@ struct outer_cache_fns {
 	void (*sync)(void);
 #endif
 	void (*set_debug)(unsigned long);
+	void (*resume)(void);
 };
 
 #ifdef CONFIG_OUTER_CACHE
@@ -74,6 +75,11 @@ static inline void outer_disable(void)
 		outer_cache.disable();
 }
 
+static inline void outer_resume(void)
+{
+	if (outer_cache.resume)
+		outer_cache.resume();
+}
 #else
 
 static inline void outer_inv_range(phys_addr_t start, phys_addr_t end)
@@ -86,6 +92,7 @@ static inline void outer_flush_all(void) { }
 static inline void outer_inv_all(void) { }
 static inline void outer_disable(void) { }
 
+static inline void outer_resume(void) { }
 #endif
 
 #ifdef CONFIG_OUTER_CACHE_SYNC
-- 
1.7.4.4
