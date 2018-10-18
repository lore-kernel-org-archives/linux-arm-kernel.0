From: shameerali.kolothum.thodi@huawei.com (Shameerali Kolothum Thodi)
Date: Thu, 18 Oct 2018 09:26:19 +0000
Subject: [PATCH v4 2/4] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <201810180536.3mHoIqvz%fengguang.wu@intel.com>
References: <20181016124920.24708-3-shameerali.kolothum.thodi@huawei.com>
 <201810180536.3mHoIqvz%fengguang.wu@intel.com>
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83879FFDA@FRAEML521-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: kbuild test robot [mailto:lkp at intel.com]
> Sent: 17 October 2018 22:53
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Cc: kbuild-all at 01.org; lorenzo.pieralisi at arm.com; robin.murphy at arm.com;
> jean-philippe.brucker at arm.com; will.deacon at arm.com;
> mark.rutland at arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
> John Garry <john.garry@huawei.com>; pabba at codeaurora.org;
> vkilari at codeaurora.org; rruigrok at codeaurora.org; linux-
> acpi at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Linuxarm <linuxarm@huawei.com>;
> neil.m.leeder at gmail.com
> Subject: Re: [PATCH v4 2/4] perf: add arm64 smmuv3 pmu driver
> 
> Hi Neil,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on linux-sof-driver/master]
> [also build test ERROR on v4.19-rc8 next-20181017]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Shameer-Kolothum/arm64-
> SMMUv3-PMU-driver-with-IORT-support/20181017-063949
> base:   https://github.com/thesofproject/linux master
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 8.1.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-
> tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=8.1.0 make.cross ARCH=xtensa
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    drivers//perf/arm_smmuv3_pmu.c: In function
> 'smmu_pmu_counter_set_value':
>    include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-
> count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^~
>    drivers//perf/arm_smmuv3_pmu.c:145:31: note: in expansion of macro 'BIT'
>      if (smmu_pmu->counter_mask & BIT(32))
>                                   ^~~
>    drivers//perf/arm_smmuv3_pmu.c:146:3: error: implicit declaration of
> function 'writeq'; did you mean 'writel'? [-Werror=implicit-function-
> declaration]
>       writeq(value, smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 8));
>       ^~~~~~
>       writel
>    In file included from include/linux/kernel.h:11,
>                     from include/linux/list.h:9,
>                     from include/linux/resource_ext.h:17,
>                     from include/linux/acpi.h:26,
>                     from drivers//perf/arm_smmuv3_pmu.c:37:
>    drivers//perf/arm_smmuv3_pmu.c: In function
> 'smmu_pmu_counter_get_value':
>    include/linux/bitops.h:7:24: warning: left shift count >= width of type [-Wshift-
> count-overflow]
>     #define BIT(nr)   (1UL << (nr))
>                            ^~
>    drivers//perf/arm_smmuv3_pmu.c:155:31: note: in expansion of macro 'BIT'
>      if (smmu_pmu->counter_mask & BIT(32))
>                                   ^~~
>    drivers//perf/arm_smmuv3_pmu.c:156:11: error: implicit declaration of
> function 'readq'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>       value = readq(smmu_pmu->reloc_base + SMMU_PMCG_EVCNTR(idx, 8));
>               ^~~~~
>               readl

Right. This again is linked to the COMPILE_TEST added in this version of the series.
It looks like these functions has dependency on architecture (CONFIG_64BIT). I will 
take care of this in next revision.

Thanks,
Shameer

