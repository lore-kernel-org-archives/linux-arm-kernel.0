From: lkp@intel.com (kbuild test robot)
Date: Mon, 9 Nov 2015 03:13:23 +0800
Subject: [PATCH V3 4/4] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <1446958380-23298-5-git-send-email-okaya@codeaurora.org>
Message-ID: <201511090323.GmbQltpW%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

[auto build test WARNING on: robh/for-next]
[also build test WARNING on: v4.3 next-20151106]

url:    https://github.com/0day-ci/linux/commits/Sinan-Kaya/ma-add-Qualcomm-Technologies-HIDMA-driver/20151108-125824
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: mn10300-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:17,
                    from include/linux/dmaengine.h:20,
                    from drivers/dma/qcom/hidma.c:45:
   drivers/dma/qcom/hidma.c: In function 'hidma_prep_dma_memcpy':
   include/linux/dynamic_debug.h:64:16: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1171:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
>> drivers/dma/qcom/hidma.c:391:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(mdma->ddev.dev,
     ^

vim +/dev_dbg +391 drivers/dma/qcom/hidma.c

   375	
   376		mchan->allocated = 0;
   377		spin_unlock_irqrestore(&mchan->lock, irqflags);
   378		dev_dbg(mdma->ddev.dev, "freed channel for %u\n", mchan->dma_sig);
   379	}
   380	
   381	
   382	static struct dma_async_tx_descriptor *
   383	hidma_prep_dma_memcpy(struct dma_chan *dmach, dma_addr_t dma_dest,
   384				dma_addr_t dma_src, size_t len, unsigned long flags)
   385	{
   386		struct hidma_chan *mchan = to_hidma_chan(dmach);
   387		struct hidma_desc *mdesc = NULL;
   388		struct hidma_dev *mdma = mchan->dmadev;
   389		unsigned long irqflags;
   390	
 > 391		dev_dbg(mdma->ddev.dev,
   392			"memcpy: chan:%p dest:%pad src:%pad len:%zu\n", mchan,
   393			&dma_dest, &dma_src, len);
   394	
   395		/* Get free descriptor */
   396		spin_lock_irqsave(&mchan->lock, irqflags);
   397		if (!list_empty(&mchan->free)) {
   398			mdesc = list_first_entry(&mchan->free, struct hidma_desc,
   399						node);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36268 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151109/27ad99a9/attachment-0001.obj>
