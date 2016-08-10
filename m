From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 10 Aug 2016 17:07:13 -0600
Subject: [PATCH V3 1/6] perf/core: Adding PMU driver specific configuration
In-Reply-To: <20160805155344.GV6879@twins.programming.kicks-ass.net>
References: <1469742143-22245-1-git-send-email-mathieu.poirier@linaro.org>
 <1469742143-22245-2-git-send-email-mathieu.poirier@linaro.org>
 <20160804165821.GT6862@twins.programming.kicks-ass.net>
 <CANLsYkzK+mNRYiGn0SLQ5kA0+xxi6OGVbNL4F3LLRBTgSkssxQ@mail.gmail.com>
 <20160805155344.GV6879@twins.programming.kicks-ass.net>
Message-ID: <CANLsYkwz1aCmsBbtZXQK3_B-T6cVBP1UYV9cqbKiNSmdrhUuFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 August 2016 at 09:53, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Aug 05, 2016 at 09:35:05AM -0600, Mathieu Poirier wrote:
>> On 4 August 2016 at 10:58, Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Thu, Jul 28, 2016 at 03:42:18PM -0600, Mathieu Poirier wrote:
>> >> This patch somewhat mimics the work done on address filters to
>> >> add the infrastructure needed to pass PMU specific HW
>> >> configuration to the driver before a session starts.
>> >>
>> >> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>> >
>> >> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
>> >> index c66a485a24ac..90fbc5fd3925 100644
>> >> --- a/include/uapi/linux/perf_event.h
>> >> +++ b/include/uapi/linux/perf_event.h
>> >> @@ -407,6 +407,7 @@ struct perf_event_attr {
>> >>  #define PERF_EVENT_IOC_ID            _IOR('$', 7, __u64 *)
>> >>  #define PERF_EVENT_IOC_SET_BPF               _IOW('$', 8, __u32)
>> >>  #define PERF_EVENT_IOC_PAUSE_OUTPUT  _IOW('$', 9, __u32)
>> >> +#define PERF_EVENT_IOC_SET_DRV_CONFIGS       _IOW('$', 10, char *)
>> >
>> > Please also do a manpages patch.
>>
>> Patch 3/6 in this set documents the new option
>> (tools/perf/Documentation/perf-record.tx).  Is this what you were
>> looking for?  If not please expand on the information you want to see
>> added add and where.
>
> Since you add an IOCTL (with preferably more structure than present in
> this patch, see the other email) this needs to be documented in the
> syscall manpage.
>
>   http://git.kernel.org/cgit/docs/man-pages/man-pages.git/tree/man2/perf_event_open.2
>
>   http://www.man7.org/linux/man-pages/man2/perf_event_open.2.html

After a little bit of digging around I understand that manpages have
to be written _after_ the new ioctl call has been added - at least
that's what I deduce when looking at what Vince Weaver did for the BPF
support:

commit b0f7b411bed0505937f0f51d6499d0c6c56f4b8c
Author: Vince Weaver <vincent.weaver@maine.edu>
Date:   Thu Jul 23 13:10:21 2015 -0400

    perf_event_open.2: 4.1 PERF_EVENT_IOC_SET_BPF support

    This manpage patch relates to the addition of the
    PERF_EVENT_IOC_SET_BPF ioctl in the following commit:

        commit 2541517c32be2531e0da59dfd7efc1ce844644f5
        Author: Alexei Starovoitov <ast@plumgrid.com>

        tracing, perf: Implement BPF programs attached to kprobes

        Signed-off-by: Alexei Starovoitov <ast@plumgrid.com>
        Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
        Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
        Cc: Andrew Morton <akpm@linux-foundation.org>
        Cc: Arnaldo Carvalho de Melo <acme@infradead.org>
        Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
        Cc: Daniel Borkmann <daniel@iogearbox.net>
        Cc: David S. Miller <davem@davemloft.net>
        Cc: Jiri Olsa <jolsa@redhat.com>
        Cc: Linus Torvalds <torvalds@linux-foundation.org>
        Cc: Namhyung Kim <namhyung@kernel.org>
        Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
        Cc: Peter Zijlstra <peterz@infradead.org>
        Link: http://lkml.kernel.org/r/1427312966-8434-4-git-send-email-ast at plumgrid.com
        Signed-off-by: Ingo Molnar <mingo@kernel.org>

    Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
    Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>

Am I correct here or you want to proceed differently?

Thanks for the guidance,
Mathieu
