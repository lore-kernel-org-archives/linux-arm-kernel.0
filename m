From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Mar 2017 06:57:54 +0800
Subject: [PATCHv2 14/14] treewide: Decouple cacheflush.h and set_memory.h
In-Reply-To: <1488413706-9739-15-git-send-email-labbott@redhat.com>
Message-ID: <201703050645.HwAzqV20%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

[auto build test ERROR on linus/master]
[also build test ERROR on next-20170303]
[cannot apply to tip/x86/core drm/drm-next v4.10]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Laura-Abbott/set_memory_-functions-header-refactor/20170305-062939
config: i386-randconfig-x014-201710 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   arch/x86/kernel/machine_kexec_32.c: In function 'machine_kexec_prepare':
>> arch/x86/kernel/machine_kexec_32.c:160:2: error: implicit declaration of function 'set_pages_x' [-Werror=implicit-function-declaration]
     set_pages_x(image->control_code_page, 1);
     ^~~~~~~~~~~
   arch/x86/kernel/machine_kexec_32.c: In function 'machine_kexec_cleanup':
>> arch/x86/kernel/machine_kexec_32.c:174:2: error: implicit declaration of function 'set_pages_nx' [-Werror=implicit-function-declaration]
     set_pages_nx(image->control_code_page, 1);
     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/x86/mm/init_32.c: In function 'set_kernel_text_rw':
>> arch/x86/mm/init_32.c:880:2: error: implicit declaration of function 'set_pages_rw' [-Werror=implicit-function-declaration]
     set_pages_rw(virt_to_page(start), size >> PAGE_SHIFT);
     ^~~~~~~~~~~~
   arch/x86/mm/init_32.c: In function 'set_kernel_text_ro':
>> arch/x86/mm/init_32.c:894:2: error: implicit declaration of function 'set_pages_ro' [-Werror=implicit-function-declaration]
     set_pages_ro(virt_to_page(start), size >> PAGE_SHIFT);
     ^~~~~~~~~~~~
   arch/x86/mm/init_32.c: In function 'mark_nxdata_nx':
>> arch/x86/mm/init_32.c:911:2: error: implicit declaration of function 'set_pages_nx' [-Werror=implicit-function-declaration]
     set_pages_nx(virt_to_page(start), size >> PAGE_SHIFT);
     ^~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/set_pages_x +160 arch/x86/kernel/machine_kexec_32.c

9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  154   * - Setup page tables
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  155   */
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  156  int machine_kexec_prepare(struct kimage *image)
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  157  {
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  158  	int error;
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  159  
3ab83521 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-07-25 @160  	set_pages_x(image->control_code_page, 1);
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  161  	error = machine_kexec_alloc_page_tables(image);
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  162  	if (error)
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  163  		return error;
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  164  	machine_kexec_prepare_page_tables(image);
9868ee63 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  165  	return 0;
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  166  }
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  167  
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  168  /*
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  169   * Undo anything leftover by machine_kexec_prepare
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  170   * when an image is freed.
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  171   */
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  172  void machine_kexec_cleanup(struct kimage *image)
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  173  {
3ab83521 arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-07-25 @174  	set_pages_nx(image->control_code_page, 1);
92be3d6b arch/x86/kernel/machine_kexec_32.c Huang Ying        2008-10-31  175  	machine_kexec_free_page_tables(image);
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  176  }
5033cba0 arch/i386/kernel/machine_kexec.c   Eric W. Biederman 2005-06-25  177  

:::::: The code at line 160 was first introduced by commit
:::::: 3ab83521378268044a448113c6aa9a9e245f4d2f kexec jump

:::::: TO: Huang Ying <ying.huang@intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27856 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170305/c03609f0/attachment-0001.gz>
