From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 May 2018 22:07:52 +0800
Subject: [PATCH 2/2] arm64/mm: add speculative page fault
In-Reply-To: <1525247672-2165-2-git-send-email-opensource.ganesh@gmail.com>
References: <1525247672-2165-2-git-send-email-opensource.ganesh@gmail.com>
Message-ID: <201805022019.dToUjest%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.17-rc3 next-20180502]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ganesh-Mahendran/arm64-mm-define-ARCH_SUPPORTS_SPECULATIVE_PAGE_FAULT/20180502-183036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/mm/fault.c: In function '__do_page_fault':
>> arch/arm64/mm/fault.c:329:15: error: implicit declaration of function 'can_reuse_spf_vma' [-Werror=implicit-function-declaration]
     if (!vma || !can_reuse_spf_vma(vma, addr))
                  ^~~~~~~~~~~~~~~~~
   arch/arm64/mm/fault.c: In function 'do_page_fault':
>> arch/arm64/mm/fault.c:416:11: error: implicit declaration of function 'handle_speculative_fault'; did you mean 'handle_mm_fault'? [-Werror=implicit-function-declaration]
      fault = handle_speculative_fault(mm, addr, mm_flags, &vma);
              ^~~~~~~~~~~~~~~~~~~~~~~~
              handle_mm_fault
