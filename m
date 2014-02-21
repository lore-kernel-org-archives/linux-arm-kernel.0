From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 21 Feb 2014 15:01:40 +0000
Subject: [PATCH 1/4] arm64: topology: Implement basic CPU topology support
In-Reply-To: <1392037324-5069-1-git-send-email-broonie@kernel.org>
References: <1392037324-5069-1-git-send-email-broonie@kernel.org>
Message-ID: <20140221150140.GB495@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 01:02:01PM +0000, Mark Brown wrote:

[...]

> +void store_cpu_topology(unsigned int cpuid)
> +{
> +	struct cpu_topology *cpuid_topo = &cpu_topology[cpuid];
> +
> +	/* DT should have been parsed by the time we get here */
> +	if (cpuid_topo->core_id == -1)
> +		pr_info("CPU%u: No topology information configured\n", cpuid);
> +	else
> +		update_siblings_masks(cpuid);

If the DT does not contain a proper topology the scheduler seem to go for a
toss. I tried to track it down and it seems it expects topology cpumasks to be
initialized regardless (eg to possible mask), they cannot be left empty.

Either update_siblings_masks is called regardless or possible mask must
be copied to the topology masks.

I will have a thorough look to check if the scheduler has a fall-back
mechanism.

On top of that, the pr_info message is quite annoying and should be
probably downgraded or removed altogether.

Furthermore leaving core_id as -1 should be fine, but I have to have a
proper look into the scheduler topology code to countercheck that.

Lorenzo
