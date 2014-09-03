From: apinski@cavium.com (Andrew Pinski)
Date: Wed,  3 Sep 2014 14:19:06 -0700
Subject: [PATCH 12/24] ARM64:ILP32: COMPAT_USE_64BIT_TIME is true for ILP32
 tasks
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <1409779158-30963-13-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since __kernel_long_t (time_t) is long long, we need to tell the rest of
kernel that we use 64bit time_t for compat when the task is not an
AARCH32 task.  The reason why we check AARCH32 rather than ILP32 here is
because if we don't have AARCH32 compiled in (which is going to be the common case due to AARCH32 requiring 4k pages).

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/compat.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 9082b27..eca6eec 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -76,6 +76,9 @@ struct compat_timeval {
 	s32		tv_usec;
 };
 
+/* ILP32 uses 64bit time_t and not the above compat structures */
+#define COMPAT_USE_64BIT_TIME (!is_a32_compat_task())
+
 struct compat_stat {
 #ifdef __AARCH64EB__
 	short		st_dev;
-- 
1.7.2.5
