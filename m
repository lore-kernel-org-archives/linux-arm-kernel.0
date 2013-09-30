From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Mon, 30 Sep 2013 15:54:55 +0200
Subject: [PATCH v2 1/3] dma: mxs-dma: Cleanup interrupt handler
In-Reply-To: <1380546822-14034-2-git-send-email-mpa@pengutronix.de>
References: <1380546822-14034-1-git-send-email-mpa@pengutronix.de>
 <1380546822-14034-2-git-send-email-mpa@pengutronix.de>
Message-ID: <21065.33455.71463.188271@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Markus Pargmann writes:
> The DMA interrupt handler uses its controll registers to handle all
> available channel interrupts it can find.
> 
> This patch changes it to handle only one interrupt by directly mapping
> irq number to channel. It also includes a cleanup of the ctrl-register
> usage.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  drivers/dma/mxs-dma.c | 95 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 59 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
> index ccd13df..bfca8dc 100644
> --- a/drivers/dma/mxs-dma.c
> +++ b/drivers/dma/mxs-dma.c
> @@ -272,58 +272,81 @@ static void mxs_dma_tasklet(unsigned long data)
>  		mxs_chan->desc.callback(mxs_chan->desc.callback_param);
>  }
>  
> +static int mxs_dma_irq_to_chan(struct mxs_dma_engine *mxs_dma, int irq)
> +{
> +	int i;
> +
> +	for (i = 0; i != mxs_dma->nr_channels; ++i)
> +		if (mxs_dma->mxs_chans[i].chan_irq == irq)
> +			return i;
>
You might use a linked list for all active channels so that you don't
have to check all unused channels when trying to find the channel
number for an irq.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
