From: lkp@intel.com (kbuild test robot)
Date: Mon, 20 Mar 2017 14:51:32 +0800
Subject: [alsa-devel] [PATCH v3 03/11] IIO: ADC: add sigma delta
 modulator support
In-Reply-To: <1489759704-30217-4-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <201703201458.zf1CdM1e%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.11-rc3]
[cannot apply to iio/togreg next-20170310]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arnaud-Pouliquen/Add-STM32-DFSDM-support/20170320-133247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/adc/sd_adc_modulator.c:23:0:
   drivers/iio/adc/sd_adc_modulator.c:84:25: error: 'adc081c_of_match' undeclared here (not in a function)
    MODULE_DEVICE_TABLE(of, adc081c_of_match);
                            ^
   include/linux/module.h:212:21: note: in definition of macro 'MODULE_DEVICE_TABLE'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                        ^~~~
   include/linux/module.h:212:27: error: '__mod_of__adc081c_of_match_device_table' aliased to undefined symbol 'adc081c_of_match'
    extern const typeof(name) __mod_##type##__##name##_device_table  \
                              ^
>> drivers/iio/adc/sd_adc_modulator.c:84:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
    MODULE_DEVICE_TABLE(of, adc081c_of_match);
    ^~~~~~~~~~~~~~~~~~~

vim +/MODULE_DEVICE_TABLE +84 drivers/iio/adc/sd_adc_modulator.c

    68		iio->info = &iio_sd_mod_iio_info;
    69		iio->modes = INDIO_BUFFER_HARDWARE;
    70	
    71		iio->num_channels = 1;
    72		iio->channels = &stm32_dfsdm_ch;
    73	
    74		platform_set_drvdata(pdev, iio);
    75	
    76		return devm_iio_device_register(&pdev->dev, iio);
    77	}
    78	
    79	static const struct of_device_id sd_adc_of_match[] = {
    80		{ .compatible = "sd-modulator" },
    81		{ .compatible = "ads1201" },
    82		{ }
    83	};
  > 84	MODULE_DEVICE_TABLE(of, adc081c_of_match);
    85	
    86	static struct platform_driver iio_sd_mod_adc = {
    87		.driver = {
    88			.name = "iio_sd_adc_mod",
    89			.of_match_table = of_match_ptr(sd_adc_of_match),
    90		},
    91		.probe = iio_sd_mod_probe,
    92	};

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 58882 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/50f8caa9/attachment-0001.gz>
