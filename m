From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  6 Sep 2018 17:38:08 +0100
Subject: [PATCH v2 9/9] ARM: spectre-v1.1: harden __copy_to_user
In-Reply-To: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
References: <1536251888-8302-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1536251888-8302-10-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sanitize user pointer given to __copy_to_user, both for standard version
and memcopy version of the user accessor.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/arm/lib/copy_to_user.S        | 6 +++++-
 arch/arm/lib/uaccess_with_memcpy.c | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index caf5019..970abe5 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -94,6 +94,11 @@
 
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
+#ifdef CONFIG_CPU_SPECTRE
+	get_thread_info r3
+	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	uaccess_mask_range_ptr r0, r2, r3, ip
+#endif
 
 #include "copy_template.S"
 
@@ -108,4 +113,3 @@ ENDPROC(__copy_to_user_std)
 	rsb	r0, r0, r2
 	copy_abort_end
 	.popsection
-
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 9b4ed17..73dc736 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -152,7 +152,8 @@
 		n = __copy_to_user_std(to, from, n);
 		uaccess_restore(ua_flags);
 	} else {
-		n = __copy_to_user_memcpy(to, from, n);
+		n = __copy_to_user_memcpy(uaccess_mask_range_ptr(to, n),
+					  from, n);
 	}
 	return n;
 }
-- 
1.9.1
