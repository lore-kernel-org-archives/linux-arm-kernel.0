From: ananaza@iki.fi (Antti Miettinen)
Date: Tue, 10 Dec 2013 08:31:56 +0200
Subject: [PATCH RFC 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Mon, 2 Dec 2013 16:20:05 +0000")
References: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1386001205-11978-3-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <87lhztgqsj.fsf@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:
> +	- latency
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Worst case latency in microseconds required to
> +			    enter and exit the C-state.
> +
> +	- min-residency
> +		Usage: Required
> +		Value type: <u32>
> +		Definition: Time in microseconds required for the CPU to be in
> +			    the C-state to make up for the dynamic power
> +			    consumed to enter/exit the C-state in order to
> +			    break even in terms of power consumption compared
> +			    to C1 state (wfi).
> +			    This parameter depends on the operating conditions
> +			    (operating point, cache state) and must assume
> +			    worst case scenario.

I have a concern with these. I know it is not the fault of this patch as
these parameters are what current cpuidle governor/driver interface
uses, but..

Power state entry/exit latencies can be vary quite a lot. Especially CPU
and memory frequencies affect them as can e.g. PMIC properties. Also
power level during entry/exit depends on clocks and voltages. Also the
power level of a sleep state can be context dependent (clocks and
voltages). These mean that also the minimum residency for energy break
even varies. Defining a minimum residency against C1 is a bit
arbitrary. There is no guarantee that the break even order of idle
states remains constant over device context changes.

I have not really properly thought through this but here's an idea.. how
about an alternative interface between governor and driver? The cpuidle
core would provide the expected wakeup time and currently enforced
minimum latency to the driver and the driver would make the decision
about the state to choose.

	--Antti
