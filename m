From: lkp@intel.com (kbuild test robot)
Date: Thu, 30 Aug 2018 07:43:30 +0800
Subject: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
In-Reply-To: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
References: <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
Message-ID: <201808300705.abCHwamP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Codrin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on at91/at91-next]
[also build test ERROR on v4.19-rc1 next-20180829]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Codrin-Ciubotariu/ASoC-Add-driver-for-PROTO-Audio-CODEC-with-a-WM8731/20180830-060610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   sound/soc/atmel/mikroe-proto.c: In function 'snd_proto_init':
>> sound/soc/atmel/mikroe-proto.c:49:35: error: 'struct snd_soc_pcm_runtime' has no member named 'codec'
     struct snd_soc_codec *codec = rtd->codec;
                                      ^~
>> sound/soc/atmel/mikroe-proto.c:56:16: error: dereferencing pointer to incomplete type 'struct snd_soc_codec'
      dev_err(codec->dev, "Failed to set WM8731 SYSCLK: %d\n", ret);
                   ^~

vim +49 sound/soc/atmel/mikroe-proto.c

    46	
    47	static int snd_proto_init(struct snd_soc_pcm_runtime *rtd)
    48	{
  > 49		struct snd_soc_codec *codec = rtd->codec;
    50		struct snd_soc_dai *codec_dai = rtd->codec_dai;
    51	
    52		/* Set proto sysclk */
    53		int ret = snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
    54						 XTAL_RATE, SND_SOC_CLOCK_IN);
    55		if (ret < 0) {
  > 56			dev_err(codec->dev, "Failed to set WM8731 SYSCLK: %d\n", ret);
    57			return ret;
    58		}
    59	
    60		return 0;
    61	}
    62	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64126 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180830/71379246/attachment-0001.gz>
