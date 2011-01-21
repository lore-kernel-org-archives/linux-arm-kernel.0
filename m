From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 21 Jan 2011 09:10:26 +0530
Subject: [PATCH V5 39/63] SPEAr CPU freq: Adding support for CPU Freq
	framework
In-Reply-To: <20110120144941.GB25954@pulham.picochip.com>
References: <cover.1295499392.git.viresh.kumar@st.com>
	<403ef0da274038357f72e84e2378dc4e55be8cb0.1295499395.git.viresh.kumar@st.com>
	<20110120144941.GB25954@pulham.picochip.com>
Message-ID: <4D39002A.10703@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 08:19 PM, Jamie Iles wrote:
>> > +	newfreq = clk_round_rate(cpu_clk, freqs.new * 1000);
>> > +	if (newfreq < 0) {
>> > +		pr_err("CPU Freq: clk_round_rate failed: %ld\n", newfreq);
>> > +		freqs.new = freqs.old;
> Nitpick, you don't need to assign freqs.new here as you return 
> immediately after.
> 
>> > +		return newfreq;
>> > +	}
>> > +
>> > +	freqs.new = newfreq / 1000;
>> > +
>> > +	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>> > +
>> > +	/* Get current rate after clk_set_rate, for both success and failure */
>> > +	ret = clk_set_rate(cpu_clk, freqs.new * 1000);
>> > +	if (ret) {
>> > +		pr_err("CPU Freq: cpu clk_set_rate failed: %d\n", ret);
>> > +		freqs.new = clk_get_rate(cpu_clk) / 1000;
>> > +	}
>> > +
>> > +	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>> > +	return 0;
> Shouldn't this return 'ret' here in case clk_set_rate() failed?

Will correct both of them.
I will resend this patch alone, instead of sending everything again.

-- 
viresh
