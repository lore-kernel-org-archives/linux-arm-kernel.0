From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Jan 2013 12:38:33 -0800
Subject: [PATCH] hardlockup: detect hard lockups without NMIs using
 secondary cpus
In-Reply-To: <1357783059-13923-1-git-send-email-ccross@android.com>
References: <1357783059-13923-1-git-send-email-ccross@android.com>
Message-ID: <20130110203833.GE14149@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Colin Cross <ccross@android.com> [130109 18:05]:
> +static void watchdog_check_hardlockup_other_cpu(void)
> +{
> +	int cpu;
> +	cpumask_t cpus = watchdog_cpus;
> +
> +	/*
> +	 * Test for hardlockups every 3 samples.  The sample period is
> +	 *  watchdog_thresh * 2 / 5, so 3 samples gets us back to slightly over
> +	 *  watchdog_thresh (over by 20%).
> +	 */
> +	if (__this_cpu_read(hrtimer_interrupts) % 3 != 0)
> +		return;
> +
> +	/* check for a hardlockup on the next cpu */
> +	cpu = cpumask_next(smp_processor_id(), &cpus);

Hmm don't you want to check cpu_oneline_mask here and
return if the other CPU is offline?

> +	if (cpu >= nr_cpu_ids)
> +		cpu = cpumask_first(&cpus);
> +	if (cpu == smp_processor_id())
> +		return;

Regards,

Tony
