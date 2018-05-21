From: ilialin@codeaurora.org (ilialin at codeaurora.org)
Date: Mon, 21 May 2018 15:57:10 +0300
Subject: [PATCH] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
References: <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <1526729701-8589-1-git-send-email-ilialin@codeaurora.org>
 <153cc316-dcb5-972f-5a2f-c91fe0f6348b@arm.com>
Message-ID: <000f01d3f103$3ff78ba0$bfe6a2e0$@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: Monday, May 21, 2018 15:50
> To: Ilia Lin <ilialin@codeaurora.org>; mturquette at baylibre.com;
> sboyd at kernel.org; robh at kernel.org; mark.rutland at arm.com;
> viresh.kumar at linaro.org; nm at ti.com; lgirdwood at gmail.com;
> broonie at kernel.org; andy.gross at linaro.org; david.brown at linaro.org;
> catalin.marinas at arm.com; will.deacon at arm.com; rjw at rjwysocki.net; linux-
> clk at vger.kernel.org
> Cc: Sudeep Holla <sudeep.holla@arm.com>; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-pm at vger.kernel.org; linux-arm-
> msm at vger.kernel.org; linux-soc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; rnayak at codeaurora.org;
> amit.kucheria at linaro.org; nicolas.dechesne at linaro.org;
> celster at codeaurora.org; tfinkel at codeaurora.org
> Subject: Re: [PATCH] cpufreq: Add Kryo CPU scaling driver
> 
> 
> 
> On 19/05/18 12:35, Ilia Lin wrote:
> > In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > processors, the CPU frequency subset and voltage value of each OPP
> > varies based on the silicon variant in use. Qualcomm Process Voltage
> > Scaling Tables defines the voltage and frequency value based on the
> > msm-id in SMEM and speedbin blown in the efuse combination.
> > The qcom-cpufreq-kryo driver reads the msm-id and efuse value from the
> > SoC to provide the OPP framework with required information.
> > This is used to determine the voltage and frequency value for each OPP
> > of
> > operating-points-v2 table when it is parsed by the OPP framework.
> >
> > Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm          |  10 +++
> >  drivers/cpufreq/Makefile             |   1 +
> >  drivers/cpufreq/cpufreq-dt-platdev.c |   3 +
> >  drivers/cpufreq/qcom-cpufreq-kryo.c  | 164
> > +++++++++++++++++++++++++++++++++++
> >  4 files changed, 178 insertions(+)
> >  create mode 100644 drivers/cpufreq/qcom-cpufreq-kryo.c
> >
> 
> [..]
> 
> > +
> > +/*
> > + * In Certain QCOM SoCs like apq8096 and msm8996 that have KRYO
> > +processors,
> > + * the CPU frequency subset and voltage value of each OPP varies
> > + * based on the silicon variant in use. Qualcomm Process Voltage
> > +Scaling Tables
> > + * defines the voltage and frequency value based on the msm-id in
> > +SMEM
> > + * and speedbin blown in the efuse combination.
> > + * The qcom-cpufreq-kryo driver reads the msm-id and efuse value from
> > +the SoC
> > + * to provide the OPP framework with required information.
> > + * This is used to determine the voltage and frequency value for each
> > +OPP of
> > + * operating-points-v2 table when it is parsed by the OPP framework.
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_opp.h>
> > +#include <linux/slab.h>
> > +#include <linux/soc/qcom/smem.h>
> > +
> > +#define MSM_ID_SMEM	137
> > +#define SILVER_LEAD	0
> > +#define GOLD_LEAD	2
> > +
> 
> So I gather form other emails, that these are physical cpu number(not even
> unique identifier like MPIDR). Will this work on parts or platforms that need
> to boot in GOLD LEAD cpus.

The driver is for Kryo CPU, which (and AFAIK all multicore MSMs) always boots on the CPU0.

> 
> [...]
> 
> > +
> > +static int __init qcom_cpufreq_kryo_driver_init(void)
> > +{
> > +	struct device *cpu_dev_silver, *cpu_dev_gold;
> > +	struct opp_table *opp_silver, *opp_gold;
> > +	enum _msm8996_version msm8996_version;
> > +	struct nvmem_cell *speedbin_nvmem;
> > +	struct platform_device *pdev;
> > +	struct device_node *np;
> > +	u8 *speedbin;
> > +	u32 versions;
> > +	size_t len;
> > +	int ret;
> > +
> > +	cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> > +	if (IS_ERR_OR_NULL(cpu_dev_silver))
> > +		return PTR_ERR(cpu_dev_silver);
> > +
> > +	cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> 
> s/SILVER/GOLD/ ?

Yes, you are right. This is already fixed in the respin.

> 
> --
> Regards,
> Sudeep
