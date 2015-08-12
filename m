From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Aug 2015 12:49:31 +0100
Subject: [PATCH 12/20] regmap: Introduce max_raw_io for
 regmap_bulk_read/write
In-Reply-To: <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-13-git-send-email-mpa@pengutronix.de>
Message-ID: <20150812114931.GZ10748@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 12:12:37PM +0200, Markus Pargmann wrote:

> +	/* if set, raw reads/writes are limited to this size */
> +	size_t max_raw_io;
> +

Do this separately for read and write, there's doubtless going to be
something that has asymmetry.

> +		if (!map->use_single_rw) {
> +			write_count = total_bytes / map->max_raw_io;
> +			write_bytes = map->max_raw_io;

We may not be able to fit a whole number of values into whatever the
constraint that the bus has is and partial values don't seem like a good
idea.

> +			reg_stride *= write_bytes / val_bytes;
> +		}

This is very confusing, regmap already has a concept of stride and this
isn't the same thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/c337ed3f/attachment.sig>
