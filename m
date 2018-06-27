From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jun 2018 08:16:16 +0800
Subject: [PATCH v2 1/2] clk: pxa: export 32kHz PLL
In-Reply-To: <20180626200308.16192-1-robert.jarzmik@free.fr>
References: <20180626200308.16192-1-robert.jarzmik@free.fr>
Message-ID: <201806270855.xvEN3vnK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.18-rc2 next-20180626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/clk-pxa-export-32kHz-PLL/20180627-040726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-xcep_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/pxa/clk-pxa25x.c: In function 'pxa25x_register_plls':
>> drivers/clk/pxa/clk-pxa25x.c:298:17: error: expected ')' before ';' token
              32768);
                    ^
>> drivers/clk/pxa/clk-pxa25x.c:304:1: error: expected ';' before '}' token
    }
    ^

vim +298 drivers/clk/pxa/clk-pxa25x.c

   290	
   291	static void __init pxa25x_register_plls(void)
   292	{
   293		clk_register_fixed_rate(NULL, "osc_3_6864mhz", NULL,
   294					CLK_GET_RATE_NOCACHE, 3686400);
   295		clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
   296				    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
   297							    CLK_GET_RATE_NOCACHE,
 > 298							    32768);
   299		clk_register_fixed_rate(NULL, "clk_dummy", NULL, 0, 0);
   300		clk_register_fixed_factor(NULL, "ppll_95_85mhz", "osc_3_6864mhz",
   301					  0, 26, 1);
   302		clk_register_fixed_factor(NULL, "ppll_147_46mhz", "osc_3_6864mhz",
   303					  0, 40, 1);
 > 304	}
   305	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 12833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/e0d4c48a/attachment-0001.gz>
