From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Sep 2012 23:36:14 +0200
Subject: [PATCH 09/12] tty/console: fix warnings in drivers/tty/serial/kgdboc.c
In-Reply-To: <1348868177-21205-1-git-send-email-arnd@arndb.de>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
Message-ID: <1348868177-21205-10-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The con_debug_leave/con_debug_enter functions are stubbed out
by defining them to (0), which causes harmless build warnings.
Using proper inline functions is the normal way to deal with
this.

Without this patch, building the ARM bcm2835_defconfig results in:

drivers/tty/serial/kgdboc.c: In function 'kgdboc_pre_exp_handler':
drivers/tty/serial/kgdboc.c:279:3: warning: statement with no effect [-Wunused-value]
drivers/tty/serial/kgdboc.c: In function 'kgdboc_post_exp_handler':
drivers/tty/serial/kgdboc.c:293:3: warning: statement with no effect [-Wunused-value]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Anton Vorontsov <anton.vorontsov@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/console.h |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 7201ce4..dedb082 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -83,8 +83,14 @@ void give_up_console(const struct consw *sw);
 int con_debug_enter(struct vc_data *vc);
 int con_debug_leave(void);
 #else
-#define con_debug_enter(vc) (0)
-#define con_debug_leave() (0)
+static inline int con_debug_enter(struct vc_data *vc)
+{
+	return 0;
+}
+static inline int con_debug_leave(void)
+{
+	return 0;
+}
 #endif
 
 /* scroll */
-- 
1.7.10
