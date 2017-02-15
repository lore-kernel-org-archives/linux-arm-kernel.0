From: psodagud@codeaurora.org (Sodagudi Prasad)
Date: Tue, 14 Feb 2017 21:52:30 -0800
Subject: <Query> Looking more details and reasons for using orig_add_limit.
Message-ID: <def87360266193184dc013a055ec3869@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi All,

  Would like to understand the reasons behind using the orig_add_limit 
variable in the following code. Can you please share more details ?

"arch/arm64/mm/fault.c"
static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
                                    struct pt_regs *regs)
{
?
?
?
         if (addr < USER_DS && is_permission_fault(esr, regs)) {          
=====>> condition_1
                 /* regs->orig_addr_limit may be 0 if we entered from EL0 
*/
                 if (regs->orig_addr_limit == KERNEL_DS)             	    
=====>> condition_2
                         die("Accessing user space memory with 
fs=KERNEL_DS", regs, esr);

                 if (is_el1_instruction_abort(esr))
                         die("Attempting to execute userspace memory", 
regs, esr);

                 if (!search_exception_tables(regs->pc))
                         die("Accessing user space memory outside 
uaccess.h routines", regs, esr);
         }


When any sys call is made from user space orig_addr_limit will be zero 
and after that driver is calling set_fs(KERNEL_DS) and  then 
copy_to_user() to user space memory.  If there is permission fault for 
user space address the above condition is leading to kernel crash. 
Because orig_add_limit is having KERNEL_DS as set_fs called before 
copy_to_user().

1)	So I would like to understand that,  is that user space pointer 
leading to permission fault not correct(condition_1) in this scenario?
2)	Are there any corner cases where these if conditions (condition_1 and 
condition2) would lead to kernel crash ?
3)	What are all scenarios these if conditions (condition_1 and 
condition2)  would like to take care?

-Thanks, Prasad


-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
Linux Foundation Collaborative Project
