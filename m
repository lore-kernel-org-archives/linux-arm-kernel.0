From: panand@redhat.com (Pratyush Anand)
Date: Tue, 22 Mar 2016 22:21:34 +0530
Subject: [PATCH v11 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <20160321145242.GJ23397@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-4-git-send-email-dave.long@linaro.org>
 <56E858D8.8030300@arm.com>
 <20160316054329.GC28915@dhcppc6.redhat.com>
 <56E9350A.7010909@arm.com>
 <20160317075726.GA16882@dhcppc6.redhat.com>
 <20160318132902.GA29225@dhcppc6.redhat.com>
 <20160321145242.GJ23397@arm.com>
Message-ID: <20160322165134.GF15150@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thanks for the reply.

On 21/03/2016:02:52:43 PM, Will Deacon wrote:
> On Fri, Mar 18, 2016 at 06:59:02PM +0530, Pratyush Anand wrote:
> > On 17/03/2016:01:27:26 PM, Pratyush Anand wrote:
> > > @David: This patch was added in v9 and fixup_exception() had been dropped in v9.
> > > Since, dropping of fixup_exception() also caused to fail some systemtap test
> > > cases, so it was added back in v10. I wonder if we really need this patch.
> > > May be you can try to run related test case by dropping this patch. 
> > 
> > Had a closer look to the code, and noticed that fixup_exception() does not have
> > any role in handling of page fault of copy_to_user(). Then, why do we have the
> > problem.
> > Probably, I can see why does not it work. So, when we are single stepping an
> > instruction and page fault occurs, we will come to el1_da in entry.S. Here, we
> > do enable_dbg. As soon as we will do this, we will start receiving single step
> > exception after each instruction (not sure, probably for each alternate
> > instruction). Since, there will not be any matching single step handler for
> > these instructions, so we will see warning "Unexpected kernel single-step
> > exception at EL1". 
> > 
> > So, I think, we should 
> > 
> > (1) may be do not enable debug for el1_da, or
> > (2) enable_dbg only when single stepping is not enabled, or
> > (3) or disable single stepping during el1_da execution.
> > 
> > (1) will solve the issue for sure, but not sure if it could be the best choice.
> > 
> > Will, what do you suggest?
> 
> Leaving debug exceptions disabled isn't something I'm keen on at all,
> because it leads to blackspots in kernel debugging that I don't think
> should be enforced by the low-level debug machinery. My preference is
> for the higher-level debugger code (e.g. kprobes, kdgb) to ignore the
> events that it's not interested in.

I think this is what the current implementation is, so in the given situation
higher-level debugger code ignore the single step exceptions events, which they
are not expecting.
Here, execution of single stepped instruction is causing to raise another new
exception, say data abort. Now, as soon as we enable debug exceptions while
handling this data abort we will start getting single step exceptions for all
the executed instruction of data abort handler. None of the "higher-level
debugger code" is interested in those events and so they ignore them. We keep on
getting "Unexpected kernel single-step exception at EL1" until all the
instructions for data abort handler are executed.

> 
> It's also very easy to lose track of the debug state if you run preemptible
> code at EL1 with debug exceptions disabled, because kernel debugging is
> per-cpu rather than per-task.

OK.Thanks for this clarification. So, one of the way could be to set a per
cpu variable by higher level debugger code, and then check them in kernel_entry
and kernel_exit and accordingly disable/enable only single stepping. Do you
think, it would be good idea to do that?
If yes, then would adding a new u64 variable say "flags" in struct pt_regs be
acceptable? 

~Pratyush
