From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 11:17:42 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110130212856.GA32737@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=HzzOkVmD9z=9uRdzHsaixFAfOv9BmxoY=u7uf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> 8<----
> Subject: [PATCH 1/2] ARM: mmci: complete the transaction on error
>
> When we encounter an error, make sure we complete the transaction
> otherwise we'll leave the request dangling.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?drivers/mmc/host/mmci.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index b6fd6dc..175a623 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -319,7 +319,7 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
> ? ? ? ?if (status & MCI_DATABLOCKEND)
> ? ? ? ? ? ? ? ?dev_err(mmc_dev(host->mmc), "stray MCI_DATABLOCKEND interrupt\n");
>
> - ? ? ? if (status & MCI_DATAEND) {
> + ? ? ? if (status & MCI_DATAEND || data->error) {
> ? ? ? ? ? ? ? ?mmci_stop_data(host);

The hardware always sets the MCI_DATAEND bit if there is
some error, so these flags always appear simultaneously, but
it doesn't hurt to take some extra precaution, so
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Linus Walleij
