From: cjb@laptop.org (Chris Ball)
Date: Mon, 11 Feb 2013 11:36:24 -0500
Subject: [PATCH REPOST] mmc: bcm2835: set
 SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
In-Reply-To: <1360382187-26296-1-git-send-email-swarren@wwwdotorg.org>
 (Stephen Warren's message of "Fri, 8 Feb 2013 20:56:27 -0700")
References: <1360382187-26296-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <87k3qest87.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Feb 08 2013, Stephen Warren wrote:
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK does basically the same as
> implementing struct sdhci_ops .get_timeout_clock, so simply set that
> quirk and remove the custom code to simplify the driver.
>
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>

This conflicts with Lars-Peter's larger patch, which I just merged --
I could merge the changes from both, which reduces your patch to this:

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 1e97b89..8ffea05 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -133,11 +133,11 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
 	.read_b = bcm2835_sdhci_readb,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_min_clock = bcm2835_sdhci_get_min_clock,
-	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
 };
 
 static struct sdhci_pltfm_data bcm2835_sdhci_pdata = {
-	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.ops = &bcm2835_sdhci_ops,
 };


Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
