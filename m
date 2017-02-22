From: lkp@intel.com (kbuild test robot)
Date: Wed, 22 Feb 2017 14:49:59 +0800
Subject: [alsa-devel] [PATCH v6] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
In-Reply-To: <1487740949-27583-1-git-send-email-flatmax@flatmax.org>
Message-ID: <201702221449.aUxpz16w%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matt,

[auto build test WARNING on v4.9-rc8]
[also build test WARNING on next-20170221]
[cannot apply to linux-rpi/for-rpi-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Matt-Flax/ASoC-bcm2835-Add-8-channel-multitrack-capability/20170222-134433
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All warnings (new ones prefixed by >>):

   sound/soc/bcm/bcm2835-i2s.c: In function 'bcm2835_i2s_startup':
>> sound/soc/bcm/bcm2835-i2s.c:534:15: warning: suggest parentheses around comparison in operand of '&' [-Wparentheses]
     if (dev->fmt & (SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK)
                  ^

vim +534 sound/soc/bcm/bcm2835-i2s.c

   518		bcm2835_i2s_stop_clock(dev);
   519	
   520		/* Enable PCM block */
   521		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
   522				BCM2835_I2S_EN, BCM2835_I2S_EN);
   523	
   524		/*
   525		 * Disable STBY.
   526		 * Requires at least 4 PCM clock cycles to take effect.
   527		 */
   528		regmap_update_bits(dev->i2s_regmap, BCM2835_I2S_CS_A_REG,
   529				BCM2835_I2S_STBY, BCM2835_I2S_STBY);
   530	
   531		/* Set the max channels to 8 if the codec is master and
   532		 * we are in DSP A mode. Otherwise only allow 2 channels.
   533		 */
 > 534		if (dev->fmt & (SND_SOC_DAIFMT_MASTER_MASK | SND_SOC_DAIFMT_FORMAT_MASK)
   535			  == (SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
   536			return snd_pcm_hw_constraint_single(substream->runtime,
   537				SNDRV_PCM_HW_PARAM_CHANNELS, 8);
   538		else
   539			return snd_pcm_hw_constraint_single(substream->runtime,
   540				SNDRV_PCM_HW_PARAM_CHANNELS, 2);
   541	}
   542	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47879 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170222/de4fd1b4/attachment-0001.gz>
