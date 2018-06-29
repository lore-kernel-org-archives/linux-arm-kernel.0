From: lkp@intel.com (kbuild test robot)
Date: Sat, 30 Jun 2018 06:22:16 +0800
Subject: [rjarzmik:pxa/for-next 17/17] sound/arm/pxa2xx-pcm-lib.c:128:51:
 sparse: call with no type!
Message-ID: <201806300612.SzBlvRq2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux pxa/for-next
head:   0d0b16b8e008825834684163799ab944920aabce
commit: 0d0b16b8e008825834684163799ab944920aabce [17/17] dmaengine: pxa: make the filter function internal
reproduce:
        # apt-get install sparse
        git checkout 0d0b16b8e008825834684163799ab944920aabce
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/arm/pxa2xx-pcm-lib.c:129:41: sparse: undefined identifier 'pxad_filter_fn'
>> sound/arm/pxa2xx-pcm-lib.c:128:51: sparse: call with no type!
   sound/arm/pxa2xx-pcm-lib.c: In function '__pxa2xx_pcm_open':
   sound/arm/pxa2xx-pcm-lib.c:129:6: error: 'pxad_filter_fn' undeclared (first use in this function); did you mean 'dma_filter_fn'?
         pxad_filter_fn,
         ^~~~~~~~~~~~~~
         dma_filter_fn
   sound/arm/pxa2xx-pcm-lib.c:129:6: note: each undeclared identifier is reported only once for each function it appears in
   sound/arm/pxa2xx-pcm-lib.c:131:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +128 sound/arm/pxa2xx-pcm-lib.c

a6d77317 Dmitry Eremin-Solenikov 2008-09-10   94  
a6d77317 Dmitry Eremin-Solenikov 2008-09-10   95  int __pxa2xx_pcm_open(struct snd_pcm_substream *substream)
a6d77317 Dmitry Eremin-Solenikov 2008-09-10   96  {
58ceb57e Daniel Mack             2015-09-30   97  	struct snd_soc_pcm_runtime *rtd = substream->private_data;
a6d77317 Dmitry Eremin-Solenikov 2008-09-10   98  	struct snd_pcm_runtime *runtime = substream->runtime;
58ceb57e Daniel Mack             2015-09-30   99  	struct snd_dmaengine_dai_dma_data *dma_params;
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  100  	int ret;
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  101  
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  102  	runtime->hw = pxa2xx_pcm_hardware;
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  103  
58ceb57e Daniel Mack             2015-09-30  104  	dma_params = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
58ceb57e Daniel Mack             2015-09-30  105  	if (!dma_params)
58ceb57e Daniel Mack             2015-09-30  106  		return 0;
58ceb57e Daniel Mack             2015-09-30  107  
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  108  	/*
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  109  	 * For mysterious reasons (and despite what the manual says)
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  110  	 * playback samples are lost if the DMA count is not a multiple
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  111  	 * of the DMA burst size.  Let's add a rule to enforce that.
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  112  	 */
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  113  	ret = snd_pcm_hw_constraint_step(runtime, 0,
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  114  		SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 32);
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  115  	if (ret)
58ceb57e Daniel Mack             2015-09-30  116  		return ret;
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  117  
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  118  	ret = snd_pcm_hw_constraint_step(runtime, 0,
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  119  		SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 32);
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  120  	if (ret)
58ceb57e Daniel Mack             2015-09-30  121  		return ret;
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  122  
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  123  	ret = snd_pcm_hw_constraint_integer(runtime,
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  124  					    SNDRV_PCM_HW_PARAM_PERIODS);
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  125  	if (ret < 0)
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  126  		return ret;
58ceb57e Daniel Mack             2015-09-30  127  
58ceb57e Daniel Mack             2015-09-30 @128  	return snd_dmaengine_pcm_open_request_chan(substream,
58ceb57e Daniel Mack             2015-09-30 @129  					pxad_filter_fn,
58ceb57e Daniel Mack             2015-09-30  130  					dma_params->filter_data);
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  131  }
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  132  EXPORT_SYMBOL(__pxa2xx_pcm_open);
a6d77317 Dmitry Eremin-Solenikov 2008-09-10  133  

:::::: The code at line 128 was first introduced by commit
:::::: 58ceb57ec1be928bec2faeca11fe0752f930669d ASoC: pxa: pxa-pcm-lib: switch over to snd-soc-dmaengine-pcm

:::::: TO: Daniel Mack <zonque@gmail.com>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
