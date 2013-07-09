From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Jul 2013 09:03:54 +0100
Subject: ARM Cortex A9: User/Kernel filter events
In-Reply-To: <BFCB49997E59134AAAF17FFE77F8FF0667378D28@REXMD.intranet.epfl.ch>
References: <BFCB49997E59134AAAF17FFE77F8FF0667378D28@REXMD.intranet.epfl.ch>
Message-ID: <20130709080354.GA26169@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 08, 2013 at 09:58:17PM +0100, Javier Picorel wrote:
> Dear all,
> 
> Is there any reason why ARM Cortex A9 cannot filter user/kernel events?
> 
> arch/arm/kernel/perf_event_v7.c
> 
> 1144/*
> 1145 * Add an event filter to a given event. This will only work for PMUv2 PMUs.
> 1146 */
> 1147static int armv7pmu_set_event_filter(struct hw_perf_event *event,
> 1148                                     struct perf_event_attr *attr)
> 1149{
> 1150        unsigned long config_base = 0;
> 1151
> 1152        if (attr->exclude_idle)
> 1153                return -EPERM;
> 1154        if (attr->exclude_user)
> 1155                config_base |= ARMV7_EXCLUDE_USER;
> 1156        if (attr->exclude_kernel)
> 1157                config_base |= ARMV7_EXCLUDE_PL1;
> 1158        if (!attr->exclude_hv)
> 1159                config_base |= ARMV7_INCLUDE_HYP;
> 1160
> 1161        /*
> 1162         * Install the filter into config_base as this is used to
> 1163         * construct the event type.
> 1164         */
> 1165        event->config_base = config_base;
> 1166
> 1167        return 0;
> 1168}
> 
> It seems that only A15 and A7 are able to do it. Is it a limitation A9's PMU? Thank you!

Event filtering requires hardware support in the PMU, as described in the
comment above ("This will only work for PMUv2 PMUs"). A9 doesn't support
this feature.

One interesting thing would be to see if we can plumb into the new
context-tracking stuff from Kevin, which does keep track of transitions
between user and kernel space. That would allow a `poor man's' event
filtering for hardware that doesn't support it.

Will
