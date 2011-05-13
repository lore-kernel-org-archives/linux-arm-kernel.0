From: viresh.linux@gmail.com (viresh kumar)
Date: Fri, 13 May 2011 18:49:39 +0530
Subject: [PATCH] spi/amba-pl022: work in polling or interrupt mode if
	pl022_dma_probe fails
In-Reply-To: <a105605733caadfea25034ce0b8af73eb907fd33.1305287569.git.viresh.kumar@st.com>
References: <a105605733caadfea25034ce0b8af73eb907fd33.1305287569.git.viresh.kumar@st.com>
Message-ID: <BANLkTi=V7Y1boyEVn5feSzUiZbUL5RhJyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/13/11, Viresh Kumar <viresh.kumar@st.com> wrote:
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 08de58e..82b98b8 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -1063,7 +1063,7 @@ static int __init pl022_dma_probe(struct pl022 *pl022)
>  					    pl022->master_info->dma_filter,
>  					    pl022->master_info->dma_rx_param);
>  	if (!pl022->dma_rx_channel) {
> -		dev_err(&pl022->adev->dev, "no RX DMA channel!\n");
> +		dev_warn(&pl022->adev->dev, "no RX DMA channel!\n");

Sorry, this must be dev_dbg

>  		goto err_no_rxchan;
>  	}
>
> @@ -1071,13 +1071,13 @@ static int __init pl022_dma_probe(struct pl022
> *pl022)
>  					    pl022->master_info->dma_filter,
>  					    pl022->master_info->dma_tx_param);
>  	if (!pl022->dma_tx_channel) {
> -		dev_err(&pl022->adev->dev, "no TX DMA channel!\n");
> +		dev_warn(&pl022->adev->dev, "no TX DMA channel!\n");

                dev_dbg

>  		goto err_no_txchan;
>  	}
>
>  	pl022->dummypage = kmalloc(PAGE_SIZE, GFP_KERNEL);
>  	if (!pl022->dummypage) {
> -		dev_err(&pl022->adev->dev, "no DMA dummypage!\n");
> +		dev_warn(&pl022->adev->dev, "no DMA dummypage!\n");

                dev_dbg

>  		goto err_no_dummypage;
>  	}
>
> @@ -1093,6 +1093,8 @@ err_no_txchan:
>  	dma_release_channel(pl022->dma_rx_channel);
>  	pl022->dma_rx_channel = NULL;
>  err_no_rxchan:
> +	dev_warn(&pl022->adev->dev,

        dev_err

> +			"Failed to work in dma mode, work without dma!\n");
>  	return -ENODEV;
>  }
>

Will resend patch on Monday. Till that time, please see if this patch
with mentioned changes is acceptable or not.

--
viresh
