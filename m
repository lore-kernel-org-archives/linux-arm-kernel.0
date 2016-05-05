From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 5 May 2016 12:22:19 -0500
Subject: [PATCH 2/2] drivers: i2c: qup: Fix error handling
In-Reply-To: <1462166637-16778-3-git-send-email-sricharan@codeaurora.org>
References: <1462166637-16778-1-git-send-email-sricharan@codeaurora.org>
 <1462166637-16778-3-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160505172219.GB6533@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 02, 2016 at 10:53:57AM +0530, Sricharan R wrote:
> Among the bus errors reported from the QUP_MASTER_STATUS register
> only NACK is considered and transfer gets suspended, while
> other errors are ignored. Correct this and suspend the transfer
> for other errors as well. This avoids unnessecary 'timeouts' which
> happens when waiting for events that would never happen when there
> is already an error condition on the bus.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> ---
>  drivers/i2c/busses/i2c-qup.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)

Reviewed-by: Andy Gross <andy.gross@linaro.org>

<snip>

> @@ -1227,6 +1240,9 @@ static int qup_i2c_xfer_v2(struct i2c_adapter *adap,
>  	struct qup_i2c_dev *qup = i2c_get_adapdata(adap);
>  	int ret, len, idx = 0, use_dma = 0;
>  
> +	qup->bus_err = 0;
> +	qup->qup_err = 0;
> +

What about the initial setting of these?  Does this need to be removed from the
main xfer function?

>  	ret = pm_runtime_get_sync(qup->dev);
>  	if (ret < 0)
>  		goto out;
