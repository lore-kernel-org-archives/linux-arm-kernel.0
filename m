From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 26 May 2016 06:45:03 +0800
Subject: [rjarzmik:work/ac97 5/7] sound/soc/codecs/wm9705.c:216:10: error:
 'soc_ac97_ops' undeclared
Message-ID: <201605260600.1KJon77G%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux work/ac97
head:   6ebaee487a55e240a38df1557d9e6bde652589d2
commit: 4a88e9608287031bea0c753218347fddf8a26f30 [5/7] ASoC: pxa: switch to new ac97 bus support
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4a88e9608287031bea0c753218347fddf8a26f30
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the rjarzmik/work/ac97 HEAD 6ebaee487a55e240a38df1557d9e6bde652589d2 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   sound/soc/codecs/wm9705.c: In function 'ac97_read':
>> sound/soc/codecs/wm9705.c:216:10: error: 'soc_ac97_ops' undeclared (first use in this function)
      return soc_ac97_ops->read(ac97, reg);
             ^
   sound/soc/codecs/wm9705.c:216:10: note: each undeclared identifier is reported only once for each function it appears in
   sound/soc/codecs/wm9705.c: In function 'ac97_write':
   sound/soc/codecs/wm9705.c:233:2: error: 'soc_ac97_ops' undeclared (first use in this function)
     soc_ac97_ops->write(ac97, reg, val);
     ^
   sound/soc/codecs/wm9705.c: In function 'wm9705_soc_suspend':
   sound/soc/codecs/wm9705.c:304:2: error: 'soc_ac97_ops' undeclared (first use in this function)
     soc_ac97_ops->write(ac97, AC97_POWERDOWN, 0xffff);
     ^
   sound/soc/codecs/wm9705.c: In function 'wm9705_soc_resume':
   sound/soc/codecs/wm9705.c:321:3: error: 'soc_ac97_ops' undeclared (first use in this function)
      soc_ac97_ops->write(ac97, i, cache[i>>1]);
      ^
   sound/soc/codecs/wm9705.c: In function 'wm9705_soc_probe':
>> sound/soc/codecs/wm9705.c:335:9: error: implicit declaration of function 'snd_soc_new_ac97_codec' [-Werror=implicit-function-declaration]
     ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
            ^
>> sound/soc/codecs/wm9705.c:335:7: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
          ^
   sound/soc/codecs/wm9705.c: In function 'wm9705_soc_remove':
>> sound/soc/codecs/wm9705.c:351:2: error: implicit declaration of function 'snd_soc_free_ac97_codec' [-Werror=implicit-function-declaration]
     snd_soc_free_ac97_codec(ac97);
     ^
   cc1: some warnings being treated as errors

vim +/soc_ac97_ops +216 sound/soc/codecs/wm9705.c

