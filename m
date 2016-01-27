From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Jan 2016 16:57:18 +0100
Subject: [PATCH 2/7] mptfusion: hide unused seq_mpt_print_ioc_summary function
In-Reply-To: <1453910247-3447628-1-git-send-email-arnd@arndb.de>
References: <1453910247-3447628-1-git-send-email-arnd@arndb.de>
Message-ID: <1453910247-3447628-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The seq_mpt_print_ioc_summary function is used for the /proc/mpt/iocN/summary
implementation and never gets called when CONFIG_PROC_FS is disabled:

drivers/message/fusion/mptbase.c:6851:13: warning: 'seq_mpt_print_ioc_summary' defined but not used [-Wunused-function]
 static void seq_mpt_print_ioc_summary(MPT_ADAPTER *ioc, struct seq_file *m, int showlan)

This adds an #ifdef to hide the function definition in that case
and avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/message/fusion/mptbase.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 5dcc0313c38a..207370d68c17 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -6848,6 +6848,7 @@ mpt_print_ioc_summary(MPT_ADAPTER *ioc, char *buffer, int *size, int len, int sh
 	*size = y;
 }
 
+#ifdef CONFIG_PROC_FS
 static void seq_mpt_print_ioc_summary(MPT_ADAPTER *ioc, struct seq_file *m, int showlan)
 {
 	char expVer[32];
@@ -6879,6 +6880,7 @@ static void seq_mpt_print_ioc_summary(MPT_ADAPTER *ioc, struct seq_file *m, int
 
 	seq_putc(m, '\n');
 }
+#endif
 
 /**
  *	mpt_set_taskmgmt_in_progress_flag - set flags associated with task management
-- 
2.7.0
