From: will.deacon@arm.com (Will Deacon)
Date: Wed, 26 Aug 2015 12:39:22 +0100
Subject: [PATCH] arm64: fix bug for reloading FPSIMD state after execve
 on cpu 0.
In-Reply-To: <CAKv+Gu_VtFGsKPmFfLHm=kNM=vK=p1TR+fd52P68MiA6J0zUFQ@mail.gmail.com>
References: <1440556841-17219-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <20150826111205.GD30466@arm.com>
 <CAKv+Gu_VtFGsKPmFfLHm=kNM=vK=p1TR+fd52P68MiA6J0zUFQ@mail.gmail.com>
Message-ID: <20150826113922.GE30466@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 26, 2015 at 12:32:03PM +0100, Ard Biesheuvel wrote:
> On 26 August 2015 at 13:12, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Aug 26, 2015 at 03:40:41AM +0100, Chunyan Zhang wrote:
> >> From: Janet Liu <janet.liu@spreadtrum.com>
> >>
> >> If process A is running on CPU 0 and do execve syscall and after sched_exec,
> >> dest_cpu is 0, fpsimd_state.cpu is 0. If at the time Process A get scheduled
> >> out and after some kernel threads running on CPU 0, process A is back in CPU 0,
> >> A's fpsimd_state.cpu is current cpu id "0", and per_cpu(fpsimd_last_state)
> >> points A's fpsimd_state, TIF_FOREIGN_FPSTATE will be clear, kernel will not
> >> reload the context during it return to userspace. so set the cpu's
> >> fpsimd_last_state to NULL to avoid this.
> >
> > AFAICT, this is only a problem if one of the kernel threads uses the fpsimd
> > registers, right? However, kernel_neon_begin_partial clobbers
> > fpsimd_last_state, so I'm struggling to see the problem.
> >
> 
> I think the problem is real, but it would be better to set the
> fpsimd_state::cpu field to an invalid value like we do in
> fpsimd_flush_task_state()
> 
> diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
> index 44d6f7545505..c56956a16d3f 100644
> --- a/arch/arm64/kernel/fpsimd.c
> +++ b/arch/arm64/kernel/fpsimd.c
> @@ -158,6 +158,7 @@ void fpsimd_thread_switch(struct task_struct *next)
>  void fpsimd_flush_thread(void)
>  {
>         memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
> +       fpsimd_flush_task_state(current);
>         set_thread_flag(TIF_FOREIGN_FPSTATE);
>  }
> 
> (note the memset erroneously initializes that field to CPU 0)

Aha, I see. So the problem is actually that we get a view on our fpsimd
state before the exec, rather than a view on some kernel state.

> This more accurately reflects the state of the process after forking,
> i.e., that its FPSIMD state has never been loaded into any CPU.

Yup, that's much clearer.

Will
