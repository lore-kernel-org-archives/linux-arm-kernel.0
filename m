From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 13 Jun 2011 20:37:48 +0200
Subject: [PATCH 0/3] CPU PM notifiers
In-Reply-To: <1307925825-28566-1-git-send-email-ccross@android.com>
References: <1307925825-28566-1-git-send-email-ccross@android.com>
Message-ID: <201106132037.49009.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, June 13, 2011, Colin Cross wrote:
> This patch set tries to address Russell's concerns with platform
> pm code calling into the driver for every block in the Cortex A9s
> during idle, hotplug, and suspend.  The first patch adds cpu pm
> notifiers that can be called by platform code, the second uses
> the notifier to save and restore the GIC state, and the third
> saves the VFP state.
> 
> The notifiers are used for two types of events, CPU PM events and
> CPU complex PM events.  CPU PM events are used to save and restore
> per-cpu context when a single CPU is preparing to enter or has
> just exited a low power state.  For example, the VFP saves the
> last thread context, and the GIC saves banked CPU registers.
> 
> CPU complex events are used after all the CPUs in a power domain
> have been prepared for the low power state.  The GIC uses these
> events to save global register state.
> 
> Platforms that call the cpu_pm APIs must select
> CONFIG_ARCH_USES_CPU_PM
> 
> L2 cache is not covered by this patch set, as the determination
> of when the L2 is reset and when it is retained is
> platform-specific, and most of the APIs necessary are already
> present.
> 
>  arch/arm/Kconfig              |    7 ++
>  arch/arm/common/gic.c         |  212 +++++++++++++++++++++++++++++++++++++++++
>  arch/arm/include/asm/cpu_pm.h |   54 +++++++++++
>  arch/arm/kernel/Makefile      |    1 +
>  arch/arm/kernel/cpu_pm.c      |  181 +++++++++++++++++++++++++++++++++++

Is there any reason why this has to be ARM-specific?  There are other
architectures where this kind of feature might make sense (SH and
powerpc at least).

Besides, is there any overlap between this feature and the CPU hotplug
notifiers?

Rafael
