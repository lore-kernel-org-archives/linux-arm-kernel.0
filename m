From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 31 Jan 2011 11:24:09 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
In-Reply-To: <20110130212939.GA384@n2100.arm.linux.org.uk>
References: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
	<20110130212856.GA32737@n2100.arm.linux.org.uk>
	<20110130212939.GA384@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=yj716us6bHFfGRwm2Q_iPEAJeQHDjB=3_pTe5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/1/30 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> 8<-----
> Subject: [PATCH 2/2] ARM: mmci: round down the bytes transferred on error
>
> We should not report incomplete blocks on error. ?Return the number of
> bytes successfully transferred, rounded down to the nearest block.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?drivers/mmc/host/mmci.c | ? ?6 +++---
> ?1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 175a623..0de1602 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -289,13 +289,13 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
> ? ? ? ? ? ? ? ?dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
> ? ? ? ? ? ? ? ?if (status & MCI_DATACRCFAIL) {
> ? ? ? ? ? ? ? ? ? ? ? ?/* Last block was not successful */
> - ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = ((success - 1) / data->blksz) * data->blksz;
> + ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = (success - 1) & ~(data->blksz - 1);

Looks equivalent to using the macro round_down() from
<linux/kernel.h> like this:

host->data_xfered = round_down((success - 1), data->blksz);

Maybe that adds a bit to readability...

> ? ? ? ? ? ? ? ? ? ? ? ?data->error = -EILSEQ;
> ? ? ? ? ? ? ? ?} else if (status & MCI_DATATIMEOUT) {
> - ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success;
> + ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success & ~(data->blksz - 1);
> ? ? ? ? ? ? ? ? ? ? ? ?data->error = -ETIMEDOUT;
> ? ? ? ? ? ? ? ?} else if (status & (MCI_TXUNDERRUN|MCI_RXOVERRUN)) {
> - ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success;
> + ? ? ? ? ? ? ? ? ? ? ? host->data_xfered = success & ~(data->blksz - 1);
> ? ? ? ? ? ? ? ? ? ? ? ?data->error = -EIO;
> ? ? ? ? ? ? ? ?}

Dito on both but just
round_down(success, data->blksz);

Either way it is correct so:
Acked-by: Linus Walleij <linus.walleij@stericsson.com>

Yours,
Linus Walleij
