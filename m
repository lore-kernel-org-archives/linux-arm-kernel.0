From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Mar 2011 07:48:48 -0600
Subject: [PATCH v3 0/7] ARM timer clock api support
In-Reply-To: <20110311081646.GA13596@n2100.arm.linux.org.uk>
References: <1299627277-20311-1-git-send-email-robherring2@gmail.com>
	<20110311081646.GA13596@n2100.arm.linux.org.uk>
Message-ID: <4D7A2840.1020808@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 03/11/2011 02:16 AM, Russell King - ARM Linux wrote:
> On Tue, Mar 08, 2011 at 05:34:30PM -0600, Rob Herring wrote:
>> From: Rob Herring<rob.herring@calxeda.com>
>>
>> This patch series converts ARM sp804 timer and smp_twd timer to use the clock
>> api.
>
> This is what I came up with - I've still not sorted these patches out,
> the second is a superset of the first.

Any comments on the smp_twd patch? Colin plans to base his cpufreq 
patches on it.

> +	clk = clk_get_sys(name, NULL);
> +	if (IS_ERR(clk)) {
> +		pr_err("sp804: %s clock not found, defaulting to 1MHz: %d\n",
> +			name, ERR_PTR(clk));
> +	} else {
> +		int err = clk_enable(clk);
> +		if (err != 0) {
> +			pr_err("sp804: %s clock failed to enable: %d\n",
> +				name, err);
> +			clk_put(clk);
> +		} else {
> +			rate = clk_get_rate(clk);
> +		}

You previously said this should fully move to using the clock api. 
Presumably, that meant no default freq of 1MHz.

Also, my patch allows for clksrc and clkevent timers to have different 
clocks. Currently, no h/w needs that, but it could happen. Even if they 
are the same clk, you are introducing a requirement on the calling order 
of sp804_clocksource_init and sp804_clockevents_init.

Rob
