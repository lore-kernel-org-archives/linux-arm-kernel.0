From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 26 Apr 2012 13:42:01 +0200
Subject: possible MXS-i2c bug
In-Reply-To: <201204261326.29388.marex@denx.de>
References: <201204261326.29388.marex@denx.de>
Message-ID: <20120426114201.GC3548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

you forgot the most important list, linux-i2c ;)

> I recently tried mxs-i2c (on 3.4-rc4) with at24 eeprom, didn't work as expected.

Yes, we had the same this week/last week.

> Apparently, there might be some timing issue, when I put printk() into the at24 
> driver eeprom write function, it "fixed" itself. Though, replacing the i2c 
> driver with i2c gpio also fixed the issue, so I suspect the i2c driver has some 
> flaw in it.

Try removing the printk and use the module paramter "io_limit=24" for
at24. Does this help? (Or bs<=24 with dd)

> If noone has any fixes already, I'll debug this tonight or so.

The write FIFO overflows, since it only can carry 8 words. There is
currently no check for that. One solution would be to check the FIFO
status and fill them as needed. This will probably require additional
locking, so I think the proper solution would be to use DMA for
transfers bigger than the write FIFO size (we would get MX23 support
then, too). Sadly, we don't have DMA support yet and I don't have time
to implement it.

I am thinking if such transfers which would fail anyway, should
currently be rejected or if the driver should depend on BROKEN or both.

I am still undecided, though.

Please also check the patch I sent yesterday, there is also another one
coming after I get confirmation from a customer.

Regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120426/e69a67b6/attachment.sig>
