From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 22 Aug 2014 22:27:18 +0200
Subject: [PATCH v7 3/8] cpufreq: kirkwood: Remove use of the clk provider
 API
In-Reply-To: <20140822201112.GH17277@lunn.ch>
References: <1408375833-10703-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408375833-10703-4-git-send-email-tomeu.vizoso@collabora.com>
 <20140820225513.5251.284@quantum> <53F5A587.9030200@collabora.com>
 <20140821133825.GH8608@lunn.ch> <20140822192933.5251.53733@quantum>
 <20140822201112.GH17277@lunn.ch>
Message-ID: <20140822202718.GI17277@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> It was clearer in earlier versions of the driver, but code has been
> refactored into the cpufreq core. The core should call
> kirkwood_cpufreq_get_cpu_frequency() in order to get the current
> frequency, and only perform a change if the requested frequency is
> different. In the current code, kirkwood_cpufreq_get_cpu_frequency()
> reads from the hardware what the current frequency is. So we are
> guaranteed to only call kirkwood_cpufreq_target() when there is a real
> change.

Hi Mike

I went looking at the core.

drivers/cpufreq/cpufreq.c:__cpufreq_add_dev() contains:

        if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
                policy->cur = cpufreq_driver->get(policy->cpu);
                if (!policy->cur) {
                        pr_err("%s: ->get() failed\n", __func__);
                        goto err_get_freq;
                }
        }

So this gets the current frequency from the driver, when the driver is
added. So for the current code, this gets the real state of the
hardware.

and

drivers/cpufreq/cpufreq.c:__cpufreq_driver_target() contains:

        /*
         * This might look like a redundant call as we are checking it again
         * after finding index. But it is left intentionally for cases where
         * exactly same freq is called again and so we can save on few function
         * calls.
         */
        if (target_freq == policy->cur)
                return 0;

        /* Save last value to restore later on errors */
        policy->restore_freq = policy->cur;

        if (cpufreq_driver->target)
                retval = cpufreq_driver->target(policy, target_freq, relation);

and here it will only call the function to change the frequency, if it
is different from the current frequency.

   Andrew
