From: zhizhouzhang@asrmicro.com (=?utf-8?B?WmhhbmcgWmhpemhvdSjlvKDmsrvmtLIp?=)
Date: Mon, 12 Nov 2018 07:38:07 +0000
Subject: [PATCH] arm64: disable KASAN for save_trace()
In-Reply-To: <20181111172333.ov25gdmlsmhc6ysp@salmiak>
References: <1541938036-29498-1-git-send-email-zhizhouzhang@asrmicro.com>
 <20181111172333.ov25gdmlsmhc6ysp@salmiak>
Message-ID: <28fb310518294fbebf82ce22e4620cd3@mail2012.asrmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Mark Rutland [mailto:mark.rutland at arm.com]
> Sent: Monday, November 12, 2018 1:24 AM
> To: Zhang Zhizhou(???) <zhizhouzhang@asrmicro.com>
> Cc: catalin.marinas at arm.com; will.deacon at arm.com;
> mpatocka at redhat.com; alex.popov at linux.com; labbott at redhat.com;
> panand at redhat.com; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; zhizhouzh at gmail.com
> Subject: Re: [PATCH] arm64: disable KASAN for save_trace()
> 
> On Sun, Nov 11, 2018 at 08:07:16PM +0800, Zhizhou Zhang wrote:
> > save_trace() which is called from walk_stackframe() always try to
> > read/write caller's stack. This results KASAN stack-out-of-bounds
> > warning. So mute it.
> 
> The save_trace() function should never perform an out-of-bounds access on
> the caller's stack, so this is papering over a bug elsewhere.
> 
> Can you please given an example report from KASAN?
> 
I'm sorry, I don't have a device with the newest kernel on hand. So my test is based on 4.4.145. The stack is shown below:

c4 0 (swapper/4) ==================================================================
c4 0 (swapper/4) BUG: KASAN: stack-out-of-bounds in save_trace+0x98/0x130
c4 0 (swapper/4) Write of size 8 at addr ffffffc09b04fbe0 by task swapper/4/0
c4 0 (swapper/4) 
c4 0 (swapper/4) CPU: 4 PID: 0 Comm: swapper/4 Not tainted 4.4.145+ #2
c4 0 (swapper/4) Hardware name: ASR AQUILAC EVB (DT)
c4 0 (swapper/4) Call trace:
c4 0 (swapper/4) [<ffffff9008091a50>] dump_backtrace+0x0/0x418
c4 0 (swapper/4) [<ffffff9008091e90>] show_stack+0x28/0x38
c4 0 (swapper/4) [<ffffff90086252a4>] dump_stack+0xe8/0x13c
c4 0 (swapper/4) [<ffffff900831c164>] print_address_description+0x8c/0x2b0
c4 0 (swapper/4) [<ffffff900831c690>] kasan_report+0x210/0x330
c4 0 (swapper/4) [<ffffff900831ac44>] __asan_store8+0x84/0x98
c4 0 (swapper/4) [<ffffff9008090cd0>] save_trace+0x98/0x130
c4 0 (swapper/4) [<ffffff9008091174>] walk_stackframe+0x4c/0x68
c4 0 (swapper/4) [<ffffff90080912cc>] save_stack_trace_tsk+0x13c/0x1f8
c4 0 (swapper/4) [<ffffff90080913b0>] save_stack_trace+0x28/0x38
c4 0 (swapper/4) [<ffffff900831b978>] kasan_slab_free+0x88/0x1a0
c4 0 (swapper/4) [<ffffff9008317bfc>] kmem_cache_free+0xac/0x3f8
c4 0 (swapper/4) [<ffffff90080b76f0>] __put_task_struct+0xa8/0x1f0
c4 0 (swapper/4) [<ffffff90081116c4>] finish_task_switch+0x21c/0x2a0
c4 0 (swapper/4) [<ffffff90092dc50c>] __schedule+0x4cc/0xe80
c4 0 (swapper/4) [<ffffff90092dd198>] schedule+0x70/0x110
c4 0 (swapper/4) [<ffffff90092dd554>] schedule_preempt_disabled+0x24/0x70
c4 0 (swapper/4) [<ffffff9008151dc0>] cpu_startup_entry+0x198/0x538
c4 0 (swapper/4) [<ffffff9008099f38>] secondary_start_kernel+0x258/0x2f0
c4 0 (swapper/4) [<00000001032e603c>] 0x1032e603c
c4 0 (swapper/4) 
c4 0 (swapper/4) The buggy address belongs to the page:
c4 0 (swapper/4) page:ffffffbdc26c13c0 count:0 mapcount:0 mapping:          (null)5.091297] c4 0 (swapper/4) 
c4 0 (swapper/4) Memory state around the buggy address:
c4 0 (swapper/4)  ffffffc09b04fa80: 00 00 f2 f2 f2 f2 f2 f2 00 00 00 00 f3 f3 f3 f3
c4 0 (swapper/4)  ffffffc09b04fb00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c4 0 (swapper/4) >ffffffc09b04fb80: 00 00 00 00 00 00 00 00 00 00 00
      swapper/4)  ffffffc09b04fc00: 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00 00 00
c4 0 (swapper/4)  ffffffc09b04fc80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c4 0 (swapper/4) ==================================================================

Maybe this issue has been fixed in the latest kernel, I have no idea about that. Though some function has been changed, but I found the calling flow doesn't change a lot in the latest kernel. Could you help me to figure out what's wrong with it?

Thanks,
zhizhou

> Thanks,
> Mark.
> 
> >
> > Signed-off-by: Zhizhou Zhang <zhizhouzhang@asrmicro.com>
> > ---
> >  arch/arm64/kernel/stacktrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/stacktrace.c
> > b/arch/arm64/kernel/stacktrace.c index 4989f7e..e93ca67 100644
> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -107,7 +107,7 @@ struct stack_trace_data {
> >  	unsigned int skip;
> >  };
> >
> > -static int save_trace(struct stackframe *frame, void *d)
> > +static int __no_sanitize_address save_trace(struct stackframe *frame,
> > +void *d)
> >  {
> >  	struct stack_trace_data *data = d;
> >  	struct stack_trace *trace = data->trace;
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
