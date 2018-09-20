From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 21 Sep 2018 00:55:40 +0200
Subject: [RFC PATCH 4/4] i2c: core: introduce master_xfer_irqless callback
In-Reply-To: <ca62f8b1-26e2-2b40-d8ce-39a920d90063@axentia.se>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-5-wsa+renesas@sang-engineering.com>
 <ca62f8b1-26e2-2b40-d8ce-39a920d90063@axentia.se>
Message-ID: <20180920225540.GC988@kunai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2018 at 07:41:05PM +0200, Peter Rosin wrote:
> On 2018-09-20 18:14, Wolfram Sang wrote:
> > We had the request to access devices very late when interrupts are not
> > available anymore multiple times now. Mostly to prepare shutdown or
> 
> The first sentence is a bit backwards, I'd rephrase like so:
> 
> Multiple times now we've had the request to access devices very late, when
> interrupts are no longer available.

Ok. Don't see much difference, but I don't mind.

> > reboot. Allow adapters to specify a specific callback for this case.
> > Note that we fall back to the generic master_xfer callback if this new
> > irqless one is not present. This is intentional to preserve the previous
> > behaviour and avoid regressions. Because there are drivers not using
> > interrupts or because it might have worked "accidently" before.
> 
> accidentally

Thanks.

> > @@ -498,6 +498,8 @@ i2c_register_board_info(int busnum, struct i2c_board_info const *info,
> >   * @master_xfer: Issue a set of i2c transactions to the given I2C adapter
> >   *   defined by the msgs array, with num messages available to transfer via
> >   *   the adapter specified by adap.
> > + * @master_xfer_irqless: same as master_xfer. Yet, not using any interrupts
> 
> "Same" (with capital 'S') to match the other entries. Also, should it
> not be @master_xfer to help the tools do the right thing?

I'll check. You are probably right.

> > + *   so e.g. PMICs can be accessed very late before shutdown
> 
> Trailing period.
> 
> I'm fine with this change, but should it not wait until there is a user?
> (I think there is one in the wings, so that's a very weak objection...)

As I mentioned in the cover-letter, this series is RFC because it is
mainly meant as assistance for Stefan, so he could base his imx patches
on top of it. Or the TI folks for their omap driver.

I somewhen need to implement irqless transfers for the i2c-sh_mobile
driver. But this may take a while, so I hope the others are first. And
yes, I won't apply this series without a user and proper testing.

Thanks for the review, Peter!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/7ea2df25/attachment.sig>
