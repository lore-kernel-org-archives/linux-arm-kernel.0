From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 Sep 2014 11:59:39 +0200
Subject: [PATCH] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <CAE0=X_0VQ8rWrUgbsgKm1MwCP8bwWm3UJPq9p=xNDfjP4CC7Bg@mail.gmail.com>
References: <1408967482-17723-1-git-send-email-anders.berg@avagotech.com>
 <20140920121242.GA3833@katana>
 <CAE0=X_0VQ8rWrUgbsgKm1MwCP8bwWm3UJPq9p=xNDfjP4CC7Bg@mail.gmail.com>
Message-ID: <20140922095939.GB1406@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> >> +             if (idev->msg_xfrd == 0 && i2c_m_recv_len(msg)) {
> >> +                     /*
> >> +                      * Check length byte for SMBus block read
> >> +                      */
> >> +                     if (c <= 0) {
> >> +                             idev->msg_err = -EPROTO;
> >> +                             i2c_int_disable(idev, ~0);
> >> +                             complete(&idev->msg_complete);
> >> +                             break;
> >> +                     } else if (c > I2C_SMBUS_BLOCK_MAX) {
> >> +                             c = I2C_SMBUS_BLOCK_MAX;
> >
> > What about returning -EPROTO here as well? I don't think that reading
> > just a slice of all the data is helpful.
> >
> 
> Right, that is probably true. This came from the device I was using to
> test the block-read operation. This device violated the
> I2C_SMBUS_BLOCK_MAX limit, so I added this truncation to at least get
> something out...

Which device was it? I know there are some doing that, yet I like to
know which ones.

> >> +{
> >> +     struct axxia_i2c_dev *idev = _dev;
> >> +     u32 status;
> >> +
> >> +     if (!idev->msg)
> >> +             return IRQ_NONE;
> >
> > This is actually not true. There might be interrupt bits set, so there
> > is an IRQ. There shouldn't be one, right, but that's another case IMO.
> >
> 
> You could see it as: there is no interrupt that this handler is
> interested in serving. I'd like to keep this test as there is some
> legacy software that could be run on platforms with this driver that
> access the I2C controller directly. If this happens, this test assures
> that the user get an informative "unhandled irq" error message
> (instead of a null pointer dereference).

IRQ_NONE is "this interrupt wasn't by me" so for shared IRQs, the next
handler can check. You shouldn't remove the check per se. Still,  since
this interrupt was definately from the I2C core, you should return
IRQ_HANDLED and print an error message to the logs.

> >> +static int
> >> +axxia_i2c_xfer_msg(struct axxia_i2c_dev *idev, struct i2c_msg *msg)
> >> +{
> >> +     u32 int_mask = MST_STATUS_ERR | MST_STATUS_SNS;
> >> +     u32 rx_xfer, tx_xfer;
> >> +     u32 addr_1, addr_2;
> >> +     int ret;
> >> +
> >> +     if (msg->len == 0 || msg->len > 255)
> >> +             return -EINVAL;
> >
> > Ouch, really? Maybe we should warn the user here.
> 
> Yeah, the transfer length register limits the length to 255. I'll add
> a warning here.

Please also add this information to the Kconfig description and
somewhere at the top of the source file. This is an important flaw which
people should easily find out about.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/76868cc6/attachment-0001.sig>
