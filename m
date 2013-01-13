From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 13 Jan 2013 19:24:29 +0000
Subject: [PATCH V3] mmc: mmci: Fixup and cleanup code for DMA handling
In-Reply-To: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
References: <1357570707-28207-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20130113192428.GU23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 03:58:27PM +0100, Ulf Hansson wrote:
> @@ -374,19 +415,12 @@ static void mmci_dma_unmap(struct mmci_host *host, struct mmc_data *data)
>  	 * contiguous buffers.  On TX, we'll get a FIFO underrun error.
>  	 */
>  	if (status & MCI_RXDATAAVLBLMASK) {
> -		dmaengine_terminate_all(chan);
> -		if (!data->error)
> -			data->error = -EIO;
> -	}
> -
> -	if (data->flags & MMC_DATA_WRITE) {
> -		dir = DMA_TO_DEVICE;
> -	} else {
> -		dir = DMA_FROM_DEVICE;
> +		data->error = -EIO;
> +		mmci_dma_data_error(host);

Please explain the change of behaviour here.  Before your change, we _only_
set data->error if the error is not set.  Here, we overwrite the error code
no matter what.  What is the reasoning for that change?

The reason the code is like it _was_ is so that any bytes remaining in the
FIFO are _only_ reported as an error if there wasn't a preceding error.
That is the behaviour I desired when I wrote this code.
