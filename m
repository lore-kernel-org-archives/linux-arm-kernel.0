From: panand@redhat.com (Pratyush Anand)
Date: Thu, 17 Mar 2016 13:27:26 +0530
Subject: [PATCH v11 3/9] arm64: add copy_to/from_user to kprobes blacklist
In-Reply-To: <56E9350A.7010909@arm.com>
References: <1457501543-24197-1-git-send-email-dave.long@linaro.org>
 <1457501543-24197-4-git-send-email-dave.long@linaro.org>
 <56E858D8.8030300@arm.com>
 <20160316054329.GC28915@dhcppc6.redhat.com>
 <56E9350A.7010909@arm.com>
Message-ID: <20160317075726.GA16882@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,

On 16/03/2016:10:27:22 AM, James Morse wrote:
> Hi Pratyush,
> 
> On 16/03/16 05:43, Pratyush Anand wrote:
> > On 15/03/2016:06:47:52 PM, James Morse wrote:
> >> If I understand this correctly -  you can't kprobe these ldr/str instructions
> >> as the fault handler wouldn't find kprobe's out-of line version of the
> >> instruction in the exception table... but why only these two functions? (for
> >> library functions, we also have clear_user() and copy_in_user()...)
> >
> > May be not clear_user() because those are inlined, but may be __clear_user().
> 
> You're right - the other library functions in that same directory is what I meant..
> 
> >> Is it feasible to search the exception table at runtime instead? If an
> >> address-to-be-kprobed appears in the list, we know it could generate exceptions,
> >> so we should report that we can't probe this address. That would catch all of
> >> the library functions, all the places uaccess.h was inlined, and anything new
> >> that gets invented in the future.
> > 
> > Sorry, probably I could not get it. How can an inlined addresses range be placed
> > in exception table or any other code area.
> 
> Ah, not a section or code area, sorry I wasn't clear:
> 
> When a fault happens in the kernel, the fault handler
> (/arch/arm64/mm/fault.c:do_page_fault()) calls search_exception_tables(regs->pc)
> to see if the faulting address has a 'fixup' registered. If it does, the fixup
> causes -EFAULT to be returned, if not it ends up in die().
> 
> The horrible block of assembler in
> arch/arm64/include/asm/uaccess.h:__get_user_asm() adds the address of the
> instruction that is allowed to fault to the __ex_table section:
> >	.section __ex_table,"a"
> > 	.align	3
> > 	.quad	1b, 3b
> >	.previous
> 
> Here 1b is the address of the instruction that can fault, and 3b is the fixup
> that moves -EFAULT into the return value.
> 
> This works for get_user() and friends which are inlined all over the kernel. It
> even works for modules, as there is an exception table for each module which is
> searched by kernel/module.c:search_module_extables().
> 
> This list of addresses that can fault already exists, there is even an API
> function to check for a given address. Grabbing the nearest vmlinux, there are
> ~1300 entries in the __ex_table section, this patch blacklists two of them,
> using search_exception_tables() obviously blacklists them all.

Thanks a lot for explaining it. Got it now. So agreeing to your idea. But....

> 
> 
> I've had a quick look at x86 and sparc, it looks like they allowed probed
> instructions to fault, do_page_fault()->kprobes_fault()->kprobe_fault_handler()
> - which uses the original probed address with search_exception_tables() to find
> and run the fixup. I doubt this is needed in an initial version of kprobes,
> (maybe its later in this series - I haven't read all the way through it yet).

Hummmm..We do have fixup_exception() in arm64 kprobe_fault_handler(). So, it
should have worked, without this patch.

@David: This patch was added in v9 and fixup_exception() had been dropped in v9.
Since, dropping of fixup_exception() also caused to fail some systemtap test
cases, so it was added back in v10. I wonder if we really need this patch.
May be you can try to run related test case by dropping this patch. 

Thanks James for bringing this out.

~Pratyush
