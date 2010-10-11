From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Oct 2010 10:44:04 +0100
Subject: [PATCHv2] mmci: work with only one irq
In-Reply-To: <1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
	<1286755601-25664-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <20101011094404.GB27153@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 11, 2010 at 05:36:41AM +0530, Rabin Vincent wrote:
> @@ -276,6 +292,10 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
>  	if (status & MCI_DATAEND) {
>  		mmci_stop_data(host);
>  
> +		/* MCI_DATABLOCKEND not used with single irq */
> +		if (host->singleirq && !data->error)
> +			host->data_xfered = data->blksz * data->blocks;
> +

I'm uneasy about this.  If we don't get datablockend interrupts, then
when there's an error we don't know how much data was transferred, and
with big requests, we're going to have a very long time spent retrying
block by block.
