From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sun, 13 Oct 2013 14:15:03 +0200
Subject: [RFC v3 PATCH 7/7] lib/raid6: port NEON implementation to updated
 kmode NEON api
In-Reply-To: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381666503-23726-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381666503-23726-8-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 lib/raid6/neon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/raid6/neon.c b/lib/raid6/neon.c
index 36ad470..172b53f 100644
--- a/lib/raid6/neon.c
+++ b/lib/raid6/neon.c
@@ -13,8 +13,8 @@
 #ifdef __KERNEL__
 #include <asm/neon.h>
 #else
-#define kernel_neon_begin()
-#define kernel_neon_end()
+#define kernel_neon_begin(s)
+#define kernel_neon_end(s)
 #define cpu_has_neon()		(1)
 #endif
 
@@ -33,12 +33,13 @@
 	static void raid6_neon ## _n ## _gen_syndrome(int disks,	\
 					size_t bytes, void **ptrs)	\
 	{								\
+		DEFINE_NEON_REGSTACK(s);				\
 		void raid6_neon ## _n  ## _gen_syndrome_real(int,	\
 						unsigned long, void**);	\
-		kernel_neon_begin();					\
+		kernel_neon_begin(s);					\
 		raid6_neon ## _n ## _gen_syndrome_real(disks,		\
 					(unsigned long)bytes, ptrs);	\
-		kernel_neon_end();					\
+		kernel_neon_end(s);					\
 	}								\
 	struct raid6_calls const raid6_neonx ## _n = {			\
 		raid6_neon ## _n ## _gen_syndrome,			\
-- 
1.8.1.2
