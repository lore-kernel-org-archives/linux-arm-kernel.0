From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 15:43:04 +0800
Subject: [PATCH] serial: 8250_of: Add basic PM runtime support
In-Reply-To: <20170802163218.14377-1-fcooper@ti.com>
Message-ID: <201708031530.elCfGZbv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Franklin,

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on next-20170802]
[cannot apply to v4.13-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Franklin-S-Cooper-Jr/serial-8250_of-Add-basic-PM-runtime-support/20170803-151414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: sparc64-allmodconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   drivers/tty//serial/8250/8250_of.c: In function 'of_serial_suspend':
>> drivers/tty//serial/8250/8250_of.c:273:24: error: 'ofdev' undeclared (first use in this function)
      pm_runtime_put_sync(&ofdev->dev);
                           ^~~~~
   drivers/tty//serial/8250/8250_of.c:273:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/tty//serial/8250/8250_of.c: In function 'of_serial_resume':
   drivers/tty//serial/8250/8250_of.c:286:24: error: 'ofdev' undeclared (first use in this function)
      pm_runtime_get_sync(&ofdev->dev);
                           ^~~~~

vim +/ofdev +273 drivers/tty//serial/8250/8250_of.c

   262	
   263	#ifdef CONFIG_PM_SLEEP
   264	static int of_serial_suspend(struct device *dev)
   265	{
   266		struct of_serial_info *info = dev_get_drvdata(dev);
   267		struct uart_8250_port *port8250 = serial8250_get_port(info->line);
   268		struct uart_port *port = &port8250->port;
   269	
   270		serial8250_suspend_port(info->line);
   271	
   272		if ((!uart_console(port) || console_suspend_enabled)) {
 > 273			pm_runtime_put_sync(&ofdev->dev);
   274			clk_disable_unprepare(info->clk);
   275		}
   276		return 0;
   277	}
   278	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51285 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170803/57cf4453/attachment-0001.gz>
