From: broonie@kernel.org (Mark Brown)
Date: Wed, 6 Dec 2017 12:58:17 +0000
Subject: [PATCH 5/8] ASoC: uniphier: add support for UniPhier AIO driver
In-Reply-To: <004801d36e57$ea1940d0$be4bc270$@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
 <20171205121440.GC11658@finisterre>
 <004801d36e57$ea1940d0$be4bc270$@socionext.com>
Message-ID: <20171206125817.GF1827@finisterre>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 03:03:18PM +0900, Katsuhiro Suzuki wrote:

> > I'd expect this code to be structured more like a library - have a
> > driver that handles the specific IPs then have it call into a shared
> > block of code that does the generic bits.  Though in this case the
> > device specific bit looks like a couple of tiny data tables so I'm not
> > sure it's worth making it conditional or separate at all.

> Sorry... I agree your opinion, but I can't imagine the detail.

> I think my driver has structure as follows (ex. startup):
>   DAI: uniphier_aio_startup()@aio-core.c
>   Lib: uniphier_aio_init()@aio-regctrl.c
>   SoC specific: uniphier_aio_ld11_spec at aio-ld11.c

> Am I wrong? Would you mean split the functions in aio-regctl.[ch] to other
> kernel module? I wonder if you could tell me the example from existing
> drivers. I'll try to fix my driver like as it.

One example is how all the drivers that use the generic dmaengine code
instantiate their DMA drivers, or how all the drivers for CODECs that
have both I2C and SPIi control interfaces instantiate - given that the
device specific code here seems to be mostly data tables that's probably
the closest thing.

> > At least.  I do think we need to get to the bottom of how flexible the
> > hardware is first though.

> Yes, indeed. This hardware is more flexible and complex, but now I (and our
> company) don't use it. Of course, I don't want to hide some features of this
> hardware from ALSA people. I should try to upstream all features in the future,
> I think.

My main concern here is to make sure that when you decide you need to
use the more complex hardware that this can be done without too much
pain to existing machines (and that they can benefit from as much of the
enhanced functionality as is possible).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171206/bf132a6c/attachment.sig>
