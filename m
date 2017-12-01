From: lkp@intel.com (kbuild test robot)
Date: Fri, 1 Dec 2017 22:41:33 +0800
Subject: [alsa-devel] [PATCH v5 13/13] ASoC: stm32: add DFSDM DAI support
In-Reply-To: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
References: <1511881557-28596-14-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201712012209.tM3mzVo9%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on iio/togreg]
[also build test WARNING on v4.15-rc1 next-20171201]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20171201-215409
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: blackfin-allyesconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:13,
                    from include/linux/clk.h:16,
                    from sound/soc//stm/stm32_adfsdm.c:23:
   sound/soc//stm/stm32_adfsdm.c: In function 'stm32_afsdm_pcm_cb':
>> sound/soc//stm/stm32_adfsdm.c:173:20: warning: format '%d' expects argument of type 'int', but argument 7 has type 'size_t {aka long unsigned int}' [-Wformat=]
     dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %d\n",
                       ^
   include/linux/dynamic_debug.h:134:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> sound/soc//stm/stm32_adfsdm.c:173:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(rtd->dev, "%s: buff_add :%p, pos = %d, size = %d\n",
     ^~~~~~~

vim +/dev_dbg +173 sound/soc//stm/stm32_adfsdm.c

  > 23	#include <linux/clk.h>
    24	#include <linux/module.h>
    25	#include <linux/platform_device.h>
    26	#include <linux/slab.h>
    27	
    28	#include <linux/iio/iio.h>
    29	#include <linux/iio/consumer.h>
    30	#include <linux/iio/adc/stm32-dfsdm-adc.h>
    31	
    32	#include <sound/pcm.h>
    33	#include <sound/soc.h>
    34	
    35	#define STM32_ADFSDM_DRV_NAME "stm32-adfsdm"
    36	
    37	#define DFSDM_MAX_PERIOD_SIZE	(PAGE_SIZE / 2)
    38	#define DFSDM_MAX_PERIODS	6
    39	
    40	struct stm32_adfsdm_priv {
    41		struct snd_soc_dai_driver dai_drv;
    42		struct snd_pcm_substream *substream;
    43		struct device *dev;
    44	
    45		/* IIO */
    46		struct iio_channel *iio_ch;
    47		struct iio_cb_buffer *iio_cb;
    48		bool iio_active;
    49	
    50		/* PCM buffer */
    51		unsigned char *pcm_buff;
    52		unsigned int pos;
    53		bool allocated;
    54	};
    55	
    56	struct stm32_adfsdm_data {
    57		unsigned int rate;	/* SNDRV_PCM_RATE value */
    58		unsigned int freq;	/* frequency in Hz */
    59	};
    60	
    61	static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
    62		.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
    63		    SNDRV_PCM_INFO_PAUSE,
    64		.formats = SNDRV_PCM_FMTBIT_S32_LE,
    65	
    66		.rate_min = 8000,
    67		.rate_max = 32000,
    68	
    69		.channels_min = 1,
    70		.channels_max = 1,
    71	
    72		.periods_min = 2,
    73		.periods_max = DFSDM_MAX_PERIODS,
    74	
    75		.period_bytes_max = DFSDM_MAX_PERIOD_SIZE,
    76		.buffer_bytes_max = DFSDM_MAX_PERIODS * DFSDM_MAX_PERIOD_SIZE
    77	};
    78	
    79	static void stm32_adfsdm_shutdown(struct snd_pcm_substream *substream,
    80					  struct snd_soc_dai *dai)
    81	{
    82		struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
    83	
    84		if (priv->iio_active) {
    85			iio_channel_stop_all_cb(priv->iio_cb);
    86			priv->iio_active = false;
    87		}
    88	}
    89	
    90	static int stm32_adfsdm_dai_prepare(struct snd_pcm_substream *substream,
    91					    struct snd_soc_dai *dai)
    92	{
    93		struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
    94		int ret;
    95	
    96		ret = iio_write_channel_attribute(priv->iio_ch,
    97						  substream->runtime->rate, 0,
    98						  IIO_CHAN_INFO_SAMP_FREQ);
    99		if (ret < 0) {
   100			dev_err(dai->dev, "%s: Failed to set %d sampling rate\n",
   101				__func__, substream->runtime->rate);
   102			return ret;
   103		}
   104	
   105		if (!priv->iio_active) {
   106			ret = iio_channel_start_all_cb(priv->iio_cb);
   107			if (!ret)
   108				priv->iio_active = true;
   109			else
   110				dev_err(dai->dev, "%s: IIO channel start failed (%d)\n",
   111					__func__, ret);
   112		}
   113	
   114		return ret;
   115	}
   116	
   117	static int stm32_adfsdm_set_sysclk(struct snd_soc_dai *dai, int clk_id,
   118					   unsigned int freq, int dir)
   119	{
   120		struct stm32_adfsdm_priv *priv = snd_soc_dai_get_drvdata(dai);
   121		ssize_t size;
   122	
   123		dev_dbg(dai->dev, "%s: Enter for freq %d\n", __func__, freq);
   124	
   125		/* Set IIO frequency if CODEC is master as clock comes from SPI_IN*/
   126		if (dir == SND_SOC_CLOCK_IN) {
   127			char str_freq[10];
   128	
   129			snprintf(str_freq, sizeof(str_freq), "%d\n", freq);
   130			size = iio_write_channel_ext_info(priv->iio_ch, "spi_clk_freq",
   131							  str_freq, sizeof(str_freq));
   132			if (size != sizeof(str_freq)) {
   133				dev_err(dai->dev, "%s: Failed to set SPI clock\n",
   134					__func__);
   135				return -EINVAL;
   136			}
   137		}
   138		return 0;
   139	}
   140	
   141	static const struct snd_soc_dai_ops stm32_adfsdm_dai_ops = {
   142		.shutdown = stm32_adfsdm_shutdown,
   143		.prepare = stm32_adfsdm_dai_prepare,
   144		.set_sysclk = stm32_adfsdm_set_sysclk,
   145	};
   146	
   147	static const struct snd_soc_dai_driver stm32_adfsdm_dai = {
   148		.capture = {
   149			    .channels_min = 1,
   150			    .channels_max = 1,
   151			    .formats = SNDRV_PCM_FMTBIT_S32_LE,
   152			    .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
   153				      SNDRV_PCM_RATE_32000),
   154			    },
   155		.ops = &stm32_adfsdm_dai_ops,
   156	};
   157	
   158	static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
   159		.name = "stm32_dfsdm_audio",
   160	};
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
Size: 46104 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171201/04fdb848/attachment-0001.gz>