>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_reset':
>    drivers//perf/arm_smmuv3_pmu.c:607:2: error: implicit declaration of
> function 'writeq_relaxed'; did you mean 'writel_relaxed'? [-Werror=implicit-
> function-declaration]
>      writeq_relaxed(smmu_pmu->counter_present_mask,
>      ^~~~~~~~~~~~~~
>      writel_relaxed
>    drivers//perf/arm_smmuv3_pmu.c: In function 'smmu_pmu_probe':
> >> drivers//perf/arm_smmuv3_pmu.c:666:15: error: implicit declaration of
> function 'readq_relaxed'; did you mean 'readl_relaxed'? [-Werror=implicit-
> function-declaration]
>      ceid_64[0] = readq_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CEID0);
>                   ^~~~~~~~~~~~~
>                   readl_relaxed
>    drivers//perf/arm_smmuv3_pmu.c:687:64: warning: format '%llx' expects
> argument of type 'long long unsigned int', but argument 4 has type
> 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>      name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
>                                                                 ~~~^
>                                                                 %x
>    cc1: some warnings being treated as errors
> 
> vim +666 drivers//perf/arm_smmuv3_pmu.c
> 
>    601
>    602	static void smmu_pmu_reset(struct smmu_pmu *smmu_pmu)
>    603	{
>    604		smmu_pmu_disable(&smmu_pmu->pmu);
>    605
>    606		/* Disable counter and interrupt */
>  > 607		writeq_relaxed(smmu_pmu->counter_present_mask,
>    608			       smmu_pmu->reg_base +
> SMMU_PMCG_CNTENCLR0);
>    609		writeq_relaxed(smmu_pmu->counter_present_mask,
>    610			       smmu_pmu->reg_base +
> SMMU_PMCG_INTENCLR0);
>    611		writeq_relaxed(smmu_pmu->counter_present_mask,
>    612			       smmu_pmu->reloc_base +
> SMMU_PMCG_OVSCLR0);
>    613	}
>    614
>    615	static int smmu_pmu_probe(struct platform_device *pdev)
>    616	{
>    617		struct smmu_pmu *smmu_pmu;
>    618		struct resource *res_0, *res_1;
>    619		u32 cfgr, reg_size;
>    620		u64 ceid_64[2];
>    621		int irq, err;
>    622		char *name;
>    623		struct device *dev = &pdev->dev;
>    624
>    625		smmu_pmu = devm_kzalloc(dev, sizeof(*smmu_pmu),
> GFP_KERNEL);
>    626		if (!smmu_pmu)
>    627			return -ENOMEM;
>    628
>    629		smmu_pmu->dev = dev;
>    630		platform_set_drvdata(pdev, smmu_pmu);
>    631
>    632		smmu_pmu->pmu = (struct pmu) {
>    633			.task_ctx_nr    = perf_invalid_context,
>    634			.pmu_enable	= smmu_pmu_enable,
>    635			.pmu_disable	= smmu_pmu_disable,
>    636			.event_init	= smmu_pmu_event_init,
>    637			.add		= smmu_pmu_event_add,
>    638			.del		= smmu_pmu_event_del,
>    639			.start		= smmu_pmu_event_start,
>    640			.stop		= smmu_pmu_event_stop,
>    641			.read		= smmu_pmu_event_read,
>    642			.attr_groups	= smmu_pmu_attr_grps,
>    643		};
>    644
>    645		res_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>    646		smmu_pmu->reg_base = devm_ioremap_resource(dev, res_0);
>    647		if (IS_ERR(smmu_pmu->reg_base))
>    648			return PTR_ERR(smmu_pmu->reg_base);
>    649
>    650		cfgr = readl_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CFGR);
>    651
>    652		/* Determine if page 1 is present */
>    653		if (cfgr & SMMU_PMCG_CFGR_RELOC_CTRS) {
>    654			res_1 = platform_get_resource(pdev,
> IORESOURCE_MEM, 1);
>    655			smmu_pmu->reloc_base =
> devm_ioremap_resource(dev, res_1);
>    656			if (IS_ERR(smmu_pmu->reloc_base))
>    657				return PTR_ERR(smmu_pmu->reloc_base);
>    658		} else {
>    659			smmu_pmu->reloc_base = smmu_pmu->reg_base;
>    660		}
>    661
>    662		irq = platform_get_irq(pdev, 0);
>    663		if (irq > 0)
>    664			smmu_pmu->irq = irq;
>    665
>  > 666		ceid_64[0] = readq_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CEID0);
>    667		ceid_64[1] = readq_relaxed(smmu_pmu->reg_base +
> SMMU_PMCG_CEID1);
>    668		bitmap_from_arr32(smmu_pmu->supported_events, (u32
> *)ceid_64,
>    669				  SMMU_ARCH_MAX_EVENTS);
>    670
>    671		smmu_pmu->num_counters =
> FIELD_GET(SMMU_PMCG_CFGR_NCTR_MASK, cfgr) + 1;
>    672		smmu_pmu->counter_present_mask = GENMASK(smmu_pmu-
> >num_counters - 1, 0);
>    673
>    674		smmu_pmu->sid_filter_global = !!(cfgr &
> SMMU_PMCG_CFGR_SID_FILTER_TYPE);
>    675
>    676		reg_size = FIELD_GET(SMMU_PMCG_CFGR_SIZE_MASK, cfgr);
>    677		smmu_pmu->counter_mask = GENMASK_ULL(reg_size, 0);
>    678
>    679		smmu_pmu_reset(smmu_pmu);
>    680
>    681		err = smmu_pmu_setup_irq(smmu_pmu);
>    682		if (err) {
>    683			dev_err(dev, "Setup irq failed, PMU @%pa\n", &res_0-
> >start);
>    684			return err;
>    685		}
>    686
>    687		name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> "smmuv3_pmcg_%llx",
>    688				      (res_0->start) >> SMMU_PA_SHIFT);
>    689		if (!name) {
>    690			dev_err(dev, "Create name failed, PMU @%pa\n",
> &res_0->start);
>    691			return -EINVAL;
>    692		}
>    693
>    694		/* Pick one CPU to be the preferred one to use */
>    695		smmu_pmu->on_cpu = get_cpu();
>    696		WARN_ON(irq_set_affinity(smmu_pmu->irq,
> cpumask_of(smmu_pmu->on_cpu)));
>    697
>    698		err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
>    699						       &smmu_pmu->node);
>    700		if (err) {
>    701			dev_err(dev, "Error %d registering hotplug, PMU
> @%pa\n",
>    702				err, &res_0->start);
>    703			goto out_cpuhp_err;
>    704		}
>    705
>    706		err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
>    707		if (err) {
>    708			dev_err(dev, "Error %d registering PMU @%pa\n",
>    709				err, &res_0->start);
>    710			goto out_unregister;
>    711		}
>    712
>    713		put_cpu();
>    714		dev_info(dev, "Registered PMU @ %pa using %d counters with
> %s filter settings\n",
>    715			 &res_0->start, smmu_pmu->num_counters,
>    716			 smmu_pmu->sid_filter_global ? "Global(Counter0)" :
>    717			 "Individual");
>    718
>    719		return 0;
>    720
>    721	out_unregister:
>    722		cpuhp_state_remove_instance_nocalls(cpuhp_state_num,
> &smmu_pmu->node);
>    723	out_cpuhp_err:
>    724		put_cpu();
>    725		return err;
>    726	}
>    727
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
