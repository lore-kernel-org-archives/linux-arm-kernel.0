From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 22 Jan 2015 22:34:43 +0800
Subject: [PATCH RFC 2/2] ARM64: psci: implement system suspend using PSCI
 v0.2 CPU SUSPEND
In-Reply-To: <20150122120850.GC1218@red-moon>
References: <1421840155-18990-1-git-send-email-sudeep.holla@arm.com>
 <1421840155-18990-3-git-send-email-sudeep.holla@arm.com>
 <20150122061812.GB9244@leoy-linaro>
 <20150122120850.GC1218@red-moon>
Message-ID: <20150122143443.GA18425@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi Lorenzo,

On Thu, Jan 22, 2015 at 12:08:50PM +0000, Lorenzo Pieralisi wrote:
> On Thu, Jan 22, 2015 at 06:18:12AM +0000, Leo Yan wrote:
> 
> [...]
> 
> > How about unify the power states passing for cpu idle and suspend?
> > 
> > below is a example for dts which place all power state into psci
> > entry, so that idle-states and system suspend both can reference
> > the power state.
> > 
> > psci {
> > 	compatible = "arm,psci-0.2";
> > 	method = "smc";
> > 
> >         power_state {
> >                 CPU_POWER_OFF: cpu_power_off {
> >                         state = <0x00010000>;
> >                 };
> > 
> >                 CLUSTER_POWER_OFF: cluster_power_off {
> >                         state = <0x01010000>;
> >                 };
> > 
> >                 SOC_SUSPEND: soc_suspend {
> >                         state = <0x01010001>;
> >                 };
> >         };
> > };
> 
> I do not see why this would help. We would end up with phandles to
> the nodes above to get the parameter from idle-states, to me it
> looks like churn honestly, I do not see where the improvement is.

My original thought is these power states actually are mainly used by
the arm trusted firmware; in kernel, it only need maintain such power
state ids and pass these power state to firmware according to the
requirement from cpuidle or suspend flows.

For cpuidle and suspend, they only need to know the index which
should use and simply pass this index to the function *cpu_suspend(idx)*
will be enough. So finally we also can simplize the code to parse
these power state.

Following upper idea, the dts can be written like this way:

        psci {
        	compatible = "arm,psci-0.2";
        	method = "smc";

                power_state {
                        CPU_POWER_OFF: cpu_power_off {
                                state = <0x00010000>;
                        };

                        CLUSTER_POWER_OFF: cluster_power_off {
                                state = <0x01010000>;
                        };

                        SOC_SUSPEND: soc_suspend {
                                state = <0x01010001>;
                        };
                };
        };

	idle-states {
		entry-method = "arm,psci";

		C1: cpu-power-down {
			compatible = "arm,idle-state";
			arm,psci-state-idx = 0;
			entry-latency-us = <20>;
			exit-latency-us = <40>;
			min-residency-us = <80>;
		};

		MP: cluster-power-down {
			compatible = "arm,idle-state";
			local-timer-stop;
			arm,psci-state-idx = 1;
			entry-latency-us = <50>;
			exit-latency-us = <100>;
			min-residency-us = <250>;
			wakeup-latency-us = <130>;
		};
        };

        system-suspend {
                compatible = "arm,system-suspend";
                entry-method = "arm,psci";
                arm,psci-state-idx = 2;
        };

Before i have not followed up the discussion tightly, so if i miss something
introduce noise for this topic, sorry about that.

Thanks,
Leo Yan
