From: kim.phillips@arm.com (Kim Phillips)
Date: Fri, 29 Sep 2017 17:19:40 -0500
Subject: [PATCH v5 6/7] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <1506607791-8621-7-git-send-email-will.deacon@arm.com>
References: <1506607791-8621-1-git-send-email-will.deacon@arm.com>
 <1506607791-8621-7-git-send-email-will.deacon@arm.com>
Message-ID: <20170929171940.2aa33d00463b1e9c987aea15@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Sep 2017 15:09:50 +0100
Will Deacon <will.deacon@arm.com> wrote:

> +/* Perf callbacks */
> +static int arm_spe_pmu_event_init(struct perf_event *event)
> +{
> +	u64 reg;
> +	struct perf_event_attr *attr = &event->attr;
> +	struct arm_spe_pmu *spe_pmu = to_spe_pmu(event->pmu);
> +
> +	/* This is, of course, deeply driver-specific */
> +	if (attr->type != event->pmu->type)
> +		return -ENOENT;
> +
> +	if (event->cpu >= 0 &&
> +	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
> +		return -ENOENT;

So -ENOENT will make tools/perf/util/evsel.c tell the user "The %s event is not
supported." whereas returning -ENODEV will say "No such device - did
you specify an out-of-range profile CPU?" which may or may not be more
appropriate for this check.

> +	if (arm_spe_event_to_pmsevfr(event) & SYS_PMSEVFR_EL1_RES0)
> +		return -EOPNOTSUPP;
> +	if (attr->exclude_idle)
> +		return -EOPNOTSUPP;

"PMU Hardware doesn't support sampling/overflow-interrupts." will be
printed if the user didn't specify a sample period.  Otherwise, a
string with "/bin/dmesg may provide additional information." will be
printed.

I was hoping for a response from acme by now for this:

https://www.spinics.net/lists/linux-perf-users/msg04066.html

Alas, nothing.  Looking at the #ifdef x86 in evsel.c, I'm guessing
it'll be ok, although I'm still not sure how PMU-specific we can get in
evsel.c, nor whether it's ok to communicate lists of h/w supported
sample periods through /sys/bus/event_source/devices/...

acme?  OK to refactor evsel messaging for Arm, including parsing for
which PMUs are being used, so customize the message?

Kim
