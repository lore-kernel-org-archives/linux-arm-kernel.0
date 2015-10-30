From: lkp@intel.com (kbuild test robot)
Date: Sat, 31 Oct 2015 03:59:46 +0800
Subject: [PATCH 2/2] sound: soc: Add Cygnus audio driver
In-Reply-To: <1446231297-10648-3-git-send-email-ssimran@broadcom.com>
Message-ID: <201510310354.D5Au86C0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simran,

[auto build test WARNING on asoc/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Simran-Rai/Add-audio-support-for-Broadcom-Cygnus-SoC/20151031-025721
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/wait.h:6,
                    from include/linux/fs.h:5,
                    from include/linux/debugfs.h:18,
                    from sound/soc/bcm/cygnus-pcm.c:13:
   sound/soc/bcm/cygnus-pcm.c: In function 'cygnus_pcm_preallocate_dma_buffer':
>> sound/soc/bcm/cygnus-pcm.c:785:29: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(rtd->cpu_dai->dev, "%s: size 0x%x @ 0x%p\n",
                                ^
   include/linux/dynamic_debug.h:86:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^
>> sound/soc/bcm/cygnus-pcm.c:785:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(rtd->cpu_dai->dev, "%s: size 0x%x @ 0x%p\n",
     ^

vim +785 sound/soc/bcm/cygnus-pcm.c

   769	
   770	static int cygnus_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream)
   771	{
   772		struct snd_pcm_substream *substream = pcm->streams[stream].substream;
   773		struct snd_soc_pcm_runtime *rtd = substream->private_data;
   774		struct snd_dma_buffer *buf = &substream->dma_buffer;
   775		size_t size;
   776	
   777		size = cygnus_pcm_hw.buffer_bytes_max;
   778	
   779		buf->dev.type = SNDRV_DMA_TYPE_DEV;
   780		buf->dev.dev = pcm->card->dev;
   781		buf->private_data = NULL;
   782		buf->area = dma_alloc_coherent(pcm->card->dev, size,
   783				&buf->addr, GFP_KERNEL);
   784	
 > 785		dev_dbg(rtd->cpu_dai->dev, "%s: size 0x%x @ 0x%p\n",
   786					__func__, size, buf->area);
   787	
   788		if (!buf->area) {
   789			dev_err(rtd->cpu_dai->dev, "%s: dma_alloc failed\n", __func__);
   790			return -ENOMEM;
   791		}
   792		buf->bytes = size;
   793	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50151 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151031/b8b6b49f/attachment-0001.obj>
