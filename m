From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 27 Aug 2015 07:49:25 +0200
Subject: [PATCH] regmap: Fix the null function of format_val on
 regmap_bulk_read.
In-Reply-To: <20150826173812.GA28760@sirena.org.uk>
References: <1440589396-696-1-git-send-email-henryc.chen@mediatek.com>
 <20150826123556.GB2977@sirena.org.uk>
 <20150826132246.GR706@pengutronix.de>
 <20150826173812.GA28760@sirena.org.uk>
Message-ID: <20150827054925.GK706@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 06:38:12PM +0100, Mark Brown wrote:
> On Wed, Aug 26, 2015 at 03:22:46PM +0200, Markus Pargmann wrote:
> > On Wed, Aug 26, 2015 at 01:35:56PM +0100, Mark Brown wrote:
> > > On Wed, Aug 26, 2015 at 07:43:16PM +0800, Henry Chen wrote:
> 
> > > Why are these format functions sensible?  Converting a null pointer
> > > dereference into data corruption wouldn't be ideal.  The commit message
> > > should really cover this.
> 
> > The regmap_bulk_read() function worked before the following patch:
> > 	15b8d2c41fe5 (regmap: Fix regmap_bulk_read in BE mode)
> 
> Define "worked" here.

"worked" means here that it did not run into a null pointer and returned
something that the user expected. I am not sure if someone actually
complained about the previous use of memcpy? I also don't know how the
behavior of regmap_bulk_read with reg_read() is defined.

Best Regards,

Markus

> 
> > As far as I can see this patch fixes this issue by using simple format
> > functions. Before the above mentioned patch, the code used memcpy. Now
> > regmap_format_*_native is used which should result in the same behaviour
> > but fixes the null pointer.
> 
> Again, this sort of analysis needs to be in the commit message (and
> really ought to explain why the resulting API makes sense).
> 
> > I am not sure if there are other locations in the code where format_val
> > is used in this setup so I don't know if this would change behavior in a
> > different codepath.
> 
> Which is another part of the concern, being able to format values is a
> more general concept.



-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150827/7e3ac6bd/attachment.sig>
