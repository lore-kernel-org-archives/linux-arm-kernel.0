From: joe@perches.com (Joe Perches)
Date: Thu, 29 Sep 2016 11:06:32 -0700
Subject: [PATCH] dmaengine: coh901318: fix integer overflow when
 shifting more than 32 places
In-Reply-To: <20160929175725.14157-1-colin.king@canonical.com>
References: <20160929175725.14157-1-colin.king@canonical.com>
Message-ID: <1475172392.2027.12.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-09-29 at 18:57 +0100, Colin King wrote:
> Currently U300_DMA_CHANNELS is set to 40, meaning that the shift of 1 can
> be more than 32 places, which leads to a 32 bit integer overflow. Fix this
> by casting 1 to a u64 (the same type as started_channels) before shifting
> it.

trivia:

> diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
[]
> @@ -1353,7 +1353,7 @@ static ssize_t coh901318_debugfs_read(struct file *file, char __user *buf,
> ?	tmp += sprintf(tmp, "DMA -- enabled dma channels\n");
> ?
> ?	for (i = 0; i < U300_DMA_CHANNELS; i++)
> -		if (started_channels & (1 << i))
> +		if (started_channels & ((u64)1 << i))

Using

		if (started_channels & (1ULL << i))

would be more common.

It's also how started_channel bits are set and cleared later in the file.

And maybe the for loop should use braces.
