From: ben@trinity.fluff.org (Ben Dooks)
Date: Fri, 5 Aug 2011 09:58:13 +0100
Subject: [RFC PATCH] mmc: at91_mci: remove the use of irq_to_gpio
In-Reply-To: <1312472943-13839-1-git-send-email-nicolas.ferre@atmel.com>
References: <1312472943-13839-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20110805085813.GK13248@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2011 at 04:49:03PM +0100, Nicolas Ferre wrote:
> Remove the use of irq_to_gpio() in the card detection interrupt
> handler. The information is available in the board structure and
> we can avoid using a function that has little meaning.

thanks, looks good.
 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> Ben, Arnd,
> 
> I have identified this use of irq_to_gpio() which can be remove immediatly.
> 
>  drivers/mmc/host/at91_mci.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
> index a4aa3af..351951c 100644
> --- a/drivers/mmc/host/at91_mci.c
> +++ b/drivers/mmc/host/at91_mci.c
> @@ -869,7 +869,10 @@ static irqreturn_t at91_mci_irq(int irq, void *devid)
>  static irqreturn_t at91_mmc_det_irq(int irq, void *_host)
>  {
>  	struct at91mci_host *host = _host;
> -	int present = !gpio_get_value(irq_to_gpio(irq));
> +	int present;
> +
> +	/* if we are here is that the det_pin exists */
> +	present = !gpio_get_value(host->board->det_pin);
>  
>  	/*
>  	 * we expect this irq on both insert and remove,
> -- 
> 1.7.4.1
> 

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
