From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Nov 2018 16:01:54 -0800
Subject: Regression in next with spi return from transfer_one()
In-Reply-To: <20181115234359.GJ53235@atomide.com>
References: <20181115211451.GH53235@atomide.com>
 <20181115221241.GQ2089@sirena.org.uk>
 <20181115234359.GJ53235@atomide.com>
Message-ID: <20181116000154.GS2089@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 03:44:00PM -0800, Tony Lindgren wrote:

> It seems to be caused because of the now missing "if (ret > 0) {"
> line somehow that was there earlier. New code sets ms to 200 it
> seems, then dmesg shows:

Doh, of course :(  Sorry I missed that.

> The old code is not updating ms and it's set to 1.

Right, and not waiting either which should be the issue.  Does the
following work:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 498d3b9bf3ae..430ad637c643 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1114,9 +1114,11 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				goto out;
 			}
 
-			ret = spi_transfer_wait(ctlr, msg, xfer);
-			if (ret < 0)
-				msg->status = ret;
+			if (ret > 0) {
+				ret = spi_transfer_wait(ctlr, msg, xfer);
+				if (ret < 0)
+					msg->status = ret;
+			}
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/213c9a1f/attachment.sig>
