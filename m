From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 19 Jul 2018 12:47:48 +0200
Subject: [PATCH] cpufreq: armada-37xx: Fix clock leak
In-Reply-To: <20180405045153.GL3572@vireshk-i7>
References: <20180404144444.4142-1-gregory.clement@bootlin.com>
 <20180405045153.GL3572@vireshk-i7>
Message-ID: <1928207.9cCKXrpt8K@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 5, 2018 6:51:53 AM CEST Viresh Kumar wrote:
> On 04-04-18, 16:44, Gregory CLEMENT wrote:
> > There was no clk_put() balancing the clk_get(). This commit fixes it.
> > 
> > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> > Cc: <stable@vger.kernel.org>
> > Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> > ---
> >  drivers/cpufreq/armada-37xx-cpufreq.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> > index c6ebc88a7d8d..72a2975499db 100644
> > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > @@ -202,6 +202,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
> >  	cur_frequency = clk_get_rate(clk);
> >  	if (!cur_frequency) {
> >  		dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
> > +		clk_put(clk);
> >  		return -EINVAL;
> >  	}
> >  
> > @@ -210,6 +211,7 @@ static int __init armada37xx_cpufreq_driver_init(void)
> >  		return -EINVAL;
> >  
> >  	armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
> > +	clk_put(clk);
> >  
> >  	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
> >  	     load_lvl++) {
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Applied, thanks!
