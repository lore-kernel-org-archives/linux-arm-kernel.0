From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Dec 2016 16:47:42 +0000
Subject: [PATCH v2 2/2] mfd: axp20x: Fix AXP806 access errors on cold boot
In-Reply-To: <20161209112018.GL3625@dell.home>
References: <20161123031616.10114-1-wens@csie.org>
 <20161123031616.10114-3-wens@csie.org>
 <20161209112018.GL3625@dell.home>
Message-ID: <20161213164742.4ztisstxifatlm5a@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 11:20:18AM +0000, Lee Jones wrote:

> Is the following valid/necessary?

> On Wed, 23 Nov 2016, Chen-Yu Tsai wrote:
> > The AXP806 supports either master/standalone or slave mode.
> > Slave mode allows sharing the serial bus, even with multiple
> > AXP806 which all have the same hardware address.

> > This is done with extra "serial interface address extension",
> > or AXP806_BUS_ADDR_EXT, and "register address extension", or
> > AXP806_REG_ADDR_EXT, registers. The former is read-only, with
> > 1 bit customizable at the factory, and 1 bit depending on the

I don't really know anything about the details of this chip, sorry.

> > This patch sets AXP806_REG_ADDR_EXT to 0x10, which is what we
> > know to be the proper value for a standard AXP806 in slave mode.
> > Afterwards it will reinitialize the regmap cache, to purge any
> > invalid stale values.

If the chip has been reset then you'd want to reset the cache too.  I've
no idea if that's needed here or not though, it depends what happens to
the global state of the chip when this reconfiguration happens.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 484 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161213/18150a5a/attachment.sig>
