From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Mar 2014 17:55:07 +0100
Subject: [PATCH 1/2] v1 ARM: sun4i: spi: Allow Rx transfers larger than
 FIFO size
In-Reply-To: <2167943.Zs1zPAMITN@nukelap.gtech>
References: <2167943.Zs1zPAMITN@nukelap.gtech>
Message-ID: <20140319165507.GJ27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for working on this.

I have a few general comments first:
  - Use a decent mailer for your patches. git send-email is perfect
    for that, use it. Otherwise, your patches will be wrapped, like it
    happened here, and they won't be applyable anymore.
  - The vX should be between the brackets, together with
    PATCH. Remember that everything that is not between these brackets
    will be part of the commit message, and you don't want the version
    number in there.. Either git format-patch or git send-email will
    once again do the right thing if you use the -v or --reroll-count
    option.
  - Those two patches should be merged together. They're doing an
    useful thing, but are pretty much useless one without another, and
    it will avoid adding code just to remove it in the following
    patch.

On Tue, Mar 18, 2014 at 05:04:19PM -0500, Alexandru Gagniuc wrote:
> SPI transfers were limited to one FIFO depth, which is 64 bytes.
> This was an artificial limitation, however, as the hardware can handle
> much larger bursts. To accommodate this, we enable the interrupt when
> the Rx FIFO is 3/4 full, and drain the FIFO within the interrupt
> handler. The 3/4 ratio was chosen arbitrarily, with the intention to
> reduce the potential number of interrupts.
> 
> Since the SUN4I_CTL_TP bit is set, the hardware will pause
> transmission whenever the FIFO is full, so there is no risk of losing
> data if we can't service the interrupt in time.
> 
> This patch only handles long Rx transfers, and continues to return
> -EINVAL on long Tx transfers. Tx transfers are handled in a subsequent
> patch.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/spi/spi-sun4i.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
> index 3f82705..09d4b54 100644
> --- a/drivers/spi/spi-sun4i.c
> +++ b/drivers/spi/spi-sun4i.c
> @@ -47,6 +47,7 @@
>  #define SUN4I_CTL_TP				BIT(18)
>  
>  #define SUN4I_INT_CTL_REG		0x0c
> +#define SUN4I_INT_CTL_RF_F34			BIT(4)
>  #define SUN4I_INT_CTL_TC			BIT(16)
>  
>  #define SUN4I_INT_STA_REG		0x10
> @@ -68,6 +69,8 @@
>  #define SUN4I_XMIT_CNT_REG		0x24
>  #define SUN4I_XMIT_CNT(cnt)			((cnt) & 0xffffff)
>  
> +#define SUN4I_MAX_XFER_SIZE			0xffffff
> +
>  #define SUN4I_FIFO_STA_REG		0x28
>  #define SUN4I_FIFO_STA_RF_CNT_MASK		0x7f
>  #define SUN4I_FIFO_STA_RF_CNT_BITS		0
> @@ -175,8 +178,11 @@ static int sun4i_spi_transfer_one(struct spi_master 
> *master,
>  	int ret = 0;
>  	u32 reg;
>  
> -	/* We don't support transfer larger than the FIFO */
> -	if (tfr->len > SUN4I_FIFO_DEPTH)
> +	if (tfr->len > SUN4I_MAX_XFER_SIZE)
> +		return -EINVAL;

Why do you still need this test?

> +	/* We only support read transfers larger than the FIFO */
> +	if ((tfr->len > SUN4I_FIFO_DEPTH) && tfr->tx_buf)
>  		return -EINVAL;
>  
>  	reinit_completion(&sspi->done);
> @@ -274,7 +280,8 @@ static int sun4i_spi_transfer_one(struct spi_master 
> *master,
>  	sun4i_spi_fill_fifo(sspi, SUN4I_FIFO_DEPTH);
>  
>  	/* Enable the interrupts */
> -	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC);
> +	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, SUN4I_INT_CTL_TC |
> +						 SUN4I_INT_CTL_RF_F34);
>  
>  	/* Start the transfer */
>  	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
> @@ -287,7 +294,7 @@ static int sun4i_spi_transfer_one(struct spi_master 
> *master,
>  		goto out;
>  	}
>  
> -	sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +	/* FIFO is drained during the interrupt handler */

Then don't mention it.

>  out:
>  	sun4i_spi_write(sspi, SUN4I_INT_CTL_REG, 0);
> @@ -303,10 +310,19 @@ static irqreturn_t sun4i_spi_handler(int irq, void 
> *dev_id)
>  	/* Transfer complete */
>  	if (status & SUN4I_INT_CTL_TC) {
>  		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, SUN4I_INT_CTL_TC);
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
>  		complete(&sspi->done);
>  		return IRQ_HANDLED;
>  	}
>  
> +	/* Receive FIFO 3/4 full */
> +	if (status & SUN4I_INT_CTL_RF_F34) {
> +		sun4i_spi_drain_fifo(sspi, SUN4I_FIFO_DEPTH);
> +		/* Only clear the interrupt _after_ draining the FIFO */
> +		sun4i_spi_write(sspi, SUN4I_INT_STA_REG, 
> SUN4I_INT_CTL_RF_F34);

Not that it's important, but it really doesn't matter to do it before
or after, the interrupts are disabled in the handler.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140319/b574318d/attachment.sig>
