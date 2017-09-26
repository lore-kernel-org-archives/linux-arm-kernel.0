From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Sep 2017 04:11:11 +0800
Subject: [PATCH v3 01/10] dmaengine: sun6i: Correct setting of clock
 autogating register for A83T/H3
In-Reply-To: <8b0e3c36-850c-4211-b647-b03143be67f7@rwthex-w2-a.rwth-ad.de>
Message-ID: <201709270406.p1vlAwqk%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

[auto build test ERROR on next-20170926]
[also build test ERROR on v4.14-rc2]
[cannot apply to linus/master robh/for-next v4.14-rc2 v4.14-rc1 v4.13]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stefan-Br-ns/dmaengine-sun6i-Correct-setting-of-clock-autogating-register-for-A83T-H3/20170927-021533
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

>> drivers//dma/sun6i-dma.c:117:2: error: function declaration isn't a prototype [-Werror=strict-prototypes]
     void (*clock_autogate_enable)();
     ^
>> drivers//dma/sun6i-dma.c:1036:58: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_a23;
                                                             ^
   drivers//dma/sun6i-dma.c:1043:58: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_a23;
                                                             ^
   drivers//dma/sun6i-dma.c:1057:57: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_h3;
                                                            ^
   drivers//dma/sun6i-dma.c:1069:58: error: expected '}' before ';' token
     .clock_autogate_enable = sun6i_enable_clock_autogate_a23;
                                                             ^
   cc1: some warnings being treated as errors

vim +117 drivers//dma/sun6i-dma.c

    95	
    96	/*
    97	 * Hardware channels / ports representation
    98	 *
    99	 * The hardware is used in several SoCs, with differing numbers
   100	 * of channels and endpoints. This structure ties those numbers
   101	 * to a certain compatible string.
   102	 */
   103	struct sun6i_dma_config {
   104		u32 nr_max_channels;
   105		u32 nr_max_requests;
   106		u32 nr_max_vchans;
   107		/*
   108		 * In the datasheets/user manuals of newer Allwinner SoCs, a special
   109		 * bit (bit 2 at register 0x20) is present.
   110		 * It's named "DMA MCLK interface circuit auto gating bit" in the
   111		 * documents, and the footnote of this register says that this bit
   112		 * should be set up when initializing the DMA controller.
   113		 * Allwinner A23/A33 user manuals do not have this bit documented,
   114		 * however these SoCs really have and need this bit, as seen in the
   115		 * BSP kernel source code.
   116		 */
 > 117		void (*clock_autogate_enable)();
   118	};
   119	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51625 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170927/6b5e4b3b/attachment-0001.gz>
