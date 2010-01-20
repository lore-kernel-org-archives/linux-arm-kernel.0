From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 20 Jan 2010 09:16:00 +0100
Subject: [PATCH 1/2] s3cmci: Initialize default platform data no_wprotect and
	no_detect with 1
Message-ID: <1263975361-29376-1-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If no platform_data was givin to the device it's going to use it's default
platform data struct which has all fields initialized to zero.
As a result the driver is going to try to request gpio0 both as write protect
and card detect pin. Which of course will fail and makes the driver unusable

Previously to the introduction of no_wprotect and no_detect the behavior was
to assume that if no platform data was given there is no write protect or card
detect pin.
This patch restores that behavior.
---
 drivers/mmc/host/s3cmci.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index d96e1ab..b9c96cc 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1360,6 +1360,8 @@ static struct mmc_host_ops s3cmci_ops = {
 static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
 	/* This is currently here to avoid a number of if (host->pdata)
 	 * checks. Any zero fields to ensure reasonable defaults are picked. */
+	 .no_wprotect = 1,
+	 .no_detect = 1,
 };
 
 #ifdef CONFIG_CPU_FREQ
-- 
1.5.6.5
