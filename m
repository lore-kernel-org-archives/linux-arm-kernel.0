From: lkp@intel.com (kbuild test robot)
Date: Tue, 7 Mar 2017 08:15:25 +0800
Subject: [alsa-devel] [PATCH v2 03/12] ASoC: sun8i-codec-analog: split
 out mbias
In-Reply-To: <20170305133709.6288-4-icenowy@aosc.xyz>
Message-ID: <201703070743.k6QjVQJ7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

[auto build test ERROR on linus/master]
[also build test ERROR on v4.11-rc1 next-20170306]
[cannot apply to robh/for-next asoc/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Icenowy-Zheng/ASoC-sun8i-codec-analog-split-out-mic2/20170307-064313
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> sound/soc/sunxi/sun8i-codec-analog.c:705:2: error: unknown field 'has_mbias' specified in initializer
     .has_mbias = true,
     ^
   sound/soc/sunxi/sun8i-codec-analog.c:712:2: error: unknown field 'has_mbias' specified in initializer
     .has_mbias = true,
     ^
   sound/soc/sunxi/sun8i-codec-analog.c: In function 'sun8i_codec_analog_cmpnt_probe':
>> sound/soc/sunxi/sun8i-codec-analog.c:755:12: error: 'const struct sun8i_codec_analog_quirks' has no member named 'has_mbias'; did you mean 'has_mic2'?
     if (quirks->has_mbias) {
               ^~

vim +/has_mbias +705 sound/soc/sunxi/sun8i-codec-analog.c

   699	};
   700	
   701	static const struct sun8i_codec_analog_quirks sun8i_a23_quirks = {
   702		.has_headphone	= true,
   703		.has_hmic	= true,
   704		.has_linein	= true,
 > 705		.has_mbias	= true,
   706		.has_mic2	= true,
   707	};
   708	
   709	static const struct sun8i_codec_analog_quirks sun8i_h3_quirks = {
   710		.has_linein	= true,
   711		.has_lineout	= true,
   712		.has_mbias	= true,
   713		.has_mic2	= true,
   714	};
   715	
   716	static int sun8i_codec_analog_cmpnt_probe(struct snd_soc_component *cmpnt)
   717	{
   718		struct device *dev = cmpnt->dev;
   719		const struct sun8i_codec_analog_quirks *quirks;
   720		int ret;
   721	
   722		/*
   723		 * This would never return NULL unless someone directly registers a
   724		 * platform device matching this driver's name, without specifying a
   725		 * device tree node.
   726		 */
   727		quirks = of_device_get_match_data(dev);
   728	
   729		/* Add controls, widgets, and routes for individual features */
   730	
   731		if (quirks->has_headphone) {
   732			ret = sun8i_codec_add_headphone(cmpnt);
   733			if (ret)
   734				return ret;
   735		}
   736	
   737		if (quirks->has_hmic) {
   738			ret = sun8i_codec_add_hmic(cmpnt);
   739			if (ret)
   740				return ret;
   741		}
   742	
   743		if (quirks->has_linein) {
   744			ret = sun8i_codec_add_linein(cmpnt);
   745			if (ret)
   746				return ret;
   747		}
   748	
   749		if (quirks->has_lineout) {
   750			ret = sun8i_codec_add_lineout(cmpnt);
   751			if (ret)
   752				return ret;
   753		}
   754	
 > 755		if (quirks->has_mbias) {
   756			ret = sun8i_codec_add_mbias(cmpnt);
   757			if (ret)
   758				return ret;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58978 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170307/f18e9bc0/attachment-0001.gz>
