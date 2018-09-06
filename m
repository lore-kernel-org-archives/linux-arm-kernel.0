From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Sep 2018 11:05:11 +0100
Subject: [PATCH] arm64: don't account for cpu offline time with irqsoff
 tracer
In-Reply-To: <CAN1e=SF8ij0080wd55_v1Eu+Qo+2iGpWgWf4ELnTZa+zUBhjkw@mail.gmail.com>
References: <1536135583-6607-1-git-send-email-zhizhouzhang@asrmicro.com>
 <20180905122905.GI20186@arm.com>
 <CAN1e=SF8ij0080wd55_v1Eu+Qo+2iGpWgWf4ELnTZa+zUBhjkw@mail.gmail.com>
Message-ID: <20180906100510.GC3592@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 09:14:17PM +0800, Zhizhou Zhang wrote:
> 
> 
> On Wed, Sep 5, 2018 at 8:29 PM Will Deacon <will.deacon@arm.com> wrote:
> 
>     On Wed, Sep 05, 2018 at 04:19:43PM +0800, Zhizhou Zhang wrote:
>     > This is no need to account for cpu offline time with irqsoff tracer.
>     > We can trigger a large irqsoff latency with below commands:
>     >
>     > $ echo irqsoff > /sys/kernel/debug/tracing/current_tracer
>     > $ echo 0 > /sys/kernel/debug/tracing/options/function-trace
>     > $ echo 1 > /sys/kernel/debug/tracing/tracing_on
>     > $ echo 0 > /sys/devices/system/cpu/cpu1/online
>     > $ # wait a while ...
>     > $ echo 1 > /sys/devices/system/cpu/cpu1/online
>     > $ cat /sys/kernel/debug/tracing/trace
>     >
>     > Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
>     > ---
>     >  arch/arm64/kernel/smp.c | 1 +
>     >  1 file changed, 1 insertion(+)
>     >
>     > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>     > index 25fcd22..faed8f6 100644
>     > --- a/arch/arm64/kernel/smp.c
>     > +++ b/arch/arm64/kernel/smp.c
>     > @@ -346,6 +346,7 @@ void cpu_die(void)
>     >       idle_task_exit();
>     > 
>     >       local_daif_mask();
>     > +     stop_critical_timings();
>     > 
>     >       /* Tell __cpu_die() that this CPU is now safe to dispose of */
>     >       (void)cpu_report_death();
>     > --
>     > 1.9.1
> 
>     Hmm, so there are only a handful of other callers of stop_critical_timings
>     ()
>     which suggests that we probably shouldn't be calling this from deep in the
>     arch code. Do other architectures have the same problem? If not, how do
>     they
>     avoid it?
> 
> 
> I read mips just now, it use raw irq turn-off primitive without calling
> trace_hardirqs_off().
> So mips can get rid of this problem. Maybe same other architectures have the
> same
> problem. As I can see, X86 may also be influenced, but I didn't test that. For
> this patch, the reason
> I put this in architecture specific folder is irq turn-off code is placed here.
> I think stop_critical_timings()
> should be placed nearby local_daif_mask().

I'm not so sure. local_daif_mask() just toggles a bit in a register, whereas
stop_critical_timings() does a lot more, including locking. Calling this
from a CPU which is no longer online feels fragile to me.

Anyway, my strong preference here is that either we address this in the
core code, or we follow the example of other architectures.

Will
