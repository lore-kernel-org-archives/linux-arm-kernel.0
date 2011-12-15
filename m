From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Dec 2011 20:29:11 +0000
Subject: [RFC V1 1/4] cpufreq: add arm soc generic cpufreq driver
In-Reply-To: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
References: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111215202911.GL14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 07:16:35PM +0800, Richard Zhao wrote:
> +#ifdef CONFIG_SMP
> +	/* loops_per_jiffy is not updated by the cpufreq core for SMP systems.
> +	 * So update it for all CPUs.
> +	 */
> +	for_each_possible_cpu(cpu)
> +		per_cpu(cpu_data, cpu).loops_per_jiffy =
> +		cpufreq_scale(per_cpu(cpu_data, cpu).loops_per_jiffy,
> +					freqs.old, freqs.new);

NAK.  If you think this is a good solution, you're very wrong.  If this
is what's in the core cpufreq code, then it too is very broken.

I've seen this exact method result in the loops_per_jiffy being totally
buggered over time by the constant scaling up and down.  The only way
to do this _sensibly_ is to record the _initial_ loops_per_jiffy and
_inital_ frequency, and scale from that.

That way you get consistent results irrespective of the scalings you
do over time, rather than something which continually deteriorates with
every frequency change.
