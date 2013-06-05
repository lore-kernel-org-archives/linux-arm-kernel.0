From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  5 Jun 2013 13:32:31 +0900
Subject: [PATCH 4/4] irqchip: Add irqchip_init dummy function
In-Reply-To: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
References: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370406751-3852-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bastian Hecht <hechtb@gmail.com>

We add an empty irqchip_init dummy function for cases in which
CONFIG_IRQCHIP is not used. In these cases irqchip.c is not compiled,
but a funtion call may still be present in architecture code, that in
runtime doesn't get hit.

E.g. this is needed in the arch/arm/mach-shmobile/intc-r8a7740.c
interrupt setup code where OF use and non OF us is both handled in one
file.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
[horms+renesas at verge.net.au: Make non-CONFIG_IRQCHIP version static inline
 and remove trailing ';'.]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/linux/irqchip.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
index e0006f1..14d7913 100644
--- a/include/linux/irqchip.h
+++ b/include/linux/irqchip.h
@@ -11,6 +11,10 @@
 #ifndef _LINUX_IRQCHIP_H
 #define _LINUX_IRQCHIP_H
 
+#ifdef CONFIG_IRQCHIP
 void irqchip_init(void);
+#else
+static inline void irqchip_init(void) {}
+#endif
 
 #endif
-- 
1.8.2.1