>> arch/arm64/mm/fault.c:427:18: error: 'PERF_COUNT_SW_SPF' undeclared (first use in this function); did you mean 'PERF_COUNT_SW_MAX'?
       perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, addr);
                     ^~~~~~~~~~~~~~~~~
                     PERF_COUNT_SW_MAX
   arch/arm64/mm/fault.c:427:18: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/can_reuse_spf_vma +329 arch/arm64/mm/fault.c

   322	
   323	static int __do_page_fault(struct mm_struct *mm, unsigned long addr,
   324				   unsigned int mm_flags, unsigned long vm_flags,
   325				   struct task_struct *tsk, struct vm_area_struct *vma)
   326	{
   327		int fault;
   328	
 > 329		if (!vma || !can_reuse_spf_vma(vma, addr))
   330			vma = find_vma(mm, addr);
   331	
   332		vma = find_vma(mm, addr);
   333		fault = VM_FAULT_BADMAP;
   334		if (unlikely(!vma))
   335			goto out;
   336		if (unlikely(vma->vm_start > addr))
   337			goto check_stack;
   338	
   339		/*
   340		 * Ok, we have a good vm_area for this memory access, so we can handle
   341		 * it.
   342		 */
   343	good_area:
   344		/*
   345		 * Check that the permissions on the VMA allow for the fault which
   346		 * occurred.
   347		 */
   348		if (!(vma->vm_flags & vm_flags)) {
   349			fault = VM_FAULT_BADACCESS;
   350			goto out;
   351		}
   352	
   353		return handle_mm_fault(vma, addr & PAGE_MASK, mm_flags);
   354	
   355	check_stack:
   356		if (vma->vm_flags & VM_GROWSDOWN && !expand_stack(vma, addr))
   357			goto good_area;
   358	out:
   359		return fault;
   360	}
   361	
   362	static bool is_el0_instruction_abort(unsigned int esr)
   363	{
   364		return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_LOW;
   365	}
   366	
   367	static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
   368					   struct pt_regs *regs)
   369	{
   370		struct task_struct *tsk;
   371		struct mm_struct *mm;
   372		struct siginfo si;
   373		int fault, major = 0;
   374		unsigned long vm_flags = VM_READ | VM_WRITE;
   375		unsigned int mm_flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_KILLABLE;
   376		struct vm_area_struct *vma;
   377	
   378		if (notify_page_fault(regs, esr))
   379			return 0;
   380	
   381		tsk = current;
   382		mm  = tsk->mm;
   383	
   384		/*
   385		 * If we're in an interrupt or have no user context, we must not take
   386		 * the fault.
   387		 */
   388		if (faulthandler_disabled() || !mm)
   389			goto no_context;
   390	
   391		if (user_mode(regs))
   392			mm_flags |= FAULT_FLAG_USER;
   393	
   394		if (is_el0_instruction_abort(esr)) {
   395			vm_flags = VM_EXEC;
   396		} else if ((esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM)) {
   397			vm_flags = VM_WRITE;
   398			mm_flags |= FAULT_FLAG_WRITE;
   399		}
   400	
   401		if (addr < TASK_SIZE && is_permission_fault(esr, regs, addr)) {
   402			/* regs->orig_addr_limit may be 0 if we entered from EL0 */
   403			if (regs->orig_addr_limit == KERNEL_DS)
   404				die("Accessing user space memory with fs=KERNEL_DS", regs, esr);
   405	
   406			if (is_el1_instruction_abort(esr))
   407				die("Attempting to execute userspace memory", regs, esr);
   408	
   409			if (!search_exception_tables(regs->pc))
   410				die("Accessing user space memory outside uaccess.h routines", regs, esr);
   411		}
   412	
   413		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
   414	
   415		if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT)) {
 > 416			fault = handle_speculative_fault(mm, addr, mm_flags, &vma);
   417			/*
   418			 * Page fault is done if VM_FAULT_RETRY is not returned.
   419			 * But if the memory protection keys are active, we don't know
   420			 * if the fault is due to key mistmatch or due to a
   421			 * classic protection check.
   422			 * To differentiate that, we will need the VMA we no
   423			 * more have, so let's retry with the mmap_sem held.
   424			 */
   425			if (fault != VM_FAULT_RETRY &&
   426				 fault != VM_FAULT_SIGSEGV) {
 > 427				perf_sw_event(PERF_COUNT_SW_SPF, 1, regs, addr);
   428				goto done;
   429			}
   430		} else {
   431			vma = NULL;
   432		}
   433	
   434		/*
   435		 * As per x86, we may deadlock here. However, since the kernel only
   436		 * validly references user space from well defined areas of the code,
   437		 * we can bug out early if this is from code which shouldn't.
   438		 */
   439		if (!down_read_trylock(&mm->mmap_sem)) {
   440			if (!user_mode(regs) && !search_exception_tables(regs->pc))
   441				goto no_context;
   442	retry:
   443			down_read(&mm->mmap_sem);
   444		} else {
   445			/*
   446			 * The above down_read_trylock() might have succeeded in which
   447			 * case, we'll have missed the might_sleep() from down_read().
   448			 */
   449			might_sleep();
   450	#ifdef CONFIG_DEBUG_VM
   451			if (!user_mode(regs) && !search_exception_tables(regs->pc))
   452				goto no_context;
   453	#endif
   454		}
   455	
   456		fault = __do_page_fault(mm, addr, mm_flags, vm_flags, tsk, vma);
   457		major |= fault & VM_FAULT_MAJOR;
   458	
   459		if (fault & VM_FAULT_RETRY) {
   460			/*
   461			 * If we need to retry but a fatal signal is pending,
   462			 * handle the signal first. We do not need to release
   463			 * the mmap_sem because it would already be released
   464			 * in __lock_page_or_retry in mm/filemap.c.
   465			 */
   466			if (fatal_signal_pending(current)) {
   467				if (!user_mode(regs))
   468					goto no_context;
   469				return 0;
   470			}
   471	
   472			/*
   473			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk of
   474			 * starvation.
   475			 */
   476			if (mm_flags & FAULT_FLAG_ALLOW_RETRY) {
   477				mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
   478				mm_flags |= FAULT_FLAG_TRIED;
   479	
   480				/*
   481				 * Do not try to reuse this vma and fetch it
   482				 * again since we will release the mmap_sem.
   483				 */
   484				if (IS_ENABLED(CONFIG_SPECULATIVE_PAGE_FAULT))
   485					vma = NULL;
   486	
   487				goto retry;
   488			}
   489		}
   490		up_read(&mm->mmap_sem);
   491	
   492	done:
   493	
   494		/*
   495		 * Handle the "normal" (no error) case first.
   496		 */
   497		if (likely(!(fault & (VM_FAULT_ERROR | VM_FAULT_BADMAP |
   498				      VM_FAULT_BADACCESS)))) {
   499			/*
   500			 * Major/minor page fault accounting is only done
   501			 * once. If we go through a retry, it is extremely
   502			 * likely that the page will be found in page cache at
   503			 * that point.
   504			 */
   505			if (major) {
   506				tsk->maj_flt++;
   507				perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
   508					      addr);
   509			} else {
   510				tsk->min_flt++;
   511				perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
   512					      addr);
   513			}
   514	
   515			return 0;
   516		}
   517	
   518		/*
   519		 * If we are in kernel mode at this point, we have no context to
   520		 * handle this fault with.
   521		 */
   522		if (!user_mode(regs))
   523			goto no_context;
   524	
   525		if (fault & VM_FAULT_OOM) {
   526			/*
   527			 * We ran out of memory, call the OOM killer, and return to
   528			 * userspace (which will retry the fault, or kill us if we got
   529			 * oom-killed).
   530			 */
   531			pagefault_out_of_memory();
   532			return 0;
   533		}
   534	
   535		clear_siginfo(&si);
   536		si.si_addr = (void __user *)addr;
   537	
   538		if (fault & VM_FAULT_SIGBUS) {
   539			/*
   540			 * We had some memory, but were unable to successfully fix up
   541			 * this page fault.
   542			 */
   543			si.si_signo	= SIGBUS;
   544			si.si_code	= BUS_ADRERR;
   545		} else if (fault & VM_FAULT_HWPOISON_LARGE) {
   546			unsigned int hindex = VM_FAULT_GET_HINDEX(fault);
   547	
   548			si.si_signo	= SIGBUS;
   549			si.si_code	= BUS_MCEERR_AR;
   550			si.si_addr_lsb	= hstate_index_to_shift(hindex);
   551		} else if (fault & VM_FAULT_HWPOISON) {
   552			si.si_signo	= SIGBUS;
   553			si.si_code	= BUS_MCEERR_AR;
   554			si.si_addr_lsb	= PAGE_SHIFT;
   555		} else {
   556			/*
   557			 * Something tried to access memory that isn't in our memory
   558			 * map.
   559			 */
   560			si.si_signo	= SIGSEGV;
   561			si.si_code	= fault == VM_FAULT_BADACCESS ?
   562					  SEGV_ACCERR : SEGV_MAPERR;
   563		}
   564	
   565		__do_user_fault(&si, esr);
   566		return 0;
   567	
   568	no_context:
   569		__do_kernel_fault(addr, esr, regs);
   570		return 0;
   571	}
   572	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37763 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/acdff24e/attachment-0001.gz>
