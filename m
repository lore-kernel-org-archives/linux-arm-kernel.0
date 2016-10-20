From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 11:41:54 +0100
Subject: [PATCH v3 0/5] Cavium ThunderX uncore PMU support
In-Reply-To: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
References: <1476955841-27898-1-git-send-email-jglauber@cavium.com>
Message-ID: <20161020104146.GC10234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:30:36AM +0200, Jan Glauber wrote:
> Sorry for the long time it took for re-cooking this patch set.
> The v3 should address all of Marks previous comments, things I didn't
> change are listed below.
> 
> Not changed:
> - Stick to NUMA node ID to detect the socket a device belongs to but made
>   uncore depend on CONFIG_NUMA.
> - Stick to initcall for uncore framework because it is easier to do the
>   scanning for the same type of PCI devices, also I don't know if the PCI layer
>   would allow for several drivers to register for the same device ID.
> 
> Note:
> I'm using perf_sw_context in difference to perf_invalid_context
> (see WARN_ON in perf_pmu_register). Reason is that with perf_invalid_context
> add() is never called and the counter results are shown as "unsupported" by
> perf. With perf_sw_context everything works as expected.

I take it you were tryign to open per-task, non system-wide events?

As a shared resource, per-task events do not make sense, and thus using
perf_sw_context does not make sense.

I take it If you expose a cpumask, and open the event in system-wide
mode (passing '-a' to perf tool), things should work even if using
perf_invalid_context.

Thanks,
Mark.
