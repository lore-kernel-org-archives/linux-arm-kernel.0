From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Fri, 11 Dec 2015 14:58:57 -0700
Subject: [PATCH V6 20/26] perf: changing pmu::setup_aux() parameter to
 include event
In-Reply-To: <87egetcbvs.fsf@ashishki-desk.ger.corp.intel.com>
References: <1449176702-13213-1-git-send-email-mathieu.poirier@linaro.org>
 <1449176702-13213-21-git-send-email-mathieu.poirier@linaro.org>
 <87egetcbvs.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <CANLsYkwv2OUruopusgyFbSnRCfNMpZMV=KdkKzVOkfpVjrUgsw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 December 2015 at 07:12, Alexander Shishkin
<alexander.shishkin@linux.intel.com> wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
>
>> For Coresight ETMv3/4 tracers the event carries information
>> about trace modes such as user or kernel space tracing and
>> whether tracing is allowed when operating in secure mode.
>
> Ok, so it looks to me that what you're doing in your setup_aux with the
> event, you should rather be doing in pmu::event_init(), which takes
> event as a parameter and it even makes more sense semantically, because
> that bit is really configuring the parameters of tracing and not
> capturing, which setup_aux() is more about. And the above paragraph also
> sounds very much like it. Since in Coresight there is a very clear
> distinction between trace generation (sources) and capturing (sinks) it
> should also be possible to structure the code in such a way that the
> former are not as closely tied to the latter. Please correct me if I'm
> missing something.

Conceptually there is no need to do the configuration for source, path
and sink in setup_aux() but all this information has to be kept
somewhere...  Since setup_aux() is where the private data structure
that will be used for the rest of the trace session gets created I
didn't see another way.

But with your patchset on trace filtering [1] I'm pretty sure we don't
need to do tracer configuration for all the tracers at the beginning.
I have to double check a few things but it is very likely that CS
tracer configuration can be made the same way PT is done, something
that will seriously simplify the setup process.

That leaves us with the path from source to sink - it is event
specific and as such needs to be part of the private data structure.
Unless you see a better way to proceed it will stay in setup_aux...

Thanks for the review,
Mathieu

[1]. https://lkml.org/lkml/2015/12/11/449

>
> Regards,
> --
> Alex
