From: mst@redhat.com (Michael S. Tsirkin)
Date: Tue, 6 Jan 2015 17:44:27 +0200
Subject: [PATCH v2 17/40] arm: fix put_user sparse errors
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Message-ID: <1420558883-10131-18-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

virtio wants to write bitwise types to userspace using put_user.
At the moment this triggers sparse errors, since the value is passed
through an integer.

For example:

	__le32 __user *p;
	__le32 x;
	put_user(x, p);

is safe, but currently triggers a sparse warning.

Fix that up using __force.

Note: this does not suppress any useful sparse checks since caller
assigns x to typeof(*p), which in turn forces all the necessary type
checks.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/arm/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 4767eb9..74fcde7 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -413,14 +413,14 @@ do {									\
 #ifndef __ARMEB__
 #define __put_user_asm_half(x,__pu_addr,err)			\
 ({								\
-	unsigned long __temp = (unsigned long)(x);		\
+	unsigned long __temp = (__force unsigned long)(x);	\
 	__put_user_asm_byte(__temp, __pu_addr, err);		\
 	__put_user_asm_byte(__temp >> 8, __pu_addr + 1, err);	\
 })
 #else
 #define __put_user_asm_half(x,__pu_addr,err)			\
 ({								\
-	unsigned long __temp = (unsigned long)(x);		\
+	unsigned long __temp = (__force unsigned long)(x);	\
 	__put_user_asm_byte(__temp >> 8, __pu_addr, err);	\
 	__put_user_asm_byte(__temp, __pu_addr + 1, err);	\
 })
-- 
MST
