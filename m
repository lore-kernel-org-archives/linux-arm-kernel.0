From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Jul 2014 15:43:27 +0100
Subject: [PATCH 04/19] ARM64 / ACPI: Introduce arch_fix_phys_package_id()
 for cpu topology
In-Reply-To: <1406206825-15590-5-git-send-email-hanjun.guo@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-5-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140724144327.GJ17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 09:00:10PM +0800, Hanjun Guo wrote:

> +/*
> + * Use the CPU slot number provided by ACPI to update the physical
> + * package id when cpuid_topo->cluster_id is not available, then we
> + * can get the right value in the "physical id" field of /proc/cpuinfo.
> + */
> +void arch_fix_phys_package_id(int num, u32 slot)
> +{
> +	struct cpu_topology *cpuid_topo = &cpu_topology[num];
> +
> +	if (cpuid_topo->cluster_id == -1)
> +		cpuid_topo->cluster_id = slot;
> +}
> +EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);

As I said on the previous version of this patch are you sure this runs
at a point between the cluster ID getting initialized to -1 and the slot
being initialized (bear in mind that we now use MPIDR information if
availabe).  I don't understand why we don't just unconditionally use the
value given.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140724/ea69f852/attachment.sig>
