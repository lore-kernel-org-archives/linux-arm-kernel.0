From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 26 May 2013 17:30:42 +0300
Subject: [PATCH v3-resend 02/11] arm64: uaccess s/might_sleep/might_fault/
In-Reply-To: <1369575487-26176-1-git-send-email-mst@redhat.com>
References: <1369575487-26176-1-git-send-email-mst@redhat.com>
Message-ID: <1369577426-26721-2-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The only reason uaccess routines might sleep
is if they fault. Make this explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 008f848..edb3d5c 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -166,7 +166,7 @@ do {									\
 
 #define get_user(x, ptr)						\
 ({									\
-	might_sleep();							\
+	might_fault();							\
 	access_ok(VERIFY_READ, (ptr), sizeof(*(ptr))) ?			\
 		__get_user((x), (ptr)) :				\
 		((x) = 0, -EFAULT);					\
@@ -227,7 +227,7 @@ do {									\
 
 #define put_user(x, ptr)						\
 ({									\
-	might_sleep();							\
+	might_fault();							\
 	access_ok(VERIFY_WRITE, (ptr), sizeof(*(ptr))) ?		\
 		__put_user((x), (ptr)) :				\
 		-EFAULT;						\
-- 
MST
