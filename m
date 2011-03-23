From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Mar 2011 15:07:26 -0000
Subject: [PATCH 1/2] ARM: perf: reset counters on all CPUs during
	initialisation
In-Reply-To: <AANLkTikbWKHgNyQmgu+LHQ+mPBm411R8BLaDDz6YZnJo@mail.gmail.com>
References: <1300289898-2720-1-git-send-email-will.deacon@arm.com>	<AANLkTim_XwErHv_Brkn5hXn7sAxvkd++C5wbKv9n4VXC@mail.gmail.com>	<-7053270875332574934@unknownmsgid>
	<AANLkTikbWKHgNyQmgu+LHQ+mPBm411R8BLaDDz6YZnJo@mail.gmail.com>
Message-ID: <003001cbe96c$05c77a90$11566fb0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > I don't think this patch is safe for combined v6/v7 kernels because the
> > arch_initcall will try to poke the v7 PMU regardless of whether or not
> > it exists. I'll try and rework something and send another version to the
> > list.
> Ok. The new code should probably be called from *read_num_pmnc_events.

I thought that initially, but we need SMP up and running for the cross
calls. Since read_num_pmnc_events is called via an early_initcall, that's
not possible (which is the reason I used an arch_initcall in the first place).

The solution I've come up with is adding a ->reset function pointer to
struct arm_pmu, which can be called via an arch_initcall in perf_event.c
for the PMU it ends up using. I'll post it in a bit.

Will
