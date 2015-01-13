From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 13 Jan 2015 12:28:54 +0100
Subject: [PATCH v5 1/2] i2c: cadence: Handle > 252 byte transfers
In-Reply-To: <1418357907-4215-2-git-send-email-harinik@xilinx.com>
References: <1418357907-4215-1-git-send-email-harinik@xilinx.com>
 <1418357907-4215-2-git-send-email-harinik@xilinx.com>
Message-ID: <20150113112854.GA7660@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 12, 2014 at 09:48:26AM +0530, Harini Katakam wrote:
> The I2C controller sends a NACK to the slave when transfer size register
> reaches zero, irrespective of the hold bit. So, in order to handle transfers
> greater than 252 bytes, the transfer size register has to be maintained at a
> value >= 1. This patch implements the same.
> The interrupt status is cleared at the beginning of the isr instead of
> the end, to avoid missing any interrupts.
> 
> Signed-off-by: Harini Katakam <harinik@xilinx.com>

Applied to for-next, thanks!

> @@ -333,10 +359,11 @@ static void cdns_i2c_mrecv(struct cdns_i2c *id)
>  	 * receive if it is less than transfer size and transfer size if
>  	 * it is more. Enable the interrupts.
>  	 */
> -	if (id->recv_count > CDNS_I2C_TRANSFER_SIZE)
> +	if (id->recv_count > CDNS_I2C_TRANSFER_SIZE) {
>  		cdns_i2c_writereg(CDNS_I2C_TRANSFER_SIZE,
>  				  CDNS_I2C_XFER_SIZE_OFFSET);
> -	else
> +		id->curr_recv_count = CDNS_I2C_TRANSFER_SIZE;
> +	} else
>  		cdns_i2c_writereg(id->recv_count, CDNS_I2C_XFER_SIZE_OFFSET);

else branch must have braces, too! I fixed that.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/e62b6b87/attachment.sig>
