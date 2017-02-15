From: will.deacon@arm.com (Will Deacon)
Date: Wed, 15 Feb 2017 11:38:30 +0000
Subject: <Query> Looking more details and reasons for using orig_add_limit.
In-Reply-To: <def87360266193184dc013a055ec3869@codeaurora.org>
References: <def87360266193184dc013a055ec3869@codeaurora.org>
Message-ID: <20170215113829.GE9630@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 09:52:30PM -0800, Sodagudi Prasad wrote:
> 
> Hi All,
> 
>  Would like to understand the reasons behind using the orig_add_limit
> variable in the following code. Can you please share more details ?
> 
> "arch/arm64/mm/fault.c"
> static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>                                    struct pt_regs *regs)
> {
> ?
> ?
> ?
>         if (addr < USER_DS && is_permission_fault(esr, regs)) {
> =====>> condition_1
>                 /* regs->orig_addr_limit may be 0 if we entered from EL0 */
>                 if (regs->orig_addr_limit == KERNEL_DS)             	
> =====>> condition_2
>                         die("Accessing user space memory with fs=KERNEL_DS",
> regs, esr);
> 
>                 if (is_el1_instruction_abort(esr))
>                         die("Attempting to execute userspace memory", regs,
> esr);
> 
>                 if (!search_exception_tables(regs->pc))
>                         die("Accessing user space memory outside uaccess.h
> routines", regs, esr);
>         }
> 
> 
> When any sys call is made from user space orig_addr_limit will be zero and
> after that driver is calling set_fs(KERNEL_DS) and  then copy_to_user() to
> user space memory.  If there is permission fault for user space address the
> above condition is leading to kernel crash. Because orig_add_limit is having
> KERNEL_DS as set_fs called before copy_to_user().

Which driver is setting KERNEL_DS prior to accessing userspace and why? It
sounds broken to me. I also don't think it will work with PAN + UAO enabled.

Will
