From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:10:31 +0100
Subject: [PATCH 06/20] regmap: Fix regmap_bulk_write for bus writes
In-Reply-To: <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812111031.GV10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:31PM +0200, Markus Pargmann wrote:

> Cc: Stephen Boyd <sboyd@codeaurora.org>

I'm not sure why you're putting this in these commit messages...

>  	if (!map->bus || map->use_single_rw) {
> +		if (val_bytes != 1 && val_bytes != 2 && val_bytes != 4)
> +			return -EINVAL;
> +

switch statement please.  This also looks like a separate change to the
handling of single writes.

> +	} else if (map->use_single_rw) {
> +		/*

How are we ever going to fall into this else case?  The first check has
an || map->use_single_rw it so if this is true then the first check will
be too so we'd never end up in this else case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/6c5fa1df/attachment.sig>
