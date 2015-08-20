From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Aug 2015 11:51:27 +0100
Subject: [PATCH] arm64: entry: always restore x0 from the stack on
 syscall return
In-Reply-To: <55D592E4.50609@linaro.org>
References: <1439996989-5772-1-git-send-email-will.deacon@arm.com>
 <20150819160320.GI24062@e104818-lin.cambridge.arm.com>
 <20150819162359.GA10297@arm.com>
 <20150819163504.GL24062@e104818-lin.cambridge.arm.com>
 <20150819165643.GD10297@arm.com> <55D592E4.50609@linaro.org>
Message-ID: <20150820105127.GE19328@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 09:42:12AM +0100, Hanjun Guo wrote:
> On 08/20/2015 12:56 AM, Will Deacon wrote:
> > On Wed, Aug 19, 2015 at 05:35:05PM +0100, Catalin Marinas wrote:
> >> On Wed, Aug 19, 2015 at 05:23:59PM +0100, Will Deacon wrote:
> >>> On Wed, Aug 19, 2015 at 05:03:20PM +0100, Catalin Marinas wrote:
> >>>> There is another str x0 in __sys_trace_return which I think we could
> >>>> remove.
> >>>
> >>> Hmm, I don't think we can remove that. It's needed on the slowpath to
> >>> update the pt_regs with either -ENOSYS (for __ni_sys_trace) or the
> >>> syscall return value from the blr in __sys_trace.
> >>>
> >>> What we can do instead is change the branch above to branch to
> >>> __sys_trace_return_skipped. Patch below.
> >>>
> >>> Will
> >>>
> >>> --->8
> >>>
> >>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> >>> index 2a5e64ccc991..088322ff1ba0 100644
> >>> --- a/arch/arm64/kernel/entry.S
> >>> +++ b/arch/arm64/kernel/entry.S
> >>> @@ -619,7 +619,7 @@ ret_fast_syscall:
> >>>          kernel_exit 0
> >>>   ret_fast_syscall_trace:
> >>>          enable_irq                              // enable interrupts
> >>> -       b       __sys_trace_return
> >>> +       b       __sys_trace_return_skipped      // we already saved x0
> >>
> >> That would do. With this added:
> >>
> >> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >>
> >> (or I can take it for 4.2 but I'd like more testing like LTP)
> >
> > Yeah, I'll run some tests overnight and see how it holds up.
> 
> How is the stress test going on? I didn't do some stress test but
> when I applied this patch (along with above additions), the problem
> I reported is gone,
> 
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks, Hanjun. LTP passed successfully, so I think the patch is ok but
there's no need to rush it in for 4.2.

Will
