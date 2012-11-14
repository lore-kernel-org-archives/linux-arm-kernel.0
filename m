From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 14 Nov 2012 17:46:00 +0100
Subject: [PATCH v3] i2c: omap: ensure writes to dev->buf_len are ordered
In-Reply-To: <1352902965-25666-1-git-send-email-balbi@ti.com>
References: <20121114112050.GG5954@pengutronix.de>
 <1352902965-25666-1-git-send-email-balbi@ti.com>
Message-ID: <20121114164600.GA1020@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2012 at 04:22:45PM +0200, Felipe Balbi wrote:
> if we allow compiler reorder our writes, we could
> fall into a situation where dev->buf_len is reset
> for no apparent reason.
> 
> This bug was found with a simple script which would
> transfer data to an i2c client from 1 to 1024 bytes
> (a simple for loop), when we got to transfer sizes
> bigger than the fifo size, dev->buf_len was reset
> to zero before we had an oportunity to handle XDR
> Interrupt. Because dev->buf_len was zero, we entered
> omap_i2c_transmit_data() to transfer zero bytes,
> which would mean we would just silently exit
> omap_i2c_transmit_data() without actually writing
> anything to DATA register. That would cause XDR
> IRQ to trigger forever and we would never transfer
> the remaining bytes.
> 
> After adding the memory barrier, we also drop resetting
> dev->buf_len to zero in omap_i2c_xfer_msg() because
> both omap_i2c_transmit_data() and omap_i2c_receive_data()
> will act until dev->buf_len reaches zero, rendering the
> other write in omap_i2c_xfer_msg() redundant.
> 
> This patch has been tested with pandaboard for a few
> iterations of the script mentioned above.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied to for-current, thanks!

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121114/0b0eb476/attachment.sig>
