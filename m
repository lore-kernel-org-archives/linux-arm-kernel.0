From: andrew@lunn.ch (Andrew Lunn)
Date: Tue,  5 Jun 2012 08:52:34 +0200
Subject: [PATCH] printk: Fix alignment of buf causing crash on ARM EABI
Message-ID: <1338879154-6546-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7ff9554bb578ba02166071d2d487b7fc7d860d62, printk: convert
byte-buffer to variable-length record buffer, causes systems using
EABI to crash very early in the boot cycle. The first entry in struct
log is a u64, which for EABI must be 8 byte aligned.

Make use of __alignof__() so the compiler to decide the alignment, but
allow it to be overridden using CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
for systems which can perform unaligned access and want to save
a few bytes of space.

Tested on Orion5x and Kirkwood.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 kernel/printk.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/printk.c b/kernel/printk.c
index 32462d2..f205c25 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -227,10 +227,10 @@ static u32 clear_idx;
 #define LOG_LINE_MAX 1024
 
 /* record buffer */
-#if !defined(CONFIG_64BIT) || defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
+#if defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
 #define LOG_ALIGN 4
 #else
-#define LOG_ALIGN 8
+#define LOG_ALIGN __alignof__(struct log)
 #endif
 #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
 static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
-- 
1.7.10
