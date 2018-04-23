From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 23 Apr 2018 16:38:43 +0200
Subject: [PATCH] cpufreq: add suspend/resume support in Armada 37xx DVFS
 driver
In-Reply-To: <20180423042703.GC2989@vireshk-i7>
References: <20180421141943.25705-1-miquel.raynal@bootlin.com>
 <20180423042703.GC2989@vireshk-i7>
Message-ID: <20180423163843.2b9e18b2@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Mon, 23 Apr 2018 09:57:03 +0530, Viresh Kumar
<viresh.kumar@linaro.org> wrote:

> On 21-04-18, 16:19, Miquel Raynal wrote:
> > Add suspend/resume hooks in Armada 37xx DVFS driver to handle S2RAM
> > operations. As there is currently no 'driver' structure, create one
> > to store both the regmap and the register values during suspend
> > operation.
> > 
> > A syscore_ops is used to export the suspend/resume hooks.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  drivers/cpufreq/armada-37xx-cpufreq.c | 73 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 71 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> > index 72a2975499db..9c9c3673cbbe 100644
> > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/pm_opp.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > +#include <linux/syscore_ops.h>
> >  
> >  /* Power management in North Bridge register set */
> >  #define ARMADA_37XX_NB_L0L1	0x18
> > @@ -56,6 +57,18 @@
> >   */
> >  #define LOAD_LEVEL_NR	4
> >  
> > +#if defined(CONFIG_PM)
> > +struct armada37xx_cpufreq_state {
> > +	struct regmap *regmap;
> > +	u32 nb_l0l1;
> > +	u32 nb_l2l3;
> > +	u32 nb_dyn_mod;
> > +	u32 nb_cpu_load;
> > +};
> > +
> > +static struct armada37xx_cpufreq_state *armada37xx_cpufreq_state;
> > +#endif /* CONFIG_PM */
> > +
> >  struct armada_37xx_dvfs {
> >  	u32 cpu_freq_max;
> >  	u8 divider[LOAD_LEVEL_NR];
> > @@ -136,7 +149,7 @@ static void __init armada37xx_cpufreq_dvfs_setup(struct regmap *base,
> >  	clk_set_parent(clk, parent);
> >  }
> >  
> > -static void __init armada37xx_cpufreq_disable_dvfs(struct regmap *base)
> > +static void armada37xx_cpufreq_disable_dvfs(struct regmap *base)
> >  {
> >  	unsigned int reg = ARMADA_37XX_NB_DYN_MOD,
> >  		mask = ARMADA_37XX_NB_DFS_EN;
> > @@ -162,6 +175,46 @@ static void __init armada37xx_cpufreq_enable_dvfs(struct regmap *base)
> >  	regmap_update_bits(base, reg, mask, mask);
> >  }
> >  
> > +#if defined(CONFIG_PM)
> > +static int armada37xx_cpufreq_suspend(void)
> > +{
> > +	struct armada37xx_cpufreq_state *state = armada37xx_cpufreq_state;
> > +
> > +	regmap_read(state->regmap, ARMADA_37XX_NB_L0L1, &state->nb_l0l1);
> > +	regmap_read(state->regmap, ARMADA_37XX_NB_L2L3, &state->nb_l2l3);
> > +	regmap_read(state->regmap, ARMADA_37XX_NB_CPU_LOAD,
> > +		    &state->nb_cpu_load);
> > +	regmap_read(state->regmap, ARMADA_37XX_NB_DYN_MOD, &state->nb_dyn_mod);
> > +
> > +	return 0;
> > +}
> > +
> > +static void armada37xx_cpufreq_resume(void)
> > +{
> > +	struct armada37xx_cpufreq_state *state = armada37xx_cpufreq_state;
> > +
> > +	/* Ensure DVFS is disabled otherwise the following registers are RO */
> > +	armada37xx_cpufreq_disable_dvfs(state->regmap);
> > +
> > +	regmap_write(state->regmap, ARMADA_37XX_NB_L0L1, state->nb_l0l1);
> > +	regmap_write(state->regmap, ARMADA_37XX_NB_L2L3, state->nb_l2l3);
> > +	regmap_write(state->regmap, ARMADA_37XX_NB_CPU_LOAD,
> > +		     state->nb_cpu_load);
> > +
> > +	/*
> > +	 * NB_DYN_MOD register is the one that actually enable back DVFS if it
> > +	 * was enabled before the suspend operation. This must be done last
> > +	 * otherwise other registers are not writable.
> > +	 */
> > +	regmap_write(state->regmap, ARMADA_37XX_NB_DYN_MOD, state->nb_dyn_mod);
> > +}
> > +
> > +static struct syscore_ops armada37xx_cpufreq_syscore_pm_ops = {
> > +	.suspend = armada37xx_cpufreq_suspend,
> > +	.resume = armada37xx_cpufreq_resume,
> > +};  
> 
> And why can't you use the suspend/resume callbacks present in the struct
> cpufreq_driver ?
> 

I did not knew about this structure (not used in this driver).

I checked the Documentation and wrote something to introduce the use
of struct cpufreq_driver but this means that the driver has things
to do during frequency switches, which is not the case here, explaining
(I guess) the use of cpufreq-dt.

How would you proceed then? Shall I continue in this path? I checked
all the drivers currently registering the cpufreq-dt driver, none of
them use this structure, so I am open to suggestions.

Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
