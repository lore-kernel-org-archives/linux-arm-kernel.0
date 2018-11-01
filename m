From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Nov 2018 01:44:58 +0800
Subject: [PATCH i2c-next v9 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
In-Reply-To: <20181030210917.32711-6-jae.hyun.yoo@linux.intel.com>
References: <20181030210917.32711-6-jae.hyun.yoo@linux.intel.com>
Message-ID: <201811020154.eziM0emr%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jae,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on v4.19 next-20181101]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/dt-bindings-i2c-Add-bus-timeout-ms-and-retries-properties-as-common-optional/20181031-051152
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-aspeed.c: In function 'aspeed_i2c_master_xfer':
>> drivers/i2c/busses/i2c-aspeed.c:624:210: warning: 'timeout' may be used uninitialized in this function [-Wmaybe-uninitialized]
      if (time_after(jiffies, timeout))
                                                                                                                                                                                                                     ^           
   drivers/i2c/busses/i2c-aspeed.c:607:16: note: 'timeout' was declared here
     unsigned long timeout;
                   ^~~~~~~

vim +/timeout +624 drivers/i2c/busses/i2c-aspeed.c

   604	
   605	static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
   606	{
   607		unsigned long timeout;
   608	
   609		if (bus->multi_master) {
   610			might_sleep();
   611			/* Initialize it only when multi_master is set */
   612			timeout = jiffies + bus->adap.timeout;
   613		}
   614	
   615		for (;;) {
   616			if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
   617			      ASPEED_I2CD_BUS_BUSY_STS))
   618	#if IS_ENABLED(CONFIG_I2C_SLAVE)
   619				if (bus->slave_state == ASPEED_I2C_SLAVE_STOP)
   620	#endif
   621					return 0;
   622			if (!bus->multi_master)
   623				break;
 > 624			if (time_after(jiffies, timeout))
   625				break;
   626			usleep_range((ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US >> 2) + 1,
   627				     ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US);
   628		}
   629	
   630		return aspeed_i2c_recover_bus(bus);
   631	}
   632	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64563 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181102/9bc6f6c4/attachment-0001.gz>
