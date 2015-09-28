From: lkp@intel.com (kbuild test robot)
Date: Mon, 28 Sep 2015 16:50:08 +0800
Subject: [PATCH 1/1] ASoC: dwc: fix dma stop transferring issue
In-Reply-To: <035401d0f9b7$faa800b0$eff80210$@tangramtek.com>
Message-ID: <201509281643.vPLojmpB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi yitian,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: i386-randconfig-r0-201539 (attached as .config)
reproduce:
  git checkout 3488a5ee9b79e2ced9fa43b78c9c5d0aa7e052f9
  # save the attached .config to linux build tree
  make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   sound/soc/dwc/designware_i2s.c: In function 'i2s_start':
>> sound/soc/dwc/designware_i2s.c:148:8: error: 'i' undeclared (first use in this function)
      for (i = 0; i < 4; i++) {
           ^
   sound/soc/dwc/designware_i2s.c:148:8: note: each undeclared identifier is reported only once for each function it appears in
>> sound/soc/dwc/designware_i2s.c:149:4: error: 'irq' undeclared (first use in this function)
       irq = i2s_read_reg(dev->i2s_base, IMR(i));
       ^

vim +/i +148 sound/soc/dwc/designware_i2s.c

   142			      struct snd_pcm_substream *substream)
   143	{
   144	
   145		i2s_write_reg(dev->i2s_base, IER, 1);
   146	
   147		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 > 148			for (i = 0; i < 4; i++) {
 > 149				irq = i2s_read_reg(dev->i2s_base, IMR(i));
   150				i2s_write_reg(dev->i2s_base, IMR(i), irq & ~0x30);
   151			}
   152			i2s_write_reg(dev->i2s_base, ITER, 1);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24380 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150928/887c1234/attachment-0001.obj>
