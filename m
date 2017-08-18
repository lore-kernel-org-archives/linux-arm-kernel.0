From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 18 Aug 2017 23:21:17 +0800
Subject: [xlnx:master 956/965]
 drivers/media/platform/xilinx/xilinx-sdirxss.c:309:7: warning:
 'forced_mode_mask' may be used uninitialized in this function
Message-ID: <201708182316.wzWrGSDU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   ebbdeb2313158d2b17b196c445f894b5436741c0
commit: c9e6857c552d87452818b51b0cbe7baf40c83c22 [956/965] v4l: xilinx: sdirxss: Add V4L control for Mode detection
config: ia64-allyesconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout c9e6857c552d87452818b51b0cbe7baf40c83c22
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/media/platform/xilinx/xilinx-sdirxss.c: In function 'xsdirxss_s_ctrl':
>> drivers/media/platform/xilinx/xilinx-sdirxss.c:309:7: warning: 'forced_mode_mask' may be used uninitialized in this function [-Wmaybe-uninitialized]
      u32 forced_mode_mask;
          ^~~~~~~~~~~~~~~~

vim +/forced_mode_mask +309 drivers/media/platform/xilinx/xilinx-sdirxss.c

6147feae8 Vishal Sagar 2017-08-16  265  
6147feae8 Vishal Sagar 2017-08-16  266  static int xsdirx_set_modedetect(struct xsdirxss_core *core, u16 mask)
fcdd72979 Vishal Sagar 2017-07-27  267  {
6147feae8 Vishal Sagar 2017-08-16  268  	u32 i, val;
6147feae8 Vishal Sagar 2017-08-16  269  
c9e6857c5 Vishal Sagar 2017-08-16  270  	mask &= XSDIRX_DETECT_ALL_MODES;
6147feae8 Vishal Sagar 2017-08-16  271  	if (!mask) {
6147feae8 Vishal Sagar 2017-08-16  272  		dev_err(core->dev, "Invalid bit mask = 0x%08x\n", mask);
6147feae8 Vishal Sagar 2017-08-16  273  		return -EINVAL;
6147feae8 Vishal Sagar 2017-08-16  274  	}
6147feae8 Vishal Sagar 2017-08-16  275  
6147feae8 Vishal Sagar 2017-08-16  276  	val = xsdirxss_read(core, XSDIRX_MDL_CTRL_REG);
6147feae8 Vishal Sagar 2017-08-16  277  	val &= ~(XSDIRX_MDL_CTRL_MODE_DET_EN_MASK);
6147feae8 Vishal Sagar 2017-08-16  278  	val &= ~(XSDIRX_MDL_CTRL_MODE_AUTO_DET_MASK);
6147feae8 Vishal Sagar 2017-08-16  279  	val &= ~(XSDIRX_MDL_CTRL_FORCED_MODE_MASK);
6147feae8 Vishal Sagar 2017-08-16  280  
6147feae8 Vishal Sagar 2017-08-16  281  	if (hweight16(mask) > 1) {
6147feae8 Vishal Sagar 2017-08-16  282  		/* Multi mode detection as more than 1 bit set in mask */
6147feae8 Vishal Sagar 2017-08-16  283  		dev_dbg(core->dev, "Detect multiple modes\n");
6147feae8 Vishal Sagar 2017-08-16  284  		for (i = 0; i < XSDIRX_MODE_NUM_SUPPORTED; i++) {
6147feae8 Vishal Sagar 2017-08-16  285  			switch (mask & (1 << i)) {
6147feae8 Vishal Sagar 2017-08-16  286  			case BIT(XSDIRX_MODE_SD_OFFSET):
6147feae8 Vishal Sagar 2017-08-16  287  				val |= XSDIRX_MDL_CTRL_MODE_SD_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  288  				break;
6147feae8 Vishal Sagar 2017-08-16  289  			case BIT(XSDIRX_MODE_HD_OFFSET):
6147feae8 Vishal Sagar 2017-08-16  290  				val |= XSDIRX_MDL_CTRL_MODE_HD_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  291  				break;
6147feae8 Vishal Sagar 2017-08-16  292  			case BIT(XSDIRX_MODE_3G_OFFSET):
6147feae8 Vishal Sagar 2017-08-16  293  				val |= XSDIRX_MDL_CTRL_MODE_3G_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  294  				break;
6147feae8 Vishal Sagar 2017-08-16  295  			case BIT(XSDIRX_MODE_6G_OFFSET):
6147feae8 Vishal Sagar 2017-08-16  296  				val |= XSDIRX_MDL_CTRL_MODE_6G_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  297  				break;
6147feae8 Vishal Sagar 2017-08-16  298  			case BIT(XSDIRX_MODE_12GI_OFFSET):
6147feae8 Vishal Sagar 2017-08-16  299  				val |= XSDIRX_MDL_CTRL_MODE_12GI_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  300  				break;
6147feae8 Vishal Sagar 2017-08-16  301  			case BIT(XSDIRX_MODE_12GF_OFFSET):
6147feae8 Vishal Sagar 2017-08-16  302  				val |= XSDIRX_MDL_CTRL_MODE_12GF_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  303  				break;
6147feae8 Vishal Sagar 2017-08-16  304  			}
6147feae8 Vishal Sagar 2017-08-16  305  		}
6147feae8 Vishal Sagar 2017-08-16  306  		val |= XSDIRX_MDL_CTRL_MODE_DET_EN_MASK;
6147feae8 Vishal Sagar 2017-08-16  307  	} else {
6147feae8 Vishal Sagar 2017-08-16  308  		/* Fixed Mode */
6147feae8 Vishal Sagar 2017-08-16 @309  		u32 forced_mode_mask;
6147feae8 Vishal Sagar 2017-08-16  310  
6147feae8 Vishal Sagar 2017-08-16  311  		dev_dbg(core->dev, "Detect fixed mode\n");
6147feae8 Vishal Sagar 2017-08-16  312  
6147feae8 Vishal Sagar 2017-08-16  313  		/* Find offset of first bit set */
6147feae8 Vishal Sagar 2017-08-16  314  		switch (__ffs(mask)) {
6147feae8 Vishal Sagar 2017-08-16  315  		case XSDIRX_MODE_SD_OFFSET:
6147feae8 Vishal Sagar 2017-08-16  316  			forced_mode_mask = XSDIRX_MODE_SD_MASK;
6147feae8 Vishal Sagar 2017-08-16  317  			break;
6147feae8 Vishal Sagar 2017-08-16  318  		case XSDIRX_MODE_HD_OFFSET:
6147feae8 Vishal Sagar 2017-08-16  319  			forced_mode_mask = XSDIRX_MODE_HD_MASK;
6147feae8 Vishal Sagar 2017-08-16  320  			break;
6147feae8 Vishal Sagar 2017-08-16  321  		case XSDIRX_MODE_3G_OFFSET:
6147feae8 Vishal Sagar 2017-08-16  322  			forced_mode_mask = XSDIRX_MODE_3G_MASK;
6147feae8 Vishal Sagar 2017-08-16  323  			break;
6147feae8 Vishal Sagar 2017-08-16  324  		case XSDIRX_MODE_6G_OFFSET:
6147feae8 Vishal Sagar 2017-08-16  325  			forced_mode_mask = XSDIRX_MODE_6G_MASK;
6147feae8 Vishal Sagar 2017-08-16  326  			break;
6147feae8 Vishal Sagar 2017-08-16  327  		case XSDIRX_MODE_12GI_OFFSET:
6147feae8 Vishal Sagar 2017-08-16  328  			forced_mode_mask = XSDIRX_MODE_12GI_MASK;
6147feae8 Vishal Sagar 2017-08-16  329  			break;
6147feae8 Vishal Sagar 2017-08-16  330  		case XSDIRX_MODE_12GF_OFFSET:
6147feae8 Vishal Sagar 2017-08-16  331  			forced_mode_mask = XSDIRX_MODE_12GF_MASK;
6147feae8 Vishal Sagar 2017-08-16  332  			break;
6147feae8 Vishal Sagar 2017-08-16  333  		}
6147feae8 Vishal Sagar 2017-08-16  334  		dev_dbg(core->dev, "Forced Mode Mask : 0x%x\n",
6147feae8 Vishal Sagar 2017-08-16  335  			forced_mode_mask);
6147feae8 Vishal Sagar 2017-08-16  336  		val |= forced_mode_mask << XSDIRX_MDL_CTRL_FORCED_MODE_OFFSET;
6147feae8 Vishal Sagar 2017-08-16  337  	}
fcdd72979 Vishal Sagar 2017-07-27  338  
6147feae8 Vishal Sagar 2017-08-16  339  	dev_dbg(core->dev, "Modes to be detected : sdi ctrl reg = 0x%08x\n",
6147feae8 Vishal Sagar 2017-08-16  340  		val);
fcdd72979 Vishal Sagar 2017-07-27  341  	xsdirxss_write(core, XSDIRX_MDL_CTRL_REG, val);
6147feae8 Vishal Sagar 2017-08-16  342  
6147feae8 Vishal Sagar 2017-08-16  343  	return 0;
fcdd72979 Vishal Sagar 2017-07-27  344  }
fcdd72979 Vishal Sagar 2017-07-27  345  

:::::: The code at line 309 was first introduced by commit
:::::: 6147feae8ea0468801bfddc2f21bffda923d747d v4l: xilinx: sdirxss: Streaming is enabled only on video lock

:::::: TO: Vishal Sagar <vishal.sagar@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170818/80eb3f30/attachment-0001.gz>
