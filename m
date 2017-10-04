From: lkp@intel.com (kbuild test robot)
Date: Wed, 4 Oct 2017 17:40:03 +0800
Subject: [PATCH v4 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <20171002061431.11117-4-takahiro.akashi@linaro.org>
Message-ID: <201710041753.sJjSW3iY%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.14-rc3 next-20170929]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/arm64-kexec-add-kexec_file_load-support/20171004-163130
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: x86_64-randconfig-x000-201740 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   kernel/kexec_file.c: In function 'kimage_file_post_load_cleanup':
>> kernel/kexec_file.c:152:2: error: implicit declaration of function 'arch_kimage_file_post_load_cleanup' [-Werror=implicit-function-declaration]
     arch_kimage_file_post_load_cleanup(image);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/arch_kimage_file_post_load_cleanup +152 kernel/kexec_file.c

a43cac0d9 Dave Young 2015-09-09  126  
a43cac0d9 Dave Young 2015-09-09  127  /*
a43cac0d9 Dave Young 2015-09-09  128   * Free up memory used by kernel, initrd, and command line. This is temporary
a43cac0d9 Dave Young 2015-09-09  129   * memory allocation which is not needed any more after these buffers have
a43cac0d9 Dave Young 2015-09-09  130   * been loaded into separate segments and have been copied elsewhere.
a43cac0d9 Dave Young 2015-09-09  131   */
a43cac0d9 Dave Young 2015-09-09  132  void kimage_file_post_load_cleanup(struct kimage *image)
a43cac0d9 Dave Young 2015-09-09  133  {
a43cac0d9 Dave Young 2015-09-09  134  	struct purgatory_info *pi = &image->purgatory_info;
a43cac0d9 Dave Young 2015-09-09  135  
a43cac0d9 Dave Young 2015-09-09  136  	vfree(image->kernel_buf);
a43cac0d9 Dave Young 2015-09-09  137  	image->kernel_buf = NULL;
a43cac0d9 Dave Young 2015-09-09  138  
a43cac0d9 Dave Young 2015-09-09  139  	vfree(image->initrd_buf);
a43cac0d9 Dave Young 2015-09-09  140  	image->initrd_buf = NULL;
a43cac0d9 Dave Young 2015-09-09  141  
a43cac0d9 Dave Young 2015-09-09  142  	kfree(image->cmdline_buf);
a43cac0d9 Dave Young 2015-09-09  143  	image->cmdline_buf = NULL;
a43cac0d9 Dave Young 2015-09-09  144  
a43cac0d9 Dave Young 2015-09-09  145  	vfree(pi->purgatory_buf);
a43cac0d9 Dave Young 2015-09-09  146  	pi->purgatory_buf = NULL;
a43cac0d9 Dave Young 2015-09-09  147  
a43cac0d9 Dave Young 2015-09-09  148  	vfree(pi->sechdrs);
a43cac0d9 Dave Young 2015-09-09  149  	pi->sechdrs = NULL;
a43cac0d9 Dave Young 2015-09-09  150  
a43cac0d9 Dave Young 2015-09-09  151  	/* See if architecture has anything to cleanup post load */
a43cac0d9 Dave Young 2015-09-09 @152  	arch_kimage_file_post_load_cleanup(image);
a43cac0d9 Dave Young 2015-09-09  153  
a43cac0d9 Dave Young 2015-09-09  154  	/*
a43cac0d9 Dave Young 2015-09-09  155  	 * Above call should have called into bootloader to free up
a43cac0d9 Dave Young 2015-09-09  156  	 * any data stored in kimage->image_loader_data. It should
a43cac0d9 Dave Young 2015-09-09  157  	 * be ok now to free it up.
a43cac0d9 Dave Young 2015-09-09  158  	 */
a43cac0d9 Dave Young 2015-09-09  159  	kfree(image->image_loader_data);
a43cac0d9 Dave Young 2015-09-09  160  	image->image_loader_data = NULL;
a43cac0d9 Dave Young 2015-09-09  161  }
a43cac0d9 Dave Young 2015-09-09  162  

:::::: The code at line 152 was first introduced by commit
:::::: a43cac0d9dc2073ff2245a171429ddbe1accece7 kexec: split kexec_file syscall code to kexec_file.c

:::::: TO: Dave Young <dyoung@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27479 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171004/789b3c2f/attachment-0001.gz>
