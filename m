From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 16 May 2013 14:11:19 +0300
Subject: [PATCH v2 05/10] microblaze: uaccess s/might_sleep/might_fault/
In-Reply-To: <cover.1368702323.git.mst@redhat.com>
References: <cover.1368702323.git.mst@redhat.com>
Message-ID: <b6ae099df81bf07ad812189a0fe83ae3ebde9306.1368702323.git.mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason uaccess routines might sleep
is if they fault. Make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/microblaze/include/asm/uaccess.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index efe59d8..2fc8bf7 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -145,7 +145,7 @@ static inline unsigned long __must_check __clear_user(void __user *to,
 static inline unsigned long __must_check clear_user(void __user *to,
 							unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (unlikely(!access_ok(VERIFY_WRITE, to, n)))
 		return n;
 
@@ -371,7 +371,7 @@ extern long __user_bad(void);
 static inline long copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (access_ok(VERIFY_READ, from, n))
 		return __copy_from_user(to, from, n);
 	return n;
@@ -385,7 +385,7 @@ static inline long copy_from_user(void *to,
 static inline long copy_to_user(void __user *to,
 		const void *from, unsigned long n)
 {
-	might_sleep();
+	might_fault();
 	if (access_ok(VERIFY_WRITE, to, n))
 		return __copy_to_user(to, from, n);
 	return n;
-- 
MST
