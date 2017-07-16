From: giuseppe.cantavenera@azcom.it (Giuseppe Cantavenera)
Date: Sun, 16 Jul 2017 18:47:08 +0200 (CEST)
Subject: [PATCH] i2c-cadence: fix repeated start in message sequence
In-Reply-To: <1500022844-3027-1-git-send-email-giuseppe.cantavenera@azcom.it>
References: <1500022844-3027-1-git-send-email-giuseppe.cantavenera@azcom.it>
Message-ID: <580184342.11300.1500223628588.JavaMail.zimbra@azcom.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Wrong i2c transactions have been observed in reads made up of
> a write followed by a read supposed to be interleaved by a
> repeated start.
> cdns_i2c_mrecv() and cdns_i2c_msend() were clearing the
> HOLD bit in the control register before issuing the last
> transaction of a series, which somehow reflects the
> Zynq-7000 Reference Manual but is incorrect for most slaves.
> Seems like most of the times the clearing of the HOLD bit
> takes some istants to be effective:
> the controller sends a restart on the bus.
> Sometimes the clearing does take effect and the last call
> to cdns_i2c_mrecv() or cdns_i2c_msend() results in:
> STOP + START instead of simply a RESTART (often mandatory).
> 
> Modify the command sequence:
> 1- enable interrupts
> 2- issue the write/read operation
> 3- clear the HOLD bit if needed
> 
> Signed-off-by: Giuseppe Cantavenera <giuseppe.cantavenera@azcom.it>
> Tested-by: Giuseppe Cantavenera <giuseppe.cantavenera@azcom.it>
> Cc: stable at vger.kernel.org
> Cc: michal.simek at xilinx.com
> Cc: soren.brinkmann at xilinx.com
> ---

Hello,

just noticed a similar fix [8064c616984eaa] 
is in the just released  4.13-rc1, submitted about 1 month ago.
Sadly, it would have saved our team weeks of investigation 
on a major issue if we had noticed before, but that's our problem :(

Still I don't understand why that one applies the change only to the receive
and not to the write as well.
Moreover, the interrupts being enabled after issuing the command does not
seem logic to me.
Does anyone has different advice? I think we need that as well..

I would like to submit it, maybe split in two
subpatches, but about the interrupts I still wonder whether
there was a reason it was coded like that in the first place.

Let us know,
thanks,
Giuseppe C.
  


> drivers/i2c/busses/i2c-cadence.c | 25 ++++++++++++++++---------
> 1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
> index 7234e32..8a36df2 100644
> --- a/drivers/i2c/busses/i2c-cadence.c
> +++ b/drivers/i2c/busses/i2c-cadence.c
> @@ -428,15 +428,21 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
> 		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);
> 	}
> 
> -	/* Clear the bus hold flag if bytes to receive is less than FIFO size */
> +	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
> +	/* Set the slave address in address register - triggers operation */
> +	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
> +						CDNS_I2C_ADDR_OFFSET);
> +
> +	/*
> +	 * Clear the bus hold flag if bytes to receive is less than FIFO size.
> +	 * This needs to be after the read is triggered, otherwise any read
> +	 * made up of a write plus a read interleaved by a repeated start
> +	 * may fail.
> +	 */
> 	if (!id->bus_hold_flag &&
> 		((id->p_msg->flags & I2C_M_RECV_LEN) != I2C_M_RECV_LEN) &&
> 		(id->recv_count <= CDNS_I2C_FIFO_DEPTH))
> 			cdns_i2c_clear_bus_hold(id);
> -	/* Set the slave address in address register - triggers operation */
> -	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
> -						CDNS_I2C_ADDR_OFFSET);
> -	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
> }
> 
> /**
> @@ -489,17 +495,18 @@ static void cdns_i2c_msend(struct cdns_i2c *id)
> 		id->send_count--;
> 	}
> 
> +
> +	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
> +	/* Set the slave address in address register - triggers operation. */
> +	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
> +						CDNS_I2C_ADDR_OFFSET);
> 	/*
> 	 * Clear the bus hold flag if there is no more data
> 	 * and if it is the last message.
> 	 */
> 	if (!id->bus_hold_flag && !id->send_count)
> 		cdns_i2c_clear_bus_hold(id);
> -	/* Set the slave address in address register - triggers operation. */
> -	cdns_i2c_writereg(id->p_msg->addr & CDNS_I2C_ADDR_MASK,
> -						CDNS_I2C_ADDR_OFFSET);
> 
> -	cdns_i2c_writereg(CDNS_I2C_ENABLED_INTR_MASK, CDNS_I2C_IER_OFFSET);
> }
> 
> /**
> --
> 1.9.1
