From: lkp@intel.com (kbuild test robot)
Date: Wed, 25 Jan 2017 05:28:10 +0800
Subject: [PATCH 3/8] serial: st-asc: Read in all Pinctrl states
In-Reply-To: <20170124134310.27512-4-lee.jones@linaro.org>
Message-ID: <201701250559.iD93QYdx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on v4.10-rc5 next-20170124]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lee-Jones/serial-st-asc-Allow-handling-of-RTS-line/20170125-014618
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: alpha-allyesconfig (attached as .config)
compiler: alpha-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=alpha 

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/st-asc.c: In function 'asc_init_port':
>> drivers/tty/serial/st-asc.c:730:21: error: implicit declaration of function 'devm_pinctrl_get' [-Werror=implicit-function-declaration]
     ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
                        ^~~~~~~~~~~~~~~~
>> drivers/tty/serial/st-asc.c:730:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
                      ^
>> drivers/tty/serial/st-asc.c:737:3: error: implicit declaration of function 'pinctrl_lookup_state' [-Werror=implicit-function-declaration]
      pinctrl_lookup_state(ascport->pinctrl, "default");
      ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:736:27: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ascport->states[DEFAULT] =
                              ^
   drivers/tty/serial/st-asc.c:746:30: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ascport->states[MANUAL_RTS] =
                                 ^
   cc1: some warnings being treated as errors

vim +/devm_pinctrl_get +730 drivers/tty/serial/st-asc.c

   724		/* ensure that clk rate is correct by enabling the clk */
   725		clk_prepare_enable(ascport->clk);
   726		ascport->port.uartclk = clk_get_rate(ascport->clk);
   727		WARN_ON(ascport->port.uartclk == 0);
   728		clk_disable_unprepare(ascport->clk);
   729	
 > 730		ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
   731		if (IS_ERR(ascport->pinctrl)) {
   732			ret = PTR_ERR(ascport->pinctrl);
   733			dev_err(&pdev->dev, "Failed to get Pinctrl: %d\n", ret);
   734		}
   735	
   736		ascport->states[DEFAULT] =
 > 737			pinctrl_lookup_state(ascport->pinctrl, "default");
   738		if (IS_ERR(ascport->states[DEFAULT])) {
   739			ret = PTR_ERR(ascport->states[DEFAULT]);
   740			dev_err(&pdev->dev,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48646 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/1372cacd/attachment-0001.gz>
