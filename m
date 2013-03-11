From: cjb@laptop.org (Chris Ball)
Date: Mon, 11 Mar 2013 17:55:39 -0400
Subject: Regulator API ignored return values
In-Reply-To: <201303112043.53334.arnd@arndb.de> (Arnd Bergmann's message of
 "Mon, 11 Mar 2013 20:43:53 +0000")
References: <201303112043.53334.arnd@arndb.de>
Message-ID: <87a9q9iotg.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 11 2013, Arnd Bergmann wrote:
> ==> build/dove_defconfig/faillog <==
> /git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
> /git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring
> return value of 'regulator_enable', declared with attribute
> warn_unused_result [-Wunused-result]

Thanks, this looks like the right fix to me:


Subject: [PATCH] mmc: sdhci: Don't ignore regulator_enable() return value

Fixes:
/git/arm-soc/drivers/mmc/host/sdhci.c: In function 'sdhci_add_host':
/git/arm-soc/drivers/mmc/host/sdhci.c:2910:19: warning: ignoring
return value of 'regulator_enable', declared with attribute
warn_unused_result [-Wunused-result]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51bbba4..fbf0b93 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2907,12 +2907,17 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->vqmmc = NULL;
 		}
 	} else {
-		regulator_enable(host->vqmmc);
+		ret = regulator_enable(host->vqmmc);
 		if (!regulator_is_supported_voltage(host->vqmmc, 1700000,
 			1950000))
 			caps[1] &= ~(SDHCI_SUPPORT_SDR104 |
 					SDHCI_SUPPORT_SDR50 |
 					SDHCI_SUPPORT_DDR50);
+		if (ret) {
+			pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
+				mmc_hostname(mmc), ret);
+			host->vqmmc = NULL;
+		}
 	}
 
 	if (host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
