From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 4 Apr 2018 12:17:30 +0530
Subject: [PATCH v8 25/42] ARM: davinci: dm644x: add new clock init using
 common clock framework
In-Reply-To: <43c266b8-c023-a1b4-c751-bd46c2fb910d@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-26-git-send-email-david@lechnology.com>
 <333f49c7-bafd-8e2d-65e9-7d1aff4836de@ti.com>
 <43c266b8-c023-a1b4-c751-bd46c2fb910d@lechnology.com>
Message-ID: <cda6f3bc-7ca9-68e9-80ca-baf6d4860c95@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2018 10:00 PM, David Lechner wrote:
> On 04/03/2018 05:26 AM, Sekhar Nori wrote:
>> On Friday 16 March 2018 08:22 AM, David Lechner wrote:
>>> +static struct resource dm644x_pll1_resources[] = {
>>> +??? {
>>> +??????? .start??? = DAVINCI_PLL1_BASE,
>>> +??????? .end??? = DAVINCI_PLL1_BASE + SZ_4K - 1,
>>
>> The .end should be DAVINCI_PLL1_BASE + SZ_1K - 1, otherwise it prevents
>> PLL2 from getting registered.
>>
>>> +??????? .flags??? = IORESOURCE_MEM,
>>> +??? },
>>> +};
>>> +
>>> +static struct platform_device dm644x_pll1_device = {
>>> +??? .name??????? = "dm644x-pll1",
>>> +??? .id??????? = -1,
>>> +??? .resource??? = dm644x_pll1_resources,
>>> +??? .num_resources??? = ARRAY_SIZE(dm644x_pll1_resources),
>>> +};
>>> +
>>> +static struct resource dm644x_pll2_resources[] = {
>>> +??? {
>>> +??????? .start??? = DAVINCI_PLL2_BASE,
>>> +??????? .end??? = DAVINCI_PLL2_BASE + SZ_4K - 1,
>>
>> And this too should be fixed, else it prevents the PSC from getting
>> registered.
>>
>>> +??????? .flags??? = IORESOURCE_MEM,
>>> +??? },
>>> +};
>>
>> With these fixed, I still had to enable 'clk_ignore_unused' on DM644x
>> EVM to get to NFS boot. I think root of the problem is that pm_runtime()
>> APIs are not working in the legacy boot mode.
>>
>> This can be seen even on the DA850 LCDK in legacy boot. pm_genpd_summary
>> in debugfs shows all domains are off and there are no devices registered
>> under the "da850-psc1: emac" domain. NFS mounting still works on the
>> DA850 LCDK because clk_summary shows enable and prepare count of 4 for
>> emac. Not sure how that's happening. But on DM644x EVM, the emac clock
>> enable count is 0.
>>
>> Still looking at whats going wrong here. I am testing your v8 branch
>> with clk-davinci branch from clk-next merged to get the fixes Stephen
>> made.
>>
> 
> In legacy mode, genpd is not being used. I didn't see any mechanism for

Ah, I got stumped by the genpd related debug entries popping up.
Probably something should be done to make sure they don't show up in
legacy boot. And some comments to that effect in psc.c will help.

> genpd lookup without device tree. So, we are still relying on the
> matching in arch/arm/mach-davinci/pm_domain.c.

This is fine. We just need legacy boot to keep working without regressions.

> 
> I suspect we need to fix the clock lookups in
> drivers/clk/davinci/psc-dm644x.c.
> 
> LPSC_CLKDEV2(emac_clkdev,??????? NULL,??????? "davinci_emac.1",
> ??????????????????? "fck",??????? "davinci_mdio.0");
> 
> NULL might need to be changed to "fck" to be picked up by pm matching
> and "davinci_emac.1" should be verified that it matches the actual EMAC
> device name.

NULL con_id matches what we have for DA850 and also what we had for
DM644x prior to CCF conversion. So, I did not really suspect that. The
device name does match. I will check what else could be going on based
on your input.

Thanks,
Sekhar
