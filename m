From: horms@verge.net.au (Simon Horman)
Date: Wed, 18 Feb 2015 17:27:31 -0500
Subject: [PATCH v3] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <1423874574-3494-1-git-send-email-sboyd@codeaurora.org>
References: <1423874574-3494-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150218222731.GC24177@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 04:42:54PM -0800, Stephen Boyd wrote:
> Writes to /sys/.../cpuX/online fail if we determine the platform
> doesn't support hotplug for that CPU. Furthermore, if the cpu_die
> op isn't specified the system hangs when we try to offline a CPU
> and it comes right back online unexpectedly. Let's figure this
> stuff out before we make the sysfs nodes so that the online file
> doesn't even exist if it isn't (at least sometimes) possible to
> hotplug the CPU.
> 
> Add a new cpu_can_disable op and repoint all cpu_disable
> implementations at it because all current users use the op to
> indicate if a CPU can be hotplugged or not in a static fashion.
> With PSCI we may need to introduce a cpu_disable op so that the
> secure OS can be migrated off the CPU we're trying to hotplug.
> In this case, the cpu_can_disable op will indicate that all CPUs
> are hotpluggable by returning 1, but the cpu_disable op will make
> a PSCI migration call and occasionally fail, denying the hotplug
> of a CPU. This shouldn't be any worse than x86 where we may
> indicate that all CPUs are hotpluggable but occasionally we can't
> offline a CPU due to check_irq_vectors_for_cpu_disable() failing
> to find a CPU to move vectors to.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: <linux-sh@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> Changes since v2:
>  * Left cpu_disable op in place
>  * Split out shmobile function deletion
> 
>  arch/arm/common/mcpm_platsmp.c       | 12 ++++--------
>  arch/arm/include/asm/smp.h           | 10 ++++++++++
>  arch/arm/kernel/setup.c              |  2 +-
>  arch/arm/kernel/smp.c                | 15 ++++++++++++++-
>  arch/arm/mach-shmobile/common.h      |  2 +-
>  arch/arm/mach-shmobile/platsmp.c     |  4 ++--
>  arch/arm/mach-shmobile/smp-r8a7790.c |  2 +-
>  arch/arm/mach-shmobile/smp-r8a7791.c |  2 +-
>  arch/arm/mach-shmobile/smp-sh73a0.c  |  2 +-
>  9 files changed, 35 insertions(+), 16 deletions(-)

I think it would make sense to separate the ARM-core changes
from the mach-shmobile integration changes.
