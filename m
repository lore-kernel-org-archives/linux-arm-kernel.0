From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 10 Sep 2012 22:22:44 +0200
Subject: [PATCH] cpufreq: add helper function cpufreq_set_target()
In-Reply-To: <20120910031341.GS26709@S2101-09.ap.freescale.net>
References: <1346981599-28081-1-git-send-email-shawn.guo@linaro.org>
 <201209072131.56593.rjw@sisk.pl>
 <20120910031341.GS26709@S2101-09.ap.freescale.net>
Message-ID: <201209102222.45165.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 10, 2012, Shawn Guo wrote:
> On Fri, Sep 07, 2012 at 09:31:56PM +0200, Rafael J. Wysocki wrote:
> > > +	struct cpufreq_target_data data;
> > > +
> > > +	data.dev = cpu_dev;
> > > +	data.clk = cpu_clk;
> > > +	data.reg = cpu_reg;
> > > +	data.tol = voltage_tolerance;
> > > +	data.freq_table = freq_table;
> > > +	data.policy = policy;
> > > +	data.target_freq = target_freq;
> > > +	data.relation = relation;
> > 
> > I'm not sure what you need the new data structure for.  Both
> > cpu0_set_target() and omap_target() have the same set of arguments, so it
> > seems pointless to copy those values back and forth.
> > 
> But the first 4 arguments are driver specific.  They are existing
> in cpufreq-cpu0 and omap-cpufreq drivers as global variables.  I
> haven't thought of a good way to consolidate all these differences.

Hmm.  Who's going to use the cpufreq-cpu0 driver, then?  Is OMAP going to be
the only user?

> > > +
> > > +	return cpufreq_set_target(&data);
> > 
> > What about calling that function cpufreq_common_set_target()?
> > 
> All driver specific .set_target functions are named with a driver
> specific prefix, so this shorter name seems explicit to tell the
> "common", IMO.  But if you insist, I can change.

Well, it's not exactly common, so to speak.  It only is shared between
the cpu0 and OMAP drivers, so I'm not sure (see below).

> > >  }
> > >  
> > >  static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
> > > diff --git a/drivers/cpufreq/cpufreq.h b/drivers/cpufreq/cpufreq.h
> > > new file mode 100644
> > > index 0000000..ae380b3
> > > --- /dev/null
> > > +++ b/drivers/cpufreq/cpufreq.h
> > 
> > I don't think this header is really necessary.
> > 
> Put the stuff into include/linux/cpufreq.h?  But these stuff do not
> necessarily need to be that public.
> 
> <snip>
> 
> > > +int cpufreq_set_target(struct cpufreq_target_data *d)
> > 
> > Why don't you use the original arguments of cpu0_set_target() here?
> > 
> As explained above, cpu_dev, cpu_clk, cpu_reg and voltage_tolerance
> are used in the function as global variables in cpufreq-cpu0 driver.
> 
> And that's the primary reason why I think making this common set_target
> thing is somehow a churn.

OK

I'm concerned about the copy-pasting, but if that copy-pasting is going to
go away when you move OMAP to the new driver, then I agree that adding more
complexity just to avoid it is probably not a good idea.

What's the planned time frame for the OMAP conversion?

Rafael
