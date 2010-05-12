From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 May 2010 10:32:32 +0100
Subject: [PATCH 4/6] ARM: oprofile: use perf-events framework as backend
In-Reply-To: <4BEA3018.8060600@gmail.com>
References: 1271695361-7121-5-git-send-email-will.deacon@arm.com
	<4BEA3018.8060600@gmail.com>
Message-ID: <1273656752.3347.16.camel@e200755-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-05-12 at 05:35 +0100, Deng-Cheng Zhu wrote:
> Hi, Will
> 
Hi Deng-Cheng,
> 
> This is a great idea.
> 
I'm pleased to hear that :)

> Here's one comment on irq handling (Maybe you or somebody else has already
> addressed in other threads - I'm new to this list):
> 
This code is pretty new, so comments and concerns are more than welcome.

> In original Oprofile code, the irq handler mainly does 3 things - clearing
> the flag, resetting the counter, and calling oprofile_add_sample(). By
> using perf events as the backend of Oprofile, they are now scattered into
> a relatively long code path in armpmu->handle_irq(). Could this be
> something improvable?
> 
The IRQ handling path is indeed longer, but this shouldn't affect the
profiling data you obtain provided that you aren't sampling with an
unrealistic period [and essentially profiling the profiling framework].

The PMU interrupt handler for ARM runs with interrupts disabled and
passes the IRQ registers to the overflow handler, so although the
execution path is longer than before, you're still dealing with the same
data.

I guess the benefit of reducing this code path is that you minimise the
overhead of profiling, but unless you're seeing big problems with the
new framework, I don't think this is an issue.

> In addition, the counterpart of resetting the counter in perf events is
> the armpmu->write_counter() in armpmu_event_set_period(). How could you
> make sure the value written into the counter is the same between the
> original Oprofile and the "new" Oprofile?
> 
For Oprofile, we only deal with the sample_period attribute field and
leave the frequency stuff alone. This means that the only time that a
different value is written to the hardware is when we are compensating
for changes to the counter that have occurred during the handling path
[or more importantly, during a section of code running with interrupts
disabled]. I don't believe OProfile on ARM used to do this, but it
really should have.

One thing that might be worth communicating to OProfile is if an event
is throttled by perf. In this case, the sample period would need
adjusting by userspace. Currently I don't think we can detect if this
happens.

I hope that helps,

Will
