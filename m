From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 22 Nov 2011 13:58:56 +0530
Subject: [PATCH 7/7] spi/pl022: make the chip deselect handling thread safe
In-Reply-To: <1321950328-4882-1-git-send-email-linus.walleij@stericsson.com>
References: <1321950328-4882-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4ECB5D48.8040309@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/22/2011 1:55 PM, Linus WALLEIJ wrote:
> From: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> 
> There is a possibility that the pump_message and giveback
> run in parallel on a SMP system. Both the pump_message and
> giveback threads work on the same SPI message queue.
> Results will be in correct if the pump_message gets to
> work on the queue first.
> 
> when the pump_message works with the queue, it reads the
> head of the queue and removes it from the queue. pump_message
> activates the chip select depending on this message read.
> 
> This leads to giveback working on the modified queue or a
> emptied queue. If the queue is empty or if the next message on
> the queue (which is not the actual next message, as the pump
> message has removed the next message from the queue) is not for
> the same SPI device as that Of the previous one, giveback will
> de-activate the chip select activated by pump_message(),
> which is wrong.
> 
> To solve this problem pump_message is made not to run and
> access the queue until the giveback is done handling the queue.
> I.e. by making the cur_msg NULL after the giveback has read the
> queue.
> 
> Also a state variable has been introduced to keep track of when
> the CS for next message is already activated and avoid to
> double-activate it.
> 
> Signed-off-by: Virupax Sadashivpetimath <virupax.sadashivpetimath@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/spi/spi-pl022.c |   72 ++++++++++++++++++++++++-----------------------
>  1 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 13988a3..1cff8ad 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -340,6 +340,10 @@ struct vendor_data {
>   * @cur_msg: Pointer to current spi_message being processed
>   * @cur_transfer: Pointer to current spi_transfer
>   * @cur_chip: pointer to current clients chip(assigned from controller_state)
> + * @next_msg_cs_active: the next message in the queue has been examined
> + *  and it was found that it uses the same chip select as the previous
> + *  message, so we left it active after the previous transfer, and it's
> + *  active already.
>   * @tx: current position in TX buffer to be read
>   * @tx_end: end position in TX buffer to be read
>   * @rx: current position in RX buffer to be written
> @@ -373,6 +377,7 @@ struct pl022 {
>  	struct spi_message		*cur_msg;
>  	struct spi_transfer		*cur_transfer;
>  	struct chip_data		*cur_chip;
> +	bool				next_msg_cs_active;
>  	void				*tx;
>  	void				*tx_end;
>  	void				*rx;
> @@ -445,23 +450,9 @@ static void giveback(struct pl022 *pl022)
>  	struct spi_transfer *last_transfer;
>  	unsigned long flags;
>  	struct spi_message *msg;
> -	void (*curr_cs_control) (u32 command);
> +	pl022->next_msg_cs_active = false;
>  
> -	/*
> -	 * This local reference to the chip select function
> -	 * is needed because we set curr_chip to NULL
> -	 * as a step toward termininating the message.
> -	 */
> -	curr_cs_control = pl022->cur_chip->cs_control;
> -	spin_lock_irqsave(&pl022->queue_lock, flags);
> -	msg = pl022->cur_msg;
> -	pl022->cur_msg = NULL;
> -	pl022->cur_transfer = NULL;
> -	pl022->cur_chip = NULL;
> -	queue_work(pl022->workqueue, &pl022->pump_messages);
> -	spin_unlock_irqrestore(&pl022->queue_lock, flags);
> -
> -	last_transfer = list_entry(msg->transfers.prev,
> +	last_transfer = list_entry(pl022->cur_msg->transfers.prev,
>  					struct spi_transfer,
>  					transfer_list);
>  
> @@ -473,18 +464,13 @@ static void giveback(struct pl022 *pl022)
>  		 */
>  		udelay(last_transfer->delay_usecs);
>  
> -	/*
> -	 * Drop chip select UNLESS cs_change is true or we are returning
> -	 * a message with an error, or next message is for another chip
> -	 */
> -	if (!last_transfer->cs_change)
> -		curr_cs_control(SSP_CHIP_DESELECT);
> -	else {
> +	if (!last_transfer->cs_change) {
>  		struct spi_message *next_msg;
>  
> -		/* Holding of cs was hinted, but we need to make sure
> -		 * the next message is for the same chip.  Don't waste
> -		 * time with the following tests unless this was hinted.
> +		/*
> +		 * cs_change was not set. We can keep the chip select
> +		 * enabled if there is message in the queue and it is
> +		 * for the same spi device.
>  		 *
>  		 * We cannot postpone this until pump_messages, because
>  		 * after calling msg->complete (below) the driver that
> @@ -501,14 +487,26 @@ static void giveback(struct pl022 *pl022)
>  					struct spi_message, queue);
>  		spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  
> -		/* see if the next and current messages point
> -		 * to the same chip
> +		/*
> +		 * see if the next and current messages point
> +		 * to the same spi device.
>  		 */
> -		if (next_msg && next_msg->spi != msg->spi)
> +		if (next_msg && next_msg->spi != pl022->cur_msg->spi)
>  			next_msg = NULL;
> -		if (!next_msg || msg->state == STATE_ERROR)
> -			curr_cs_control(SSP_CHIP_DESELECT);
> +		if (!next_msg || pl022->cur_msg->state == STATE_ERROR)
> +			pl022->cur_chip->cs_control(SSP_CHIP_DESELECT);
> +		else
> +			pl022->next_msg_cs_active = true;
>  	}
> +
> +	spin_lock_irqsave(&pl022->queue_lock, flags);
> +	msg = pl022->cur_msg;
> +	pl022->cur_msg = NULL;
> +	pl022->cur_transfer = NULL;
> +	pl022->cur_chip = NULL;
> +	queue_work(pl022->workqueue, &pl022->pump_messages);
> +	spin_unlock_irqrestore(&pl022->queue_lock, flags);
> +
>  	msg->state = NULL;
>  	if (msg->complete)
>  		msg->complete(msg->context);
> @@ -1350,7 +1348,7 @@ static void pump_transfers(unsigned long data)
>  			 */
>  			udelay(previous->delay_usecs);
>  
> -		/* Drop chip select only if cs_change is requested */
> +		/* Reselect chip select only if cs_change was requested */
>  		if (previous->cs_change)
>  			pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
>  	} else {
> @@ -1389,8 +1387,10 @@ static void do_interrupt_dma_transfer(struct pl022 *pl022)
>  	 */
>  	u32 irqflags = ENABLE_ALL_INTERRUPTS & ~SSP_IMSC_MASK_RXIM;
>  
> -	/* Enable target chip */
> -	pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
> +	/* Enable target chip, if not already active */
> +	if (!pl022->next_msg_cs_active)
> +		pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
> +
>  	if (set_up_next_transfer(pl022, pl022->cur_transfer)) {
>  		/* Error path */
>  		pl022->cur_msg->state = STATE_ERROR;
> @@ -1445,7 +1445,8 @@ static void do_polling_transfer(struct pl022 *pl022)
>  		} else {
>  			/* STATE_START */
>  			message->state = STATE_RUNNING;
> -			pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
> +			if (!pl022->next_msg_cs_active)
> +				pl022->cur_chip->cs_control(SSP_CHIP_SELECT);
>  		}
>  
>  		/* Configuration Changing Per Transfer */
> @@ -1604,6 +1605,7 @@ static int start_queue(struct pl022 *pl022)
>  	pl022->cur_msg = NULL;
>  	pl022->cur_transfer = NULL;
>  	pl022->cur_chip = NULL;
> +	pl022->next_msg_cs_active = false;
>  	spin_unlock_irqrestore(&pl022->queue_lock, flags);
>  
>  	queue_work(pl022->workqueue, &pl022->pump_messages);

Reviewed-by: Viresh Kumar <viresh.kumar@st.com>

-- 
viresh
