From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Oct 2018 11:58:54 +0100
Subject: [PATCH] i2c: cadence: Implement timeout
In-Reply-To: <1540378203-1655-1-git-send-email-shubhrajyoti.datta@gmail.com>
References: <1540378203-1655-1-git-send-email-shubhrajyoti.datta@gmail.com>
Message-ID: <20181024105854.GU30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 04:20:03PM +0530, shubhrajyoti.datta at gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> In some cases we are waiting in a loop. Replace the infinite wait with
> the  timeout.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---
>  drivers/i2c/busses/i2c-cadence.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index b136057..9c38278 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -209,6 +209,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  	struct cdns_i2c *id = ptr;
>  	/* Signal completion only after everything is updated */
>  	int done_flag = 0;
> +	unsigned int timeout;
>  	irqreturn_t status = IRQ_NONE;
>  
>  	isr_status = cdns_i2c_readreg(CDNS_I2C_ISR_OFFSET);
> @@ -235,6 +236,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  	    ((isr_status & CDNS_I2C_IXR_COMP) ||
>  	     (isr_status & CDNS_I2C_IXR_DATA))) {
>  		/* Read data if receive data valid is set */
> +		timeout = 1000;
>  		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
>  		       CDNS_I2C_SR_RXDV) {
>  			/*
> @@ -253,6 +255,16 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
>  
>  			if (cdns_is_holdquirk(id, hold_quirk))
>  				break;
> +			timeout--;
> +			if (timeout)
> +				mdelay(1);
> +			else
> +				break;
> +		}
> +		if (!timeout) {
> +			id->err_status = -ETIMEDOUT;
> +			complete(&id->xfer_done);
> +			return IRQ_HANDLED;

Good kernel programming principle: Always check for the success
condition when exiting due to timeout rather than the fact that we
timed out.

Also, is this _really_ a loop that needs a timeout condition?  Looking
at the original code, it looks like the purpose of the loop is to read
more than one byte, and you are introducing a 1ms delay between the
read of each byte.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
