From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 1 Jun 2011 10:30:39 -0400 (EDT)
Subject: [PATCH 2/2] sdio: report error if pending IRQ but none function
	bits
In-Reply-To: <1306874008-28867-3-git-send-email-per.forlin@linaro.org>
References: <1306874008-28867-1-git-send-email-per.forlin@linaro.org>
	<1306874008-28867-3-git-send-email-per.forlin@linaro.org>
Message-ID: <alpine.LFD.2.00.1106011029390.30544@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 31 May 2011, Per Forlin wrote:

> Return error in case of pending IRQ but none functions bits
> in CCCR_INTx is set.
> 
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
>  drivers/mmc/core/sdio_irq.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 2f81ddc..8184b6e 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -50,6 +50,11 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
>  		return ret;
>  	}
>  
> +	if (!pending) {
> +		printk(KERN_WARNING "%s: pending IRQ but none function bits\n",
> +		       mmc_card_id(card));
> +		ret = -EINVAL;
> +	}

Nope, this won't work with the polled interrupt mode.


Nicolas
