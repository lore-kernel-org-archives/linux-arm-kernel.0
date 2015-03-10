From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Mar 2015 15:36:08 +0000
Subject: [PATCH 1/3] arm/pmu: Reject groups spanning multiple hardware PMUs
In-Reply-To: <20150310125351.GD2896@worktop.programming.kicks-ass.net>
References: <1425905192-10509-1-git-send-email-suzuki.poulose@arm.com>
 <1425905192-10509-2-git-send-email-suzuki.poulose@arm.com>
 <20150310112723.GY2896@worktop.programming.kicks-ass.net>
 <20150310120521.GD28168@leverpostej>
 <20150310125351.GD2896@worktop.programming.kicks-ass.net>
Message-ID: <20150310153608.GB31849@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 12:53:51PM +0000, Peter Zijlstra wrote:
> On Tue, Mar 10, 2015 at 12:05:21PM +0000, Mark Rutland wrote:
> > On Tue, Mar 10, 2015 at 11:27:23AM +0000, Peter Zijlstra wrote:
> > > On Mon, Mar 09, 2015 at 12:46:30PM +0000, Suzuki K. Poulose wrote:
> > > > From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
> > > > 
> > > > Don't allow grouping hardware events from different PMUs
> > > >  (eg. CCI + CPU).
> > > 
> > > Uhm, how does this work? If we have multiple hardware PMUs we'll stop
> > > scheduling events after the first failed event schedule. This can leave
> > > one of the PMUs severely under utilized.
> > 
> > The problem is here group validation at pmu::event_init() time, not
> > scheduling.
> 
> Maybe make that a little more explicit.

On the assumption that the patch is otherwise OK, how about the commit
message below?

---->8----
arm/pmu: Reject groups spanning multiple hardware PMUs

The perf core implicitly rejects events spanning multiple HW PMUs, as in
these cases the event->ctx will differ. However this validation is
performed after pmu::event_init() is called in perf_init_event(), and
thus pmu::event_init() may be called with a group leader from a
different HW PMU.

The ARM PMU driver does not take this fact into account, and when
validating groups assumes that it can call to_arm_pmu(event->pmu) for
any HW event. When the event in question is from another HW PMU this is
wrong, and results in dereferencing garbage.

This patch updates the ARM PMU driver to first test for and reject
events from other PMUs, moving the to_arm_pmu and related logic after
this test. Fixes a crash triggered by perf_fuzzer on Linux-4.0-rc2, with
a CCI PMU present:

CPU: 0 PID: 1527 Comm: perf_fuzzer Not tainted 4.0.0-rc2 #57
Hardware name: ARM-Versatile Express
task: bd8484c0 ti: be676000 task.ti: be676000
PC is at 0xbf1bbc90
LR is at validate_event+0x34/0x5c
pc : [<bf1bbc90>]    lr : [<80016060>]    psr: 00000013
...
[<80016060>] (validate_event) from [<80016198>] (validate_group+0x28/0x90)
[<80016198>] (validate_group) from [<80016398>] (armpmu_event_init+0x150/0x218)
[<80016398>] (armpmu_event_init) from [<800882e4>] (perf_try_init_event+0x30/0x48)
[<800882e4>] (perf_try_init_event) from [<8008f544>] (perf_init_event+0x5c/0xf4)
[<8008f544>] (perf_init_event) from [<8008f8a8>] (perf_event_alloc+0x2cc/0x35c)
[<8008f8a8>] (perf_event_alloc) from [<8009015c>] (SyS_perf_event_open+0x498/0xa70)
[<8009015c>] (SyS_perf_event_open) from [<8000e420>] (ret_fast_syscall+0x0/0x34)
Code: bf1be000 bf1bb380 802a2664 00000000 (00000002)
---[ end trace 01aff0ff00926a0a ]---
---->8----

Mark.
