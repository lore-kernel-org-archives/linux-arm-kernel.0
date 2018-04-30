From: lkp@intel.com (kbuild test robot)
Date: Tue, 1 May 2018 04:45:05 +0800
Subject: [PATCH 2/3] platform: move the early platform device support to
 arch/sh
In-Reply-To: <20180430163556.2560-3-brgl@bgdev.pl>
References: <20180430163556.2560-3-brgl@bgdev.pl>
Message-ID: <201805010406.gWvwh2G4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartosz,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.17-rc3 next-20180430]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/sh-make-early_platform-code-SuperH-specific/20180501-025442
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/tty/serial/sh-sci.c: In function 'sci_probe':
   drivers/tty/serial/sh-sci.c:3196:6: error: implicit declaration of function 'is_early_platform_device'; did you mean 'to_platform_device'? [-Werror=implicit-function-declaration]
     if (is_early_platform_device(dev))
         ^~~~~~~~~~~~~~~~~~~~~~~~
         to_platform_device
   drivers/tty/serial/sh-sci.c: At top level:
>> drivers/tty/serial/sh-sci.c:3294:28: error: expected declaration specifiers or '...' before string constant
    early_platform_init_buffer("earlyprintk", &sci_driver,
                               ^~~~~~~~~~~~~
>> drivers/tty/serial/sh-sci.c:3294:43: error: expected declaration specifiers or '...' before '&' token
    early_platform_init_buffer("earlyprintk", &sci_driver,
                                              ^
>> drivers/tty/serial/sh-sci.c:3295:7: error: expected declaration specifiers or '...' before 'early_serial_buf'
          early_serial_buf, ARRAY_SIZE(early_serial_buf));
          ^~~~~~~~~~~~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers/tty/serial/sh-sci.c:24:
   include/linux/kernel.h:71:25: error: expected declaration specifiers or '...' before '(' token
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                            ^
   drivers/tty/serial/sh-sci.c:3295:25: note: in expansion of macro 'ARRAY_SIZE'
          early_serial_buf, ARRAY_SIZE(early_serial_buf));
                            ^~~~~~~~~~
   cc1: some warnings being treated as errors

vim +3294 drivers/tty/serial/sh-sci.c

