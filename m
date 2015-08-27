From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Aug 2015 11:06:41 +0100
Subject: [PATCH] regmap: Fix the null function of format_val on
 regmap_bulk_read.
In-Reply-To: <20150827054925.GK706@pengutronix.de>
References: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
 <20150826123556.GB2977@sirena.org.uk>
 <20150826132246.GR706@pengutronix.de>
 <20150826173812.GA28760@sirena.org.uk>
 <20150827054925.GK706@pengutronix.de>
Message-ID: <20150827100641.GA5313@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 07:49:25AM +0200, Markus Pargmann wrote:
> On Wed, Aug 26, 2015 at 06:38:12PM +0100, Mark Brown wrote:
> > On Wed, Aug 26, 2015 at 03:22:46PM +0200, Markus Pargmann wrote:

> > > The regmap_bulk_read() function worked before the following patch:
> > > 	15b8d2c41fe5 (regmap: Fix regmap_bulk_read in BE mode)

> > Define "worked" here.

> "worked" means here that it did not run into a null pointer and returned
> something that the user expected. I am not sure if someone actually
> complained about the previous use of memcpy? I also don't know how the
> behavior of regmap_bulk_read with reg_read() is defined.

Which basically boils down to hacked something that happened to work
with the current implementation but wasn't obviously coherent - this is 
part of the problem, the interface just happened so hasn't been thought
through.  It's not clear that defining the bit sizes at all without any
formatting makes sense, if anything I would have been expecting arrays
of unsigned integers to be being passed around since that's how we store
unformatted values in regmap.

Using memcpy() worries me because we are using memcpy() to move a value
that isn't an unsigned long out of an unsigned long and I can't convince
myself that this will be safe on big endian systems.  If we are going to
keep using the val_bits word size then we're going to need to rewrite
the values.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150827/b16c5f24/attachment.sig>
