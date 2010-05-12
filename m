From: dengcheng.zhu@gmail.com (Deng-Cheng Zhu)
Date: Wed, 12 May 2010 12:35:36 +0800
Subject: [PATCH 4/6] ARM: oprofile: use perf-events framework as backend
References: 1271695361-7121-5-git-send-email-will.deacon@arm.com
Message-ID: <4BEA3018.8060600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Will


This is a great idea.

Here's one comment on irq handling (Maybe you or somebody else has already
addressed in other threads - I'm new to this list):

In original Oprofile code, the irq handler mainly does 3 things - clearing
the flag, resetting the counter, and calling oprofile_add_sample(). By
using perf events as the backend of Oprofile, they are now scattered into
a relatively long code path in armpmu->handle_irq(). Could this be
something improvable?

In addition, the counterpart of resetting the counter in perf events is
the armpmu->write_counter() in armpmu_event_set_period(). How could you
make sure the value written into the counter is the same between the
original Oprofile and the "new" Oprofile?


Deng-Cheng


On 2010-04-19 16:42, Will Deacon wrote:
 > There are currently two hardware performance monitoring subsystems in the
 > kernel for ARM: OProfile and perf-events. This creates the following 
problems:
 >
 > 1.) Duplicate PMU accessor code. Inevitable code drift may lead to 
bugs in one
 > framework that are fixed in the other.
 >
 > 2.) Locking issues. OProfile doesn't reprogram hardware counters between
 > profiling runs if the events to be monitored have not been changed. 
This means
 > that other profiling frameworks cannot use the counters if OProfile 
is in use.
 >
 > 3.) Due to differences in the two frameworks, it may not be possible to
 > compare the results obtained by OProfile with those obtained by perf.
 >
 > This patch removes the OProfile PMU driver code and replaces it with 
calls
 > to perf, therefore solving the issues mentioned above.
 >

 > +/*
 > + * Overflow callback for oprofile.
 > + */
 > +static void op_overflow_handler(struct perf_event *event, int unused,
 > + struct perf_sample_data *data, struct pt_regs *regs)
 > +{
 > + int id;
 > + u32 cpu = smp_processor_id();
 > +
 > + for (id = 0; id < perf_num_counters; ++id)
 > + if (perf_events[cpu][id] == event)
 > + break;
 > +
 > + if (id != perf_num_counters)
 > + oprofile_add_sample(regs, id);
 > + else
 > + pr_warning("oprofile: ignoring spurious overflow "
 > + "on cpu %u\n", cpu);
 > +}
