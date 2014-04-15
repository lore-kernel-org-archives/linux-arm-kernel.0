From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Apr 2014 11:09:22 +0100
Subject: [RFC PATCH v2] regmap: smbus: add support for regmap over SMBus
In-Reply-To: <534CE16D.8010508@free-electrons.com>
References: <1397292335-5516-1-git-send-email-boris.brezillon@free-electrons.com>
 <1397480885-11962-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140414210429.GJ25182@sirena.org.uk>
 <534CE16D.8010508@free-electrons.com>
Message-ID: <20140415100922.GN12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 09:36:13AM +0200, Boris BREZILLON wrote:
> On 14/04/2014 23:04, Mark Brown wrote:

> > The transfer type gets set once per device at init time so why not
> > just parameterise based on val_bytes?

> Actually, you may want to transfer 1 byte registers using the block
> method (if your device only support block transfers). This depends on
> the device being accessed and what it supports, but I'm not sure we can
> assume 1 byte registers will always be transferred using SMBUS byte
> transfers.

OK, so if this a realistic issue then it seems like it's better to
implement three different buses - there is not really any common code
between the various paths.  This would also mean that you avoid having
gather write when it can't be implemented.

The code is also not validating the lengths for two byte values.

> >> +    case REGMAP_SMBUS_I2C_BLOCK_TRANSFER: +        while (count
> >> > 0 && !ret) { +            ret =
> >> i2c_smbus_write_i2c_block_data(ctx->i2c, +
> >> reg, +                                 ctx->val_bytes, +
> >> (const u8 *)data);

> > Fix the const correctness of the API rather than casting.

> The API is correct because the i2c_smbus_write_i2c_block does not modify
> the data pointer.
> Just removing the const keyword in the cast should be enough, because
> you can safely cast a non const pointer to a const one.

If you need to cast away from void at all something is going wrong (and
we appear to be always passing in write buffers as const too, I can't
remember which operation this was though).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140415/101e2bae/attachment.sig>
