From: gengdongjiu@huawei.com (gengdongjiu)
Date: Mon, 11 Dec 2017 15:38:44 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggUkVTRU5EXSBhcm02NDogZmF1bHQ6IGF2b2lkIHNl?=
 =?utf-8?Q?nd_SIGBUS_two_times?=
In-Reply-To: <5A2E8DAC.1010400@arm.com>
References: <20171205150235.46325-1-gengdongjiu@huawei.com>
 <20171206161540.GB25408@arm.com>
 <7d5791bf-39d4-b790-2f01-6abff800c6d0@huawei.com> <5A295114.7020409@arm.com>
 <d2b0d31b-1831-3c76-1c57-96101abf4b6e@huawei.com> <5A2E8DAC.1010400@arm.com>
Message-ID: <0184EA26B2509940AA629AE1405DD7F2019F54D0@DGGEMA503-MBS.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi James,
  Thanks for your review and suggestion.

> Hi gengdongjiu,
> 
> On 08/12/17 04:43, gengdongjiu wrote:
> > by the way, I think also change the info.si_code to "BUS_MCEERR_AR" is better, as shown [1].
> > BUS_MCEERR_AR can tell user space  "Hardware memory error consumed on a error; action required".
> 
> Today its also used as the last-resort. This signal tells user-space the page can't be re-read from disk/swap, and its been unmapped from all
> affected processes.
> 
> I think using it like this (tempting as it is) changes the meaning.


Consider again, I think what is your said is reasonable, when the ghes_notify_sea() return failure, it means the meory_failure() does not handler the error and even not 
unmapped the affected processes. 
So setting the si_code to BUS_MCEERR_AR may not better, I will set the si_code to 0.
Thanks for your suggestion and reminder.

> 
> 
> > so it is better than "0". In the X86 platform, it also use the "BUS_MCEERR_AR" for si_code[2] in "arch/x86/mm/fault.c".
> > what do you think about it?
> 
> This is heading into kernel-first territory, I'd prefer we do that all at once so we know everything is covered.

Yes, it is.

> 
> 
> > [2]:
> > arch/x86/mm/fault.c:
> >
> > static void
> > do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
> >       u32 *pkey, unsigned int fault)
> > {
> >   ......
> > #ifdef CONFIG_MEMORY_FAILURE
> >     if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
> 
> These VM_FAULT flags indicate memory_failure() has run, tried to re-read the memory from disk/swap, failed, and unmapped the page
> from all affected processes.

Understand, These VM_FAULT flags is different with the do_sea() handling. In the do_sea(), the memory_failure() may not run.  

> 
> 
> >         printk(KERN_ERR
> >     "MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
> >             tsk->comm, tsk->pid, address);
> >         code = BUS_MCEERR_AR;
> >     }
> > #endif
> >     force_sig_info_fault(SIGBUS, code, address, tsk, pkey, fault); }
> 
> This is x86's page fault handler, not its Machine-Check-Exception handler.
> 
> arm64's page fault handler does this too, from do_page_fault():

Yes, indeed. 
just now I check the code, you are right. 

> >	} else if (fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE)) {
> >		sig = SIGBUS;
> >		code = BUS_MCEERR_AR;
> 
> 
> If you're seeing this, its likely due to the race Xie XiuQi spotted where the recovery action has been queued, then we return to user-space
> before its done.
> 
> I had a go at tackling this, adding helpers to kick the assorted queues, which we can do if we took the exception from user-space. Where I
> got stuck is whether we should still force a signal, and how signals get merged. I'll try and spend some more time on that this week.


Understand, thanks for tacking and effort.

> 
> 
> 
> Thanks,
> 
> James
