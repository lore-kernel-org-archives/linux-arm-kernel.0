From: mark.rutland@arm.com (Mark Rutland)
Date: Sat, 10 Mar 2018 15:45:36 +0000
Subject: [PATCH v11 8/8] perf: ARM DynamIQ Shared Unit PMU support
In-Reply-To: <5AA30F5C.2010402@codeaurora.org>
References: <20180102112533.13640-1-suzuki.poulose@arm.com>
 <20180102112533.13640-9-suzuki.poulose@arm.com>
 <5AA1CE48.5030203@codeaurora.org>
 <a466d82b-2a0f-ffba-f9f7-c76c6c787bb5@arm.com>
 <20180309133531.fepm2suvdmvm4muv@lakrids.cambridge.arm.com>
 <5AA30F5C.2010402@codeaurora.org>
Message-ID: <20180310154527.f6j2fgqimbtn4eme@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 09, 2018 at 02:49:00PM -0800, Saravana Kannan wrote:
> > > > Looking at the code, I didn't see any specific handling of cluster
> > > > power collapse. AFAIK, the HW counters do not retain config (what event
> > > > they are counting) or value (the current count) across power collapse.
> > > > Wouldn't you need to register for some kind of PM_ENTER/EXIT notifiers
> > > > to handle that?
> > > 
> > > Good point, yes *somebody* needs to save-restore the registers. But who ? As far
> > > as the kernel is concerned, it doesn't control the DSU states. Also, as of now
> > > there is no reliable way to get the "ENTER/EXIT" notifications for the DSU power
> > > domain state changes. All we do is use the PMU, assuming it is available. AFAIT,
> > > it should really be done at EL3, which manages the DSU, but may be I am wrong.
> > 
> > Given this can happen behind the back of the kernel, if FW doesn't
> > save/restore this state, we'll have to inhibit cpuidle on a CPU
> > associated with the DSU PMU whenever it has active events, which would
> > keep the cluster online.
> 
> Using PMUs should be designed to have the least impact on power/performance.
> Otherwise, using them to profile and debug issues becomes impossible.
> Disabling cpuidle would significantly affect power and performance.
> 
> Why not use CPU_CLUSTER_PM_ENTER similar to how arm-pmu.c uses CPU_PM_ENTER
> for saving and restoring the counters?

The CPU_CLUSTER_PM_{ENTER,EXIT} notifications only exist on particular 32-bit
platforms where the kernel directly manages CPU power states. These do not
exist on systems where FW manages the cluster power state (e.g. on any arm64
platform with PSCI). So we cannot rely on CPU_CLUSTER_PM_{ENTER,EXIT} in the
DSU PMU driver.

The arm-pmu code manages state which is strictly CPU affine, so we can rely on
the CPU_PM_{ENTER,EXIT} notifications there.

We cannot rely on CPU_PM_{ENTER,EXIT} notifications to manage per-cluster
state, as CPUs can race to enter/exit idle, and we cannot track the cluster
state accurately in the kernel without serializing idle entry/exit across CPUs,
which will affect power/performance.

Thanks,
Mark.
