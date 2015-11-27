From: mmarek@suse.com (Michal Marek)
Date: Fri, 27 Nov 2015 15:14:06 +0100
Subject: [PATCH] logfs: clarify MTD dependency
In-Reply-To: <9365895.IkncCfXjo6@wuerfel>
References: <9365895.IkncCfXjo6@wuerfel>
Message-ID: <20151127141406.GA29886@sepie.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 02:54:53PM +0100, Arnd Bergmann wrote:
> After a change to the way that composite modules work, we get
> a logfs build error:
> 
> fs/built-in.o: In function `logfs_mount':
> :(.text+0x139d34): undefined reference to `logfs_get_sb_mtd'
> fs/built-in.o: In function `logfs_get_sb_bdev':
> :(.text+0x13aa08): undefined reference to `logfs_get_sb_mtd'
> 
> This patch avoids the error by changing the dependencies of
> logfs in a way that we can no longer configure logfs as built-in
> when the MTD core is a loadable module, while leaving the
> dependency to require at least one of MTD or BLOCK to be
> enabled.

Hi Arnd,

I hit this as well and was about to submit a slightly different fix. Can
you try the logfs portion of the below patch? Proper changelog is to be
done, but the gist of the patch is that IS_REACHABLE(CONFIG_FOO) 
evaluates to 1 if CONFIG_FOO=y or we are building a module and
CONFIG_FOO=m.

Michal

>From 63e7ab41e3958e753277728acbe15faf35a5374e Mon Sep 17 00:00:00 2001
From: Michal Marek <mmarek@suse.com>
Date: Fri, 27 Nov 2015 15:08:29 +0100
Subject: [PATCH] kbuild: Use IS_REACHABLE to handle objname-m composite
 objects

Fixes: cf4f21938e13 ("kbuild: Allow to specify composite modules with modname-m")
Signed-off-by: Michal Marek <mmarek@suse.com>
---
 drivers/misc/ibmasm/ibmasm.h   | 2 +-
 drivers/usb/chipidea/otg_fsm.h | 2 +-
 fs/logfs/logfs.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/ibmasm/ibmasm.h b/drivers/misc/ibmasm/ibmasm.h
index 5bd127727d8e..0f4c43a8543e 100644
--- a/drivers/misc/ibmasm/ibmasm.h
+++ b/drivers/misc/ibmasm/ibmasm.h
@@ -211,7 +211,7 @@ void ibmasmfs_unregister(void);
 void ibmasmfs_add_sp(struct service_processor *sp);
 
 /* uart */
-#if IS_ENABLED(CONFIG_SERIAL_8250)
+#if IS_REACHABLE(CONFIG_SERIAL_8250)
 void ibmasm_register_uart(struct service_processor *sp);
 void ibmasm_unregister_uart(struct service_processor *sp);
 #else
diff --git a/drivers/usb/chipidea/otg_fsm.h b/drivers/usb/chipidea/otg_fsm.h
index 262d6ef8df7c..44506e4aa11f 100644
--- a/drivers/usb/chipidea/otg_fsm.h
+++ b/drivers/usb/chipidea/otg_fsm.h
@@ -62,7 +62,7 @@
 /* SSEND time before SRP */
 #define TB_SSEND_SRP         (1500)	/* minimum 1.5 sec, section:5.1.2 */
 
-#if IS_ENABLED(CONFIG_USB_OTG_FSM)
+#if IS_REACHABLE(CONFIG_USB_OTG_FSM)
 
 int ci_hdrc_otg_fsm_init(struct ci_hdrc *ci);
 int ci_otg_fsm_work(struct ci_hdrc *ci);
diff --git a/fs/logfs/logfs.h b/fs/logfs/logfs.h
index 23f961a8fb92..2fcd487a4ab2 100644
--- a/fs/logfs/logfs.h
+++ b/fs/logfs/logfs.h
@@ -485,7 +485,7 @@ static inline int logfs_get_sb_bdev(struct logfs_super *s,
 #endif
 
 /* dev_mtd.c */
-#if IS_ENABLED(CONFIG_MTD)
+#if IS_REACHABLE(CONFIG_MTD)
 int logfs_get_sb_mtd(struct logfs_super *s, int mtdnr);
 #else
 static inline int logfs_get_sb_mtd(struct logfs_super *s, int mtdnr)
-- 
2.1.4
