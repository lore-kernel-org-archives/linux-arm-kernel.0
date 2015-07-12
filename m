From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 12 Jul 2015 22:58:55 +0100
Subject: [PATCH 3/3] arm64, mm: Use IPIs for TLB invalidation.
In-Reply-To: <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
References: <1436646323-10527-1-git-send-email-ddaney.cavm@gmail.com>
 <1436646323-10527-4-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150712215851.GA12807@MBP>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 11, 2015 at 01:25:23PM -0700, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> Most broadcast TLB invalidations are unnecessary.  So when
> invalidating for a given mm/vma target the only the needed CPUs via
> and IPI.
> 
> For global TLB invalidations, also use IPI.
> 
> Tested on Cavium ThunderX.
> 
> This change reduces 'time make -j48' on kernel from 139s to 116s (83%
> as long).

Have you tried something like kernbench? It tends to be more consistent
than a simple "time make".

However, the main question is how's the performance on systems with a
lot less CPUs (like 4 to 8)? The results are highly dependent on the
type of application, CPU and SoC implementation (I've done similar
benchmarks in the past). So, I don't think it's a simple answer here.

> The patch is needed because of a ThunderX Pass1 erratum: Exclusive
> store operations unreliable in the presence of broadcast TLB
> invalidations. The performance improvements shown make it compelling
> even without the erratum workaround need.

This performance argument is debatable, I need more data and not just
for the Cavium boards and kernel building. In the meantime, it's an
erratum workaround and it needs to follow the other workarounds we have
in the kernel with a proper Kconfig option and alternatives that can be
patched in our out at run-time (I wonder whether jump labels would be
better suited here).

-- 
Catalin
