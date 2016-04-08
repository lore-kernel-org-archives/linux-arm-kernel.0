From: panand@redhat.com (Pratyush Anand)
Date: Fri, 8 Apr 2016 14:28:24 +0530
Subject: [PATCH 2/2] arm64: Fix watchpoint recursion when single-step is
 wrongly triggered in irq
In-Reply-To: <570766B0.60100@huawei.com>
References: <1458549470-124791-1-git-send-email-hekuang@huawei.com>
 <1458549470-124791-2-git-send-email-hekuang@huawei.com>
 <20160321102423.GB15150@dhcppc6.redhat.com>
 <56FD1BD1.7070101@huawei.com>
 <20160404051714.GH28435@dhcppc0.redhat.com>
 <570645CD.6030400@huawei.com>
 <20160408051408.GA28371@dhcppc6.redhat.com>
 <570766B0.60100@huawei.com>
Message-ID: <20160408085824.GC28371@dhcppc6.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2016:04:07:12 PM, Li Bin wrote:
> 
> 
> on 2016/4/8 13:14, Pratyush Anand wrote:
> > Hi Li,
> > 
> > On 07/04/2016:07:34:37 PM, Li Bin wrote:
> >> Hi Pratyush,
> >>
> >> on 2016/4/4 13:17, Pratyush Anand wrote:
> >>> Hi Li,
> >>>
> >>> On 31/03/2016:08:45:05 PM, Li Bin wrote:
> >>>> Hi Pratyush,
> >>>>
> >>>> on 2016/3/21 18:24, Pratyush Anand wrote:
> >>>>> On 21/03/2016:08:37:50 AM, He Kuang wrote:
> >>>>>> On arm64, watchpoint handler enables single-step to bypass the next
> >>>>>> instruction for not recursive enter. If an irq is triggered right
> >>>>>> after the watchpoint, a single-step will be wrongly triggered in irq
> >>>>>> handler, which causes the watchpoint address not stepped over and
> >>>>>> system hang.
> >>>>>
> >>>>> Does patch [1] resolves this issue as well? I hope it should. Patch[1] has still
> >>>>> not been sent for review. Your test result will be helpful.
> >>>>>
> >>>>> ~Pratyush
> >>>>>
> >>>>> [1] https://github.com/pratyushanand/linux/commit/7623c8099ac22eaa00e7e0f52430f7a4bd154652
> >>>>
> >>>> This patch did not consider that, when excetpion return, the singlestep flag
> >>>> should be restored, otherwise the right singlestep will not triggered.
> >>>> Right?
> >>>
> >>> Yes, you are right, and there are other problems as well. Will Deacon pointed
> >>> out [1] that kernel debugging is per-cpu rather than per-task. So, I did thought
> >>> of a per-cpu implementation by introducing a new element "flags" in struct
> >>> pt_regs. But even with that I see issues. For example:
> >>> - While executing single step instruction, we get a data abort
> >>> - In the kernel_entry of data abort we disable single stepping based on "flags"
> >>>   bit field
> >>> - While handling data abort we receive anther interrupt, so we are again in
> >>>   kernel_entry (for el1_irq). Single stepping will be disabled again (although
> >>>   it does not matter).
> >>>
> >>> Now the issue is that, what condition should be verified in kernel_exit for
> >>> enabling single step again? In the above scenario, kernel_exit for el1_irq
> >>> should not enable single stepping, but how to prevent that elegantly?
> >>
> >> The condition for kernel_entry to disable the single step is that MDSCR_EL1.SS
> >> has been set. And only when the corresponding kernel_entry has disabled the single
> >> step, the kernel_exit should enable it, but the kernel_exit of single-step exception
> >> should be handled specially, that when disable single step in single-step exception
> >> handler, flag of pt_regs stored in stack should be cleard to prevent to be re-enabled
> >> by kernel_exit.
> > 
> > Nice, :-)
> > I had latter on almost similar patch [1], but it did fail when I merged two of
> > the tests.
> > -- I inserted kprobe to an instruction in function __copy_to_user() which could
> > generate data abort.
> > -- In parallel I also run test case which is defined here [2]
> > -- As soon as I did `cat /proc/version`, kernel crashed.
> 
> Hi Pratyush,
> 
> Firstly, I have test this case, and it does not trigger failture as you describing.
> But it indeed may trigger problem, and it is an another issue that if an exception
> triggered before single-step exception, changes the regs->pc (data abort exception will
> fixup_exception), the current implemetion of kprobes does not support, for example:

Yes, you are right, I missed it. All those aborts which has a fixup defined,
will fail. While, I did not see any issue when running test individually, ie
only hitting kprobe at __copy_to_user() instructions, because there is no fixup
for them. I was able to trace instruction which was aborting. Problem occurred
only when I run perf memory read to linux_proc_banner in parallel. Since I do
not see failure due to fixup_exception in this test case, so I think we are
missing some more pitfalls.

But certainly it is going to fail in the case  __get_user/__put_user etc are
being traced, because there exists a fixup section for them.

> 1. kprobes brk exception setup single-step, regs->pc points to the slot, MDSCR.SS=1,
> SPSR_EL1.SS=1 (Inactive state)
> 2. brk exception eret (Active-not-pending state)
> 3. execute the slot instruction and trigger data abort exception, and this case the
> return addr is also the slot instruction, so the SPSR_EL1.SS is set to 1 (Inactive state)
> 4. but in the data abort exception, fixup_exception will change the regs->pc to the fixup

Yes, for the instructions with fixup defined.

> code
> 5. data abort exception eret, going into Active-not-pending state, executing fixup code
> without taking an exception, going into Active-pending state, triggering single-step
> exception. But the single-step instruction is not the target instrution, so kprobe fails.
> 
> And so this case including copy_to/from_user should be added to kprobes blacklist.
> Right, or am i missing something?

As of now, we are be going with blacklisting approach only.

~Pratyush
