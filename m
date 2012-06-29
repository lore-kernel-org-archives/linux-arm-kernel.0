From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jun 2012 13:28:47 +0200
Subject: [PATCH 1/2] mtd mxc_nand: use 32bit copy functions
In-Reply-To: <1340969124.3070.155.camel@sauron.fi.intel.com>
References: <1337955762-19157-1-git-send-email-s.hauer@pengutronix.de>
 <20120627175234.GF18096@pengutronix.de>
 <1340969124.3070.155.camel@sauron.fi.intel.com>
Message-ID: <20120629112847.GD12019@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

On Fri, Jun 29, 2012 at 02:25:24PM +0300, Artem Bityutskiy wrote:
> On Wed, 2012-06-27 at 19:52 +0200, Uwe Kleine-K?nig wrote:
> > I don't know about the sparse problems this introduces, but without this
> > patch the mxc-nand driver is broken, so it should really go in before
> > 3.5.
> 
> The problems, AFAIU, are that you cannot directly dereference __iomem
> pointers, you always need to use helpers like 'readl()'. This patch
> introduces the following warnings:
> 
> +drivers/mtd/nand/mxc_nand.c:281:33: warning: incorrect type in initializer (different address spaces) [sparse]
> +drivers/mtd/nand/mxc_nand.c:281:33:    expected unsigned int const volatile [usertype] *s [sparse]
> +drivers/mtd/nand/mxc_nand.c:281:33:    got void const volatile [noderef] <asn:2>*src [sparse]
> +drivers/mtd/nand/mxc_nand.c:284 memcpy32_fromio() warn: side effect in macro '__raw_readl' doing 's++' [smatch]
> +drivers/mtd/nand/mxc_nand.c:284:24: warning: incorrect type in argument 1 (different address spaces) [sparse]
> +drivers/mtd/nand/mxc_nand.c:284:24:    expected void const volatile [noderef] <asn:2>*<noident> [sparse]
> +drivers/mtd/nand/mxc_nand.c:284:24:    got unsigned int const volatile [usertype] * [sparse]
> +drivers/mtd/nand/mxc_nand.c:290:27: warning: incorrect type in initializer (different address spaces) [sparse]
> +drivers/mtd/nand/mxc_nand.c:290:27:    expected unsigned int volatile [usertype] *t [sparse]
> +drivers/mtd/nand/mxc_nand.c:290:27:    got void volatile [noderef] <asn:2>*trg [sparse]
> +drivers/mtd/nand/mxc_nand.c:294 memcpy32_toio() warn: side effect in macro '__raw_writel' doing 't++' [smatch]
> +drivers/mtd/nand/mxc_nand.c:294:17: warning: incorrect type in argument 1 (different address spaces) [sparse]
> +drivers/mtd/nand/mxc_nand.c:294:17:    expected void const volatile [noderef] <asn:2>*<noident> [sparse]
> +drivers/mtd/nand/mxc_nand.c:294:17:    got unsigned int volatile [usertype] * [sparse]
> 
> The "volitile" should be also removed.
Did you see that Sascha posted a v2?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
