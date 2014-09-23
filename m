From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 20:23:21 +0200
Subject: [PATCH] dmaengine: fsl-edma: fixup reg offset and hw S/G support
 in big-endian model
In-Reply-To: <1411492720444.3205@freescale.com>
References: <1411463719-7728-1-git-send-email-jingchang.lu@freescale.com>
 <45444544.Xl4NeUiTm0@wuerfel> <1411492720444.3205@freescale.com>
Message-ID: <4465641.JLAzuEs1O5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 17:18:43 Jingchang Lu wrote:
> I will reconsider this setting. BTW, why writel() can't be used
> for memory location since it's still mapped and registers space is
> also memory mapped? Thanks.

You cannot rely on an '__iomem' token to actually be a pointer, even
if that is currently the case on ARM.

On other architectures, the bits in the pointer can encode something
completely different, e.g. it may be the physical address on
architectures that have instructions to load/store on that directly,
and ioremap() in that case returns an identity mapping.

If you install sparse and build with 'make C=1', you will in fact
get a warning about the code when you assign a regular pointer to
an __iomem pointer or vice versa.

	Arnd
