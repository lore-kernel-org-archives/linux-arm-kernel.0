From: lkp@intel.com (kbuild test robot)
Date: Wed, 14 Mar 2018 17:06:23 +0800
Subject: [RESEND PATCH v1 5/6] i2c: i2c-stm32f7: Add DMA support
In-Reply-To: <1520852023-27083-6-git-send-email-pierre-yves.mordret@st.com>
References: <1520852023-27083-6-git-send-email-pierre-yves.mordret@st.com>
Message-ID: <201803141720.ft3WbBi6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pierre-Yves,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180314]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Pierre-Yves-MORDRET/Add-different-features-for-I2C/20180313-193102
config: m32r-allmodconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All warnings (new ones prefixed by >>):

   In file included from arch/m32r/include/uapi/asm/byteorder.h:8:0,
                    from arch/m32r/include/asm/bitops.h:22,
                    from include/linux/bitops.h:38,
                    from include/linux/kernel.h:11,
                    from include/linux/clk.h:16,
                    from drivers/i2c/busses/i2c-stm32f7.c:17:
   include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
    #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
     ^~~~~~~
   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:14,
                    from include/linux/clk.h:16,
                    from drivers/i2c/busses/i2c-stm32f7.c:17:
   drivers/i2c/busses/i2c-stm32f7.c: In function 'stm32f7_i2c_isr_event_thread':
>> drivers/i2c/busses/i2c-stm32f7.c:1446:24: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
     dev_dbg(i2c_dev->dev, "master evt irq (status=0x%08x, cr1=0x%08x)\n",
                           ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/i2c/busses/i2c-stm32f7.c:1446:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(i2c_dev->dev, "master evt irq (status=0x%08x, cr1=0x%08x)\n",
     ^~~~~~~

vim +1446 drivers/i2c/busses/i2c-stm32f7.c

  1423	
  1424	static irqreturn_t stm32f7_i2c_isr_event_thread(int irq, void *data)
  1425	{
  1426		struct stm32f7_i2c_dev *i2c_dev = data;
  1427		struct stm32f7_i2c_msg *f7_msg = &i2c_dev->f7_msg;
  1428		struct stm32_i2c_dma *dma = i2c_dev->dma;
  1429		u32 status;
  1430		int ret;
  1431	
  1432		/*
  1433		 * Wait for dma transfer completion before sending next message or
  1434		 * notity the end of xfer to the client
  1435		 */
  1436		ret = wait_for_completion_timeout(&i2c_dev->dma->dma_complete, HZ);
  1437		if (!ret) {
  1438			dev_dbg(i2c_dev->dev, "<%s>: Timed out\n", __func__);
  1439			stm32f7_i2c_disable_dma_req(i2c_dev);
  1440			dmaengine_terminate_all(dma->chan_using);
  1441			f7_msg->result = -ETIMEDOUT;
  1442		}
  1443	
  1444		status = readl_relaxed(i2c_dev->base + STM32F7_I2C_ISR);
  1445	
> 1446		dev_dbg(i2c_dev->dev, "master evt irq (status=0x%08x, cr1=0x%08x)\n",
  1447			status, readl_relaxed(i2c_dev->base + STM32F7_I2C_CR1));
  1448		if (status & STM32F7_I2C_ISR_TC) {
  1449			if (f7_msg->smbus) {
  1450				stm32f7_i2c_smbus_rep_start(i2c_dev);
  1451			} else {
  1452				i2c_dev->msg_id++;
  1453				i2c_dev->msg++;
  1454				stm32f7_i2c_xfer_msg(i2c_dev, i2c_dev->msg);
  1455			}
  1456		} else {
  1457			i2c_dev->master_mode = false;
  1458			complete(&i2c_dev->complete);
  1459		}
  1460	
  1461		return IRQ_HANDLED;
  1462	}
  1463	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44993 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180314/d4c543c7/attachment-0001.gz>
