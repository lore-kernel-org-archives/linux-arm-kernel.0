From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 27 Apr 2012 18:37:56 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <201204271753.39516.marex@denx.de>
References: <201204261326.29388.marex@denx.de>
 <201204271708.53467.marex@denx.de>
 <20120427154119.GF16504@pengutronix.de>
 <201204271753.39516.marex@denx.de>
Message-ID: <20120427163756.GH16504@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> But then you don't have the DMA chain linked. Which I wonder if the controller 
> has any problem with or not. I tried yesterday, got wrotes working perfectly, 
> but still had issues with reads, which is exactly what needs to be chained.

Yes, the read needs chaining of two "DMA command blocks". That should be
the only chain needed, because of how the driver handles reads. It is
still one I2C message, though.

> I'll poke further eventually.

I really hope it works out! That would be great.

> > Regarding Figure 27-10, the first I2C write command could be sent
> > seperately (probably even via PIOQUEUE).
> 
> I wonder if we want to combine pioqueue and DMA, that might create quite some 
> franken-driver.

Might be true, yet I hope it won't. Most I2C transfers tend to be very
small, so PIOQEUE would have some advantage here (less overhead).

> > The only thing to be chained is the I2C read command and the actual
> > reading of the data.
> > 
> > Just checked, the FSL driver does it basically this way, too.
> 
> Which doesn't mean FSL driver does it correctly, but it probably
> worked for them and there was some bug in my DMA tinkering.

It's only a proof-of-concept. We both know that :) (If it works, that
is, AFAICT that one will fail for transfers bigger than PAGE_SIZE, too).

Thanks,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120427/10286e8f/attachment.sig>
