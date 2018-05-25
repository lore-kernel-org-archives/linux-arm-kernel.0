From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 May 2018 10:52:12 +0100
Subject: [PATCH v11 08/19] arm64: fpsimd: Eliminate task->mm checks
In-Reply-To: <20180525090257.GB54529@C02W217FHV2R.local>
References: <1527181008-13549-1-git-send-email-Dave.Martin@arm.com>
 <1527181008-13549-9-git-send-email-Dave.Martin@arm.com>
 <20180525090257.GB54529@C02W217FHV2R.local>
Message-ID: <20180525095211.GB13470@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 25, 2018 at 11:02:57AM +0200, Christoffer Dall wrote:
> On Thu, May 24, 2018 at 05:56:37PM +0100, Dave Martin wrote:
> > Currently the FPSIMD handling code uses the condition task->mm ==
> > NULL as a hint that task has no FPSIMD register context.
> > 
> > The ->mm check is only there to filter out tasks that cannot
> > possibly have FPSIMD context loaded, for optimisation purposes.
> > Also, TIF_FOREIGN_FPSTATE must always be checked anyway before
> > saving FPSIMD context back to memory.  For these reasons, the ->mm
> > checks are not useful, providing that TIF_FOREIGN_FPSTATE is
> > maintained in a consistent way for all threads.
> > 
> > The context switch logic is already deliberately optimised to defer
> > reloads of the regs until ret_to_user (or sigreturn as a special
> > case), and save them only if they have been previously loaded.
> > These paths are the only places where the wrong_task and wrong_cpu
> > conditions can be made false, by calling fpsimd_bind_task_to_cpu().
> > Kernel threads by definition never reach these paths.  As a result,
> > the wrong_task and wrong_cpu tests in fpsimd_thread_switch() will
> > always yield true for kernel threads.
> > 
> > This patch removes the redundant checks and special-case code,                  ensuring that TIF_FOREIGN_FPSTATE is set whenever a kernel thread               is scheduled in, and ensures that this flag is set for the init
> > task.  The fpsimd_flush_task_state() call already present in
> > copy_thread() ensures the same for any new task.
> 
> nit: formatting still funny, but you shouldn't respin just for that.

Ah jeez... it was a long day.

I guess this isn't the end of the world, but I'll fix this in my branch
and point Marc at it.

> > 
> > With TIF_FOREIGN_FPSTATE always set for kernel threads, this patch
> > ensures that no extra context save work is added for kernel
> > threads, and eliminates the redundant context saving that may
> > currently occur for kernel threads that have acquired an mm via
> > use_mm().
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@arm.com>

[...]

Thanks
---Dave
