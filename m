From: lkp@intel.com (kbuild test robot)
Date: Tue, 30 Oct 2018 14:36:37 +0800
Subject: [PATCH i2c-next v8 5/5] i2c: aspeed: Add bus idle waiting logic
 for multi-master use cases
In-Reply-To: <20181029211414.20771-6-jae.hyun.yoo@linux.intel.com>
References: <20181029211414.20771-6-jae.hyun.yoo@linux.intel.com>
Message-ID: <201810301404.KLB29BHz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jae,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on wsa/i2c/for-next]
[also build test ERROR on v4.19 next-20181029]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jae-Hyun-Yoo/i2c-aspeed-Add-bus-idle-waiting-logic-for-multi-master-use-cases/20181030-051719
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/i2c//busses/i2c-aspeed.c: In function 'aspeed_i2c_check_bus_busy':
>> drivers/i2c//busses/i2c-aspeed.c:617:12: error: 'struct aspeed_i2c_bus' has no member named 'slave_state'; did you mean 'master_state'?
          bus->slave_state == ASPEED_I2C_SLAVE_STOP)
               ^~~~~~~~~~~
               master_state

vim +617 drivers/i2c//busses/i2c-aspeed.c

   604	
   605	static int aspeed_i2c_check_bus_busy(struct aspeed_i2c_bus *bus)
   606	{
   607		unsigned long check_started;
   608	
   609		if (bus->multi_master) {
   610			might_sleep();
   611			check_started = jiffies;
   612		}
   613	
   614		for (;;) {
   615			if (!(readl(bus->base + ASPEED_I2C_CMD_REG) &
   616			      ASPEED_I2CD_BUS_BUSY_STS) &&
 > 617			    bus->slave_state == ASPEED_I2C_SLAVE_STOP)
   618				return 0;
   619			if (!bus->multi_master)
   620				break;
   621			if (time_after(jiffies, check_started + bus->adap.timeout))
   622				break;
   623			usleep_range((ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US >> 2) + 1,
   624				     ASPEED_I2C_BUS_BUSY_CHECK_INTERVAL_US);
   625		}
   626	
   627		return aspeed_i2c_recover_bus(bus);
   628	}
   629	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30010 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181030/2e20b451/attachment-0001.gz>
