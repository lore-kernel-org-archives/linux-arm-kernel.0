From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:09:57 +0100
Subject: [PATCH 07/11] spi: Deal with slaves that return from
 transfer_one() unfinished
In-Reply-To: <20181010170936.316862-8-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
 <20181010170936.316862-8-lkundrak@v3.sk>
Message-ID: <20181104120957.GS23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:09:32, Lubomir Rintel wrote:
> Some drivers, such as spi-pxa2xx return from the transfer_one callback
> immediately, idicating that the transfer will be finished asynchronously.
> 
> Normally, spi_transfer_one_message() synchronously waits for the
> transfer to finish with wait_for_completion_timeout(). For slaves, we
> don't want the transaction to time out as it can complete in a long time
> in future. Use wait_for_completion_interruptible() instead.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -993,6 +993,44 @@ static int spi_map_msg(struct spi_controller *ctlr, struct spi_message *msg)
>  	return __spi_map_msg(ctlr, msg);
>  }
>  
> +static int spi_transfer_wait(struct spi_controller *ctlr,
> +			     struct spi_message *msg,
> +			     struct spi_transfer *xfer)
> +{
> +	struct spi_statistics *statm = &ctlr->statistics;
> +	struct spi_statistics *stats = &msg->spi->statistics;
> +	unsigned long long ms = 1;
> +
> +	if (spi_controller_is_slave(ctlr)) {
> +		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
> +			dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
> +			return -EINTR;
> +		}

Do "return 0" here, and you can get rid of the else branch.

> +	} else {
> +		ms = 8LL * 1000LL * xfer->len;
> +		do_div(ms, xfer->speed_hz);
> +		ms += ms + 200; /* some tolerance */
> +
> +		if (ms > UINT_MAX)
> +			ms = UINT_MAX;
> +
> +		ms = wait_for_completion_timeout(&ctlr->xfer_completion,
> +						 msecs_to_jiffies(ms));
> +
> +		if (ms == 0) {
> +			SPI_STATISTICS_INCREMENT_FIELD(statm,
> +						       timedout);
> +			SPI_STATISTICS_INCREMENT_FIELD(stats,
> +						       timedout);
> +			dev_err(&msg->spi->dev,
> +				"SPI transfer timed out\n");
> +			msg->status = -ETIMEDOUT;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * spi_transfer_one_message - Default implementation of transfer_one_message()
>   *

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/18a7de82/attachment.sig>
