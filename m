From: broonie@kernel.org (Mark Brown)
Date: Wed, 4 Nov 2015 14:39:15 +0000
Subject: [PATCH v2 1/5] spi: introduce mmap read support for spi flash
 devices
In-Reply-To: <1446545174-14193-2-git-send-email-vigneshr@ti.com>
References: <1446545174-14193-1-git-send-email-vigneshr@ti.com>
 <1446545174-14193-2-git-send-email-vigneshr@ti.com>
Message-ID: <20151104143915.GI1717@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 03:36:10PM +0530, Vignesh R wrote:

> +	}
> +	mutex_lock(&master->mmap_lock_mutex);
> +	ret = master->spi_mtd_mmap_read(spi, from, len, retlen, buf,
> +					read_opcode, addr_width,
> +					dummy_bytes);
> +	mutex_unlock(&master->mmap_lock_mutex);
> +	if (master->auto_runtime_pm)
> +		pm_runtime_put(master->dev.parent);

It's a bit worrying that this doesn't sync with the message queue except
via the mutex: this means that we might be out of order with respect to
any asynchronous transfers that are happening on the device.  I'm not
sure that this is a practical problem, though there is some risk of
unfair scheduling that would have to be under extreme load and it might
make sense to prioritise reads anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151104/71e12d1f/attachment.sig>
