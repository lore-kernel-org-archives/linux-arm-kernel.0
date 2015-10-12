From: lkp@intel.com (kbuild test robot)
Date: Mon, 12 Oct 2015 21:26:04 +0800
Subject: [PATCH v3 1/7] mmc: core: move ocr-bit to voltage translation
 into separate function
In-Reply-To: <1444654110-32293-2-git-send-email-heiko@sntech.de>
Message-ID: <201510122154.fUL0WlRf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

[auto build test WARNING on rockchip/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Heiko-Stuebner/mmc-dw_mmc-rockchip-allow-tuning-using-the-clk-phase-api/20151012-205613
config: x86_64-randconfig-x011-10121751 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/core.c:1277:12: warning: 'mmc_ocrbitnum_to_vdd' defined but not used [-Wunused-function]
    static int mmc_ocrbitnum_to_vdd(int vdd_bit, int *min_uV, int *max_uV)
               ^

vim +/mmc_ocrbitnum_to_vdd +1277 drivers/mmc/core/core.c

  1261		while (vdd_max >= vdd_min)
  1262			mask |= 1 << vdd_max--;
  1263	
  1264		return mask;
  1265	}
  1266	EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
  1267	
  1268	/**
  1269	 * mmc_ocrbitnum_to_vdd - Convert a OCR bit number to its voltage
  1270	 * @vdd_bit:	OCR bit number
  1271	 * @min_uV:	minimum voltage value (mV)
  1272	 * @max_uV:	maximum voltage value (mV)
  1273	 *
  1274	 * This function returns the voltage range according to the provided OCR
  1275	 * bit number. If conversion is not possible a negative errno value returned.
  1276	 */
> 1277	static int mmc_ocrbitnum_to_vdd(int vdd_bit, int *min_uV, int *max_uV)
  1278	{
  1279		int		tmp;
  1280	
  1281		if (!vdd_bit)
  1282			return -EINVAL;
  1283	
  1284		/*
  1285		 * REVISIT mmc_vddrange_to_ocrmask() may have set some

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 22001 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151012/794d9a0f/attachment-0001.obj>
