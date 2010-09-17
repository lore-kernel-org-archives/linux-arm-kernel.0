From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Fri, 17 Sep 2010 15:51:58 -0700
Subject: [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <4C93DC4E.5020506@ti.com> (Nishanth Menon's message of "Fri, 17
	Sep 2010 16:23:26 -0500")
References: <1284686973-13993-1-git-send-email-nm@ti.com>
	<20100917121958.1dbb57af.akpm@linux-foundation.org>
	<4C93DC4E.5020506@ti.com>
Message-ID: <878w30ugoh.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> Andrew Morton had written, on 09/17/2010 02:19 PM, the following:
>> On Thu, 16 Sep 2010 20:29:33 -0500
>> Nishanth Menon <nm@ti.com> wrote:
>>

[...]

>>> +void opp_init_cpufreq_table(struct device *dev,
>>> +			    struct cpufreq_frequency_table **table)
>>> +{
>>> +	struct device_opp *dev_opp;
>>> +	struct opp *opp;
>>> +	struct cpufreq_frequency_table *freq_table;
>>> +	int i = 0;
>>> +
>>> +	dev_opp = find_device_opp(dev);
>>> +	if (IS_ERR(dev_opp)) {
>>> +		pr_warning("%s: unable to find device\n", __func__);
>>> +		return;
>>> +	}
>>> +
>>> +	freq_table = kzalloc(sizeof(struct cpufreq_frequency_table) *
>>> +			     (dev_opp->enabled_opp_count + 1), GFP_ATOMIC);
>>> +	if (!freq_table) {
>>> +		pr_warning("%s: failed to allocate frequency table\n",
>>> +			   __func__);
>>> +		return;
>>> +	}
>>> +
>>> +	list_for_each_entry(opp, &dev_opp->opp_list, node) {
>>> +		if (opp->enabled) {
>>> +			freq_table[i].index = i;
>>> +			freq_table[i].frequency = opp->rate / 1000;
>>> +			i++;
>>> +		}
>>> +	}
>>> +
>>> +	freq_table[i].index = i;
>>> +	freq_table[i].frequency = CPUFREQ_TABLE_END;
>>> +
>>> +	*table = &freq_table[0];
>>> +}
>>
>> So we're playing with cpufreq internals here but there's no #ifdef
>> CONFIG_CPUFREQ and there's no Kconfig dependency on cpufreq.  That
>> needs fixing I think, if only from a reduce-code-bloat perspective.
>
> Thanks and ouch.. Again missing documentation. Apologies.
> http://marc.info/?l=linux-arm-kernel&m=128473931626114&w=2
>
> c) Dependency of OPP layer is on CONFIG_PM as certain SOCs such as Texas
> Instrument's OMAP support have frameworks to optionally boot at a
> certain opp without needing cpufreq.
>
> This is called "mpurate" bootarg parameter in OMAP framework. I will
> put this under #ifdef CPUFREQ and provide header coverage for the same
> appropriately.

The OPP layer in general is dependent on CONFIG_PM, but the snippit
above is called only by CPUfreq core when CPUfreq is enabled, so at
least that function should be under #ifdef CPUFREQ.

Kevin
