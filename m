From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Apr 2014 11:36:48 +0100
Subject: [PATCH 2/2] arm64: topology: add MPIDR-based detection
In-Reply-To: <1398217214-12204-3-git-send-email-zlim@broadcom.com>
References: <1398217214-12204-1-git-send-email-zlim@broadcom.com>
 <1398217214-12204-3-git-send-email-zlim@broadcom.com>
Message-ID: <20140423103648.GM12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 06:40:14PM -0700, Zi Shen Lim wrote:

> +		/* Multiprocessor system */
> +		if (mpidr & MPIDR_MT_BITMASK) {
> +			/* Multi-threads per core */
> +			cpuid_topo->thread_id  = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +			cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +			cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
> +		} else {
> +			/* Single-thread per core */
> +			cpuid_topo->thread_id  = -1;
> +			cpuid_topo->core_id    = MPIDR_AFFINITY_LEVEL(mpidr, 0);
> +			cpuid_topo->cluster_id = MPIDR_AFFINITY_LEVEL(mpidr, 1);
> +		}
> +	}

This means that we ignore affinity level 3 and on non-MT cores we ignore
affinity level 2.  That means that if it runs on some system where we do
have multiple levels of clustering (for example some future multi socket
server) or if for some reason the hardware engineers have decided to use
one of the higher affinity levels then we will incorrectly report cores
from several clusters as being part of a single cluster.

I had been intending to just combine all the bits from affinitly levels
above the CPU number into a single number until we know what to do with
them individually.  We shouldn't just ignore them.

> +	pr_info("CPU%u: cluster %d core %d thread %d mpidr %llx\n",
> +		cpuid, cpuid_topo->cluster_id, cpuid_topo->core_id,
> +		cpuid_topo->thread_id, mpidr);
> +

Catalin or Lorenzo asked for stuff like that to be taken out.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/d1331dfd/attachment-0001.sig>
