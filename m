From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Apr 2015 14:42:46 +0100
Subject: [PATCH v5] ARM: smp: Only expose /sys/.../cpuX/online if
 hotpluggable
In-Reply-To: <1428705191-15670-1-git-send-email-sboyd@codeaurora.org>
References: <1428705191-15670-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150413134246.GS12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 03:33:11PM -0700, Stephen Boyd wrote:
> Writes to /sys/.../cpuX/online fail if we determine the platform
> doesn't support hotplug for that CPU. Furthermore, if the cpu_die
> op isn't specified the system hangs when we try to offline a CPU
> and it comes right back online unexpectedly. Let's figure this
> stuff out before we make the sysfs nodes so that the online file
> doesn't even exist if it isn't (at least sometimes) possible to
> hotplug the CPU.
> 
> Add a new 'cpu_can_disable' op and repoint all 'cpu_disable'
> implementations at it because all implementers use the op to
> indicate if a CPU can be hotplugged or not in a static fashion.
> With PSCI we may need to add a 'cpu_disable' op so that the
> secure OS can be migrated off the CPU we're trying to hotplug.
> In this case, the 'cpu_can_disable' op will indicate that all
> CPUs are hotpluggable by returning true, but the 'cpu_disable' op
> will make a PSCI migration call and occasionally fail, denying
> the hotplug of a CPU. This shouldn't be any worse than x86 where
> we may indicate that all CPUs are hotpluggable but occasionally
> we can't offline a CPU due to check_irq_vectors_for_cpu_disable()
> failing to find a CPU to move vectors to.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Dave Martin <Dave.Martin@arm.com>
> Acked-by: Simon Horman <horms@verge.net.au> [shmobile portion]
> Tested-by: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: <linux-sh@vger.kernel.org>
> Cc: Tyler Baker <tyler.baker@linaro.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Let's see some more acks for this...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
