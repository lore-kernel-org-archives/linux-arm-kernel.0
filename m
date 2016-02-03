From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 3 Feb 2016 17:35:36 +0000
Subject: [PATCH v4 4/7] arm64: Handle early CPU boot failures
In-Reply-To: <56B237B7.1060805@arm.com>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
 <1453745225-27736-5-git-send-email-suzuki.poulose@arm.com>
 <20160203170114.GD1234@leverpostej> <56B237B7.1060805@arm.com>
Message-ID: <20160203173535.GF1234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 05:24:07PM +0000, Suzuki K. Poulose wrote:
> On 03/02/16 17:01, Mark Rutland wrote:
> >On Mon, Jan 25, 2016 at 06:07:02PM +0000, Suzuki K Poulose wrote:
> >>From: Suzuki K. Poulose <suzuki.poulose@arm.com>

[...]

> >>  struct secondary_data secondary_data;
> >>+/* Number of CPUs which aren't online, but looping in kernel text. */
> >>+u32 cpus_stuck_in_kernel;
> >
> >Why u32 rather than int?
> 
> No specific reasons, since it is going to be a quantity, which cannot be < 0,
> kept it unsigned. It could be unsigned int.

Elsewhere, int or unsigned int is used to contain a cpu number. I think
either would be preferable to u32, to at least limit the inconsistency.

> >>+#ifdef CONFIG_HOTPLUG_CPU
> >>+static int op_cpu_kill(unsigned int cpu);
> >>+#else
> >>+static inline int op_cpu_kill(unsigned int cpu)
> >>+{
> >>+	return -ENOSYS;
> >>+}
> >>+#endif
> >
> >There is no !CONFIG_HOTPLUG_CPU configuration any more.
> 
> Thats what I thought but then there was [1]. If you disable CONFIG_PM_SLEEP, you can
> still build with !CONFIG_HOTPLUG_CPU (or in other words allnoconfig)
> 
> [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/384589.html

Aargh, indeed. I had confused CONFIG_HOTPLUG_CPU and CONFIG_SMP. Sorry!

Mark. 
