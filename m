From: david@lechnology.com (David Lechner)
Date: Tue, 3 Apr 2018 11:30:45 -0500
Subject: [PATCH v8 25/42] ARM: davinci: dm644x: add new clock init using
 common clock framework
In-Reply-To: <333f49c7-bafd-8e2d-65e9-7d1aff4836de@ti.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-26-git-send-email-david@lechnology.com>
 <333f49c7-bafd-8e2d-65e9-7d1aff4836de@ti.com>
Message-ID: <43c266b8-c023-a1b4-c751-bd46c2fb910d@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2018 05:26 AM, Sekhar Nori wrote:
> On Friday 16 March 2018 08:22 AM, David Lechner wrote:
>> +static struct resource dm644x_pll1_resources[] = {
>> +	{
>> +		.start	= DAVINCI_PLL1_BASE,
>> +		.end	= DAVINCI_PLL1_BASE + SZ_4K - 1,
> 
> The .end should be DAVINCI_PLL1_BASE + SZ_1K - 1, otherwise it prevents
> PLL2 from getting registered.
> 
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +};
>> +
>> +static struct platform_device dm644x_pll1_device = {
>> +	.name		= "dm644x-pll1",
>> +	.id		= -1,
>> +	.resource	= dm644x_pll1_resources,
>> +	.num_resources	= ARRAY_SIZE(dm644x_pll1_resources),
>> +};
>> +
>> +static struct resource dm644x_pll2_resources[] = {
>> +	{
>> +		.start	= DAVINCI_PLL2_BASE,
>> +		.end	= DAVINCI_PLL2_BASE + SZ_4K - 1,
> 
> And this too should be fixed, else it prevents the PSC from getting
> registered.
> 
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +};
> 
> With these fixed, I still had to enable 'clk_ignore_unused' on DM644x
> EVM to get to NFS boot. I think root of the problem is that pm_runtime()
> APIs are not working in the legacy boot mode.
> 
> This can be seen even on the DA850 LCDK in legacy boot. pm_genpd_summary
> in debugfs shows all domains are off and there are no devices registered
> under the "da850-psc1: emac" domain. NFS mounting still works on the
> DA850 LCDK because clk_summary shows enable and prepare count of 4 for
> emac. Not sure how that's happening. But on DM644x EVM, the emac clock
> enable count is 0.
> 
> Still looking at whats going wrong here. I am testing your v8 branch
> with clk-davinci branch from clk-next merged to get the fixes Stephen made.
> 

In legacy mode, genpd is not being used. I didn't see any mechanism for
genpd lookup without device tree. So, we are still relying on the
matching in arch/arm/mach-davinci/pm_domain.c.

I suspect we need to fix the clock lookups in
drivers/clk/davinci/psc-dm644x.c.

LPSC_CLKDEV2(emac_clkdev,		NULL,		"davinci_emac.1",
					"fck",		"davinci_mdio.0");

NULL might need to be changed to "fck" to be picked up by pm matching
and "davinci_emac.1" should be verified that it matches the actual EMAC
device name.
