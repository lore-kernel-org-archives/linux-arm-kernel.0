From: wsa-dev@sang-engineering.com (Wolfram Sang)
Date: Thu, 24 Nov 2016 16:18:47 +0100
Subject: [PATCH 2/2] i2c: designware: fix rx fifo depth tracking
In-Reply-To: <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p18-0000R6-4w@rmk-PC.armlinux.org.uk>
Message-ID: <20161124151847.GH4271@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 07:40:10PM +0000, Russell King wrote:
> When loading the TX fifo to receive bytes on the I2C bus, we incorrectly
> count the number of bytes:
> 
> 	rx_limit = dev->rx_fifo_depth - dw_readl(dev, DW_IC_RXFLR);
> 
> 	while (buf_len > 0 && tx_limit > 0 && rx_limit > 0) {
> 		if (rx_limit - dev->rx_outstanding <= 0)
> 			break;
> 		rx_limit--;
> 		dev->rx_outstanding++;
> 	}
> 
> DW_IC_RXFLR indicates how many bytes are available to be read in the
> FIFO, dev->rx_fifo_depth is the FIFO size, and dev->rx_outstanding is
> the number of bytes that we've requested to be read so far, but which
> have not been read.
> 
> Firstly, increasing dev->rx_outstanding and decreasing rx_limit and then
> comparing them results in each byte consuming "two" bytes in this
> tracking, so this is obviously wrong.
> 
> Secondly, the number of bytes that _could_ be received into the FIFO at
> any time is the number of bytes we have so far requested but not yet
> read from the FIFO - in other words dev->rx_outstanding.
> 
> So, in order to request enough bytes to fill the RX FIFO, we need to
> request dev->rx_fifo_depth - dev->rx_outstanding bytes.
> 
> Modifying the code thusly results in us reaching the maximum number of
> bytes outstanding each time we queue more "receive" operations, provided
> the transfer allows that to happen.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161124/cd1f3cc5/attachment.sig>
