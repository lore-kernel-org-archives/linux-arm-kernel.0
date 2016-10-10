From: mathieu.desnoyers@efficios.com (Mathieu Desnoyers)
Date: Mon, 10 Oct 2016 16:15:36 +0000 (UTC)
Subject: Restartable Sequences benchmarks (was: Re: [PATCH v2] arm: Added
 support for getcpu() vDSO using TPIDRURW)
In-Reply-To: <20161010152948.GD14561@arm.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
 <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
 <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
 <20161005195359.GR1041@n2100.armlinux.org.uk>
 <CAKdL+dSt+cBCpwW5q+VCQh+7XeKrnyJgfTsEsuo2nKoUr9ytxw@mail.gmail.com>
 <20161010152948.GD14561@arm.com>
Message-ID: <1629697684.51986.1476116136779.JavaMail.zimbra@efficios.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

----- On Oct 10, 2016, at 5:29 PM, Will Deacon will.deacon at arm.com wrote:

> Hi Fredrik,
> 
> [adding Mathieu -- background is getcpu() in userspace for arm]
> 
> On Thu, Oct 06, 2016 at 12:17:07AM +0200, Fredrik Markstr?m wrote:
>> On Wed, Oct 5, 2016 at 9:53 PM, Russell King - ARM Linux <linux@armlinux.org.uk
>> > wrote:
>> > On Wed, Oct 05, 2016 at 06:48:05PM +0100, Robin Murphy wrote:
>> >> On 05/10/16 17:39, Fredrik Markstr?m wrote:
>> >> > The approach I suggested below with the vDSO data page will obviously
>> >> > not work on smp, so suggestions are welcome.
>> >>
>> >> Well, given that it's user-writeable, is there any reason an application
>> >> which cares couldn't simply run some per-cpu threads to call getcpu()
>> >> once and cache the result in TPIDRURW themselves? That would appear to
>> >> both raise no compatibility issues and work with existing kernels.
>> >
>> > There is - the contents of TPIDRURW is thread specific, and it moves
>> > with the thread between CPU cores.  So, if a thread was running on CPU0
>> > when it cached the getcpu() value in TPIDRURW, and then migrated to CPU1,
>> > TPIDRURW would still contain 0.
>> >
>> > I'm also not in favour of changing the TPIDRURW usage to be a storage
>> > repository for the CPU number - it's far too specific a usage and seems
>> > like a waste of hardware resources to solve one problem.
>> 
>> Ok, but right now it's nothing but a (architecture specific) piece of TLS,
>> which we have generic mechanisms for. From my point of view that is a waste of
>> hardware resources.
>> 
>> > As Mark says, it's an ABI breaking change too, even if it is under a config
>> option.
>> 
>> I can't argue with that. If it's an ABI it's an ABI, even if I can't imagine
>> why anyone would use it over normal tls... but then again, people probably do.
>> 
>> So in conclusion I agree and give up.
> 
> Rather than give up, you could take a look at the patches from Mathieu
> Desnoyers, that tackle this in a very different way. It's also the reason
> we've been holding off implementing an optimised getcpu in the arm64 vdso,
> because it might all well be replaced by the new restartable sequences
> approach:
> 
>  http://lkml.kernel.org/r/1471637274-13583-1-git-send-email-mathieu.desnoyers at efficios.com
> 
> He's also got support for arch/arm/ in that series, so you could take
> them for a spin. The main thing missing at the moment is justification
> for the feature using real-world code, as requested by Linus:
> 
>  http://lkml.kernel.org/r/CA+55aFz+Q33m1+ju3ANaznBwYCcWo9D9WDr2=p0YLEF4gJF12g at mail.gmail.com
> 
> so if your per-cpu buffer use-case is compelling in its own right (as
> opposed to a micro-benchmark), then you could chime in over there.
> 
> Will

FYI, I've adapted lttng-ust ring buffer (as a POC) to rseq in a dev
branch. I see interesting speedups. See top 3-4 commits of
https://github.com/compudj/lttng-ust-dev/tree/rseq-integration
(start with "Use rseq for...").

On x86-64, we have a 7ns speedup over sched_getcpu on x86-64, and
30ns speedup by using rseq atomics on x86-64, which brings the cost
per event record down to about 100ns/event. This replaces 3 atomic
operations on the fast path. (37% speedup)

On arm32, the cpu_id acceleration gives a 327 ns/event speed increase,
which brings speed to 2000ns/event. Note that reading time on that
system does not use the vDSO (old glibc), so it implies a system call.
This accounts for 857ns/events. I don't observe speed increase nor
slowdown by using rseq instead of ll/sc atomic operations on that
specific board (Cubietruck, only has 2 cores). I suspect that boards
with more core will benefit more of replacing ll/sc by rseq atomics.
If we don't account the overhead of reading time through system call,
we get a 22% speedup.

I have extra benchmarks in this branch:
https://github.com/compudj/rseq-test

Updated ref for current rseq-enabled kernel based on 4.8:
https://github.com/compudj/linux-percpu-dev/tree/rseq-fallback

(ARM64 port would be welcome!) :)

As Will pointed out, what I'm currently looking for is real-life
benchmarks that shows benefits of rseq. I fear that the microbenchmarks
I have for the lttng-ust tracer may be dismissed as being too specific.
Most heavy users of LTTng-UST are closed source applications, so it's
not easy for me to provide numbers in real-life scenarios.

The major use-case besides per-cpu buffering/tracing AFAIU is memory
allocators. It will mainly benefit in use-cases where there are more
threads than cores in a multithreaded application. This mainly makes
sense if threads are either dedicated to specific tasks, and therefore
are often idle, or in use-cases where worker threads are expected to
block (else, if threads are not expected to block, the application
should simply have one thread per core).

Dave Watson had interesting RSS shrinkage on this stress-test program:
http://locklessinc.com/downloads/t-test1.c modified to have 500 threads.
It uses jemalloc modified to use rseq.

I reproduced it on my laptop with 100 threads, 50000 loops:

4-core, 100 threads, 50000 loops.

malloc:
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
10136 compudj   20   0 2857840  24756   1348 R 379.4  0.4   3:49.50 t-test1
real    3m20.830s
user    3m22.164s
sys     9m40.936s

upstream jemalloc:
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
21234 compudj   20   0 2227124  49300   2280 S 306.2  0.7   2:26.97 t-test1
real    1m3.297s
user    3m19.616s
sys     0m8.500s

rseq jemalloc 4.2.1:
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
25652 compudj   20   0  877956  35624   3260 S 301.2  0.5   1:26.07 t-test1
real    0m27.639s
user    1m18.172s
sys     0m1.752s

The next step to translate this into a "real-life" number would be to
run rseq-jemalloc on a facebook node, but Dave has been in vacation for
the past few weeks. Perhaps someone else at Facebook or Google could
look into this ?

Cheers,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
