From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Thu, 28 Apr 2016 10:28:24 +0100
Subject: [PATCH 08/12] kexec: don't invoke OOM-killer for control page
 allocation
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
Message-ID: <E1aviFE-0000jS-UI@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we are unable to find a suitable page when allocating the control
page, do not invoke the OOM-killer: killing processes probably isn't
going to help.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/kexec.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 2cc643c6e870..1b32ab587f66 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -41,7 +41,7 @@
 #endif
 
 #ifndef KEXEC_CONTROL_MEMORY_GFP
-#define KEXEC_CONTROL_MEMORY_GFP GFP_KERNEL
+#define KEXEC_CONTROL_MEMORY_GFP (GFP_KERNEL | __GFP_NORETRY)
 #endif
 
 #ifndef KEXEC_CONTROL_PAGE_SIZE
-- 
2.1.0
