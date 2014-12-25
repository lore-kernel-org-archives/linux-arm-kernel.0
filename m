From: mst@redhat.com (Michael S. Tsirkin)
Date: Thu, 25 Dec 2014 11:28:41 +0200
Subject: [PATCH repost 03/16] arm64/uaccess: fix sparse errors
In-Reply-To: <1419499661-8566-1-git-send-email-mst@redhat.com>
References: <1419499661-8566-1-git-send-email-mst@redhat.com>
Message-ID: <1419499661-8566-4-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3bf8f4e..8d66bcf 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -147,7 +147,7 @@ do {									\
 	default:							\
 		BUILD_BUG();						\
 	}								\
-	(x) = (__typeof__(*(ptr)))__gu_val;				\
+	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 } while (0)
 
 #define __get_user(x, ptr)						\
-- 
MST
