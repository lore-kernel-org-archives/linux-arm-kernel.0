From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 28 Oct 2017 02:20:46 +0800
Subject: [xlnx:master 1076/1076] drivers/edac/synopsys_edac.c:820:54:
 warning: 'col_shift' may be used uninitialized in this function
Message-ID: <201710280244.p2C7rWXq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   a5aa440aa346ae898994f288dc67396485ac61f2
commit: a5aa440aa346ae898994f288dc67396485ac61f2 [1076/1076] edac: synopsys: fix incorrect macro defines
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a5aa440aa346ae898994f288dc67396485ac61f2
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/edac/synopsys_edac.c: In function 'synps_edac_mc_inject_data_error_store':
>> drivers/edac/synopsys_edac.c:820:54: warning: 'col_shift' may be used uninitialized in this function [-Wmaybe-uninitialized]
     int col, row, bank, bankgrp, regval, shift_val = 0, col_shift;
                                                         ^~~~~~~~~

vim +/col_shift +820 drivers/edac/synopsys_edac.c

71fe2847 Naga Sureshkumar Relli 2016-04-01  807  
71fe2847 Naga Sureshkumar Relli 2016-04-01  808  /**
71fe2847 Naga Sureshkumar Relli 2016-04-01  809   * ddr4_poison_setup - update poison registers
71fe2847 Naga Sureshkumar Relli 2016-04-01  810   * @dttype:		Device structure variable
71fe2847 Naga Sureshkumar Relli 2016-04-01  811   * @device_config:	Device configuration
71fe2847 Naga Sureshkumar Relli 2016-04-01  812   * @priv:		Pointer to synps_edac_priv struct
71fe2847 Naga Sureshkumar Relli 2016-04-01  813   *
71fe2847 Naga Sureshkumar Relli 2016-04-01  814   * Update poison registers as per ddr4 mapping
71fe2847 Naga Sureshkumar Relli 2016-04-01  815   * Return: none.
71fe2847 Naga Sureshkumar Relli 2016-04-01  816   */
71fe2847 Naga Sureshkumar Relli 2016-04-01  817  static void ddr4_poison_setup(enum dev_type dttype, int device_config,
71fe2847 Naga Sureshkumar Relli 2016-04-01  818  				struct synps_edac_priv *priv)
71fe2847 Naga Sureshkumar Relli 2016-04-01  819  {
71fe2847 Naga Sureshkumar Relli 2016-04-01 @820  	int col, row, bank, bankgrp, regval, shift_val = 0, col_shift;
71fe2847 Naga Sureshkumar Relli 2016-04-01  821  
71fe2847 Naga Sureshkumar Relli 2016-04-01  822  	/* Check the Configuration of the device */
71fe2847 Naga Sureshkumar Relli 2016-04-01  823  	if (device_config & DDRC_MSTR_DEV_CONFIG_X8_MASK) {
71fe2847 Naga Sureshkumar Relli 2016-04-01  824  		/* For Full Dq bus */
71fe2847 Naga Sureshkumar Relli 2016-04-01  825  		if (dttype == DEV_X8)
71fe2847 Naga Sureshkumar Relli 2016-04-01  826  			shift_val = 0;
71fe2847 Naga Sureshkumar Relli 2016-04-01  827  		/* For Half Dq bus */
71fe2847 Naga Sureshkumar Relli 2016-04-01  828  		else if (dttype == DEV_X4)
71fe2847 Naga Sureshkumar Relli 2016-04-01  829  			shift_val = 1;
71fe2847 Naga Sureshkumar Relli 2016-04-01  830  		col_shift = 0;
71fe2847 Naga Sureshkumar Relli 2016-04-01  831  	} else if (device_config & DDRC_MSTR_DEV_CONFIG_X16_MASK) {
71fe2847 Naga Sureshkumar Relli 2016-04-01  832  		if (dttype == DEV_X8)
71fe2847 Naga Sureshkumar Relli 2016-04-01  833  			shift_val = 1;
71fe2847 Naga Sureshkumar Relli 2016-04-01  834  		else if (dttype == DEV_X4)
71fe2847 Naga Sureshkumar Relli 2016-04-01  835  			shift_val = 2;
71fe2847 Naga Sureshkumar Relli 2016-04-01  836  		col_shift = 1;
71fe2847 Naga Sureshkumar Relli 2016-04-01  837  	}
71fe2847 Naga Sureshkumar Relli 2016-04-01  838  
71fe2847 Naga Sureshkumar Relli 2016-04-01  839  	col = (priv->poison_addr >> (DDR4_COL_SHIFT -
71fe2847 Naga Sureshkumar Relli 2016-04-01  840  				(shift_val - col_shift))) &
71fe2847 Naga Sureshkumar Relli 2016-04-01  841  				DDR4_COL_MASK;
71fe2847 Naga Sureshkumar Relli 2016-04-01  842  	row = priv->poison_addr >> (DDR4_ROW_SHIFT - shift_val);
71fe2847 Naga Sureshkumar Relli 2016-04-01  843  	row &= DDR4_ROW_MASK;
71fe2847 Naga Sureshkumar Relli 2016-04-01  844  	bank = priv->poison_addr >> (DDR4_BANK_SHIFT - shift_val);
71fe2847 Naga Sureshkumar Relli 2016-04-01  845  	bank &= DDR4_BANK_MASK;
71fe2847 Naga Sureshkumar Relli 2016-04-01  846  	bankgrp = (priv->poison_addr >> (DDR4_BANKGRP_SHIFT -
71fe2847 Naga Sureshkumar Relli 2016-04-01  847  				(shift_val - col_shift))) &
71fe2847 Naga Sureshkumar Relli 2016-04-01  848  				DDR4_BANKGRP_MASK;
71fe2847 Naga Sureshkumar Relli 2016-04-01  849  
71fe2847 Naga Sureshkumar Relli 2016-04-01  850  	writel(col, priv->baseaddr + ECC_POISON0_OFST);
71fe2847 Naga Sureshkumar Relli 2016-04-01  851  	regval = (bankgrp << ECC_POISON1_BANKGRP_SHIFT) |
71fe2847 Naga Sureshkumar Relli 2016-04-01  852  		 (bank << ECC_POISON1_BANKNR_SHIFT) | row;
71fe2847 Naga Sureshkumar Relli 2016-04-01  853  	writel(regval, priv->baseaddr + ECC_POISON1_OFST);
71fe2847 Naga Sureshkumar Relli 2016-04-01  854  }
71fe2847 Naga Sureshkumar Relli 2016-04-01  855  

:::::: The code at line 820 was first introduced by commit
:::::: 71fe2847779d339690834a384ea2792d9047ee09 edac: synopsys: Add ecc error injection support

:::::: TO: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59883 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171028/398dcad1/attachment-0001.gz>
