From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 09:53:58 +0000
Subject: [PATCH V4 38/62] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <20110119093942.GC8048@DLHLAP0379>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<0f47958e70aa830f749fe1a5e8c03b853740d701.1295333959.git.viresh.kumar@st.com>
	<20110119002046.GC2209@gallagher> <4D3648B1.4030807@st.com>
	<20110119083527.GC9569@gallagher>
	<20110119090008.GA8048@DLHLAP0379>
	<20110119093942.GC8048@DLHLAP0379>
Message-ID: <20110119095358.GA31652@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 03:09:42PM +0530, Shiraz Hashim wrote:
> On second thought it should always be there irrespective of failures
> as in our case it may happen that eventually CPU sets to a clock <=
> desired clock. So we would do following
> 
> cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> ret = clk_set_rate(cpu_clk, freqs.new * 1000);
> if (ret)
>         pr_err("Could not change cpu clk rate\n");
> freqs.new = clk_get_rate(cpu_clk);
> cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

It probably makes more sense to do:

	newfreq = clk_round_rate(cpu_clk, freqs.new * 1000);
	if (newfreq < 0) {
		pr_err("Invalid frequency blah blah\n");
		return newfreq;
	}

	freqs.new = newfreq / 1000;
	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
	ret = clk_set_rate(cpu_clk, newfreq);
	if (ret) {
	        pr_err("Could not change cpu clk rate\n");
		freqs.new = clk_get_rate(cpu_clk) / 1000;
	}
	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

so that the prechange notifier gets the actual frequency to be switched
to too.  In theory clk_set_rate() should only fail if the new frequency
couldn't be set for some reason.
