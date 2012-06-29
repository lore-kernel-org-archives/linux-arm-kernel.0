From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 29 Jun 2012 14:34:24 +0300
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <20120525145901.GS30400@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
 <1337957902.30969.46.camel@sauron.fi.intel.com>
 <20120525145901.GS30400@pengutronix.de>
Message-ID: <1340969664.3070.162.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-05-25 at 16:59 +0200, Sascha Hauer wrote:
> > WARNING:LONG_LINE: line over 80 characters
> > #103: FILE: drivers/mtd/nand/mxc_nand.c:276:
> > +static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)
> > 
> > WARNING:VOLATILE: Use of volatile is usually wrong: see Documentation/volatile-considered-harmful.txt
> > #103: FILE: drivers/mtd/nand/mxc_nand.c:276:
> > +static void memcpy32_fromio(void *trg, const volatile void __iomem  *src, size_t size)
> 
> This makes me wonder a bit, I basically copied the prototype from
> the _memcpy_*_io template from arch/arm/kernel/io.c. Should they
> be wrong?

Well, this is arch-specific code. In there we may make various
assumptions about CPU not doing re-ordering. You are changing generic
code, you should not do assumptions like this.

How about adding these functions to arch/arm/kernel/io.c instead?

> otoh I also wondered why there were volatiles in arch/arm/kernel/io.c
> in the first place ;)

Not sure, probably in that file we assume that the memory is
strongly-ordered.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/942ccb1a/attachment.sig>
