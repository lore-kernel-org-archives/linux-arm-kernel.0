From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Dec 2013 14:47:55 +0000
Subject: [PATCH 5/6] arm64: topology: Tell the scheduler about the
 relative power of cores
In-Reply-To: <1386767606-6391-5-git-send-email-broonie@kernel.org>
References: <1386767606-6391-1-git-send-email-broonie@kernel.org>
 <1386767606-6391-5-git-send-email-broonie@kernel.org>
Message-ID: <20131211144755.GF596@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 11, 2013 at 01:13:25PM +0000, Mark Brown wrote:
> The power numbers are the same as for ARMv7 since it seems that the
> expected differential between the big and little cores is very similar on
> both ARMv7 and ARMv8.

I have no idea ;). We don't have real silicon yet, so that's just a wild
guess.

> +/*
> + * Table of relative efficiency of each processors
> + * The efficiency value must fit in 20bit and the final
> + * cpu_scale value must be in the range
> + *   0 < cpu_scale < 3*SCHED_POWER_SCALE/2
> + * in order to return at most 1 when DIV_ROUND_CLOSEST
> + * is used to compute the capacity of a CPU.
> + * Processors that are not defined in the table,
> + * use the default SCHED_POWER_SCALE value for cpu_scale.
> + */
> +static const struct cpu_efficiency table_efficiency[] = {
> +	{ "arm,cortex-a57", 3891 },
> +	{ "arm,cortex-a53", 2048 },
> +	{ NULL, },
> +};

I also don't think we can just have absolute numbers here. I'm pretty
sure these were generated on TC2 but other platforms may have different
max CPU frequencies, memory subsystem, level and size of caches. The
"average" efficiency and difference will be different.

Can we define this via DT? It's a bit strange since that's a constant
used by the Linux scheduler but highly related to hardware.

-- 
Catalin
