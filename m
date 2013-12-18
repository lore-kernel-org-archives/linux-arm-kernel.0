From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Dec 2013 18:45:41 +0000
Subject: [PATCH] regmap: Allow regmap_bulk_write() to work for "no-bus"
 regmaps
In-Reply-To: <20131217023047.GC31766@codeaurora.org>
References: <20131210235000.GK11468@sirena.org.uk>
 <52A7AE1B.3040201@codeaurora.org>
 <20131211005106.GL11468@sirena.org.uk>
 <52A7C0C3.2070805@codeaurora.org>
 <20131211132729.GT11468@sirena.org.uk>
 <52AA42FD.4040503@codeaurora.org>
 <20131213104128.GT11044@sirena.org.uk>
 <20131213213707.GO21983@codeaurora.org>
 <20131216210153.GA3185@sirena.org.uk>
 <20131217023047.GC31766@codeaurora.org>
Message-ID: <20131218184541.GH31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 06:30:47PM -0800, Stephen Boyd wrote:

> -	/* No formatting is require if val_byte is 1 */
> -	if (val_bytes == 1) {
> -		wval = (void *)val;
> +			ival = *(unsigned int *)(val + (i * val_bytes));
> +			ret = _regmap_write(map, reg + (i * map->reg_stride),
> +					ival);
> +			if (ret != 0)
> +				goto out;

This doesn't quite work - val is an array of objects of the size of the
size of a register not of unsigned integers so you're parsing extra data
out there.  That possibly wasn't the best choice of API but we have
quite a few users now so ick.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131218/035c6bc6/attachment.sig>
