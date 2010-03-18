From: ccross@android.com (Colin Cross)
Date: Thu, 18 Mar 2010 16:57:10 -0700
Subject: [RFC/PATCH 03/10] [ARM] tegra: Add clock support
In-Reply-To: <20100318084205.GB8267@n2100.arm.linux.org.uk>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-1-git-send-email-konkers@google.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<20100318084205.GB8267@n2100.arm.linux.org.uk>
Message-ID: <d73d4eaf1003181657l2b62b133me654b1fb3255ce0b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 1:42 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 15, 2010 at 11:41:21PM -0700, konkers at google.com wrote:
>> From: Colin Cross <ccross@android.com>
>>
>> Signed-off-by: Colin Cross <ccross@android.com>
>> Signed-off-by: Erik Gilling <konkers@android.com>
>> ---
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-tegra/Makefile ? ? ? ? ? ? ?| ? ?2 +
>> ?arch/arm/mach-tegra/clock.c ? ? ? ? ? ? ? | ?191 +++++++
>> ?arch/arm/mach-tegra/clock.h ? ? ? ? ? ? ? | ?103 ++++
>> ?arch/arm/mach-tegra/common.c ? ? ? ? ? ? ?| ? ?1 +
>> ?arch/arm/mach-tegra/include/mach/clkdev.h | ? 32 ++
>> ?arch/arm/mach-tegra/tegra2_clocks.c ? ? ? | ?837 +++++++++++++++++++++++++++++
>> ?7 files changed, 1167 insertions(+), 0 deletions(-)
>> ?create mode 100644 arch/arm/mach-tegra/clock.c
>> ?create mode 100644 arch/arm/mach-tegra/clock.h
>> ?create mode 100644 arch/arm/mach-tegra/include/mach/clkdev.h
>> ?create mode 100644 arch/arm/mach-tegra/tegra2_clocks.c
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 1232104..a5be2d6 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -576,6 +576,7 @@ config ARCH_TEGRA
>> ? ? ? ? ?select GENERIC_CLOCKEVENTS
>> ? ? ? ? ?select GENERIC_GPIO
>> ? ? ? ? ?select HAVE_CLK
>> + ? ? ? ?select COMMON_CLKDEV
>
> These should be indented using tabs, not spaces.
Fixed

>> +/**
>> + * clk_preinit - initialize any fields in the struct clk before clk init
>> + * @clk: struct clk * to initialize
>> + *
>> + * Initialize any struct clk fields needed before normal clk initialization
>> + * can run. ?No return value.
>> + */
>> +void clk_preinit(struct clk *c)
>> +{
>> + ? ? c->lock = __SPIN_LOCK_UNLOCKED(c->lock);
>
> ? ? ? ?spin_lock_init(&c->lock);
Fixed

>> +int clk_set_parent(struct clk *c, struct clk *parent)
>> +{
>> + ? ? unsigned long flags;
>> + ? ? int ret = 0;
>> + ? ? spin_lock_irqsave(&c->lock, flags);
>> + ? ? if (c->ops && c->ops->set_parent)
>> + ? ? ? ? ? ? ret = c->ops->set_parent(c, parent);
>> + ? ? else
>> + ? ? ? ? ? ? BUG();
>
> Does this condition really justify crashing the kernel? ?Why not just
> return an error?
Changed to return -ENOSYS

>> +int clk_set_rate(struct clk *c, unsigned long rate)
>> +{
>> + ? ? int ret = 0;
>> + ? ? unsigned long flags;
>> + ? ? spin_lock_irqsave(&c->lock, flags);
>> + ? ? if (c->ops && c->ops->set_rate)
>> + ? ? ? ? ? ? ret = c->ops->set_rate(c, rate);
>> + ? ? else
>> + ? ? ? ? ? ? BUG();
>
> Ditto.
>
>> +unsigned long clk_get_rate(struct clk *c)
>> +{
>> + ? ? int ret = 0;
>> + ? ? unsigned long flags;
>> + ? ? spin_lock_irqsave(&c->lock, flags);
>> + ? ? if (c->ops && c->ops->get_rate)
>> + ? ? ? ? ? ? ret = c->ops->get_rate(c);
>> + ? ? else if (c->parent)
>> + ? ? ? ? ? ? ret = clk_get_rate(c->parent);
>> + ? ? else
>> + ? ? ? ? ? ? BUG();
>
> Ditto.
>
>> +/* PLL Functions */
>> +static int tegra2_pll_clk_set_rate(struct clk *c, unsigned long rate)
>> +{
>> + ? ? u32 val;
>> + ? ? unsigned long input_rate;
>> + ? ? const struct clk_pll_table *sel;
>> +
>> + ? ? pr_debug("%s on clock %s\n", __func__, c->name);
>> + ? ? /* BUG_ON(c->refcnt != 0); */
>> +
>> + ? ? input_rate = clk_get_rate(c->parent);
>> + ? ? for (sel = c->pll_table; sel->input_rate != 0; sel++) {
>> + ? ? ? ? ? ? if (sel->input_rate == input_rate && sel->output_rate == rate) {
>> + ? ? ? ? ? ? ? ? ? ? c->n = sel->n;
>> + ? ? ? ? ? ? ? ? ? ? c->m = sel->m;
>> + ? ? ? ? ? ? ? ? ? ? c->p = sel->p;
>> + ? ? ? ? ? ? ? ? ? ? c->cpcon = sel->cpcon;
>> + ? ? ? ? ? ? ? ? ? ? val = clk_readl(c->reg + PLL_BASE);
>> + ? ? ? ? ? ? ? ? ? ? if (c->flags & PLL_FIXED)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? val |= PLL_BASE_OVERRIDE;
>> + ? ? ? ? ? ? ? ? ? ? val &= ~(PLL_BASE_DIVP_MASK | PLL_BASE_DIVN_MASK |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?PLL_BASE_DIVM_MASK);
>> + ? ? ? ? ? ? ? ? ? ? val |= (c->m << PLL_BASE_DIVM_SHIFT) |
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? (c->n << PLL_BASE_DIVN_SHIFT);
>> + ? ? ? ? ? ? ? ? ? ? BUG_ON(c->p > 2);
>> + ? ? ? ? ? ? ? ? ? ? if (c->p == 2)
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? val |= 1 << PLL_BASE_DIVP_SHIFT;
>> + ? ? ? ? ? ? ? ? ? ? clk_writel(val, c->reg + PLL_BASE);
>> + ? ? ? ? ? ? ? ? ? ? c->rate = rate;
>> +
>> + ? ? ? ? ? ? ? ? ? ? if (c->flags & PLL_HAS_CPCON) {
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? val = c->cpcon << PLL_MISC_CPCON_SHIFT;
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? clk_writel(val, c->reg + PLL_MISC);
>> + ? ? ? ? ? ? ? ? ? ? }
>> + ? ? ? ? ? ? ? ? ? ? return 0;
>> + ? ? ? ? ? ? }
>> + ? ? }
>> + ? ? return 1;
>
> What's this 'return 1' on error and 'return 0' on ?success? ?The clk API
> uses standard Linux error codes, which are negative constants on error.
> Please use a standard constant from the errno.h headers.
Fixed, along with all the other improper return values in tegra2_clocks.c

Thanks for the review,
Colin
