From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 3 Jan 2017 19:02:35 +0800
Subject: [arm-platforms:kvm-arm64/gicv4-wip 9/39]
 include/linux/irqchip/arm-gic-v3.h:245:32: warning: left shift count >=
 width of type
Message-ID: <201701031932.QueCJqof%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/gicv4-wip
head:   ff003d7a3416337cc037320bfd175aaee79f05ae
commit: c02d4af9238775c4d1cfed01cf2072bc60d8c1ed [9/39] irqchip/gic-v3-its: Add probing for VLPI properties
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c02d4af9238775c4d1cfed01cf2072bc60d8c1ed
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-gic-v3-its.c:38:0:
   drivers/irqchip/irq-gic-v3-its.c: In function 'its_probe_one':
>> include/linux/irqchip/arm-gic-v3.h:245:32: warning: left shift count >= width of type [-Wshift-count-overflow]
    #define GITS_TYPER_VMOVP  (1UL << 37)
                                   ^
>> drivers/irqchip/irq-gic-v3-its.c:1706:30: note: in expansion of macro 'GITS_TYPER_VMOVP'
     if (its->is_v4 && !(typer & GITS_TYPER_VMOVP)) {
                                 ^~~~~~~~~~~~~~~~

vim +245 include/linux/irqchip/arm-gic-v3.h

   229	#define GITS_CIDR3			0xfffc
   230	
   231	#define GITS_TRANSLATER			0x10040
   232	
   233	#define GITS_CTLR_ENABLE		(1U << 0)
   234	#define	GITS_CTLR_ITS_NUMBER_SHIFT	4
   235	#define	GITS_CTLR_ITS_NUMBER		(0xFU << GITS_CTLR_ITS_NUMBER_SHIFT)
   236	#define GITS_CTLR_QUIESCENT		(1U << 31)
   237	
   238	#define GITS_TYPER_PLPIS		(1UL << 0)
   239	#define GITS_TYPER_VLPIS		(1UL << 1)
   240	#define GITS_TYPER_IDBITS_SHIFT		8
   241	#define GITS_TYPER_DEVBITS_SHIFT	13
   242	#define GITS_TYPER_DEVBITS(r)		((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
   243	#define GITS_TYPER_PTA			(1UL << 19)
   244	#define GITS_TYPER_HWCOLLCNT_SHIFT	24
 > 245	#define GITS_TYPER_VMOVP		(1UL << 37)
   246	
   247	#define GITS_CBASER_VALID			(1ULL << 63)
   248	#define GITS_CBASER_SHAREABILITY_SHIFT		(10)
   249	#define GITS_CBASER_INNER_CACHEABILITY_SHIFT	(59)
   250	#define GITS_CBASER_OUTER_CACHEABILITY_SHIFT	(53)
   251	#define GITS_CBASER_SHAREABILITY_MASK					\
   252		GIC_BASER_SHAREABILITY(GITS_CBASER, SHAREABILITY_MASK)
   253	#define GITS_CBASER_INNER_CACHEABILITY_MASK				\

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 39862 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170103/e35a6692/attachment-0001.gz>
