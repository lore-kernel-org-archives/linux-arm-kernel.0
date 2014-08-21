From: max.schwarz@online.de (Max Schwarz)
Date: Thu, 21 Aug 2014 20:54:06 +0200
Subject: [PATCH] i2c: rk3x: fix bug that cause transfer fails in master
 receive mode
In-Reply-To: <20140821181738.GA1443@katana>
References: <1408643457-7126-1-git-send-email-addy.ke@rock-chips.com>
 <53F634AF.1010303@cogentembedded.com> <20140821181738.GA1443@katana>
Message-ID: <5150326.5TB64kCfF4@typ>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thursday 21 August 2014 at 13:17:38, Wolfram Sang wrote:
> On Thu, Aug 21, 2014 at 10:04:31PM +0400, Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 08/21/2014 09:50 PM, Addy Ke wrote:
> > >In rk3x SOC, the I2C controller can receive/transmit up to 32 bytes data
> > >in one transaction, so the size of data to be write/read to/from
> > >TXDATAx/RXDATAx must be less than or equal 32 bytes at a time.
> > >
> > >Test on pinky board, elan receive 158 bytes data.
> > >
> > >Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> > >---
> > >
> > >  drivers/i2c/busses/i2c-rk3x.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > >diff --git a/drivers/i2c/busses/i2c-rk3x.c
> > >b/drivers/i2c/busses/i2c-rk3x.c
> > >index 69e1185..dc0aa64 100644
> > >--- a/drivers/i2c/busses/i2c-rk3x.c
> > >+++ b/drivers/i2c/busses/i2c-rk3x.c
> > >@@ -323,6 +323,9 @@ static void rk3x_i2c_handle_read(struct rk3x_i2c
> > >*i2c, unsigned int ipd)> >
> > >  	/* ack interrupt */
> > >  	i2c_writel(i2c, REG_INT_MBRF, REG_IPD);
> > >
> > >+	/* Can only handle a maximum of 32 bytes at a time */
> > >+	len = (len > 32) ? 32 : len;
> > >
> >    Why not min(len, 32)? Or even:
> > 	if (len > 32)
> > 	
> > 		len = 32;
> 
> No silent trimming, please. The message should be rejected when the transfer
> is set up. We could assign -EOVERFLOW to that type of failures, so users
> will know. Sadly, I have seen other controllers having such limits :(

Actually, reads with >32 bytes of data are possible with the controller. The 
hw returns the data in 32 byte chunks. Our chunk handling code is just buggy. 
We always read the number of missing bytes from the current chunk, instead of 
truncating that to 32.
The fix is correct. The following lines in the rk3x_i2c_handle_read() function 
already check if we got everything and trigger an additional chunk read if 
necessary:

	/* are we finished? */
	if (i2c->processed == i2c->msg->len)
		rk3x_i2c_stop(i2c, i2c->error);
	else
		rk3x_i2c_prepare_read(i2c);

I'd like a clearer syntax as suggested by Sergei, though.

Apart from that,
Acked-By: Max Schwarz <max.schwarz@online.de>

Cheers,
  Max
