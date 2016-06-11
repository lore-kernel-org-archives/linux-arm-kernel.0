From: lkp@intel.com (kbuild test robot)
Date: Sat, 11 Jun 2016 10:22:14 +0800
Subject: [PATCH 47/48] PWM: atmel-tcb: switch to new binding
In-Reply-To: <1465596231-21766-48-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <201606111040.p4l4J6hH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on at91/at91-next]
[also build test WARNING on v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/ARM-at91-rework-Atmel-TCB-drivers/20160611-062134
base:   https://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git at91-next
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/pwm/pwm-atmel-tcb.c: In function 'atmel_tcb_pwm_probe':
>> drivers/pwm/pwm-atmel-tcb.c:418:18: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     tcbpwm->width = (int)match->data;
                     ^

vim +418 drivers/pwm/pwm-atmel-tcb.c

   402			dev_err(&pdev->dev, "failed to allocate memory\n");
   403			goto err_slow_clk;
   404		}
   405	
   406		tcbpwm->chip.dev = &pdev->dev;
   407		tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
   408		tcbpwm->chip.of_xlate = of_pwm_xlate_with_flags;
   409		tcbpwm->chip.of_pwm_n_cells = 3;
   410		tcbpwm->chip.base = -1;
   411		tcbpwm->chip.npwm = NPWM;
   412		tcbpwm->channel = channel;
   413		tcbpwm->regmap = regmap;
   414		tcbpwm->clk = clk;
   415		tcbpwm->slow_clk = slow_clk;
   416	
   417		match = of_match_node(atmel_tcb_dt_ids, np->parent);
 > 418		tcbpwm->width = (int)match->data;
   419	
   420		err = clk_prepare_enable(slow_clk);
   421		if (err)
   422			goto err_slow_clk;
   423	
   424		spin_lock_init(&tcbpwm->lock);
   425	
   426		err = pwmchip_add(&tcbpwm->chip);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54115 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160611/97d4d8be/attachment-0001.obj>
