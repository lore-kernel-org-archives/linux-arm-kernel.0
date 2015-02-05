From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 5 Feb 2015 18:20:31 +0800
Subject: [RFC] mmc: sdhci: implement light and heavy runtime pm resume
Message-ID: <20150205182031.1a47d726@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Most sdhci_runtime_resume_host() users just gate their clocks in their runtime
suspend implementation, so the sdhci_runtime_resume_host() is too heavy, we only
need to restore interrupts registers.

The change is something as following:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0ad412a..9d5bdde 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2856,7 +2856,7 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
-int sdhci_runtime_resume_host(struct sdhci_host *host)
+static void sdhci_runtime_resume_reinit(struct sdhci_host *host)
 {
 	unsigned long flags;
 	int host_flags = host->flags;
@@ -2880,6 +2880,15 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 		sdhci_enable_preset_value(host, true);
 		spin_unlock_irqrestore(&host->lock, flags);
 	}
+}
+
+int sdhci_runtime_resume_host(struct sdhci_host *host, bool power_keeped)
+{
+	unsigned long flags;
+	int host_flags = host->flags;
+
+	if (!power_keeped)
+		sdhci_runtime_resume_reinit(host);
 
 	/* Set the re-tuning expiration flag */
 	if (host->flags & SDHCI_USING_RETUNING_TIMER)


It's ugly, but per my test on marvell BG2Q platforms, this change can improve
the resume latency from 5500us to 11us. Is there any better solution?

Thanks in advance,
Jisheng
