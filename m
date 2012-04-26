From: marex@denx.de (Marek Vasut)
Date: Fri, 27 Apr 2012 01:10:21 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <20120426114201.GC3548@pengutronix.de>
References: <201204261326.29388.marex@denx.de>
 <20120426114201.GC3548@pengutronix.de>
Message-ID: <201204270110.21377.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Hi Marek,
> 
> you forgot the most important list, linux-i2c ;)
> 
> > I recently tried mxs-i2c (on 3.4-rc4) with at24 eeprom, didn't work as
> > expected.
> 
> Yes, we had the same this week/last week.

Ah ok ;-)
> 
> > Apparently, there might be some timing issue, when I put printk() into
> > the at24 driver eeprom write function, it "fixed" itself. Though,
> > replacing the i2c driver with i2c gpio also fixed the issue, so I
> > suspect the i2c driver has some flaw in it.
> 
> Try removing the printk and use the module paramter "io_limit=24" for
> at24. Does this help? (Or bs<=24 with dd)
> 
> > If noone has any fixes already, I'll debug this tonight or so.
> 
> The write FIFO overflows, since it only can carry 8 words. There is
> currently no check for that. One solution would be to check the FIFO
> status and fill them as needed. This will probably require additional
> locking, so I think the proper solution would be to use DMA for
> transfers bigger than the write FIFO size (we would get MX23 support
> then, too). Sadly, we don't have DMA support yet and I don't have time
> to implement it.
> 
> I am thinking if such transfers which would fail anyway, should
> currently be rejected or if the driver should depend on BROKEN or both.
> 
> I am still undecided, though.

I've been thinking about the DMA approach. The problem I found out is that we 
need to transfer all messages we're given at time in one DMA chain ... at least 
that's how I understand it from the FSL manual (see Fig. 27-10 in the mx28 
manual).

Therefore we'd have to prepare scatterlist for each message that we're given to 
transfer. In case we'd be given huge set of messages, we'd have to allocate 
these scatterlists at runtime. And maybe we'd even have to allocate buffers (to 
resize the ones in msg.buf for the additional one byte for i2c address).

I don't like the idea of calling kmalloc() in mxs_i2c_xfer_message() at all, 
does anyone have any hint how to handle these?

> 
> Please also check the patch I sent yesterday, there is also another one
> coming after I get confirmation from a customer.

Thanks

> Regards,
> 
>    Wolfram

Best regards,
Marek Vasut
