From: lkp@intel.com (kbuild test robot)
Date: Thu, 25 Feb 2016 17:10:18 +0800
Subject: [PATCH] i2c: mediatek: i2c multi transfer optimization
In-Reply-To: <1456358467-529-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <201602251730.JTaXPXHL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liguo,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on next-20160224]
[cannot apply to v4.5-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Liguo-Zhang/i2c-mediatek-i2c-multi-transfer-optimization/20160225-160535
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-mt65xx.c: In function 'mtk_i2c_transfer':
>> drivers/i2c/busses/i2c-mt65xx.c:556:6: warning: unused variable 'left_num' [-Wunused-variable]
     int left_num = num;
         ^

vim +/left_num +556 drivers/i2c/busses/i2c-mt65xx.c

173b77e8d Liguo Zhang 2015-11-09  540  	if (!i2c->auto_restart) {
b2ed11e22 Eddie Huang 2015-05-21  541  		start_reg = I2C_TRANSAC_START;
b2ed11e22 Eddie Huang 2015-05-21  542  	} else {
b2ed11e22 Eddie Huang 2015-05-21  543  		start_reg = I2C_TRANSAC_START | I2C_RS_MUL_TRIG;
b2ed11e22 Eddie Huang 2015-05-21  544  		if (left_num >= 1)
b2ed11e22 Eddie Huang 2015-05-21  545  			start_reg |= I2C_RS_MUL_CNFG;
b2ed11e22 Eddie Huang 2015-05-21  546  	}
b2ed11e22 Eddie Huang 2015-05-21  547  	writew(start_reg, i2c->base + OFFSET_START);
ce38815d3 Xudong Chen 2015-05-21  548  
ce38815d3 Xudong Chen 2015-05-21  549  	return 0;
ce38815d3 Xudong Chen 2015-05-21  550  }
ce38815d3 Xudong Chen 2015-05-21  551  
ce38815d3 Xudong Chen 2015-05-21  552  static int mtk_i2c_transfer(struct i2c_adapter *adap,
ce38815d3 Xudong Chen 2015-05-21  553  			    struct i2c_msg msgs[], int num)
ce38815d3 Xudong Chen 2015-05-21  554  {
ce38815d3 Xudong Chen 2015-05-21  555  	int ret;
ce38815d3 Xudong Chen 2015-05-21 @556  	int left_num = num;
ce38815d3 Xudong Chen 2015-05-21  557  	struct mtk_i2c *i2c = i2c_get_adapdata(adap);
cc7e965fd Liguo Zhang 2016-02-25  558  	struct mtk_i2c_transaction *i2c_transac = &i2c->transac;
cc7e965fd Liguo Zhang 2016-02-25  559  
cc7e965fd Liguo Zhang 2016-02-25  560  	i2c_transac->num = num;
cc7e965fd Liguo Zhang 2016-02-25  561  	i2c_transac->index = 0;
cc7e965fd Liguo Zhang 2016-02-25  562  	i2c_transac->msgs = msgs;
cc7e965fd Liguo Zhang 2016-02-25  563  	i2c_transac->result = 0;
cc7e965fd Liguo Zhang 2016-02-25  564  

:::::: The code at line 556 was first introduced by commit
:::::: ce38815d39eac9c73d37dd4b0039c87f15dcbe18 I2C: mediatek: Add driver for MediaTek I2C controller

:::::: TO: Xudong Chen <xudong.chen@mediatek.com>
:::::: CC: Wolfram Sang <wsa@the-dreams.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53458 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160225/63b14e49/attachment-0001.obj>