0ee70712 drivers/serial/sh-sci.c     Magnus Damm        2009-01-21  3183  
9671f099 drivers/tty/serial/sh-sci.c Bill Pemberton     2012-11-19  3184  static int sci_probe(struct platform_device *dev)
0ee70712 drivers/serial/sh-sci.c     Magnus Damm        2009-01-21  3185  {
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3186  	struct plat_sci_port *p;
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3187  	struct sci_port *sp;
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3188  	unsigned int dev_id;
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3189  	int ret;
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3190  
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3191  	/*
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3192  	 * If we've come here via earlyprintk initialization, head off to
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3193  	 * the special early probe. We don't have sufficient device state
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3194  	 * to make it beyond this yet.
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3195  	 */
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21 @3196  	if (is_early_platform_device(dev))
ecdf8a46 drivers/serial/sh-sci.c     Paul Mundt         2011-01-21  3197  		return sci_probe_earlyprintk(dev);
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm        2009-12-14  3198  
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3199  	if (dev->dev.of_node) {
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3200  		p = sci_parse_dt(dev, &dev_id);
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3201  		if (p == NULL)
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3202  			return -EINVAL;
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3203  	} else {
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3204  		p = dev->dev.platform_data;
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3205  		if (p == NULL) {
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3206  			dev_err(&dev->dev, "no platform data supplied\n");
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3207  			return -EINVAL;
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3208  		}
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3209  
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3210  		dev_id = dev->id;
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3211  	}
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3212  
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3213  	sp = &sci_ports[dev_id];
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3214  	platform_set_drvdata(dev, sp);
0ee70712 drivers/serial/sh-sci.c     Magnus Damm        2009-01-21  3215  
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3216  	ret = sci_probe_single(dev, dev_id, p, sp);
0ee70712 drivers/serial/sh-sci.c     Magnus Damm        2009-01-21  3217  	if (ret)
6dae1421 drivers/tty/serial/sh-sci.c Laurent Pinchart   2012-06-13  3218  		return ret;
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3219  
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3220  	if (sp->port.fifosize > 1) {
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3221  		ret = sysfs_create_file(&dev->dev.kobj,
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3222  				&dev_attr_rx_fifo_trigger.attr);
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3223  		if (ret)
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3224  			return ret;
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3225  	}
fa2abb03 drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-09-29  3226  	if (sp->port.type == PORT_SCIFA || sp->port.type == PORT_SCIFB ||
fa2abb03 drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-09-29  3227  	    sp->port.type == PORT_HSCIF) {
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3228  		ret = sysfs_create_file(&dev->dev.kobj,
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3229  				&dev_attr_rx_fifo_timeout.attr);
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3230  		if (ret) {
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3231  			if (sp->port.fifosize > 1) {
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3232  				sysfs_remove_file(&dev->dev.kobj,
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3233  					&dev_attr_rx_fifo_trigger.attr);
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3234  			}
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3235  			return ret;
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3236  		}
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3237  	}
5d23188a drivers/tty/serial/sh-sci.c Ulrich Hecht       2017-02-03  3238  
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3239  #ifdef CONFIG_SH_STANDARD_BIOS
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3240  	sh_bios_gdb_detach();
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3241  #endif
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3242  
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3243  	return 0;
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3244  }
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3245  
cb876341 drivers/tty/serial/sh-sci.c Sergei Shtylyov    2015-01-16  3246  static __maybe_unused int sci_suspend(struct device *dev)
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3247  {
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3248  	struct sci_port *sport = dev_get_drvdata(dev);
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3249  
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3250  	if (sport)
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3251  		uart_suspend_port(&sci_uart_driver, &sport->port);
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3252  
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3253  	return 0;
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3254  }
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3255  
cb876341 drivers/tty/serial/sh-sci.c Sergei Shtylyov    2015-01-16  3256  static __maybe_unused int sci_resume(struct device *dev)
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3257  {
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3258  	struct sci_port *sport = dev_get_drvdata(dev);
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3259  
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3260  	if (sport)
d535a230 drivers/serial/sh-sci.c     Paul Mundt         2011-01-19  3261  		uart_resume_port(&sci_uart_driver, &sport->port);
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3262  
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3263  	return 0;
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3264  }
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3265  
cb876341 drivers/tty/serial/sh-sci.c Sergei Shtylyov    2015-01-16  3266  static SIMPLE_DEV_PM_OPS(sci_dev_pm_ops, sci_suspend, sci_resume);
6daa79b3 drivers/serial/sh-sci.c     Paul Mundt         2009-06-15  3267  
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3268  static struct platform_driver sci_driver = {
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3269  	.probe		= sci_probe,
b9e39c89 drivers/serial/sh-sci.c     Uwe Kleine-K?nig   2009-11-24  3270  	.remove		= sci_remove,
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3271  	.driver		= {
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3272  		.name	= "sh-sci",
6daa79b3 drivers/serial/sh-sci.c     Paul Mundt         2009-06-15  3273  		.pm	= &sci_dev_pm_ops,
20bdcab8 drivers/tty/serial/sh-sci.c Bastian Hecht      2013-12-06  3274  		.of_match_table = of_match_ptr(of_sci_match),
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3275  	},
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3276  };
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3277  
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3278  static int __init sci_init(void)
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3279  {
6c13d5d2 drivers/tty/serial/sh-sci.c Geert Uytterhoeven 2014-03-11  3280  	pr_info("%s\n", banner);
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3281  
352b9266 drivers/tty/serial/sh-sci.c Sjoerd Simons      2017-04-20  3282  	return platform_driver_register(&sci_driver);
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3283  }
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3284  
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3285  static void __exit sci_exit(void)
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3286  {
e108b2ca drivers/serial/sh-sci.c     Paul Mundt         2006-09-27  3287  	platform_driver_unregister(&sci_driver);
352b9266 drivers/tty/serial/sh-sci.c Sjoerd Simons      2017-04-20  3288  
352b9266 drivers/tty/serial/sh-sci.c Sjoerd Simons      2017-04-20  3289  	if (sci_uart_driver.state)
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3290  		uart_unregister_driver(&sci_uart_driver);
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3291  }
^1da177e drivers/serial/sh-sci.c     Linus Torvalds     2005-04-16  3292  
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm        2009-12-14  3293  #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm        2009-12-14 @3294  early_platform_init_buffer("earlyprintk", &sci_driver,
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm        2009-12-14 @3295  			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
7b6fd3bf drivers/serial/sh-sci.c     Magnus Damm        2009-12-14  3296  #endif
0b0cced1 drivers/tty/serial/sh-sci.c Yoshinori Sato     2015-12-24  3297  #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
dd076cff drivers/tty/serial/sh-sci.c Matthias Kaehlcke  2017-10-09  3298  static struct plat_sci_port port_cfg __initdata;
0b0cced1 drivers/tty/serial/sh-sci.c Yoshinori Sato     2015-12-24  3299  

:::::: The code at line 3294 was first introduced by commit
:::::: 7b6fd3bf82c4901f6ba0101ba71a5c507c24f9cf sh-sci: Extend sh-sci driver with early console V2

:::::: TO: Magnus Damm <damm@opensource.se>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38254 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180501/96482d41/attachment-0001.gz>
