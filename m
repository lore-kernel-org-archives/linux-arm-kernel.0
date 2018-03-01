From: alex.shi@linaro.org (Alex Shi)
Date: Thu,  1 Mar 2018 20:53:45 +0800
Subject: [PATCH 08/45] arm64: uaccess: consistently check object sizes
In-Reply-To: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519908862-11425-9-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

commit 76624175dca upstream.

Currently in arm64's copy_{to,from}_user, we only check the
source/destination object size if access_ok() tells us the user access
is permissible.

However, in copy_from_user() we'll subsequently zero any remainder on
the destination object. If we failed the access_ok() check, that applies
to the whole object size, which we didn't check.

To ensure that we catch that case, this patch hoists check_object_size()
to the start of copy_from_user(), matching __copy_from_user() and
__copy_to_user(). To make all of our uaccess copy primitives consistent,
the same is done to copy_to_user().

Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 94e1457..09c9b59 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -326,9 +326,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 {
 	unsigned long res = n;
 	kasan_check_write(to, n);
+	check_object_size(to, n, false);
 
 	if (access_ok(VERIFY_READ, from, n)) {
-		check_object_size(to, n, false);
 		res = __arch_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -339,9 +339,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 static inline unsigned long __must_check copy_to_user(void __user *to, const void *from, unsigned long n)
 {
 	kasan_check_read(from, n);
+	check_object_size(from, n, true);
 
 	if (access_ok(VERIFY_WRITE, to, n)) {
-		check_object_size(from, n, true);
 		n = __arch_copy_to_user(to, from, n);
 	}
 	return n;
-- 
2.7.4
