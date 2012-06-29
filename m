From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Fri, 29 Jun 2012 14:25:24 +0300
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <20120627175234.GF18096@pengutronix.de>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
 <20120627175234.GF18096@pengutronix.de>
Message-ID: <1340969124.3070.155.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-27 at 19:52 +0200, Uwe Kleine-K?nig wrote:
> I don't know about the sparse problems this introduces, but without this
> patch the mxc-nand driver is broken, so it should really go in before
> 3.5.

The problems, AFAIU, are that you cannot directly dereference __iomem
pointers, you always need to use helpers like 'readl()'. This patch
introduces the following warnings:

+drivers/mtd/nand/mxc_nand.c:281:33: warning: incorrect type in initializer (different address spaces) [sparse]
+drivers/mtd/nand/mxc_nand.c:281:33:    expected unsigned int const volatile [usertype] *s [sparse]
+drivers/mtd/nand/mxc_nand.c:281:33:    got void const volatile [noderef] <asn:2>*src [sparse]
+drivers/mtd/nand/mxc_nand.c:284 memcpy32_fromio() warn: side effect in macro '__raw_readl' doing 's++' [smatch]
+drivers/mtd/nand/mxc_nand.c:284:24: warning: incorrect type in argument 1 (different address spaces) [sparse]
+drivers/mtd/nand/mxc_nand.c:284:24:    expected void const volatile [noderef] <asn:2>*<noident> [sparse]
+drivers/mtd/nand/mxc_nand.c:284:24:    got unsigned int const volatile [usertype] * [sparse]
+drivers/mtd/nand/mxc_nand.c:290:27: warning: incorrect type in initializer (different address spaces) [sparse]
+drivers/mtd/nand/mxc_nand.c:290:27:    expected unsigned int volatile [usertype] *t [sparse]
+drivers/mtd/nand/mxc_nand.c:290:27:    got void volatile [noderef] <asn:2>*trg [sparse]
+drivers/mtd/nand/mxc_nand.c:294 memcpy32_toio() warn: side effect in macro '__raw_writel' doing 't++' [smatch]
+drivers/mtd/nand/mxc_nand.c:294:17: warning: incorrect type in argument 1 (different address spaces) [sparse]
+drivers/mtd/nand/mxc_nand.c:294:17:    expected void const volatile [noderef] <asn:2>*<noident> [sparse]
+drivers/mtd/nand/mxc_nand.c:294:17:    got unsigned int volatile [usertype] * [sparse]

The "volitile" should be also removed.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120629/da941a49/attachment.sig>
