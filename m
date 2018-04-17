From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Apr 2018 03:56:55 +0800
Subject: [PATCH] staging: bcm2835-audio: Disconnect and free
 vchi_instance on module_exit()
In-Reply-To: <20180417050028.19372-1-k.marinushkin@gmail.com>
References: <20180417050028.19372-1-k.marinushkin@gmail.com>
Message-ID: <201804180307.q5MrL5v1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kirill,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on v4.17-rc1]
[cannot apply to anholt/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kirill-Marinushkin/staging-bcm2835-audio-Disconnect-and-free-vchi_instance-on-module_exit/20180417-193147
config: arm-allmodconfig
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        make.cross ARCH=arm  allmodconfig
        make.cross ARCH=arm 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):


vim +/err +307 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c

325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  274  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  275  static int snd_add_child_device(struct device *device,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  276  				struct bcm2835_audio_driver *audio_driver,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  277  				u32 numchans)
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  278  {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  279  	struct snd_card *card;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  280  	struct device *child;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  281  	struct bcm2835_chip *chip;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  282  	int err, i;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  283  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  284  	child = snd_create_device(device, &audio_driver->driver,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  285  				  audio_driver->driver.name);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  286  	if (IS_ERR(child)) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  287  		dev_err(device,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  288  			"Unable to create child device %p, error %ld",
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  289  			audio_driver->driver.name,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  290  			PTR_ERR(child));
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  291  		return PTR_ERR(child);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  292  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  293  
626118b4 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Kirill Marinushkin 2018-03-23  294  	card = snd_bcm2835_card_new(child);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  295  	if (IS_ERR(card)) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  296  		dev_err(child, "Failed to create card");
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  297  		return PTR_ERR(card);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  298  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  299  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  300  	snd_card_set_dev(card, child);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  301  	strcpy(card->driver, audio_driver->driver.name);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  302  	strcpy(card->shortname, audio_driver->shortname);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  303  	strcpy(card->longname, audio_driver->longname);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  304  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  305  	err = snd_bcm2835_create(card, &chip);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  306  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14 @307  		dev_err(child, "Failed to create chip, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  308  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  309  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  310  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  311  	chip->dev = child;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  312  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  313  	err = audio_driver->newpcm(chip, audio_driver->shortname,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  314  		audio_driver->route,
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  315  		numchans);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  316  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  317  		dev_err(child, "Failed to create pcm, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  318  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  319  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  320  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  321  	err = audio_driver->newctl(chip);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  322  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  323  		dev_err(child, "Failed to create controls, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  324  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  325  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  326  
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  327  	for (i = 0; i < numchans; i++)
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  328  		chip->avail_substreams |= (1 << i);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  329  
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  330  	err = snd_card_register(card);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  331  	if (err) {
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  332  		dev_err(child, "Failed to register card, error %d\n", err);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  333  		return err;
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  334  	}
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  335  
626118b4 drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Kirill Marinushkin 2018-03-23  336  	dev_set_drvdata(child, chip);
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  337  	dev_info(child, "card created with %d channels\n", numchans);
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  338  
23b028c8 drivers/staging/bcm2835-audio/bcm2835.c               Michael Zoran      2017-01-25  339  	return 0;
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  340  }
325b5b6c drivers/staging/vc04_services/bcm2835-audio/bcm2835.c Michael Zoran      2017-03-14  341  

:::::: The code at line 307 was first introduced by commit
:::::: 325b5b6c96a863989078df402d1670d061f52d88 staging: bcm2835-audio: Add support for simultanous HDMI and Headphone audio

:::::: TO: Michael Zoran <mzoran@crowfest.net>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
