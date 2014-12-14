From: mst@redhat.com (Michael S. Tsirkin)
Date: Sun, 14 Dec 2014 18:52:09 +0200
Subject: [PATCH 03/18] arm64/uaccess: fix sparse errors
In-Reply-To: <1418575877-21488-1-git-send-email-mst@redhat.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
Message-ID: <1418575877-21488-4-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virtio wants to read bitwise types from userspace using get_user.  At the
moment this triggers sparse errors, since the value is passed through an
integer.

Fix that up using __force.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
