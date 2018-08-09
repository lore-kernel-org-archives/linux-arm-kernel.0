From: julien.thierry@arm.com (Julien Thierry)
Date: Thu,  9 Aug 2018 16:26:36 +0100
Subject: [PATCH 1/8] ARM: uaccess: Prevent speculative use of the current
 addr_limit
In-Reply-To: <1533828403-21323-1-git-send-email-julien.thierry@arm.com>
References: <1533828403-21323-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1533828403-21323-2-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Porting commit c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use
of the current addr_limit").

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/include/asm/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 5451e1f..d65ef85 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -69,6 +69,14 @@ static inline void uaccess_restore(unsigned int flags)
 static inline void set_fs(mm_segment_t fs)
 {
 	current_thread_info()->addr_limit = fs;
+
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	modify_domain(DOMAIN_KERNEL, fs ? DOMAIN_CLIENT : DOMAIN_MANAGER);
 }

--
1.9.1
