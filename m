From: lkp@intel.com (kbuild test robot)
Date: Fri, 29 Jan 2016 17:58:08 +0800
Subject: [PATCH v3] i2c: mt8173: add 4GB mode support in i2c driver.
In-Reply-To: <1454031331-9107-1-git-send-email-liguo.zhang@mediatek.com>
Message-ID: <201601291754.xAwAcKci%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liguo,

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.5-rc1 next-20160129]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Liguo-Zhang/i2c-mt8173-add-4GB-mode-support-in-i2c-driver/20160129-174005
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux i2c/for-next
config: xtensa-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-mt65xx.c: In function 'mtk_i2c_set_4g_mode':
>> drivers/i2c/busses/i2c-mt65xx.c:378:2: warning: left shift count >= width of type
     return (addr & BIT(32)) ? I2C_DMA_4G_MODE : I2C_DMA_CLR_FLAG;
     ^

vim +378 drivers/i2c/busses/i2c-mt65xx.c

   362		if (target_speed > MAX_FS_MODE_SPEED) {
   363			/* Set the high speed mode register */
   364			i2c->timing_reg = I2C_FS_TIME_INIT_VALUE;
   365			i2c->high_speed_reg = I2C_TIME_DEFAULT_VALUE |
   366				(sample_cnt << 12) | (step_cnt << 8);
   367		} else {
   368			i2c->timing_reg = (sample_cnt << 8) | (step_cnt << 0);
   369			/* Disable the high speed transaction */
   370			i2c->high_speed_reg = I2C_TIME_CLR_VALUE;
   371		}
   372	
   373		return 0;
   374	}
   375	
   376	static inline u32 mtk_i2c_set_4g_mode(dma_addr_t addr)
   377	{
 > 378		return (addr & BIT(32)) ? I2C_DMA_4G_MODE : I2C_DMA_CLR_FLAG;
   379	}
   380	
   381	static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
   382				       int num, int left_num)
   383	{
   384		u16 addr_reg;
   385		u16 start_reg;
   386		u16 control_reg;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44066 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160129/4ecb961f/attachment-0001.obj>
