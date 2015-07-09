From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 9 Jul 2015 10:28:49 +0100
Subject: [PATCH v3 2/3] ARM: cpuidle: refine cpuidle_ops member's
 parameters.
In-Reply-To: <20150709164304.26b6c2be@xhacker>
References: <1436430685-2202-1-git-send-email-jszhang@marvell.com>
 <1436430685-2202-3-git-send-email-jszhang@marvell.com>
 <20150709164304.26b6c2be@xhacker>
Message-ID: <20150709092848.GA26079@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 09:43:04AM +0100, Jisheng Zhang wrote:
> On Thu, 9 Jul 2015 16:31:24 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > As for the suspend member function, the to-be-suspended cpu is always
> > the calling cpu itself, so the 'cpu' parameter may not be necessary, let
> > driver get 'cpu' itself if need.
> > 
> > As for the init member function, the device_node here may not be
> > necessary either, because we can get the node via. of_get_cpu_node().
> 
> This patch also changes drivers/soc/qcom/spm.c accordingly, but I have no
> qcom platform, so I can't test it, just make sure it can pass kernel building.
> Could anyone kindly help me to test?

CC'ing Lina who should be able to help you test it.

Thanks,
Lorenzo

> Thanks a lot,
> Jisheng
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  arch/arm/include/asm/cpuidle.h |  6 +++---
> >  arch/arm/kernel/cpuidle.c      |  8 ++++----
> >  drivers/soc/qcom/spm.c         | 17 ++++++++++++-----
> >  3 files changed, 19 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> > index 0f84249..ca5dfe6 100644
> > --- a/arch/arm/include/asm/cpuidle.h
> > +++ b/arch/arm/include/asm/cpuidle.h
> > @@ -30,8 +30,8 @@ static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> >  struct device_node;
> >  
> >  struct cpuidle_ops {
> > -	int (*suspend)(int cpu, unsigned long arg);
> > -	int (*init)(struct device_node *, int cpu);
> > +	int (*suspend)(unsigned long arg);
> > +	int (*init)(unsigned int cpu);
> >  };
> >  
> >  struct of_cpuidle_method {
> > @@ -46,6 +46,6 @@ struct of_cpuidle_method {
> >  
> >  extern int arm_cpuidle_suspend(int index);
> >  
> > -extern int arm_cpuidle_init(int cpu);
> > +extern int arm_cpuidle_init(unsigned int cpu);
> >  
> >  #endif
> > diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> > index 318da33..7bc7bc6 100644
> > --- a/arch/arm/kernel/cpuidle.c
> > +++ b/arch/arm/kernel/cpuidle.c
> > @@ -53,10 +53,10 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> >  int arm_cpuidle_suspend(int index)
> >  {
> >  	int ret = -EOPNOTSUPP;
> > -	int cpu = smp_processor_id();
> > +	unsigned int cpu = smp_processor_id();
> >  
> >  	if (cpuidle_ops[cpu].suspend)
> > -		ret = cpuidle_ops[cpu].suspend(cpu, index);
> > +		ret = cpuidle_ops[cpu].suspend(index);
> >  
> >  	return ret;
> >  }
> > @@ -134,7 +134,7 @@ static int __init arm_cpuidle_read_ops(struct device_node *dn, int cpu)
> >   *  -ENXIO if the HW reports a failure or a misconfiguration,
> >   *  -ENOMEM if the HW report an memory allocation failure 
> >   */
> > -int __init arm_cpuidle_init(int cpu)
> > +int __init arm_cpuidle_init(unsigned int cpu)
> >  {
> >  	struct device_node *cpu_node = of_cpu_device_node_get(cpu);
> >  	int ret;
> > @@ -144,7 +144,7 @@ int __init arm_cpuidle_init(int cpu)
> >  
> >  	ret = arm_cpuidle_read_ops(cpu_node, cpu);
> >  	if (!ret && cpuidle_ops[cpu].init)
> > -		ret = cpuidle_ops[cpu].init(cpu_node, cpu);
> > +		ret = cpuidle_ops[cpu].init(cpu);
> >  
> >  	of_node_put(cpu_node);
> >  
> > diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> > index b04b05a..1649ec3 100644
> > --- a/drivers/soc/qcom/spm.c
> > +++ b/drivers/soc/qcom/spm.c
> > @@ -116,7 +116,7 @@ static const struct spm_reg_data spm_reg_8064_cpu = {
> >  
> >  static DEFINE_PER_CPU(struct spm_driver_data *, cpu_spm_drv);
> >  
> > -typedef int (*idle_fn)(int);
> > +typedef int (*idle_fn)(void);
> >  static DEFINE_PER_CPU(idle_fn*, qcom_idle_ops);
> >  
> >  static inline void spm_register_write(struct spm_driver_data *drv,
> > @@ -179,9 +179,10 @@ static int qcom_pm_collapse(unsigned long int unused)
> >  	return -1;
> >  }
> >  
> > -static int qcom_cpu_spc(int cpu)
> > +static int qcom_cpu_spc(void)
> >  {
> >  	int ret;
> > +	int cpu = smp_processor_id();
> >  	struct spm_driver_data *drv = per_cpu(cpu_spm_drv, cpu);
> >  
> >  	spm_set_low_power_mode(drv, PM_SLEEP_MODE_SPC);
> > @@ -197,9 +198,11 @@ static int qcom_cpu_spc(int cpu)
> >  	return ret;
> >  }
> >  
> > -static int qcom_idle_enter(int cpu, unsigned long index)
> > +static int qcom_idle_enter(unsigned long index)
> >  {
> > -	return per_cpu(qcom_idle_ops, cpu)[index](cpu);
> > +	unsigned int cpu = smp_processor_id();
> > +
> > +	return per_cpu(qcom_idle_ops, cpu)[index]();
> >  }
> >  
> >  static const struct of_device_id qcom_idle_state_match[] __initconst = {
> > @@ -207,7 +210,7 @@ static const struct of_device_id qcom_idle_state_match[] __initconst = {
> >  	{ },
> >  };
> >  
> > -static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
> > +static int __init qcom_cpuidle_init(unsigned int cpu)
> >  {
> >  	const struct of_device_id *match_id;
> >  	struct device_node *state_node;
> > @@ -217,6 +220,10 @@ static int __init qcom_cpuidle_init(struct device_node *cpu_node, int cpu)
> >  	idle_fn *fns;
> >  	cpumask_t mask;
> >  	bool use_scm_power_down = false;
> > +	struct device_node *cpu_node = of_get_cpu_node(cpu, NULL);
> > +
> > +	if (!cpu_node)
> > +		return -ENODEV;
> >  
> >  	for (i = 0; ; i++) {
> >  		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> 
