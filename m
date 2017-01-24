From: lkp@intel.com (kbuild test robot)
Date: Wed, 25 Jan 2017 06:00:59 +0800
Subject: [PATCH 4/8] serial: st-asc: (De)Register GPIOD and swap Pinctrl
 profiles
In-Reply-To: <20170124134310.27512-5-lee.jones@linaro.org>
Message-ID: <201701250500.AYU14KMP%fengguang.wu@intel.com>
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

All errors (new ones prefixed by >>):

   drivers/tty/serial/st-asc.c: In function 'asc_set_termios':
>> drivers/tty/serial/st-asc.c:568:4: error: implicit declaration of function 'pinctrl_select_state' [-Werror=implicit-function-declaration]
       pinctrl_select_state(ascport->pinctrl,
       ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c: In function 'asc_init_port':
   drivers/tty/serial/st-asc.c:755:21: error: implicit declaration of function 'devm_pinctrl_get' [-Werror=implicit-function-declaration]
     ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
                        ^~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:755:19: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ascport->pinctrl = devm_pinctrl_get(&pdev->dev);
                      ^
   drivers/tty/serial/st-asc.c:762:3: error: implicit declaration of function 'pinctrl_lookup_state' [-Werror=implicit-function-declaration]
      pinctrl_lookup_state(ascport->pinctrl, "default");
      ^~~~~~~~~~~~~~~~~~~~
   drivers/tty/serial/st-asc.c:761:27: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ascport->states[DEFAULT] =
                              ^
   drivers/tty/serial/st-asc.c:771:30: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
     ascport->states[MANUAL_RTS] =
                                 ^
   cc1: some warnings being treated as errors

vim +/pinctrl_select_state +568 drivers/tty/serial/st-asc.c

   562	
   563			/* If flow-control selected, stop handling RTS manually */
   564			if (ascport->rts) {
   565				devm_gpiod_put(port->dev, ascport->rts);
   566				ascport->rts = NULL;
   567	
 > 568				pinctrl_select_state(ascport->pinctrl,
   569						     ascport->states[DEFAULT]);
   570			}
   571		} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48646 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/9d6f2e44/attachment-0001.gz>
