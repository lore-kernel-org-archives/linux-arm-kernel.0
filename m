From: lkp@intel.com (kbuild test robot)
Date: Thu, 22 Sep 2016 12:50:35 +0800
Subject: [PATCH v3 7/9] dmaengine: edma: enable COMPILE_TEST
In-Reply-To: <20160921124135.11849-8-peter.ujfalusi@ti.com>
Message-ID: <201609221213.4CCUmdcE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.8-rc7 next-20160921]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Peter-Ujfalusi/dmaengine-ti-drivers-enable-COMPILE_TESTing/20160921-212008
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

>> drivers/dma/edma.c:415:20: error: conflicting types for 'set_bits'
    static inline void set_bits(int offset, int len, unsigned long *p)
                       ^~~~~~~~
   In file included from include/linux/bitops.h:36:0,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/dmaengine.h:20,
                    from drivers/dma/edma.c:16:
   arch/powerpc/include/asm/bitops.h:75:14: note: previous definition of 'set_bits' was here
    DEFINE_BITOP(set_bits, or, "")
                 ^
   arch/powerpc/include/asm/bitops.h:58:24: note: in definition of macro 'DEFINE_BITOP'
    static __inline__ void fn(unsigned long mask, \
                           ^~
>> drivers/dma/edma.c:421:20: error: conflicting types for 'clear_bits'
    static inline void clear_bits(int offset, int len, unsigned long *p)
                       ^~~~~~~~~~
   In file included from include/linux/bitops.h:36:0,
                    from include/linux/kernel.h:10,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/dmaengine.h:20,
                    from drivers/dma/edma.c:16:
   arch/powerpc/include/asm/bitops.h:76:14: note: previous definition of 'clear_bits' was here
    DEFINE_BITOP(clear_bits, andc, "")
                 ^
   arch/powerpc/include/asm/bitops.h:58:24: note: in definition of macro 'DEFINE_BITOP'
    static __inline__ void fn(unsigned long mask, \
                           ^~

vim +/set_bits +415 drivers/dma/edma.c

d9c345d1 Peter Ujfalusi 2015-10-16  409  static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
2b6b3b74 Peter Ujfalusi 2015-10-14  410  				 unsigned or)
2b6b3b74 Peter Ujfalusi 2015-10-14  411  {
2b6b3b74 Peter Ujfalusi 2015-10-14  412  	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
2b6b3b74 Peter Ujfalusi 2015-10-14  413  }
2b6b3b74 Peter Ujfalusi 2015-10-14  414  
2b6b3b74 Peter Ujfalusi 2015-10-14 @415  static inline void set_bits(int offset, int len, unsigned long *p)
2b6b3b74 Peter Ujfalusi 2015-10-14  416  {
2b6b3b74 Peter Ujfalusi 2015-10-14  417  	for (; len > 0; len--)
2b6b3b74 Peter Ujfalusi 2015-10-14  418  		set_bit(offset + (len - 1), p);
2b6b3b74 Peter Ujfalusi 2015-10-14  419  }
2b6b3b74 Peter Ujfalusi 2015-10-14  420  
2b6b3b74 Peter Ujfalusi 2015-10-14 @421  static inline void clear_bits(int offset, int len, unsigned long *p)
2b6b3b74 Peter Ujfalusi 2015-10-14  422  {
2b6b3b74 Peter Ujfalusi 2015-10-14  423  	for (; len > 0; len--)
2b6b3b74 Peter Ujfalusi 2015-10-14  424  		clear_bit(offset + (len - 1), p);

:::::: The code at line 415 was first introduced by commit
:::::: 2b6b3b7420190888793c49e97276e1e73bd7eaed ARM/dmaengine: edma: Merge the two drivers under drivers/dma/

:::::: TO: Peter Ujfalusi <peter.ujfalusi@ti.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/316e4457/attachment-0001.gz>
