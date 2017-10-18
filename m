From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 18 Oct 2017 19:53:31 +0800
Subject: [arm-platforms:irq/irqchip-4.15 13/19]
 drivers//irqchip/irq-gic-v3-its.c:2897:11: error: initialization from
 incompatible pointer type
Message-ID: <201710181928.b2LegJZ2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irqchip-4.15
head:   0beae24927562ef40a444409d2a9a0d162a18ae7
commit: dea1d974b71994af8c3b0d953a07fc49eaee6d10 [13/19] irqchip/gic-v3-its: Workaround HiSilicon Hip07 redistributor addressing
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dea1d974b71994af8c3b0d953a07fc49eaee6d10
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

>> drivers//irqchip/irq-gic-v3-its.c:2897:11: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
      .init = its_enable_quirk_hip07_161600802,
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers//irqchip/irq-gic-v3-its.c:2897:11: note: (near initialization for 'its_quirks[4].init')
   cc1: some warnings being treated as errors

vim +2897 drivers//irqchip/irq-gic-v3-its.c

  2853	
  2854	static const struct gic_quirk its_quirks[] = {
  2855	#ifdef CONFIG_CAVIUM_ERRATUM_22375
  2856		{
  2857			.desc	= "ITS: Cavium errata 22375, 24313",
  2858			.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
  2859			.mask	= 0xffff0fff,
  2860			.init	= its_enable_quirk_cavium_22375,
  2861		},
  2862	#endif
  2863	#ifdef CONFIG_CAVIUM_ERRATUM_23144
  2864		{
  2865			.desc	= "ITS: Cavium erratum 23144",
  2866			.iidr	= 0xa100034c,	/* ThunderX pass 1.x */
  2867			.mask	= 0xffff0fff,
  2868			.init	= its_enable_quirk_cavium_23144,
  2869		},
  2870	#endif
  2871	#ifdef CONFIG_QCOM_QDF2400_ERRATUM_0065
  2872		{
  2873			.desc	= "ITS: QDF2400 erratum 0065",
  2874			.iidr	= 0x00001070, /* QDF2400 ITS rev 1.x */
  2875			.mask	= 0xffffffff,
  2876			.init	= its_enable_quirk_qdf2400_e0065,
  2877		},
  2878	#endif
  2879	#ifdef CONFIG_SOCIONEXT_SYNQUACER_PREITS
  2880		{
  2881			/*
  2882			 * The Socionext Synquacer SoC incorporates ARM's own GIC-500
  2883			 * implementation, but with a 'pre-ITS' added that requires
  2884			 * special handling in software.
  2885			 */
  2886			.desc	= "ITS: Socionext Synquacer pre-ITS",
  2887			.iidr	= 0x0001143b,
  2888			.mask	= 0xffffffff,
  2889			.init	= its_enable_quirk_socionext_synquacer,
  2890		},
  2891	#endif
  2892	#ifdef CONFIG_HISILICON_ERRATUM_161600802
  2893		{
  2894			.desc	= "ITS: Hip07 erratum 161600802",
  2895			.iidr	= 0x00000004,
  2896			.mask	= 0xffffffff,
> 2897			.init	= its_enable_quirk_hip07_161600802,
  2898		},
  2899	#endif
  2900		{
  2901		}
  2902	};
  2903	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36798 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171018/21a3fbc0/attachment-0001.gz>
