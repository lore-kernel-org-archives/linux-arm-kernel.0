From: mike.rapoport@gmail.com (Mike Rapoport)
Date: Fri, 17 Sep 2010 00:16:08 +0200
Subject: [PATCH 2/3] [ARM] tegra: add PCI Express support
In-Reply-To: <AANLkTin5mkE3oTtYajrXxPnMUhj202xkwZp2yb8sNcCT@mail.gmail.com>
References: <cover.1284655723.git.mike@compulab.co.il>
	<4c70c64b9b0c187af872af65426bfef60079a2a3.1284655723.git.mike@compulab.co.il>
	<AANLkTin5mkE3oTtYajrXxPnMUhj202xkwZp2yb8sNcCT@mail.gmail.com>
Message-ID: <AANLkTim2aAgqL8ThDONeZ3c4ezadJ6-61ONanyf975y4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 11:42 PM, Colin Cross <ccross@google.com> wrote:
> On Thu, Sep 16, 2010 at 9:53 AM, Mike Rapoport <mike@compulab.co.il> wrote:
>> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
>> ---
>> ?arch/arm/mach-tegra/Kconfig ? ? ? ? ? ? ? ? | ? ?4 +
>> ?arch/arm/mach-tegra/Makefile ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-tegra/board.h ? ? ? ? ? ? ? ? | ? ?1 +
>> ?arch/arm/mach-tegra/include/mach/hardware.h | ? ?4 +
>> ?arch/arm/mach-tegra/pcie.c ? ? ? ? ? ? ? ? ?| ?889 +++++++++++++++++++++++++++
>> ?5 files changed, 899 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-tegra/pcie.c
>>
> <snip>
>
>> +/* register definitions */
>> +#define AFI_OFSET ? ? ?0x3800
>> +#define PADS_OFSET ? ? 0x3000
> OFFSET

thanks, will fix

>> +#define RP0_OFFSET ? ? 0x0000
>> +#define RP1_OFFSET ? ? 0x1000
>
> <snip>
>
>> +static void tegra_pcie_xclk_clamp(bool clamp)
>> +{
>> + ? ? ? u32 reg;
>> +
>> + ? ? ? reg = pmc_readl(PMC_SCRATCH42) & ~PMC_SCRATCH42_PCX_CLAMP;
>> +
>> + ? ? ? if (clamp)
>> + ? ? ? ? ? ? ? reg |= PMC_SCRATCH42_PCX_CLAMP;
>> +
>> + ? ? ? pmc_writel(reg, PMC_SCRATCH42);
>> +}
>
> Maybe add this to mach-tegra/powergate.c, to avoid having to set PMC
> registers directly?

The patch is aginst Linus' tree, that does not have powergate yet. I'd
really like to see the PCIe in 2.6.37-rc1, so I would prefer not to
depend on powergate here.
Besides, this particular bit is PCIe specific and does not fit into
generic power gating framework.
As a side note, mach-tegra/irq.c and mach-tegra/suspend*.c also have
direct access to the PMC, so probably it's worth adding
mach-tegra/pmc.h with pmc_writel/pmc_readl definitions?

>> +static int tegra_pcie_power_on(void)
>> +{
>> + ? ? ? int err;
>> +
>> + ? ? ? tegra_pcie_xclk_clamp(true);
>> + ? ? ? tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
>> + ? ? ? tegra_pcie_xclk_clamp(false);
>> +
>> + ? ? ? clk_enable(tegra_pcie.afi_clk);
>> + ? ? ? clk_enable(tegra_pcie.pex_clk);
>> + ? ? ? return clk_enable(tegra_pcie.pll_e);
>> +}
> Any reason you can't use the powergate api here too?

I cannot use the powergate api instead of what I have now, but it
won't be a problem to add it on top of current implementation.
The PCIe subsystem uses too many clocks, which leads to necessity to
have combine powergate api with direct calls to clk_{en,dis}able and
tegra_periph_reset_{de}assert.

>> +static void tegra_pcie_power_off(void)
>> +{
>> + ? ? ? tegra_periph_reset_assert(tegra_pcie.pcie_xclk);
>> + ? ? ? tegra_periph_reset_assert(tegra_pcie.afi_clk);
>> + ? ? ? tegra_periph_reset_assert(tegra_pcie.pex_clk);
>> +
>> + ? ? ? tegra_pcie_xclk_clamp(true);
>> +}
> Can you power off the pcie partition?

Yes, but again, I prefer not to depend on powergate api. The power
gating can be easily added afterwads.

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
? ? Sincerely Yours,
? ? ? ? Mike.
