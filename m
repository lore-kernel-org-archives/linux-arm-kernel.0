From: lkp@intel.com (kbuild test robot)
Date: Thu, 16 Feb 2017 20:44:48 +0800
Subject: [PATCH 2/4] dmaengine: mtk_uart_dma: add Mediatek uart DMA support
In-Reply-To: <1487243251-964-3-git-send-email-long.cheng@mediatek.com>
Message-ID: <201702162047.nlCqKtwT%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Long,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.10-rc8 next-20170216]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Long-Cheng/add-uart-DMA-function/20170216-200846
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All warnings (new ones prefixed by >>):

   drivers/dma/mtk_uart_dma.c: In function 'mtk_dma_tx_write':
>> drivers/dma/mtk_uart_dma.c:230:37: warning: comparison of constant '1' with boolean expression is always false [-Wbool-compare]
     if (atomic_inc_and_test(&c->entry) > 1) {
                                        ^

vim +/1 +230 drivers/dma/mtk_uart_dma.c

   214			if (atomic_dec_and_test(&c->loopcnt))
   215				complete(&c->done);
   216		}
   217	}
   218	
   219	static int mtk_dma_tx_write(struct dma_chan *chan)
   220	{
   221		struct mtk_chan *c = to_mtk_dma_chan(chan);
   222		struct mtk_dmadev *mtkd = to_mtk_dma_dev(chan->device);
   223		struct timespec a, b;
   224		int txcount = c->remain_size;
   225		unsigned int tx_size = c->cfg.dst_addr_width*1024;
   226		unsigned int len, left;
   227		unsigned int wpt;
   228		ktime_t begin, end;
   229	
 > 230		if (atomic_inc_and_test(&c->entry) > 1) {
   231			if (vchan_issue_pending(&c->vc) && !c->desc) {
   232				spin_lock(&mtkd->lock);
   233				list_add_tail(&c->node, &mtkd->pending);
   234				spin_unlock(&mtkd->lock);
   235				tasklet_schedule(&mtkd->task);
   236			}
   237		} else {
   238			while (mtk_dma_chan_read(c, VFF_LEFT_SIZE) >= c->trig) {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45853 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170216/e910819e/attachment-0001.gz>
