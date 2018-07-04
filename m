From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Wed, 04 Jul 2018 13:51:22 +0300
Subject: [PATCH 5/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <CANLsYkxpLyqN76KQ3VyLq8H27hLsHxLy+zZA1xRyUXGXwx42AA@mail.gmail.com>
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-6-git-send-email-mathieu.poirier@linaro.org>
 <20180703100348.fy43f4fosw3fdc6i@um.fi.intel.com>
 <CANLsYkxpLyqN76KQ3VyLq8H27hLsHxLy+zZA1xRyUXGXwx42AA@mail.gmail.com>
Message-ID: <87bmbn6zpx.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> Hi Alex,

Hi Mathieu,

> On Tue, 3 Jul 2018 at 04:03, Alexander Shishkin
> <alexander.shishkin@linux.intel.com> wrote:
>>
>> On Mon, Jul 02, 2018 at 04:33:29PM -0600, Mathieu Poirier wrote:
>> > This patch follows what has been done for filters by adding an ioctl()
>> > option to communicate to the kernel arbitrary PMU specific configuration
>> > that don't fit in the conventional struct perf_event_attr to the kernel.
>>
>> Ok, so what *is* the PMU specific configuration that doesn't fit in the
>> attribute and needs to be re-configured by the driver using the generation
>> tracking?
>>
>
> In this patchset I'm am after the specification of sink information
> for each event, i.e what sink a CPU is supposed to use for the
> session.  I simply don't see putting something that PMU specific in
> the generic perf_event_attr structure.  I also intend to use the same
> ioctl mechanism to communicate complex tracer configuration for
> sequencers, counters and input events.  I don't see a nice way of
> doing that from the perf_event_attr, and that is even without thinking
> about the different flavours of tracers out there, all with their own
> features.

Yes, the sequencers and counters seem tricky. Here's a wild idea: can
the sequencer/counter configuration be expressed as an eBPF program? Or,
can an eBPF program be used to program those?

> I've looked around and the only clean way I found to support this is
> via an ioctl().  That way each tracer can easily identify the sink it
> should be using without smearing the perf_event_attr structure.  I
> would be happy to explore a different avenue should you think of
> something.

Yes, I also have something similar on my todo list and I was previously
thinking along the lines of pipe()/splice(). As in, you take the AUX
event file descriptor and feed it to the sink, at which point the trace
path is configured. I need to dig up the notes that I made back in the
day to continue this conversation in more concrete terms.

Regards,
--
Alex
