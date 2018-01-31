From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Feb 2018 05:47:20 +0800
Subject: [PATCH v2 08/16] iio: adc: sun4i-gpadc-iio: rework: add
 interrupt support
In-Reply-To: <20180128232919.12639-9-embed3d@gmail.com>
References: <20180128232919.12639-9-embed3d@gmail.com>
Message-ID: <201802010523.kyQGQJeE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.15 next-20180126]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Philipp-Rossak/IIO-based-thermal-sensor-driver-for-Allwinner-H3-and-A83T-SoC/20180201-043415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

Note: the linux-review/Philipp-Rossak/IIO-based-thermal-sensor-driver-for-Allwinner-H3-and-A83T-SoC/20180201-043415 HEAD e571c3ced84a9d7f150cb2d239919d31d25114e2 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/iio/adc/sun4i-gpadc-iio.c: In function 'sunxi_irq_thread':
>> drivers/iio/adc/sun4i-gpadc-iio.c:448:29: error: 'SUN8I_H3_THS_STAT' undeclared (first use in this function); did you mean 'SUN8I_H3_THS_INTC'?
     regmap_write(info->regmap, SUN8I_H3_THS_STAT, info->data->irq_clear_map);
                                ^~~~~~~~~~~~~~~~~
                                SUN8I_H3_THS_INTC
   drivers/iio/adc/sun4i-gpadc-iio.c:448:29: note: each undeclared identifier is reported only once for each function it appears in

vim +448 drivers/iio/adc/sun4i-gpadc-iio.c

   443	
   444	static irqreturn_t sunxi_irq_thread(int irq, void *data)
   445	{
   446		struct sun4i_gpadc_iio *info = data;
   447	
 > 448		regmap_write(info->regmap, SUN8I_H3_THS_STAT, info->data->irq_clear_map);
   449	
   450		thermal_zone_device_update(info->tzd, THERMAL_EVENT_TEMP_SAMPLE);
   451	
   452		return IRQ_HANDLED;
   453	}
   454	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 52622 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180201/9f9857b6/attachment-0001.gz>
