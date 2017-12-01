From: lkp@intel.com (kbuild test robot)
Date: Sat, 2 Dec 2017 03:16:39 +0800
Subject: [alsa-devel] [PATCH v5 13/13] ASoC: stm32: add DFSDM DAI support
In-Reply-To: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201712020302.G9eOX3vL%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.15-rc1 next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20171201-215409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: tile-allyesconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All warnings (new ones prefixed by >>):

   sound/soc/stm/stm32_adfsdm.c: In function 'stm32_afsdm_pcm_cb':
>> sound/soc/stm/stm32_adfsdm.c:173:2: warning: format '%d' expects argument of type 'int', but argument 7 has type 'size_t' [-Wformat]

vim +173 sound/soc/stm/stm32_adfsdm.c

   161	
   162	static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
   163	{
   164		struct stm32_adfsdm_priv *priv = private;
   165		struct snd_soc_pcm_runtime *rtd = priv->substream->private_data;
   166		u8 *pcm_buff = priv->pcm_buff;
   167		u8 *src_buff = (u8 *)data;
   168		unsigned int buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
   169		unsigned int period_size = snd_pcm_lib_period_bytes(priv->substream);
   170		unsigned int old_pos = priv->pos;
   171		unsigned int cur_size = size;
   172	
 > 173		dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %d\n",
   174			__func__, &pcm_buff[priv->pos], priv->pos, size);
   175	
   176		if ((priv->pos + size) > buff_size) {
   177			memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
   178			cur_size -= buff_size - priv->pos;
   179			priv->pos = 0;
   180		}
   181	
   182		memcpy(&pcm_buff[priv->pos], &src_buff[size - cur_size], cur_size);
   183		priv->pos = (priv->pos + cur_size) % buff_size;
   184	
   185		if (cur_size != size || (old_pos && (old_pos % period_size < size)))
   186			snd_pcm_period_elapsed(priv->substream);
   187	
   188		return 0;
   189	}
   190	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50547 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171202/a7485b14/attachment-0001.gz>
