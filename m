From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  9 Aug 2018 16:26:37 +0100
Subject: [PATCH 2/8] ARM: spectre-v1.1: force address sanitizing for
 __put_user*()
In-Reply-To: <1533828403-21323-1-git-send-email-julien.thierry@arm.com>
References: <1533828403-21323-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1533828403-21323-3-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Spectre mitigation is required, define __put_user() and
__put_user_error() to include check_uaccess, ensuring user address
is sanitized.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/uaccess.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index d65ef85..2e18b91 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -370,6 +370,20 @@ static inline void set_fs(mm_segment_t fs)
 	__pu_err;							\
 })

+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1.1, all accessors need to include
+ * verification of the address space.
+ */
+#define __put_user(x, ptr) put_user(x, ptr)
+
+#define __put_user_error(x, ptr, err)					\
+({									\
+	__put_user_switch((x), (ptr), (err), __put_user_check);		\
+	(void) 0;							\
+})
+
+#else
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
@@ -462,6 +476,7 @@ static inline void set_fs(mm_segment_t fs)
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")

+#endif /* !CONFIG_CPU_SPECTRE */

 #ifdef CONFIG_MMU
 extern unsigned long __must_check
--
1.9.1
