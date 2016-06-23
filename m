From: lkp@intel.com (kbuild test robot)
Date: Thu, 23 Jun 2016 22:38:24 +0800
Subject: [PATCH] arm64:swiotlb:Enable only when Input size through
 command line
In-Reply-To: <1466684020-5224-1-git-send-email-manjeet.p@samsung.com>
Message-ID: <201606232205.lrBeBDtG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on v4.7-rc4]
[cannot apply to arm64/for-next/core next-20160623]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Manjeet-Pawar/arm64-swiotlb-Enable-only-when-Input-size-through-command-line/20160623-205508
config: x86_64-randconfig-i0-201625 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   lib/swiotlb.c: In function 'setup_io_tlb_size':
>> lib/swiotlb.c:131:30: warning: passing argument 2 of 'kstrtoul' makes integer from pointer without a cast [-Wint-conversion]
      swiotlb_sz = kstrtoul(str, &str, 0);
                                 ^
   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/dma-mapping.h:6,
                    from lib/swiotlb.c:21:
   include/linux/kernel.h:298:32: note: expected 'unsigned int' but argument is of type 'char **'
    static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
                                   ^~~~~~~~

vim +/kstrtoul +131 lib/swiotlb.c

   115	
   116		return 0;
   117	}
   118	early_param("swiotlb", setup_io_tlb_npages);
   119	
   120	static int __init
   121	setup_io_tlb_size(char *str)
   122	{
   123		int len = strlen(str);
   124	
   125		if (str[len-1] == 'M')
   126			swiotlb_sz_shift = 20;
   127		else if (str[len-1] == 'K')
   128			swiotlb_sz_shift = 10;
   129		str[len-1] = '\0';
   130		if (isdigit(*str))
 > 131			swiotlb_sz = kstrtoul(str, &str, 0);
   132	
   133		swiotlb_enabled = 1;
   134		return 0;
   135	}
   136	early_param("swiotlb_sz", setup_io_tlb_size);
   137	/* make io_tlb_overflow tunable too? */
   138	
   139	unsigned long swiotlb_nr_tbl(void)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28749 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160623/94ae0b4a/attachment-0001.obj>
