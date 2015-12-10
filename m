From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 10 Dec 2015 08:25:18 +0000
Subject: [PATCH v6 08/10] cpufreq: st: Provide runtime initialised driver
 for ST's platforms
In-Reply-To: <20151210020737.GB29459@ubuntu>
References: <1449676697-25432-1-git-send-email-lee.jones@linaro.org>
 <1449676697-25432-9-git-send-email-lee.jones@linaro.org>
 <20151210020737.GB29459@ubuntu>
Message-ID: <20151210082518.GD17876@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 10 Dec 2015, Viresh Kumar wrote:

> On 09-12-15, 15:58, Lee Jones wrote:
> > +/*
> > + * Only match on "suitable for ALL versions" entries
> > + *
> > + * This will be used with the BIT() macro.  It sets the
> > + * top bit of a 32bit value and is equal to 0x80000000.
> > + */
> > +#define DEFAULT_VERSION		31
> 
> Okay, I misread it in the earlier version. This looks fine.
> 
> > +static int sti_cpufreq_set_opp_info(void)
> > +{
> 
> > +	sprintf(name, "pcode%d", pcode);
> 
> I would use snprintf here, in case I haven't counted the string
> properly. That should guarantee that we don't access the anything else
> than the 'name' array.

Not sure it's a big problem, unless the PCODE is read incorrectly from
h/w, but okay.

> > +	ret = dev_pm_opp_set_prop_name(dev, name);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set prop name\n");
> > +		return ret;
> > +	}
> > +
> > +	version[0] = BIT(major);
> > +	version[1] = BIT(minor);
> > +	version[2] = BIT(substrate);
> > +
> > +	ret = dev_pm_opp_set_supported_hw(dev, version, VERSION_ELEMENTS);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set supported hardware\n");
> > +		return ret;
> > +	}
> > +
> > +	dev_err(dev, "pcode: %d major: %d minor: %d substrate: %d\n",
> > +		pcode, major, minor, substrate);
> > +	dev_err(dev, "version[0]: %x version[1]: %x version[2]: %x\n",
> > +		version[0], version[1], version[2]);
> 
> These aren't errors.. dev_info ?

This is left-over from testing.  Will change.

> > +	return 0;
> > +}
> > +
> 
> > +static int sti_cpufreq_init(void)
> > +{
> > +	int ret;
> > +
> > +	ddata.cpu = get_cpu_device(0);
> > +	if (!ddata.cpu) {
> > +		dev_err(ddata.cpu, "Failed to get device for CPU0\n");
> > +		goto skip_voltage_scaling;
> > +	}
> > +
> > +	if (!of_get_property(ddata.cpu->of_node, "operating-points-v2", NULL)) {
> > +		dev_err(ddata.cpu, "OPP-v2 not supported\n");
> 
> Should be:
>                 dev_dbg(ddata.cpu, "OPP-v2 not supported, skip voltage scaling\n");

It's at least a dev_warn().  I do want this to appear on the bootlog.

> > +		goto skip_voltage_scaling;
> > +	}
> > +
> > +	ret = sti_cpufreq_fetch_syscon_regsiters();
> > +	if (ret)
> > +		goto skip_voltage_scaling;
> > +
> > +	ret = sti_cpufreq_set_opp_info();
> > +	if (ret)
> 
> Shouldn't this be !ret ? You should have jumped on success here.

Good spot.  Last minute change.  Will fix.

> > +		goto register_cpufreq_dt;
> > +
> > +skip_voltage_scaling:
> > +	dev_err(ddata.cpu, "Not doing voltage scaling\n");
> 
> This doesn't look nice as you are adding unnecessary jumps to just
> save on a print message. And because of the earlier suggestion you can
> do:

Actually it only adds one extra goto.  The other three are required
regardless.  And it saves on one whole print and prevents the other
two prints from becoming multi-line.  I think a single goto is worth
skipping that amount of non-sense and it is the latter which is the
greater evil.

I've seen what both methods looks like and chose this one for a
reason. 

> 	ret = sti_cpufreq_set_opp_info();
> 	if (ret)
>                 dev_err(ddata.cpu, "Skip voltage scaling\n");
> 
> > +
> > +register_cpufreq_dt:
> > +	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> > +
> > +	return 0;
> > +}
> > +module_init(sti_cpufreq_init);
> > +
> > +MODULE_DESCRIPTION("STMicroelectronics CPUFreq/OPP driver");
> > +MODULE_AUTHOR("Ajitpal Singh <ajitpal.singh@st.com>");
> > +MODULE_AUTHOR("Lee Jones <lee.jones@linaro.org>");
> > +MODULE_LICENSE("GPL v2");

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
