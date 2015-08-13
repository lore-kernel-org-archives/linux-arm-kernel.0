From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Thu, 13 Aug 2015 08:37:23 +0300
Subject: [PATCH v6 1/2] x86/kasan: define KASAN_SHADOW_OFFSET per architecture
In-Reply-To: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
References: <1439444244-26057-1-git-send-email-ryabinin.a.a@gmail.com>
Message-ID: <1439444244-26057-2-git-send-email-ryabinin.a.a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current definition of  KASAN_SHADOW_OFFSET in include/linux/kasan.h
will not work for upcomming arm64, so move it to the arch header.

Signed-off-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
---
 arch/x86/include/asm/kasan.h | 3 +++
 include/linux/kasan.h        | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kasan.h b/arch/x86/include/asm/kasan.h
index 74a2a8d..1410b56 100644
--- a/arch/x86/include/asm/kasan.h
+++ b/arch/x86/include/asm/kasan.h
@@ -1,6 +1,9 @@
 #ifndef _ASM_X86_KASAN_H
 #define _ASM_X86_KASAN_H
 
+#include <linux/const.h>
+#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
+
 /*
  * Compiler uses shadow offset assuming that addresses start
  * from 0. Kernel addresses don't start from 0, so shadow
diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 5486d77..6fb1c7d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -10,7 +10,6 @@ struct vm_struct;
 #ifdef CONFIG_KASAN
 
 #define KASAN_SHADOW_SCALE_SHIFT 3
-#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
 
 #include <asm/kasan.h>
 #include <linux/sched.h>
-- 
2.4.6
