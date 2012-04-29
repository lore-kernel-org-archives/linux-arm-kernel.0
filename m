From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sun, 29 Apr 2012 14:10:20 +0300
Subject: [PATCH 00/10] allow mxc_nand to be probed via device tree
In-Reply-To: <20120429092701.GS20039@pengutronix.de>
References: <20120423092240.GA18013@pengutronix.de>
 <1335615654.1937.20.camel@koala> <20120429092701.GS20039@pengutronix.de>
Message-ID: <1335697820.1942.2.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2012-04-29 at 11:27 +0200, Uwe Kleine-K?nig wrote:
> Hello Artem,
> 
> On Sat, Apr 28, 2012 at 03:20:54PM +0300, Artem Bityutskiy wrote:
> > On Mon, 2012-04-23 at 11:22 +0200, Uwe Kleine-K?nig wrote:
> > > Hello,
> > > 
> > > this series aims to be able to probe mxc_nand devices via device tree.
> > > Most of its patches reorganize the driver to only use cpu_is_mxYZ for
> > > the case that the device is not probed via device tree.
> > > 
> > > I split this conversion in several patches to allow easier review. IMHO
> > > it makes sense to keep this splitting for an eventual bisection.
> > > 
> > > This is tested on an i.MX27 based machine and works fine including
> > > passing of partition data.
> > 
> > Applied all 11 patches from your git tree to l2-mtd.git. Note, you have
> > one checkpatch.pl warning:
> > 
> > WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
> > #69: FILE: drivers/mtd/nand/mxc_nand.c:274:
> > +static const char *part_probes[] = { "RedBoot", "cmdlinepart", "ofpart", NULL };
> I noticed that, too. This is not new though and as
> mtd_device_parse_register takes a const char **types applying
> checkpatch's advice would yield another warning. But probably fixing
> both would work. I wouldn't address this as part of this series.
> 
> > Also there are still several sparse warnings, e.g.
> > 
> > +drivers/mtd/nand/mxc_nand.c:1249:26: warning: incorrect type in initializer (different modifiers) [sparse]
> > +drivers/mtd/nand/mxc_nand.c:1249:26:    expected void *data [sparse]
> > +drivers/mtd/nand/mxc_nand.c:1249:26:    got struct mxc_nand_devtype_data static const [toplevel] *<noident> [sparse]
> > 
> > And you added few gcc warnings, e.g.:
> > 
> > +drivers/mtd/nand/mxc_nand.c:1252:3: warning: initialization discards 'const' qualifier from pointer target type [enabled by default]
> This is the same problem, i.e. casting away several consts. Hmm, and for
> me neither gcc nor sparse provide that warning but I wonder why. At some
> point I saw this warning, so I sent a patch:

Try to compile with gcc 4.6 - you can download it from here:
ftp://ftp.kernel.org/pub/tools/crosstool/files/bin/

I do not know whether it produces good binaries or not, but for
compile-testing it is much better than ancient gcc 4.3.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120429/8c14338f/attachment.sig>
