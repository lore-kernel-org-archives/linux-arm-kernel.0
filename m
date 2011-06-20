From: prakity@marvell.com (Philip Rakity)
Date: Mon, 20 Jun 2011 08:59:38 -0700
Subject: [PATCH v3 1/4] mmc: sdhci: fix interrupt storm from card detection
In-Reply-To: <1308566325-11600-2-git-send-email-shawn.guo@linaro.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<1308566325-11600-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <AA2705EE-033E-4340-8CF1-774F444E143E@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jun 20, 2011, at 3:38 AM, Shawn Guo wrote:

> The issue was initially found by Eric Benard as below.
> 
> http://permalink.gmane.org/gmane.linux.ports.arm.kernel/108031
> 
> Not sure about other SDHCI based controller, but on Freescale eSDHC,
> the SDHCI_INT_CARD_INSERT bits will be immediately set again when it
> gets cleared, if a card is inserted. The driver need to mask the irq
> to prevent interrupt storm which will freeze the system.  And the
> SDHCI_INT_CARD_REMOVE gets the same situation.
> 
> The patch fixes the problem based on the initial idea from
> Eric Benard.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Eric Benard <eric@eukrea.com>
> ---
> drivers/mmc/host/sdhci.c |   27 +++++++++++++++++++++++----
> 1 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 91d9892..d94e2b4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -127,7 +127,9 @@ static void sdhci_mask_irqs(struct sdhci_host *host, u32 irqs)
> 
> static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
> {
> -	u32 irqs = SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT;
> +	u32 present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> +		      SDHCI_CARD_PRESENT;
> +	u32 irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;
> 
> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> 		return;


Accessing off chip registers is slow.  It would be better to check for the quirk first
and then read the present state register.

eg
	
	u32 present;
	u32 irqs;	

> 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> 		return;

>  	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> 		      SDHCI_CARD_PRESENT;


> 	irqs = present ? SDHCI_INT_CARD_REMOVE : SDHCI_INT_CARD_INSERT;


Philip
