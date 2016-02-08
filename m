From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 8 Feb 2016 12:03:17 -0800
Subject: [RESEND2 PATCH 1/3] memremap: add MEMREMAP_WC flag
In-Reply-To: <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
References: <cover.1454950917.git.brian.starkey@arm.com>
 <9085d37fa97a762a46b9d58719c085368682c64f.1454950917.git.brian.starkey@arm.com>
Message-ID: <20160208120317.313409dc0ae7634c25d3f021@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  8 Feb 2016 17:30:50 +0000 Brian Starkey <brian.starkey@arm.com> wrote:

> Add a flag to memremap() for writecombine mappings. Mappings satisfied
> by this flag will not be cached, however writes may be delayed or
> combined into more efficient bursts. This is most suitable for
> buffers written sequentially by the CPU for use by other DMA devices.
> 
> ...

The patch generally looks OK to me.  It generates rejects against
linux-next because of some janitorial changes in memremap.c.


> @@ -101,6 +107,11 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
>  		addr = ioremap_wt(offset, size);
>  	}
>  
> +	if (!addr && (flags & MEMREMAP_WC)) {
> +		flags &= ~MEMREMAP_WC;
> +		addr = ioremap_wc(offset, size);
> +	}
> +
>  	return addr;
>  }

The modifications of `flags' is unneeded (and the compiler will remove
it).  And generally the modification of incoming args is a bit nasty
IMO - I find it's better to treat them as const - part of the calling
environment which can be relied upon to be unaltered as the code
evolves.
