From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Nov 2011 21:10:08 +0000
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
Message-ID: <20111124211008.GX9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 12:49:54PM +0100, Peter Rusko wrote:
> +struct platform_device * __init mx28_add_lradc(
> +		const struct mxs_lradc_plat_data *pdata)
> +{
> +	struct resource res[] = {
> +		{
> +			.start = MX28_LRADC_BASE_ADDR,
> +			.end = MX28_LRADC_BASE_ADDR + SZ_16K - 1,
> +			.flags = IORESOURCE_MEM,
> +		},
> +	};

I've pointed this out to people before, and I'll do it again.  I wish
people would take a moment to think about the code they write...

How the compiler can implement the above is as this equivalent C code:

static struct res_initializer[] = {
	{
		.start = MX28_LRADC_BASE_ADDR,
		.end = MX28_LRADC_BASE_ADDR + SZ_16K - 1,
		.flags = IORESOURCE_MEM,
	},
};

struct platform_device * __init mx28_add_lradc(
		const struct mxs_lradc_plat_data *pdata)
{
	struct resource res[ARRAY_SIZE(res_initializer)];
	memcpy(res, res_initializer, sizeof(res_initializer));

Or it can put the constants into the literal pool and manually build the
structure on the stack using individual loads and stores.

So, you're not gaining any efficency by attempting this trick - in fact,
your total data + code is larger than just this:

static struct res[] __initdata = {
	{
		.start = MX28_LRADC_BASE_ADDR,
		.end = MX28_LRADC_BASE_ADDR + SZ_16K - 1,
		.flags = IORESOURCE_MEM,
	},
};

struct platform_device * __init mx28_add_lradc(
		const struct mxs_lradc_plat_data *pdata)
{
	return mxs_add_platform_device("mxs-lradc", 0,
			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
}

because doing it this way eliminates the additional stack storage and
manual or otherwise memcpy.  Moreover, you can mark the struct resource
__initdata and have it discarded at runtime.

Here's what I get with gcc 4.3.5 which illustrates the point:

   text    data     bss     dec     hex filename
    124       0       0     124      7c t.onstack.O2.o (-O2)
    122       0       0     122      7a t.onstack.Os.o (-Os)
     76      28       0     104      68 t.offstack.o

So, there's no need to make things more complex and bigger - just put
the resource outside the function and mark it __initdata.
