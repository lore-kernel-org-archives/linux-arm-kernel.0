From: lkp@intel.com (kbuild test robot)
Date: Sun, 7 Feb 2016 16:40:19 +0800
Subject: [PATCH v10 8/8] numa, mm, cleanup: remove redundant NODE_DATA
 macro from asm header files.
In-Reply-To: <1454407763-1017-9-git-send-email-gkulkarni@caviumnetworks.com>
Message-ID: <201602071624.1Td35yi4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapatrao,

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.5-rc2 next-20160205]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Ganapatrao-Kulkarni/arm64-numa-adding-numa-support-for-arm64-platforms/20160202-181522
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux for-next/core
config: i386-randconfig-sb0-02030124 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/gfp.h:5:0,
                    from include/linux/slab.h:14,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:8:
   arch/x86/include/asm/mmzone_32.h: In function 'pfn_valid':
>> include/linux/mmzone.h:704:41: error: implicit declaration of function 'NODE_DATA' [-Werror=implicit-function-declaration]
    #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
                                            ^
>> arch/x86/include/asm/mmzone_32.h:42:17: note: in expansion of macro 'node_end_pfn'
      return (pfn < node_end_pfn(nid));
                    ^
>> include/linux/mmzone.h:704:41: warning: passing argument 1 of 'pgdat_end_pfn' makes pointer from integer without a cast [-Wint-conversion]
    #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
                                            ^
>> arch/x86/include/asm/mmzone_32.h:42:17: note: in expansion of macro 'node_end_pfn'
      return (pfn < node_end_pfn(nid));
                    ^
   include/linux/mmzone.h:706:29: note: expected 'pg_data_t * {aka struct pglist_data *}' but argument is of type 'int'
    static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
                                ^
   cc1: some warnings being treated as errors
   make[2]: *** [arch/x86/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +/NODE_DATA +704 include/linux/mmzone.h

d41dee369 Andy Whitcroft    2005-06-23  698  #else
d41dee369 Andy Whitcroft    2005-06-23  699  #define pgdat_page_nr(pgdat, pagenr)	pfn_to_page((pgdat)->node_start_pfn + (pagenr))
d41dee369 Andy Whitcroft    2005-06-23  700  #endif
408fde81c Dave Hansen       2005-06-23  701  #define nid_page_nr(nid, pagenr) 	pgdat_page_nr(NODE_DATA(nid),(pagenr))
^1da177e4 Linus Torvalds    2005-04-16  702  
c6830c226 KAMEZAWA Hiroyuki 2011-06-16  703  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
da3649e13 Cody P Schafer    2013-02-22 @704  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
c6830c226 KAMEZAWA Hiroyuki 2011-06-16  705  
da3649e13 Cody P Schafer    2013-02-22  706  static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
da3649e13 Cody P Schafer    2013-02-22  707  {

:::::: The code at line 704 was first introduced by commit
:::::: da3649e133948d8b7d8c57b05a33faf62ac2cc7e mmzone: add pgdat_{end_pfn,is_empty}() helpers & consolidate.

:::::: TO: Cody P Schafer <cody@linux.vnet.ibm.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26716 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160207/0fbad0fa/attachment-0001.obj>
