From: javier.picorel@epfl.ch (javier.picorel at epfl.ch)
Date: Mon, 08 Jul 2013 23:02:30 +0200
Subject: ARM Cortex A9: User/Kernel filter events
Message-ID: <20130708230230.23643s488884h59i@webmail.epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear all,

Is there any reason why ARM Cortex A9 cannot filter user/kernel events?

arch/arm/kernel/perf_event_v7.c

1144/*
1145 * Add an event filter to a given event. This will only work for  
PMUv2 PMUs.
1146 */
1147static int armv7pmu_set_event_filter(struct hw_perf_event *event,
1148                                     struct perf_event_attr *attr)
1149{
1150        unsigned long config_base = 0;
1151
1152        if (attr->exclude_idle)
1153                return -EPERM;
1154        if (attr->exclude_user)
1155                config_base |= ARMV7_EXCLUDE_USER;
1156        if (attr->exclude_kernel)
1157                config_base |= ARMV7_EXCLUDE_PL1;
1158        if (!attr->exclude_hv)
1159                config_base |= ARMV7_INCLUDE_HYP;
1160
1161        /*
1162         * Install the filter into config_base as this is used to
1163         * construct the event type.
1164         */
1165        event->config_base = config_base;
1166
1167        return 0;
1168}

It seems that only A15 and A7 are able to do it. Is it a limitation  
A9's PMU? Thank you!

Best Regards,
Javier
