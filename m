From: broonie@kernel.org (Mark Brown)
Date: Fri, 25 Apr 2014 15:52:49 +0100
Subject: [PATCH v3 part1 07/11] ARM64 / ACPI: Introduce
 arch_fix_phys_package_id() for cpu topology
In-Reply-To: <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140425145249.GP12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 09:20:13PM +0800, Hanjun Guo wrote:

> +/*
> + * Use the CPU slot number provided by ACPI to update the physical
> + * package id, then we can get the right value in the "physical id"
> + * field of /proc/cpuinfo.
> + */
> +void arch_fix_phys_package_id(int num, u32 slot)
> +{
> +	struct cpu_topology *cpuid_topo = &cpu_topology[num];
> +
> +	if (cpuid_topo->cluster_id == -1)
> +		cpuid_topo->cluster_id = slot;
> +}
> +EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);

This isn't going to work once we parse the MPIDR - we will always have a
cluster ID from MPIDR unless the system is uniprocessor (which doesn't
seem like it's going to be a common or useful case).  We'll either need
to have something in the topology parsing path which goes out and
queries ACPI before we try to parse MPIDR or this will need to just set
whatever it's told to set unconditionally.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140425/79ab2016/attachment.sig>
