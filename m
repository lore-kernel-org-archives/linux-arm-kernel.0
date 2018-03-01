From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:52 +0800
Subject: [PATCH 15/45] arm64: uaccess: Mask __user pointers for __arch_{clear,
 copy_*}_user
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-16-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Rewritting from commit f71c2ffcb20d upstream. On LTS 4.9, there has no
raw_copy_from/to_user, neither __copy_user_flushcache, and it isn't good
idead to pick up them. The following is origin commit log, that's also
applicable for the new patch.

    Like we've done for get_user and put_user, ensure that user pointers
    are masked before invoking the underlying __arch_{clear,copy_*}_user
    operations.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index ffa4e39..fbf4ce4 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -357,14 +357,14 @@ static inline unsigned long __must_check __copy_from_user(void *to, const void _
 {
 	kasan_check_write(to, n);
 	check_object_size(to, n, false);
-	return __arch_copy_from_user(to, from, n);
+	return __arch_copy_from_user(to, __uaccess_mask_ptr(from), n);
 }
 
 static inline unsigned long __must_check __copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
 	check_object_size(from, n, true);
-	return __arch_copy_to_user(to, from, n);
+	return __arch_copy_to_user(__uaccess_mask_ptr(to), from, n);
 }
 
 static inline unsigned long __must_check copy_from_user(void *to, const void __user *from, unsigned long n)
@@ -374,7 +374,7 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 	check_object_size(to, n, false);
 
 	if (access_ok(VERIFY_READ, from, n)) {
-		res = __arch_copy_from_user(to, from, n);
+		res = __arch_copy_from_user(to, __uaccess_mask_ptr(from), n);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
@@ -387,7 +387,7 @@ static inline unsigned long __must_check copy_to_user(void __user *to, const voi
 	check_object_size(from, n, true);
 
 	if (access_ok(VERIFY_WRITE, to, n)) {
-		n = __arch_copy_to_user(to, from, n);
+		n = __arch_copy_to_user(__uaccess_mask_ptr(to), from, n);
 	}
 	return n;
 }
@@ -395,7 +395,7 @@ static inline unsigned long __must_check copy_to_user(void __user *to, const voi
 static inline unsigned long __must_check copy_in_user(void __user *to, const void __user *from, unsigned long n)
 {
 	if (access_ok(VERIFY_READ, from, n) && access_ok(VERIFY_WRITE, to, n))
-		n = __copy_in_user(to, from, n);
+		n = __copy_in_user(__uaccess_mask_ptr(to), __uaccess_mask_ptr(from), n);
 	return n;
 }
 
-- 
2.7.4
