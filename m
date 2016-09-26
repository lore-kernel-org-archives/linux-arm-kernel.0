From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Sep 2016 10:05:13 +0200
Subject: [PATCH v2 4/4] PM / AVS: rockchip-cpu-avs: add driver handling
 Rockchip cpu avs
In-Reply-To: <20160926035511.GG17336@vireshk-i7>
References: <1471510341-63926-1-git-send-email-finley.xiao@rock-chips.com>
 <20160912215515.GF7243@codeaurora.org> <20160926035511.GG17336@vireshk-i7>
Message-ID: <20776501.pZ2NDOzLK3@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 26. September 2016, 09:25:11 CEST schrieb Viresh Kumar:
> On 12-09-16, 14:55, Stephen Boyd wrote:
> > On 08/29, Viresh Kumar wrote:
> > > On 18-08-16, 16:52, Finlye Xiao wrote:
> > > > +static int rockchip_adjust_opp_table(struct device *cpu_dev,
> > > > +				     struct cpufreq_frequency_table *table,
> > > > +				     int volt)
> > > > +{
> > > > +	struct opp_table *opp_table;
> > > > +	struct cpufreq_frequency_table *pos;
> > > > +	struct dev_pm_opp *opp;
> > > > +
> > > > +	if (!volt)
> > > > +		return 0;
> > > > +
> > > > +	rcu_read_lock();
> > > > +
> > > > +	opp_table = _find_opp_table(cpu_dev);
> > > > +	if (IS_ERR(opp_table)) {
> > > > +		rcu_read_unlock();
> > > > +		return PTR_ERR(opp_table);
> > > > +	}
> > > > +
> > > > +	cpufreq_for_each_valid_entry(pos, table) {
> > > > +		opp = dev_pm_opp_find_freq_exact(cpu_dev, pos->frequency * 1000,
> > > > +						 true);
> > > > +		if (IS_ERR(opp))
> > > > +			continue;
> > > > +
> > > > +		opp->u_volt += volt;
> > > > +		opp->u_volt_min += volt;
> > > > +		opp->u_volt_max += volt;
> > > > +	}
> > > > +
> > > > +	rcu_read_unlock();
> > > > +
> > > > +	return 0;
> > > > +}
> > > 
> > > I wouldn't prefer altering the opp tables from individual drivers at
> > > all. At the least, it should be done via some helpers exposed by the
> > > core.
> > > 
> > > But before that I would like to hear from Stephen a bit as I recall he
> > > was also working on something similar.
> > 
> > I had a patch to modify the voltage at runtime for the "current"
> > OPP. Now that we have regulator and clk control inside OPP that
> > became a little easier to do without having to do some notifier
> > from the OPP layer to the consumers. I haven't had time to revive
> > those patches though. Should we do that?
> 
> Perhaps yes, we should have a common place for doing all that.
> 
> > Does this need to modify
> > anything besides the OPP the device is currently running at?
> 
> Finlye, can you please answer this ?

If I understand it correctly, depending on the leakage value stored in an 
efuse, all opp voltages are reduced by a certain value. Right now the driver 
does it in one go for the full opp table, but of course could also do it for 
each new opp individually before it gets set.
