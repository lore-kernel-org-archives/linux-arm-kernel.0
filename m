From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jun 2017 20:05:23 +0530
Subject: cpufreq: frequency scaling spec in DT node
In-Reply-To: <136334fe-c2a7-875b-91e0-329a0d7a2304@free.fr>
References: <1f665895-a2a0-6bdf-a9d9-66219fe3a8ef@free.fr>
 <20170629100459.GL29665@vireshk-i7>
 <538b1aa2-9298-6f21-392e-73d6559b581c@free.fr>
 <136334fe-c2a7-875b-91e0-329a0d7a2304@free.fr>
Message-ID: <20170629143523.GN29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-17, 15:01, Mason wrote:
> On 29/06/2017 13:41, Mason wrote:
> 
> > On 29/06/2017 12:04, Viresh Kumar wrote:
> > 
> >> There is one thing you can do to avoid adding OPP entries in the DT.
> >> You can rather add them dynamically with help of: dev_pm_opp_add() and
> >> cpufreq-dt will continue to work with that too.
> > 
> > In what driver should I call these... the clk driver?
> > (drivers/clk/tegra/cvb.c seems to be doind that)
> 
> The problem I run into is that calling get_cpu_device(0) from the
> clk driver returns NULL, because topology_init() has not run yet
> (to initialize the cpu_sys_devices).
> 
> So the OPP table needs to be built *after* topology_init() but
> *before* dt_cpufreq_probe().
> 
> subsys_initcall(topology_init);
> device_initcall(cpufreq_dt_platdev_init);
> 
> I'm not sure how to proceed.

As we discussed over IRC, you can control the creation of cpufreq-dt
platform device and hence when the cpufreq-dt driver gets probed. Your
own cpufreq driver is the way to go here.

-- 
viresh
