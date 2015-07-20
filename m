From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Jul 2015 16:02:54 +0100
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20150720150254.GC11162@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 08:41:50PM +0800, Henry Chen wrote:
> The regmap_format will not be initialize since regmap_bus is not assgined 
> on regmap_init(). It should has a function check before using 
> format_val() to avoid null function called on regmap_bulk_read().

> -			map->format.format_val(val + (i * val_bytes), ival, 0);
> +			if (map->format.format_val)
> +				map->format.format_val(val + (i * val_bytes), ival, 0);
> +			else
> +				memcpy(val + (i * val_bytes), &ival, val_bytes);

Your changelog doesn't explan why we are in this code path in the first
place without a format_val() and why a memcpy() is an appropriate
replacement.  It should, it's not clear to me that this is a good fix
but I don't feel I fully understand the problem.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150720/bd264eb8/attachment-0001.sig>
