From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 9 Nov 2011 16:29:20 +0530
Subject: [PATCH 5/6] spi/pl022: move device disable to workqueue thread
In-Reply-To: <1320835162-31337-1-git-send-email-linus.walleij@stericsson.com>
References: <1320835162-31337-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4EBA5D08.1010107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/2011 4:09 PM, Linus WALLEIJ wrote:
> From: Chris Blair <chris.blair@stericsson.com>

> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index bffad2a..2e3522d 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -512,13 +512,6 @@ static void giveback(struct pl022 *pl022)
>  	msg->state = NULL;
>  	if (msg->complete)
>  		msg->complete(msg->context);
> -
> -	/* disable the SPI/SSP operation */
> -	writew((readw(SSP_CR1(pl022->virtbase)) &
> -		(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> -

We added this in an earlier patch in the same patchset. It would be better
if we can shift that patch after this one.

> -	/* This message is completed, so let's turn off the clocks & power */
> -	pm_runtime_put(&pl022->adev->dev);
>  }
>  
>  /**
> @@ -1513,10 +1506,17 @@ static void pump_messages(struct work_struct *work)
>  	struct pl022 *pl022 =
>  		container_of(work, struct pl022, pump_messages);
>  	unsigned long flags;
> +	bool was_busy = false;
>  
>  	/* Lock queue and check for queue work */
>  	spin_lock_irqsave(&pl022->queue_lock, flags);
>  	if (list_empty(&pl022->queue) || !pl022->running) {
> +		if (pl022->busy) {
> +			/* nothing more to do - disable spi/ssp and power off */
> +			writew((readw(SSP_CR1(pl022->virtbase)) &
> +				(~SSP_CR1_MASK_SSE)), SSP_CR1(pl022->virtbase));
> +			pm_runtime_put(&pl022->adev->dev);
> +		}

Probably it will look better if we add a blank line here.

-- 
viresh
