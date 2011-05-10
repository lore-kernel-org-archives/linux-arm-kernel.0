From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 10:59:20 +0100
Subject: [PATCH 06/13] clocksource: add common mmio clocksource
In-Reply-To: <E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
References: <20110510072700.GA29869@n2100.arm.linux.org.uk>
	<E1QJhNe-0000yh-HS@rmk-PC.arm.linux.org.uk>
Message-ID: <20110510095920.GB29977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 08:29:18AM +0100, Russell King - ARM Linux wrote:
> +cycle_t clocksource_mmio_readl_up(struct clocksource *c)
> +{
> +	return readl_relaxed(to_mmio_clksrc(c)->reg);
> +}
> +
> +cycle_t clocksource_mmio_readl_down(struct clocksource *c)
> +{
> +	return ~readl_relaxed(to_mmio_clksrc(c)->reg);
> +}
> +
> +cycle_t clocksource_mmio_readw_up(struct clocksource *c)
> +{
> +	return readw_relaxed(to_mmio_clksrc(c)->reg);
> +}
> +
> +cycle_t clocksource_mmio_readw_down(struct clocksource *c)
> +{
> +	return ~(unsigned)readw_relaxed(to_mmio_clksrc(c)->reg);
> +}

I probably ought to point out why that cast is there: readw* returns an
u16.

u16 will be promoted to 'int' by the compiler, then not'd, and then
extended to cycle_t (64-bit).  This extension is a signed extension
which not only results in more code than required, but also results in
a delay slot not being filled.

It's the u16 -> signed int -> cycle_t which causes the signed extension.

u16 -> cycle_t doesn't involve changing the signed-ness of the type, so
doesn't suffer.

Neither does readl as it returns a u32 which doesn't need any promotion
to an int type.

So, rather than allow the compiler to do automatic promotion to a signed
int, the cast is there to ensure that it becomes an unsigned int instead.
