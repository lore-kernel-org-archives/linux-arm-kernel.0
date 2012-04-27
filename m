From: marex@denx.de (Marek Vasut)
Date: Fri, 27 Apr 2012 17:08:53 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <20120427145936.GD16504@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
 <201204270110.21377.marex@denx.de> <20120427145936.GD16504@pengutronix.de>
Message-ID: <201204271708.53467.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Hi,
> 
> > I've been thinking about the DMA approach. The problem I found out is
> > that we need to transfer all messages we're given at time in one DMA
> > chain ... at least that's how I understand it from the FSL manual (see
> > Fig. 27-10 in the mx28 manual).
> 
> I can't follow you:  mxs_i2c_xfer() gets a list of messages, yet they
> are iterated over in mxs_i2c_xfer_msg(). A single I2C message is
> unscattered and can't be bigger than 64KB, so that should be doable?

You can get a large list of i2c messages. In the current implementation, yes, 
they're iterated in mxs_i2c_xfer_msg. Correct.

If you want to do DMA transfer do/from the i2c controller, you have to take all 
these messages and create the chain of DMA transfers according to these 
messages, correct?

So either I missed something, or you need to do something like this to do the 
transfer:

for_each_message {
 sg_init_one()
 dma_map_sg()
 dmaengine_prep_slave_sg()
}

and then dmaengine_submit(). Is that correct?

And for each iteration of the cycle above, you need one scatterlist, you can't 
recycle one, correct?

So to create the chain. we'd need one scatterlist per message, correct?

> Am I missing something by already being in weekend-mode? :)

Best regards,
Marek Vasut
