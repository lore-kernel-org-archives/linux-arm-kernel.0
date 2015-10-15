From: lkp@intel.com (kbuild test robot)
Date: Thu, 15 Oct 2015 11:20:02 +0800
Subject: [PATCH v6 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <1444873008-2589-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <201510151152.NmZ8Lk6V%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yiwei,

[auto build test ERROR on rockchip/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Shawn-Lin/Fix-broken-DMAFLUSHP-on-Rockchips-platform/20151015-094613
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   sound/soc/rockchip/rockchip_i2s.c:467:13: sparse: undefined identifier 'snd_dmaengine_pcm_get_caps'
   sound/soc/rockchip/rockchip_i2s.c:468:29: sparse: expected structure or union
   sound/soc/rockchip/rockchip_i2s.c: In function 'rockchip_i2s_probe':
>> sound/soc/rockchip/rockchip_i2s.c:467:6: error: implicit declaration of function 'snd_dmaengine_pcm_get_caps' [-Werror=implicit-function-declaration]
     if (snd_dmaengine_pcm_get_caps(&pdev->dev, &dma_caps) == 0) {
         ^
>> sound/soc/rockchip/rockchip_i2s.c:468:15: error: request for member 'max_burst' in something not a structure or union
      if (dma_caps.max_burst > 4) {
                  ^
   cc1: some warnings being treated as errors

vim +/snd_dmaengine_pcm_get_caps +467 sound/soc/rockchip/rockchip_i2s.c

   461		i2s->playback_dma_data.addr = res->start + I2S_TXDR;
   462		i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   463	
   464		i2s->capture_dma_data.addr = res->start + I2S_RXDR;
   465		i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
   466	
 > 467		if (snd_dmaengine_pcm_get_caps(&pdev->dev, &dma_caps) == 0) {
 > 468			if (dma_caps.max_burst > 4) {
   469				i2s->playback_dma_data.maxburst = 4;
   470				i2s->capture_dma_data.maxburst = 4;
   471			} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 49951 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151015/bec4ebad/attachment-0001.obj>