2aceefef Ian Molton         2009-01-16  210  	u16 *cache = codec->reg_cache;
2aceefef Ian Molton         2009-01-16  211  
2aceefef Ian Molton         2009-01-16  212  	switch (reg) {
2aceefef Ian Molton         2009-01-16  213  	case AC97_RESET:
2aceefef Ian Molton         2009-01-16  214  	case AC97_VENDOR_ID1:
2aceefef Ian Molton         2009-01-16  215  	case AC97_VENDOR_ID2:
358a8bb5 Lars-Peter Clausen 2014-11-10 @216  		return soc_ac97_ops->read(ac97, reg);
2aceefef Ian Molton         2009-01-16  217  	default:
2aceefef Ian Molton         2009-01-16  218  		reg = reg >> 1;
2aceefef Ian Molton         2009-01-16  219  
2aceefef Ian Molton         2009-01-16  220  		if (reg >= (ARRAY_SIZE(wm9705_reg)))
2aceefef Ian Molton         2009-01-16  221  			return -EIO;
2aceefef Ian Molton         2009-01-16  222  
2aceefef Ian Molton         2009-01-16  223  		return cache[reg];
2aceefef Ian Molton         2009-01-16  224  	}
2aceefef Ian Molton         2009-01-16  225  }
2aceefef Ian Molton         2009-01-16  226  
2aceefef Ian Molton         2009-01-16  227  static int ac97_write(struct snd_soc_codec *codec, unsigned int reg,
2aceefef Ian Molton         2009-01-16  228  	unsigned int val)
2aceefef Ian Molton         2009-01-16  229  {
358a8bb5 Lars-Peter Clausen 2014-11-10  230  	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
2aceefef Ian Molton         2009-01-16  231  	u16 *cache = codec->reg_cache;
2aceefef Ian Molton         2009-01-16  232  
358a8bb5 Lars-Peter Clausen 2014-11-10  233  	soc_ac97_ops->write(ac97, reg, val);
2aceefef Ian Molton         2009-01-16  234  	reg = reg >> 1;
2aceefef Ian Molton         2009-01-16  235  	if (reg < (ARRAY_SIZE(wm9705_reg)))
2aceefef Ian Molton         2009-01-16  236  		cache[reg] = val;
2aceefef Ian Molton         2009-01-16  237  
2aceefef Ian Molton         2009-01-16  238  	return 0;
2aceefef Ian Molton         2009-01-16  239  }
2aceefef Ian Molton         2009-01-16  240  
2aceefef Ian Molton         2009-01-16  241  static int ac97_prepare(struct snd_pcm_substream *substream,
2aceefef Ian Molton         2009-01-16  242  			struct snd_soc_dai *dai)
2aceefef Ian Molton         2009-01-16  243  {
e6968a17 Mark Brown         2012-04-04  244  	struct snd_soc_codec *codec = dai->codec;
2aceefef Ian Molton         2009-01-16  245  	int reg;
2aceefef Ian Molton         2009-01-16  246  	u16 vra;
2aceefef Ian Molton         2009-01-16  247  
2aceefef Ian Molton         2009-01-16  248  	vra = ac97_read(codec, AC97_EXTENDED_STATUS);
2aceefef Ian Molton         2009-01-16  249  	ac97_write(codec, AC97_EXTENDED_STATUS, vra | 0x1);
2aceefef Ian Molton         2009-01-16  250  
2aceefef Ian Molton         2009-01-16  251  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
2aceefef Ian Molton         2009-01-16  252  		reg = AC97_PCM_FRONT_DAC_RATE;
2aceefef Ian Molton         2009-01-16  253  	else
2aceefef Ian Molton         2009-01-16  254  		reg = AC97_PCM_LR_ADC_RATE;
2aceefef Ian Molton         2009-01-16  255  
019ec505 Fabio Estevam      2012-04-10  256  	return ac97_write(codec, reg, substream->runtime->rate);
2aceefef Ian Molton         2009-01-16  257  }
2aceefef Ian Molton         2009-01-16  258  
2aceefef Ian Molton         2009-01-16  259  #define WM9705_AC97_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 | \
2aceefef Ian Molton         2009-01-16  260  			SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 | \
2aceefef Ian Molton         2009-01-16  261  			SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
2aceefef Ian Molton         2009-01-16  262  			SNDRV_PCM_RATE_48000)
2aceefef Ian Molton         2009-01-16  263  
85e7652d Lars-Peter Clausen 2011-11-23  264  static const struct snd_soc_dai_ops wm9705_dai_ops = {
6335d055 Eric Miao          2009-03-03  265  	.prepare	= ac97_prepare,
6335d055 Eric Miao          2009-03-03  266  };
6335d055 Eric Miao          2009-03-03  267  
f0fba2ad Liam Girdwood      2010-03-17  268  static struct snd_soc_dai_driver wm9705_dai[] = {
2aceefef Ian Molton         2009-01-16  269  	{
f0fba2ad Liam Girdwood      2010-03-17  270  		.name = "wm9705-hifi",
2aceefef Ian Molton         2009-01-16  271  		.playback = {
2aceefef Ian Molton         2009-01-16  272  			.stream_name = "HiFi Playback",
2aceefef Ian Molton         2009-01-16  273  			.channels_min = 1,
2aceefef Ian Molton         2009-01-16  274  			.channels_max = 2,
2aceefef Ian Molton         2009-01-16  275  			.rates = WM9705_AC97_RATES,
33f503c9 Mark Brown         2009-05-02  276  			.formats = SND_SOC_STD_AC97_FMTS,
2aceefef Ian Molton         2009-01-16  277  		},
2aceefef Ian Molton         2009-01-16  278  		.capture = {
2aceefef Ian Molton         2009-01-16  279  			.stream_name = "HiFi Capture",
2aceefef Ian Molton         2009-01-16  280  			.channels_min = 1,
2aceefef Ian Molton         2009-01-16  281  			.channels_max = 2,
2aceefef Ian Molton         2009-01-16  282  			.rates = WM9705_AC97_RATES,
33f503c9 Mark Brown         2009-05-02  283  			.formats = SND_SOC_STD_AC97_FMTS,
2aceefef Ian Molton         2009-01-16  284  		},
6335d055 Eric Miao          2009-03-03  285  		.ops = &wm9705_dai_ops,
2aceefef Ian Molton         2009-01-16  286  	},
2aceefef Ian Molton         2009-01-16  287  	{
f0fba2ad Liam Girdwood      2010-03-17  288  		.name = "wm9705-aux",
2aceefef Ian Molton         2009-01-16  289  		.playback = {
2aceefef Ian Molton         2009-01-16  290  			.stream_name = "Aux Playback",
2aceefef Ian Molton         2009-01-16  291  			.channels_min = 1,
2aceefef Ian Molton         2009-01-16  292  			.channels_max = 1,
2aceefef Ian Molton         2009-01-16  293  			.rates = WM9705_AC97_RATES,
2aceefef Ian Molton         2009-01-16  294  			.formats = SNDRV_PCM_FMTBIT_S16_LE,
2aceefef Ian Molton         2009-01-16  295  		},
2aceefef Ian Molton         2009-01-16  296  	}
2aceefef Ian Molton         2009-01-16  297  };
2aceefef Ian Molton         2009-01-16  298  
0a11b168 Mark Brown         2009-04-02  299  #ifdef CONFIG_PM
84b315ee Lars-Peter Clausen 2011-12-02  300  static int wm9705_soc_suspend(struct snd_soc_codec *codec)
0a11b168 Mark Brown         2009-04-02  301  {
358a8bb5 Lars-Peter Clausen 2014-11-10  302  	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
358a8bb5 Lars-Peter Clausen 2014-11-10  303  
358a8bb5 Lars-Peter Clausen 2014-11-10 @304  	soc_ac97_ops->write(ac97, AC97_POWERDOWN, 0xffff);
0a11b168 Mark Brown         2009-04-02  305  
0a11b168 Mark Brown         2009-04-02  306  	return 0;
0a11b168 Mark Brown         2009-04-02  307  }
0a11b168 Mark Brown         2009-04-02  308  
f0fba2ad Liam Girdwood      2010-03-17  309  static int wm9705_soc_resume(struct snd_soc_codec *codec)
0a11b168 Mark Brown         2009-04-02  310  {
358a8bb5 Lars-Peter Clausen 2014-11-10  311  	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
0a11b168 Mark Brown         2009-04-02  312  	int i, ret;
0a11b168 Mark Brown         2009-04-02  313  	u16 *cache = codec->reg_cache;
0a11b168 Mark Brown         2009-04-02  314  
6e0b73a0 Lars-Peter Clausen 2015-07-21  315  	ret = snd_ac97_reset(ac97, true, WM9705_VENDOR_ID,
6e0b73a0 Lars-Peter Clausen 2015-07-21  316  		WM9705_VENDOR_ID_MASK);
9cf766f6 Lars-Peter Clausen 2014-10-30  317  	if (ret < 0)
0a11b168 Mark Brown         2009-04-02  318  		return ret;
0a11b168 Mark Brown         2009-04-02  319  
0a11b168 Mark Brown         2009-04-02  320  	for (i = 2; i < ARRAY_SIZE(wm9705_reg) << 1; i += 2) {
358a8bb5 Lars-Peter Clausen 2014-11-10 @321  		soc_ac97_ops->write(ac97, i, cache[i>>1]);
0a11b168 Mark Brown         2009-04-02  322  	}
0a11b168 Mark Brown         2009-04-02  323  
0a11b168 Mark Brown         2009-04-02  324  	return 0;
0a11b168 Mark Brown         2009-04-02  325  }
0a11b168 Mark Brown         2009-04-02  326  #else
0a11b168 Mark Brown         2009-04-02  327  #define wm9705_soc_suspend NULL
0a11b168 Mark Brown         2009-04-02  328  #define wm9705_soc_resume NULL
0a11b168 Mark Brown         2009-04-02  329  #endif
0a11b168 Mark Brown         2009-04-02  330  
f0fba2ad Liam Girdwood      2010-03-17  331  static int wm9705_soc_probe(struct snd_soc_codec *codec)
2aceefef Ian Molton         2009-01-16  332  {
358a8bb5 Lars-Peter Clausen 2014-11-10  333  	struct snd_ac97 *ac97;
2aceefef Ian Molton         2009-01-16  334  
6e0b73a0 Lars-Peter Clausen 2015-07-21 @335  	ac97 = snd_soc_new_ac97_codec(codec, WM9705_VENDOR_ID,
6e0b73a0 Lars-Peter Clausen 2015-07-21  336  		WM9705_VENDOR_ID_MASK);
358a8bb5 Lars-Peter Clausen 2014-11-10  337  	if (IS_ERR(ac97)) {
9cf766f6 Lars-Peter Clausen 2014-10-30  338  		dev_err(codec->dev, "Failed to register AC97 codec\n");
6e0b73a0 Lars-Peter Clausen 2015-07-21  339  		return PTR_ERR(ac97);
2aceefef Ian Molton         2009-01-16  340  	}
2aceefef Ian Molton         2009-01-16  341  
f8d71be5 Lars-Peter Clausen 2015-01-23  342  	snd_soc_codec_set_drvdata(codec, ac97);
2aceefef Ian Molton         2009-01-16  343  
2aceefef Ian Molton         2009-01-16  344  	return 0;
2aceefef Ian Molton         2009-01-16  345  }
2aceefef Ian Molton         2009-01-16  346  
f0fba2ad Liam Girdwood      2010-03-17  347  static int wm9705_soc_remove(struct snd_soc_codec *codec)
2aceefef Ian Molton         2009-01-16  348  {
358a8bb5 Lars-Peter Clausen 2014-11-10  349  	struct snd_ac97 *ac97 = snd_soc_codec_get_drvdata(codec);
358a8bb5 Lars-Peter Clausen 2014-11-10  350  
358a8bb5 Lars-Peter Clausen 2014-11-10 @351  	snd_soc_free_ac97_codec(ac97);
2aceefef Ian Molton         2009-01-16  352  	return 0;
2aceefef Ian Molton         2009-01-16  353  }
2aceefef Ian Molton         2009-01-16  354  

:::::: The code at line 216 was first introduced by commit
:::::: 358a8bb5628420529e4f0b77068155ca8fa8973b ASoC: ac97: Push snd_ac97 pointer to the driver level

:::::: TO: Lars-Peter Clausen <lars@metafoo.de>
:::::: CC: Mark Brown <broonie@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30274 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160526/9534937c/attachment-0001.obj>
