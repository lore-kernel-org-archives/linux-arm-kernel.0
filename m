From: panand@redhat.com (Pratyush Anand)
Date: Mon, 21 Mar 2016 10:47:43 +0530
Subject: [PATCH v11 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <56EC4504.6060702@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-4-git-send-email-dave.long@linaro.org>
 <56E858D8.8030300@arm.com>
 <20160316054329.GC28915@dhcppc6.redhat.com>
 <56E9350A.7010909@arm.com>
 <20160317075726.GA16882@dhcppc6.redhat.com>
 <20160318132902.GA29225@dhcppc6.redhat.com>
 <56EC0A89.3030606@arm.com>
 <20160318144325.GB29225@dhcppc6.redhat.com>
 <56EC4504.6060702@arm.com>
Message-ID: <20160321051743.GD29225@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 18/03/2016:06:12:20 PM, James Morse wrote:
> Hi Pratyush,
> 
> On 18/03/16 14:43, Pratyush Anand wrote:
> > On 18/03/2016:02:02:49 PM, James Morse wrote:
> >> In kernel/entry.S when entered from EL0 we test for TIF_SINGLESTEP in the
> >> thread_info flags, and use disable_step_tsk/enable_step_tsk to save/restore the
> >> single-step state.
> >>
> >> Could we do this regardless of which EL we came from?
> > 
> > Thanks for another idea. I think, we can not do this as it is, because
> > TIF_SINGLESTEP will not be set for kprobe events.
> 
> Hmmm, I see kernel_enable_single_step() doesn't set it, but setup_singlestep()
> in patch 5 could...
> 
> There is probably a good reason its never set for a kernel thread, I will have a
> look at where else it is used.
> 
> 
> > But, we can introduce a
> > variant disable_step_kernel and enable_step_kernel, which can be called in
> > el1_da. 
> 
> What about sp/pc misalignment, or undefined instructions?
> Or worse... an irq occurs during your el1_da call (el1_da may re-enable irqs).
> el1_irq doesn't know you were careful not to unmask debug exceptions, it blindly
> turns them back on.
> 
> The problem is the 'single step me' bit is still set, save/restoring it will
> save us having to consider every interaction, (and then missing some!).
> 
> It would also mean you don't have to disable interrupts while single stepping in
> patch 5 (comment above kprobes_save_local_irqflag()).

I see.
kernel_enable_single_step() is called from watchpoint and kgdb handler. It seems
to me that, similar issue may arise there as well. So, it would be a good idea
to set TIF_SINGLESTEP in kernel_enable_single_step() and clear in
kernel_disable_single_step().

Meanwhile, I prepared a test case to reproduce the issue without this patch.
Instrumented a kprobe at an instruction of __copy_to_user() which stores in user
space memory. I can see a sea of messages "Unexpected kernel single-step
exception at EL1" within few seconds.  While with patch[1] applied, I do not see
any such messages. 

May be I can send [1] as RFC and seek feedback.

~Pratyush

[1] https://github.com/pratyushanand/linux/commit/7623c8099ac22eaa00e7e0f52430f7a4bd154652
