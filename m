From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jun 2015 08:16:47 +0100
Subject: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
In-Reply-To: <20150623025031.GD16776@linux>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <20150623025031.GD16776@linux>
Message-ID: <20150623071647.GD3245@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your timely review Viresh.

On Tue, 23 Jun 2015, Viresh Kumar wrote:
> On 22-06-15, 16:43, Lee Jones wrote:
> > +config ARM_ST_CPUFREQ
> > +	bool "ST CPUFreq support"
> 
> Isn't using ST just too generic? There are multiple SoCs ST has been
> involved with, I have worked on a completely different series.
> Probably a more relative string is required here, like stih407 ?

This is ST's only CPUFreq implementation and is pretty board
agnostic.  This particular driver only currently supports the STiH407
family, but internally it supports some others too.  I'll have a chat
and see if we can make it more specific somehow.

> > +	depends on SOC_STIH407

[...]

> > +static int st_cpufreq_get_dvfs_info(struct platform_device *pdev)
> > +{
> > +	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
> > +	struct st_dvfs_tab *dvfs_tab = &ddata->dvfs_tab[0];
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device_node *opplist, *opp;
> > +	unsigned int minor = 0, major = 0;
> > +	int err, ret = 0;
> > +
> > +	opplist = of_get_child_by_name(np, "opp-list");
> 
> st,opp-list ?

Sure.

[...]

> > +out:
> > +	of_node_put(opplist);
> > +
> > +	if (!ddata->dvfs_tab_count) {
> > +		dev_err(&pdev->dev, "No suitable AVS table found\n");
> 
> Why is this an error? I thought in this case you will go ahead with
> the normal OPP-table.

I've written it so it's an error within this function, as it makes the
function fail, but is downgraded by the caller to a warning and
gracefully bypassed to still allow frequency scaling.

> > +		return -EINVAL;

[...]

> > +	for (i = 0; i < ddata->dvfs_tab_count; i++, dvfs_tab++) {
> > +		unsigned int f = dvfs_tab->freq * 1000;
> > +		unsigned int v = dvfs_tab->avs * 1000;
> > +
> > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, f, false);
> > +
> > +		/* Remove existing voltage-less OPP entry */
> > +		if (!IS_ERR(opp))
> > +			dev_pm_opp_remove(cpu_dev, f);
> > +
> > +		/* Supply new fully populated OPP entry */
> > +		ret = dev_pm_opp_add(cpu_dev, f, v);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "Failed to add OPP %u\n", f);
> > +			return ret;
> > +		}
> > +	}
> 
> So you have added new OPPs here, but cpufreq-dt will try to add old
> OPPs. You must be getting lots of warnings ?

Yes, we recieve the 'duplicate OPPs detected' warning, but there is
nothing we can do about that.

> > +
> > +	return 0;
> > +}

[...]

> > +static const struct reg_field sti_stih407_dvfs_regfields[DVFS_MAX_REGFIELDS] = {
> > +	[PCODE]		= REG_FIELD(0, 16, 19),
> > +	[SUBSTRATE]	= REG_FIELD(0, 0, 2),
> > +};
> > +
> > +static struct of_device_id sti_cpufreq_of_match[] = {
> > +	{
> > +		.compatible = "st,stih407-cpufreq",
> > +		.data = &sti_stih407_dvfs_regfields,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, sti_cpufreq_of_match);
> > +
> > +/* Find process code -- calibrated per-SoC */
> > +static void sti_cpufreq_get_pcode(struct platform_device *pdev)
> > +{
> > +	struct st_cpufreq_ddata *ddata = platform_get_drvdata(pdev);
> > +	struct device_node *np = pdev->dev.of_node;
> > +	const struct reg_field *reg_fields;
> > +	const struct of_device_id *match;
> > +	int pcode_offset;
> > +	int ret;
> > +
> > +	ddata->regmap_eng = syscon_regmap_lookup_by_phandle(np, "st,syscfg-eng");
> > +	if (IS_ERR(ddata->regmap_eng)) {
> > +		dev_warn(&pdev->dev, "\"st,syscfg-eng\" not supplied\n");
> > +		goto set_default;
> > +	}
> > +
> > +	ret = of_property_read_u32_index(np, "st,syscfg-eng",
> > +					 PCODE_INDEX, &pcode_offset);
> > +	if (ret) {
> > +		dev_warn(&pdev->dev, "Process code offset is required\n");
> > +		goto set_default;
> > +	}
> > +
> > +	match = of_match_node(sti_cpufreq_of_match, np);
> 
> Are you planning to add more entries to this table? We are here as
> probe() is called only after matching for this string.

Yes, when new platforms are enabled.  The information stored in .data
will be different.

> > +	if (!match) {
> > +		dev_warn(&pdev->dev, "Failed to match device\n");
> > +		goto set_default;
> > +	}
> > +	reg_fields = match->data;
> > +
> > +	ddata->pcode = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
> > +						     pcode_offset,
> > +						     PCODE);
> > +	if (ddata->pcode < 0)
> > +		goto set_default;
> > +
> > +	ddata->substrate = st_cpufreq_fetch_regmap_field(pdev, reg_fields,
> > +							 pcode_offset,
> > +							 SUBSTRATE);
> > +	if (ddata->substrate < 0)
> > +		goto set_default;
> 
> Maybe:
> 
> 	if (ddata->substrate >= 0)
>                 return;

0 is a valid substrate value.

> > +
> > +	return;
> > +
> > +set_default:
> > +	dev_warn(&pdev->dev,
> > +		 "Setting pcode to highest tolerance/voltage for safety\n");
> > +	ddata->pcode = 0;
> > +	ddata->substrate = 0;
> > +}

[...]

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
