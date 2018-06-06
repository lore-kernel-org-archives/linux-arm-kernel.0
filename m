From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 6 Jun 2018 18:18:12 +0100
Subject: [PATCH v2] arm64: topology: Avoid checking numa mask for
 scheduler MC selection
In-Reply-To: <20180606163846.495725-1-jeremy.linton@arm.com>
References: <20180606163846.495725-1-jeremy.linton@arm.com>
Message-ID: <20180606171811.lro2u3g6rawxvskm@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2018 at 11:38:46AM -0500, Jeremy Linton wrote:
> The numa mask subset check can often lead to system hang or crash during
> CPU hotplug and system suspend operation if NUMA is disabled. This is
> mostly observed on HMP systems where the CPU compute capacities are
> different and ends up in different scheduler domains. Since
> cpumask_of_node is returned instead core_sibling, the scheduler is
> confused with incorrect cpumasks(e.g. one CPU in two different sched
> domains at the same time) on CPU hotplug.
> 
> Lets disable the NUMA siblings checks for the time being, as NUMA in
> socket machines have LLC's that will assure that the scheduler topology
> isn't "borken".
> 
> The NUMA check exists to assure that if a LLC within a socket crosses
> NUMA nodes/chiplets the scheduler domains remain consistent. This code will
> likely have to be re-enabled in the near future once the NUMA mask story
> is sorted.  At the moment its not necessary because the NUMA in socket
> machines LLC's are contained within the NUMA domains.
> 
> Further, as a defensive mechanism during hot-plug, lets assure that the
> LLC siblings are also masked.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks for this. I queued it for this merging window.

-- 
Catalin
