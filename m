From: shinya.kuribayashi.px@renesas.com (Shinya Kuribayashi)
Date: Mon, 08 Jul 2013 11:24:25 +0900
Subject: [PATCH] ARM: shmobile: r8a7790 SMP prototype v3
In-Reply-To: <20130701061340.22064.93012.sendpatchset@w520>
References: <20130701061340.22064.93012.sendpatchset@w520>
Message-ID: <51DA22D9.10703@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Magnus,

Thanks for the patch, see my comments below.

On 7/1/2013 3:13 PM, Magnus Damm wrote:
> --- /dev/null
> +++ work/arch/arm/mach-shmobile/smp-r8a7790.c	2013-07-01 13:41:32.000000000 +0900
> @@ -0,0 +1,187 @@

> +#define SYSC	0xe6180000
> +#define SYSCSR  0x0000
> +
> +#define RST	0xe6160000
> +#define CA15BAR	0x6020

CA15BAR and CA15BAR2 addresses in the datasheet v0.5 are simply wrong;
they should be 0x0020 and 0x0024, respectively.

You could confirm it in the documentation errata for v0.5 or in the
latest datasheet v0.6 release.

I believe that this is not related to an uncertain arch_timer issue you
mentioned in the commit log, but we should use proper addresses at least.

> +#define CA15RESCNT 0x0040
> +#define CA7BAR	0x4030

The same applies for CA7BAR and CA7BAR2 as well.

> +#define CA7RESCNT 0x0044
> +#define RESCNT	0x0050
> +
> +#define APMU	0xe6150000
> +#define CA15WUPCR 0x2010
> +#define CA7WUPCR 0x1010
> +
> +#define MERAM	0xe8080000
> +
> +enum { R8A7790_CLST_CA15, R8A7790_CLST_CA7, R8A7790_CLST_NR };
> +
> +static struct {
> +	unsigned int cabar;
> +	unsigned int carescnt;
> +	unsigned int carescnt_magic;
> +	unsigned int rescnt_bit;
> +	unsigned int use_count;
> +} r8a7790_clst[R8A7790_CLST_NR] = {
> +	[R8A7790_CLST_CA15] = {
> +		.cabar = CA15BAR,
> +		.carescnt = CA15RESCNT,
> +		.carescnt_magic = 0xa5a50000,
> +		.rescnt_bit = 1,
> +	},
> +	[R8A7790_CLST_CA7] = {
> +		.cabar = CA7BAR,
> +		.carescnt = CA7RESCNT,
> +		.carescnt_magic = 0x5a5a0000,
> +		.rescnt_bit = 0,
> +	},
> +};
> +
> +#define r8a7790_clst_id(cpu) (cpu_logical_map((cpu)) >> 8)
> +#define r8a7790_cpu_id(cpu) (cpu_logical_map((cpu)) & 0xff)
> +
> +static void r8a7790_deassert_reset(unsigned int cpu)
> +{
> +	void __iomem *p, *carescnt;
> +	u32 bar, mask, magic;
> +	unsigned int clst_id = r8a7790_clst_id(cpu);
> +
> +	/* setup reset vectors */
> +	p = ioremap_nocache(RST, 0x7000);

Therefore ioremap size for RST should be updated accordingly.

> +	bar = (MERAM >> 8) & 0xfffffc00;
> +	__raw_writel(bar, p + r8a7790_clst[clst_id].cabar);
> +	__raw_writel(bar | 0x10, p + r8a7790_clst[clst_id].cabar);
> +
> +	/* enable clocks for cluster */
> +	if (r8a7790_clst[clst_id].use_count++ == 0) {
> +		mask = 1 << r8a7790_clst[clst_id].rescnt_bit;
> +		__raw_writel(__raw_readl(p + RESCNT) & ~mask, p + RESCNT);
> +	}
> +
> +	/* enable per-core clocks */
> +	mask = BIT(3 - r8a7790_cpu_id(cpu));
> +	magic = r8a7790_clst[clst_id].carescnt_magic;
> +	carescnt = p + r8a7790_clst[clst_id].carescnt;
> +	__raw_writel((__raw_readl(carescnt) & ~mask) | magic, carescnt);
> +
> +	iounmap(p);
> +}
> +
> +static void r8a7790_assert_reset(unsigned int cpu)
> +{
> +	void __iomem *p, *carescnt;
> +	u32 mask, magic;
> +	unsigned int clst_id = r8a7790_clst_id(cpu);
> +
> +	p = ioremap_nocache(RST, 0x7000);

Ditto.
--
Shinya Kuribayashi
Renesas Electronics
