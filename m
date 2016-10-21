From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 21 Oct 2016 17:20:25 +0100
Subject: [PATCH 10/10] arm64: split thread_info from task stack
In-Reply-To: <580A2B3A.7000300@arm.com>
References: <1476904234-9511-1-git-send-email-mark.rutland@arm.com>
 <1476904234-9511-11-git-send-email-mark.rutland@arm.com>
 <580A2B3A.7000300@arm.com>
Message-ID: <20161021161959.GB17287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 03:50:34PM +0100, James Morse wrote:
> Hi Mark,
> 
> This looks great, we should definitely do this.
> There are a few things missing from entry.S below:
> 
> On 19/10/16 20:10, Mark Rutland wrote:
> > This patch moves arm64's struct thread_info from the task stack into
> > task_struct. This protects thread_info from corruption in the case of
> > stack overflows, and makes its address harder to determine if stack
> > addresses are leaked, making a number of attacks more difficult. Precise
> > detection and handling of overflow is left for subsequent patches.
> > 
> > Largely, this involves changing code to store the task_struct in sp_el0,
> > and acquire the thread_info from the task struct (which is the opposite
> > way around to the current code). Both secondary entry and idle are
> > updated to stash the sp and task pointer separately.
> > 
> > Userspace clobbers sp_el0, and we can no longer restore this from the
> > stack. Instead, the current task is cached in a per-cpu variable that we
> > can safely access from early assembly as interrupts are disabled (and we
> 
> >  arch/arm64/Kconfig                   |  1 +
> >  arch/arm64/include/asm/Kbuild        |  1 -
> >  arch/arm64/include/asm/current.h     | 22 ++++++++++++++++++++++
> >  arch/arm64/include/asm/smp.h         |  1 +
> >  arch/arm64/include/asm/thread_info.h | 24 ------------------------
> >  arch/arm64/kernel/asm-offsets.c      |  1 +
> 
> >  arch/arm64/kernel/entry.S            |  4 ++--
> 
> 4? That was too easy...

Far to easy; just looking at kernel_entry there' a glaring error:

	.if     \el == 0
	mrs     x21, sp_el0
	mov     tsk, sp
	and     tsk, tsk, #~(THREAD_SIZE - 1)   // Ensure MDSCR_EL1.SS is clear,
	ldr     x19, [tsk, #TI_FLAGS]           // since we can unmask debug
	disable_step_tsk x19, x20               // exceptions when scheduling.

...it's amazing how broken a kernel will boot quite happily.

I've fixed that up locally.

Thanks,
Mark.
