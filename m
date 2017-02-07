From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  7 Feb 2017 12:33:55 +0000
Subject: [PATCH] arm64: uaccess: consistently check object sizes
Message-ID: <1486470835-25956-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Kees, Was there any rationale for not handling the !access_ok() case?

I note that other architectures follow the same pattern, and may need a similar
fixup.

Thanks,
Mark.

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 46da3ea..5308d69 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -379,9 +379,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
 {
 	unsigned long res = n;
 	kasan_check_write(to, n);
+	check_object_size(to, n, false);
 
 	if (access_ok(VERIFY_READ, from, n)) {
-		check_object_size(to, n, false);
 		res = __arch_copy_from_user(to, from, n);
 	}
 	if (unlikely(res))
@@ -392,9 +392,9 @@ static inline unsigned long __must_check copy_from_user(void *to, const void __u
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
1.9.1
