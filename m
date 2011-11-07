From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 7 Nov 2011 14:36:30 +0200
Subject: [PATCH v2 2/8] arm/tegra: prepare early init for multiple
 tegra variants
In-Reply-To: <20111103092116.GO13358@tbergstrom-lnx.Nvidia.com>
References: <1320242948-21061-1-git-send-email-pdeschrijver@nvidia.com>
 <1320242948-21061-3-git-send-email-pdeschrijver@nvidia.com>
 <CAMbhsRSTcR8qgYESmM6OxkXeVeg6vS49woCe_OX6CY4pAj2g_A@mail.gmail.com>
 <20111103092116.GO13358@tbergstrom-lnx.Nvidia.com>
Message-ID: <20111107123630.GO29978@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2011 at 10:21:16AM +0100, Peter De Schrijver wrote:
> On Wed, Nov 02, 2011 at 07:30:43PM +0100, Colin Cross wrote:
> > On Wed, Nov 2, 2011 at 7:09 AM, Peter De Schrijver
> > <pdeschrijver@nvidia.com> wrote:
> > > This patch splits the early init code in a common and a tegra20 specific part.
> > > L2 cache initialization is generalized and discovers the cache associativity
> > > at runtime.
> > >
> > > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > > ---
> > <snip>
> > 
> > > -static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
> > > +void (*arch_reset)(char mode, const char *cmd) = tegra_assert_system_reset;
> > > +
> > This is unrelated to the patch description?
> > 
> 
> This is a left over from the past. Will be removed from the next version.
> 
> > > +static __initdata struct tegra_clk_init_table tegra20_clk_init_table[] = {
> > > ? ? ? ?/* name ? ? ? ? parent ? ? ? ? ?rate ? ? ? ? ? ?enabled */
> > > ? ? ? ?{ "clk_m", ? ? ?NULL, ? ? ? ? ? 0, ? ? ? ? ? ? ?true },
> > > ? ? ? ?{ "pll_p", ? ? ?"clk_m", ? ? ? ?216000000, ? ? ?true },
> > > @@ -59,25 +61,34 @@ static __initdata struct tegra_clk_init_table common_clk_init_table[] = {
> > > ? ? ? ?{ NULL, ? ? ? ? NULL, ? ? ? ? ? 0, ? ? ? ? ? ? ?0},
> > > ?};
> > >
> > > -static void __init tegra_init_cache(void)
> > > +static void __init tegra_init_cache(u32 tag_latency, u32 data_latency)
> > > ?{
> > > ?#ifdef CONFIG_CACHE_L2X0
> > > ? ? ? ?void __iomem *p = IO_ADDRESS(TEGRA_ARM_PERIF_BASE) + 0x3000;
> > > + ? ? ? u32 aux_ctrl;
> > > +
> > > + ? ? ? writel_relaxed(tag_latency, p + L2X0_TAG_LATENCY_CTRL);
> > > + ? ? ? writel_relaxed(data_latency, p + L2X0_DATA_LATENCY_CTRL);
> > >
> > > - ? ? ? writel_relaxed(0x331, p + L2X0_TAG_LATENCY_CTRL);
> > > - ? ? ? writel_relaxed(0x441, p + L2X0_DATA_LATENCY_CTRL);
> > > + ? ? ? aux_ctrl = readl(p + L2X0_CACHE_TYPE);
> > > + ? ? ? aux_ctrl = (aux_ctrl & 0x700) << (17-8);
> > 
> > If I'm interpreting the PL310 TRM correctly, the cache associativity
> > value in the L2X0_CACHE_TYPE register is read from the aux control
> > register, so this is just leaving the existing value in place.  If the
> > value is not being modified, just take it out of the aux_ctrl mask
> > passed to l2x0_init.
> > 
> 
> This seems to work fine on our android kernels though. Need to dig deeper
> what's going on here.

Doesn't seem to be that simple on tegra. The L2X0_CACHE_TYPE can indicate a
different waysize depending on fuses.

Cheers,

Peter.
