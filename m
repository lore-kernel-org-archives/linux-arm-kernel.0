From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Apr 2016 11:00:52 +0100
Subject: [PATCH 1/2] ARM: PIE infrastructure
In-Reply-To: <1459668234-16033-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1459668234-16033-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1459668234-16033-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20160404100052.GS19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 03, 2016 at 09:23:53AM +0200, Alexandre Belloni wrote:
> +struct pie_chunk *__pie_load_data(struct gen_pool *pool, void *code_start,
> +				  void *code_end, bool phys)
> +{
> +	struct pie_chunk *chunk;
> +	unsigned long offset;
> +	int ret;
> +	size_t code_sz;
> +	unsigned long base;
> +	phys_addr_t pbase;
> +
> +	chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
> +	if (!chunk) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	code_sz = code_end - code_start;
> +	chunk->pool = pool;
> +	chunk->sz = code_sz;
> +
> +	base = gen_pool_alloc(pool, chunk->sz);
> +	if (!base) {
> +		ret = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	pbase = gen_pool_virt_to_phys(pool, base);
> +	chunk->addr = (unsigned long)__arm_ioremap_exec(pbase, code_sz, false);
> +	if (!chunk->addr) {
> +		ret = -ENOMEM;
> +		goto err_remap;
> +	}
> +
> +	/* Copy chunk specific code/data */
> +	fncpy((char *)chunk->addr, code_start, code_sz);

Sorry, NAK.  This abuses fncpy().  There is extensive documentation on
the proper use of this in asm/fncpy.h, and anything that does not
conform, or which uses memcpy() to copy functions, gets an immediate
NAK from me.  fncpy() exists to avoid people doing broken things, and
it's written in such a way to help people get it right.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
