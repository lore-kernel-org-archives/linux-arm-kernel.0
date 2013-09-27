From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 27 Sep 2013 12:00:14 +0800
Subject: [PATCH 1/1] mmc: sdhci-of-esdhc: fix building error
Message-ID: <1380254414-12045-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git mmc-next
head:   53279906cf17c2b6138c70f41ec8f2da53cea65f
commit: d31fc00a71b4f3a52d23c5a995ccd63e50a2c877 [36/41] mmc: sdhci-esdhc: move common esdhc_set_clock to platform driver
config: make ARCH=powerpc allmodconfig

All error/warnings:

   drivers/mmc/host/sdhci-of-esdhc.c: In function 'esdhc_of_set_clock':
>> drivers/mmc/host/sdhci-of-esdhc.c:229:179: error: 'host_clock' undeclared (first use in this function)
     dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
                                                                                                                                                                                      ^
   drivers/mmc/host/sdhci-of-esdhc.c:229:179: note: each undeclared identifier is reported only once for each function it appears in

vim +/host_clock +229 drivers/mmc/host/sdhci-of-esdhc.c

   223          while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
   224                  pre_div *= 2;
   225
   226          while (host->max_clk / pre_div / div > clock && div < 16)
   227                  div++;
   228
 > 229           dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
   230                  clock, host_clock / pre_div / div);
   231
   232          pre_div >>= 1;

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index b1605a1..0b24997 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -227,7 +227,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 		div++;
 
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
-		clock, host_clock / pre_div / div);
+		clock, host->max_clk / pre_div / div);
 
 	pre_div >>= 1;
 	div--;
-- 
1.7.2.rc3
