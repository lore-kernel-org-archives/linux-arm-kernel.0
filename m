From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jan 2017 13:33:13 +0000
Subject: [RFC PATCH 09/10] drivers/perf: Add support for ARMv8.2
 Statistical Profiling Extension
In-Reply-To: <20170111150239.724c8117e997fa31cfa4d602@arm.com>
References: <1483467027-14547-1-git-send-email-will.deacon@arm.com>
 <1483467027-14547-10-git-send-email-will.deacon@arm.com>
 <20170110160419.4cc3d61c9d652e5d5da13f15@arm.com>
 <20170111123714.GK12388@arm.com>
 <20170111150239.724c8117e997fa31cfa4d602@arm.com>
Message-ID: <20170113133313.GG3253@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 03:02:39PM -0600, Kim Phillips wrote:
> On Wed, 11 Jan 2017 12:37:15 +0000
> Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Jan 10, 2017 at 04:04:19PM -0600, Kim Phillips wrote:
> > > Also, curiously, arm_spe_pmu doesn't appear in 'perf list' (even when
> > > SPE h/w is present).
> > 
> > Weird, it would be nice to understand why that is. The sysfs plumbing should
> > all be there, so I'd expect to see something. On my laptop, for example,
> > intel_pt appears as:
> > 
> >   intel_pt//                                         [Kernel PMU event]
> > 
> > and strace show perf doing the following:
> > 
> > stat("/sys/bus/event_source/devices/intel_pt/format", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> > open("/sys/bus/event_source/devices/intel_pt/format", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 82
> > open("/sys/bus/event_source/devices/intel_pt/format/psb_period", O_RDONLY) = 83
> > open("/sys/bus/event_source/devices/intel_pt/format/noretcomp", O_RDONLY) = 83
> > open("/sys/bus/event_source/devices/intel_pt/format/tsc", O_RDONLY) = 83
> > open("/sys/bus/event_source/devices/intel_pt/format/cyc_thresh", O_RDONLY) = 83
> > open("/sys/bus/event_source/devices/intel_pt/format/mtc_period", O_RDONLY) = 83
> > open("/sys/bus/event_source/devices/intel_pt/format/cyc", O_RDONLY) = 83
> > open("/sys/bus/event_source/devices/intel_pt/format/mtc", O_RDONLY) = 83
> > stat("/sys/bus/event_source/devices/intel_pt/events", 0x7ffe54eebb40) = -1 ENOENT (No such file or directory)
> > stat("/sys/bus/event_source/devices/intel_pt/type", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> > open("/sys/bus/event_source/devices/intel_pt/type", O_RDONLY) = 82
> > stat("/sys/bus/event_source/devices/intel_pt/cpumask", 0x7ffe54eedd60) = -1 ENOENT (No such file or directory)
> > stat("/sys/bus/event_source/devices/intel_pt/cpus", 0x7ffe54eedd60) = -1 ENOENT (No such file or directory)
> > stat("/sys/bus/event_source/devices/intel_pt/caps/mtc", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> > open("/sys/bus/event_source/devices/intel_pt/caps/mtc", O_RDONLY) = 82
> > stat("/sys/bus/event_source/devices/intel_pt/caps/psb_cyc", {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> > open("/sys/bus/event_source/devices/intel_pt/caps/psb_cyc", O_RDONLY) = 82
> > 
> > What do you see for SPE?
> 
> 2154  newfstatat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format", {st_mode=S_IFDIR|0755, st_size=0, ...}, 0) = 0
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 58
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/branch_filter", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/ts_enable", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/pa_enable", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/event_filter", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/load_filter", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/jitter", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/store_filter", O_RDONLY) = 59
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/format/min_latency", O_RDONLY) = 59
> 2154  newfstatat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/events", 0xffffcd6bb078, 0) = -1 ENOENT (No such file or directory)
> 2154  newfstatat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/type", {st_mode=S_IFREG|0444, st_size=4096, ...}, 0) = 0
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/type", O_RDONLY) = 58
> 2154  newfstatat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/cpumask", {st_mode=S_IFREG|0444, st_size=4096, ...}, 0) = 0
> 2154  openat(AT_FDCWD, "/sys/bus/event_source/devices/arm_spe_pmu_0/cpumask", O_RDONLY) = 58
> 
> they're identical up until /.../cpumask's stat, which exists on the
> ARM SPE run (as opposed to the Intel run).

>From a quick look at the perf tool code, it looks like you need to ensure
that pmu->selectable is set to true for SPE, since it doesn't advertise
any events (the intel pt and coresight code does this already).

Will
