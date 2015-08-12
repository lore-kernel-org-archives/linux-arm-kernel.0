From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 14:07:09 +0200
Subject: [PATCH 06/20] regmap: Fix regmap_bulk_write for bus writes
In-Reply-To: <20150812111031.GV10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
 <20150812111031.GV10748@sirena.org.uk>
Message-ID: <20150812120709.GD19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:10:31PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:31PM +0200, Markus Pargmann wrote:
> 
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> 
> I'm not sure why you're putting this in these commit messages...

Just to not forget that Stephen should be in Cc as he introduced the
switch case which removed the code that I add here again:
	f4298360a5c2 (regmap: Allow regmap_bulk_write() to work for "no-bus" regmaps)

> 
> >  	if (!map->bus || map->use_single_rw) {
> > +		if (val_bytes != 1 && val_bytes != 2 && val_bytes != 4)
> > +			return -EINVAL;
> > +
> 
> switch statement please.  This also looks like a separate change to the
> handling of single writes.

Sorry this was a left-over of a previous arrangement. Will remove it.

> 
> > +	} else if (map->use_single_rw) {
> > +		/*
> 
> How are we ever going to fall into this else case?  The first check has
> an || map->use_single_rw it so if this is true then the first check will
> be too so we'd never end up in this else case.

Oh right, seems like another leftover of rebases :-/ sorry. The above
condition should just be
 	if (!map->bus) {

Otherwise we fall into to this second case which is also able to handle
for example 3 byte values.

Thanks,

Markus

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/5ca1592e/attachment.sig>
