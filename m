From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 3 Jul 2018 16:00:39 -0600
Subject: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
 <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com>
 <20180703105652.psjq5cq4t7o2j6zk@um.fi.intel.com>
Message-ID: <CANLsYkw4w-zRczcb2uddO4UsxXrCCoXCSkPko2it-OJX2H0ecA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jul 2018 at 04:57, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
>
> On Tue, Jul 03, 2018 at 01:03:48PM +0300, Alexander Shishkin wrote:
> > On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
> > > +/*
> > > + * PMU driver configuration works the same way as filter management above,
> > > + * but without the need to deal with memory mapping.  Driver configuration
> > > + * arrives through the SET_DRV_CONFIG ioctl() where it is validated and applied
> > > + * to the event.  When the PMU is ready it calls perf_event_drv_config_sync() to
> > > + * bring the configuration information within reach of the PMU.
> >
> > Wait a second. The reason why we dance around with the generations of filters
> > is the locking order of ctx::mutex vs mmap_sem. In an mmap path, where we're
> > notified about mapping changes, we're called under the latter, and we'd need
> > to grab the former to update the event configuration. In your case, the
> > update comes in via perf_ioctl(), where we're already holding the ctx::mutex,
> > so you can just kick the PMU right there, via an event_function_call() or
> > perf_event_stop(restart=1). In the latter case, your pmu::start() would just
> > grab the new configuration. Should also be about 90% less code. :)
>
> Also, since it affects the AUX buffer configuration, it is probably a one
> time ioctl command that you issue before you mmap the buffer. If that's
> the case, you don't even have to worry about stopping the event, as it
> shouldn't be running, because without the buffer perf_aux_output_begin()
> should fail and so should the pmu::add() iirc.
>

The idea behind the current approach was to make the SET_DRV_CONFIG
ioctl() usable by other drivers where multiple ioctl() calls could be
performed while a session in ongoing.  I also opted to introduce a
_sync() function to let the PMU refresh its configuration at the time
of its own choosing rather than having to interrupt the session.

But all I need for coresight is to have available the sink information
and PMU configuration (in an upcoming patchset) by the time
setup_aux() is called.  You are correct, this is a one time
configuration and since the event isn't running there is no need for
locking - I should be able to access the PMU when the ioctl is called.

If you are fine with this bare-bone scenario and don't care much about
usability in different situation, I'll do a respin with minimal
functionality that cover my needs.

Thanks for the review,
Mathieu

> Regards,
> --
> Alex
