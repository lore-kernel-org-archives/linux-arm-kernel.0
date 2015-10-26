From: lkp@intel.com (kbuild test robot)
Date: Tue, 27 Oct 2015 06:09:06 +0800
Subject: [PATCH 08/10] pwm: core: add pulse feature to the PWM framework
In-Reply-To: <1445895161-2317-9-git-send-email-o.schinagl@ultimaker.com>
Message-ID: <201510270659.cBuJC07i%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olliver,

[auto build test WARNING on pwm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Olliver-Schinagl/pwm-lpc18xx_pwm-use-pwm_set_chip_data/20151027-053853
config: avr32-atstk1006_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=avr32 

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-atmel.c:278: warning: initialization from incompatible pointer type

vim +278 drivers/pwm/pwm-atmel.c

472ac3dc Alexandre Belloni 2015-05-25  262  	mutex_lock(&atmel_pwm->isr_lock);
472ac3dc Alexandre Belloni 2015-05-25  263  	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
472ac3dc Alexandre Belloni 2015-05-25  264  
472ac3dc Alexandre Belloni 2015-05-25  265  	while (!(atmel_pwm->updated_pwms & (1 << pwm->hwpwm)) &&
472ac3dc Alexandre Belloni 2015-05-25  266  	       time_before(jiffies, timeout)) {
472ac3dc Alexandre Belloni 2015-05-25  267  		usleep_range(10, 100);
472ac3dc Alexandre Belloni 2015-05-25  268  		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
472ac3dc Alexandre Belloni 2015-05-25  269  	}
32b16d46 Bo Shen           2013-12-13  270  
472ac3dc Alexandre Belloni 2015-05-25  271  	mutex_unlock(&atmel_pwm->isr_lock);
32b16d46 Bo Shen           2013-12-13  272  	atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
32b16d46 Bo Shen           2013-12-13  273  
32b16d46 Bo Shen           2013-12-13  274  	clk_disable(atmel_pwm->clk);
32b16d46 Bo Shen           2013-12-13  275  }
32b16d46 Bo Shen           2013-12-13  276  
32b16d46 Bo Shen           2013-12-13  277  static const struct pwm_ops atmel_pwm_ops = {
32b16d46 Bo Shen           2013-12-13 @278  	.config = atmel_pwm_config,
32b16d46 Bo Shen           2013-12-13  279  	.set_polarity = atmel_pwm_set_polarity,
32b16d46 Bo Shen           2013-12-13  280  	.enable = atmel_pwm_enable,
32b16d46 Bo Shen           2013-12-13  281  	.disable = atmel_pwm_disable,
32b16d46 Bo Shen           2013-12-13  282  	.owner = THIS_MODULE,
32b16d46 Bo Shen           2013-12-13  283  };
32b16d46 Bo Shen           2013-12-13  284  
32b16d46 Bo Shen           2013-12-13  285  struct atmel_pwm_data {
32b16d46 Bo Shen           2013-12-13  286  	void (*config)(struct pwm_chip *chip, struct pwm_device *pwm,

:::::: The code at line 278 was first introduced by commit
:::::: 32b16d46e4154d6f9d9c1d5dd35f64cdf08b7aea pwm: atmel-pwm: Add Atmel PWM controller driver

:::::: TO: Bo Shen <voice.shen@atmel.com>
:::::: CC: Thierry Reding <thierry.reding@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 13364 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151027/9f18006f/attachment.obj>
