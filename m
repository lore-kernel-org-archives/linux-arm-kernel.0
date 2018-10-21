From: joel@joelfernandes.org (Joel Fernandes)
Date: Sat, 20 Oct 2018 22:09:06 -0700
Subject: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
In-Reply-To: <15ec736d-bd54-5519-4b99-47dd161bc556@codeaurora.org>
Message-ID: <20181021050906.GA238354@joelaf.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 09:16:59AM +0530, Sai Prakash Ranjan wrote:
> On 10/20/2018 9:57 PM, Joel Fernandes wrote:
> > On Sat, Oct 20, 2018 at 12:02:37PM +0530, Sai Prakash Ranjan wrote:
> > > On 10/20/2018 10:55 AM, Joel Fernandes wrote:
> > > > On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
> > > > > Hi,
> > > > > 
> > > > > This patch series adds Event tracing support to pstore and is continuation
> > > > > to the RFC patch introduced to add a new tracing facility for register
> > > > > accesses called Register Trace Buffer(RTB). Since we decided to not introduce
> > > > > a separate framework to trace register accesses and use existing framework
> > > > > like tracepoints, I have moved from RFC. Details of the RFC in link below:
> > > > > 
> > > > > Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan at codeaurora.org/
> > > > > 
> > > > > MSR tracing example given by Steven was helpful in using tracepoints for
> > > > > register accesses instead of using separate trace. But just having these
> > > > > IO traces would not help much unless we could have them in some persistent
> > > > > ram buffer for debugging unclocked access or some kind of bus hang or an
> > > > > unexpected reset caused by some buggy driver which happens a lot during
> > > > > initial development stages. By analyzing the last few entries of this buffer,
> > > > > we could identify the register access which is causing the issue.
> > > > 
> > > > Hi Sai,
> > > > 
> > > > I wanted to see if I could make some time to get your patches working. We are
> > > > hitting usecases that need something like this as well. Basically devices
> > > > hanging and then the ramdump does not tell us much, so in this case pstore
> > > > events can be really helpful. This usecase came up last year as well.
> > > > 
> > > > Anyway while I was going through your patches, I cleaned up some pstore code
> > > > as well and I have 3 more patches on top of yours for this clean up. I prefer
> > > > we submit the patches together and sync our work together so that there is
> > > > least conflict.
> > > > 
> > > > Here's my latest tree:
> > > > https://github.com/joelagnel/linux-kernel/commits/pstore-events
> > > > (note that I have only build tested the patches since I just wrote them and
> > > > its quite late in the night here ;-))
> > > > 
> > > 
> > > Hi Joel,
> > > 
> > > Thanks for looking into this. Sure, I will be happy to sync up with you on
> > 
> > Thanks. And added a fourth patch in the tree too.


While at it, I was thinking about the problem we are trying to solve in
another way. If ftrace itself can use pages from the persistent ram store,
instead of the kernel's buddy allocator, then the ftrace ring buffer itself
could persist across a system reboot.

The clear advantage of that for Sai's pstore events work is, not having to
duplicate a lot of the ring buffer code and stuff into pstore (for the pstore
events for example, I wanted time stamps as well and ftrace's ring buffer has
some nice time management code to deal with time deltas). We already have
other ring buffers maintained in other parts of the kernel for tracing right?
So I'm a bit averse to duplicating that into pstore as well for tracing. The
other advantage of persisting the ftrace ring buffer would also mean data
from other tracers such as function-graph tracer and irqsoff tracers would
also persist and then we can also probably get rid of ftrace-in-pstore stuff
which is kind of incomplete anyway since it does not have time stamps for
recorded functions.

Steven and Kees: what do you think, is persisting ftrace ring buffer across
reboots a worthwhile idea? Any thoughts on how feasible something like that
could be, code wise? Off the top, I think the ring buffer state that ftrace
needs other than the trace data itself will also have to be persisted.

thanks,

 - Joel
