From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 19 Jan 2011 08:35:27 +0000
Subject: [PATCH V4 38/62] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <4D3648B1.4030807@st.com>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<0f47958e70aa830f749fe1a5e8c03b853740d701.1295333959.git.viresh.kumar@st.com>
	<20110119002046.GC2209@gallagher> <4D3648B1.4030807@st.com>
Message-ID: <20110119083527.GC9569@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 07:43:05AM +0530, deepaksi wrote:
> Hi James,
> 
> On 1/19/2011 5:50 AM, Jamie Iles wrote:
> >> +static int spear_cpufreq_target(struct cpufreq_policy *policy,
> >> +		unsigned int target_freq, unsigned int relation)
> >> +{
> >> +	struct cpufreq_freqs freqs;
> >> +	int ret = 0;
> >> +	int index;
> >> +
> >> +	if (policy->cpu != 0)
> >> +		return -EINVAL;
> >> +
> >> +	if (cpufreq_frequency_table_target(policy, spear_freq_tbl,
> >> +				target_freq, relation, &index))
> >> +		return -EINVAL;
> >> +
> >> +	freqs.old = spear_cpufreq_get(0);
> >> +	freqs.new = spear_cpu_freq[index];
> >> +	freqs.cpu = policy->cpu;
> >> +
> >> +	if (freqs.old == target_freq)
> >> +		return 0;
> >> +
> >> +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> >> +	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
> >> +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> >>     
> > If clk_set_rate() failed then do you need to do freqs.new = 
> > clk_get_rate(cpu_clk) before doing the CPUFREQ_POSTCHANGE to make sure you 
> > don't notify the wrong frequency?
> >
> >   
> I do have a point over here. In few of the drivers where the the pre
> notifiers have been added, the operations have been stopped (assume a
> network driver where we stalled a dma operation), and then we set the
> clock rate, followed by a post notifier where driver resumes it operations.
> 
> Now lets take the case, when the clock set rate fails (  Most failure
> could only be when the driver is unable to find any clock rate which is
> less then/equal to requested rate) .
> The post transition notifier should happen so as to allow the driver to
> resume its functions. If there are no clock rate changes because of set
> rate failures, the driver would be aware of that by using calls such as
> clk_get_rate, and would carry forward it's operations accordingly.
> 
> How do you suggest to go about it ?

Sorry, I didn't mean to remove the post notifier, just do something like:

	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
	if (ret)
		freqs.new = clk_get_rate(cpu_clk);
	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

Or:

	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
	if (ret)
		freqs.new = freqs.old;
	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

So that you're notifying the cpufreq subsystem of the frequency that you're 
actually running at with the post change notifier rather than the one you 
tried to go for.  If you don't do this then for UP you'll end up recaculating 
lpj based on the wrong frequency.

Jamie
