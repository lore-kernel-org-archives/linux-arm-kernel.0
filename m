From: lkp@intel.com (kbuild test robot)
Date: Wed, 8 Jun 2016 01:20:48 +0800
Subject: [PATCH v5 02/18] remoteproc: st_slim_rproc: add a slimcore rproc
 driver
In-Reply-To: <1465316352-20691-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <201606080142.ujZMSAIX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.7-rc2 next-20160607]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160608-002710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/remoteproc/st_slim_rproc.c: In function 'slim_rproc_start':
>> drivers/remoteproc/st_slim_rproc.c:137:9: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     writel(~0UL, slim_rproc->peri + SLIM_INT_CLR_OFST);
            ^
   drivers/remoteproc/st_slim_rproc.c:138:9: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     writel(~0UL, slim_rproc->peri + SLIM_CMD_CLR_OFST);
            ^
   drivers/remoteproc/st_slim_rproc.c:141:9: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     writel(~0UL, slim_rproc->peri + SLIM_INT_MASK_OFST);
            ^
   drivers/remoteproc/st_slim_rproc.c:142:9: warning: large integer implicitly truncated to unsigned type [-Woverflow]
     writel(~0UL, slim_rproc->peri + SLIM_CMD_MASK_OFST);
            ^

vim +137 drivers/remoteproc/st_slim_rproc.c

   121			dev_err(dev, "Failed to enable clocks\n");
   122			goto err_clk;
   123		}
   124	
   125		/* disable CPU pipeline clock & reset cpu pipeline */
   126		val = SLIM_CLK_GATE_DIS | SLIM_CLK_GATE_RESET;
   127		writel(val, slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
   128	
   129		/* disable SLIM core STBus sync */
   130		writel(SLIM_STBUS_SYNC_DIS, slim_rproc->peri + SLIM_STBUS_SYNC_OFST);
   131	
   132		/* enable cpu pipeline clock */
   133		writel(!SLIM_CLK_GATE_DIS,
   134			slim_rproc->slimcore + SLIM_CLK_GATE_OFST);
   135	
   136		/* clear int & cmd mailbox */
 > 137		writel(~0UL, slim_rproc->peri + SLIM_INT_CLR_OFST);
   138		writel(~0UL, slim_rproc->peri + SLIM_CMD_CLR_OFST);
   139	
   140		/* enable all channels cmd & int */
   141		writel(~0UL, slim_rproc->peri + SLIM_INT_MASK_OFST);
   142		writel(~0UL, slim_rproc->peri + SLIM_CMD_MASK_OFST);
   143	
   144		/* enable cpu */
   145		writel(SLIM_EN_RUN, slim_rproc->slimcore + SLIM_EN_OFST);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54766 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160608/f2d860ee/attachment-0001.obj>
