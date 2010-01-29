From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 29 Jan 2010 15:46:01 +0100
Subject: Uncompressing broken with commit e7db7b4270
In-Reply-To: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
References: <1264698229.7064.93.camel@pc1117.cambridge.arm.com>
Message-ID: <20100129144601.GA27577@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 05:03:49PM +0000, Catalin Marinas wrote:
> Hi,
> 
> For whatever reason, with commit e7db7b4270 (arm: add support for
> LZO-compressed kernels) if the kernel Image goes beyond a certain size
> it fails to uncompress. Reverting this commit solves the problem.
> Removing some random kernel features also solves the uncompressing as
> the kernel image gets smaller.
With the same commit zImage stopped printing dots during decompression.

Something that isn't mentioned in the commit log of e7db7b4270 is that
the decompressing routine for gzip is changed.

Before lib/inflate.c was included by arch/arm/boot/compressed/misc.c,
since e7db7b4270 it's lib/decompress_inflate.c.

Maybe the new implementation needs more stack space?  If so it might
help to increase the stack size.  (This is defined in the last line of
arch/arm/boot/compressed/head.S.  If you change the value be sure to
adapt the value just before the LC1 label in the same file, too.)

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
