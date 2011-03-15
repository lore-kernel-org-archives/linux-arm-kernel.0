From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Mon, 14 Mar 2011 22:01:05 -0700
Subject: [PATCH 02/11] msm: dma: Add support for flushing dma channels
In-Reply-To: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
References: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1300165274-8544-3-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sometimes dma channels need to be flushed without having a reference to
a specific command, as in msm_dmov_stop_cmd.

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/dma.c              |   13 +++++++++++++
 arch/arm/mach-msm/include/mach/dma.h |    4 ++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
index 02cae5e..8e4d46e 100644
--- a/arch/arm/mach-msm/dma.c
+++ b/arch/arm/mach-msm/dma.c
@@ -1,6 +1,7 @@
 /* linux/arch/arm/mach-msm/dma.c
  *
  * Copyright (C) 2007 Google, Inc.
+ * Copyright (c) 2008-2011, Code Aurora Forum. All rights reserved.
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and
@@ -90,6 +91,18 @@ void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd)
 	spin_unlock_irqrestore(&msm_dmov_lock, irq_flags);
 }
 
+void msm_dmov_flush(unsigned int id)
+{
+	unsigned long flags;
+	spin_lock_irqsave(&msm_dmov_lock, flags);
+	/* XXX not checking if flush cmd sent already */
+	if (!list_empty(&active_commands[id])) {
+		PRINT_IO("msm_dmov_flush(%d), send flush cmd\n", id);
+		writel(DMOV_FLUSH_GRACEFUL, DMOV_FLUSH0(id));
+	}
+	spin_unlock_irqrestore(&msm_dmov_lock, flags);
+}
+
 struct msm_dmov_exec_cmdptr_cmd {
 	struct msm_dmov_cmd dmov_cmd;
 	struct completion complete;
diff --git a/arch/arm/mach-msm/include/mach/dma.h b/arch/arm/mach-msm/include/mach/dma.h
index ece09e0..41eb4a5 100644
--- a/arch/arm/mach-msm/include/mach/dma.h
+++ b/arch/arm/mach-msm/include/mach/dma.h
@@ -38,6 +38,7 @@ struct msm_dmov_cmd {
 void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd);
 void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful);
 int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr);
+void msm_dmov_flush(unsigned int id);
 #else
 static inline
 void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd) { }
@@ -45,6 +46,8 @@ static inline
 void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful) { }
 static inline
 int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr) { return -EIO; }
+static inline
+void msm_dmov_flush(unsigned int id) { }
 #endif
 
 
@@ -79,6 +82,7 @@ int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr) { return -EIO; }
 #define DMOV_FLUSH3(ch)       DMOV_SD_AARM(0x140, ch)
 #define DMOV_FLUSH4(ch)       DMOV_SD_AARM(0x180, ch)
 #define DMOV_FLUSH5(ch)       DMOV_SD_AARM(0x1C0, ch)
+#define DMOV_FLUSH_GRACEFUL  (1 << 31)
 
 #define DMOV_STATUS(ch)       DMOV_SD_AARM(0x200, ch)
 #define DMOV_STATUS_RSLT_COUNT(n)    (((n) >> 29))
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
