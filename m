From: lkp@intel.com (kbuild test robot)
Date: Fri, 14 Apr 2017 21:20:03 +0800
Subject: [PATCH] ARM32: Support mremap() for sigpage/vDSO
In-Reply-To: <20170414101033.4780-1-dsafonov@virtuozzo.com>
Message-ID: <201704142137.ph5puyyo%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dmitry,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.11-rc6 next-20170413]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dmitry-Safonov/ARM32-Support-mremap-for-sigpage-vDSO/20170414-190018
config: arm-sunxi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   arch/arm/kernel/vdso.c: In function 'vdso_mremap':
>> arch/arm/kernel/vdso.c:69:28: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
     current->mm->context.vdso = (void __user *)new_vma->vm_start;
                               ^

vim +69 arch/arm/kernel/vdso.c

    53		.name = "[vvar]",
    54		.pages = &vdso_data_page,
    55	};
    56	
    57	static int vdso_mremap(const struct vm_special_mapping *sm,
    58			struct vm_area_struct *new_vma)
    59	{
    60		unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
    61		unsigned long vdso_size;
    62	
    63		/* without VVAR page */
    64		vdso_size = (vdso_total_pages - 1) << PAGE_SHIFT;
    65	
    66		if (vdso_size != new_size)
    67			return -EINVAL;
    68	
  > 69		current->mm->context.vdso = (void __user *)new_vma->vm_start;
    70	
    71		return 0;
    72	}
    73	
    74	static struct vm_special_mapping vdso_text_mapping __ro_after_init = {
    75		.name = "[vdso]",
    76		.mremap = vdso_mremap,
    77	};

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20767 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170414/e61d08a5/attachment-0001.gz>
