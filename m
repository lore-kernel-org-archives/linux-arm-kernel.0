From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:09 +0300
Subject: [PATCH v5 12/23] arm64:ilp32: COMPAT_USE_64BIT_TIME is true for ILP32
 tasks
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-13-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

Since __kernel_long_t (time_t) is long long, we need to tell the rest of
kernel that we use 64bit time_t for compat when the task is not an
AARCH32 task.  The reason why we check AARCH32 rather than ILP32 here is
because if we don't have AARCH32 compiled in (which is going to be the
common case due to AARCH32 requiring 4k pages).

Stricly speaking, a 'long long' time_t is not standards-compliant
(refer to https://sourceware.org/bugzilla/show_bug.cgi?id=16437 for
details), but there is precedent (i.e. x32) for such an implementation both
in the kernel and in glibc.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index f53c4e6..4b717df 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -76,6 +76,9 @@ struct compat_timeval {
 	s32		tv_usec;
 };
 
+/* ILP32 uses 64bit time_t and not the above compat structures */
+#define COMPAT_USE_64BIT_TIME !is_a32_compat_task()
+
 struct compat_stat {
 #ifdef __AARCH64EB__
 	short		st_dev;
-- 
2.1.4
