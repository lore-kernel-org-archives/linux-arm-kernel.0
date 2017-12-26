From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Dec 2017 07:02:11 +0800
Subject: [PATCH 09/11 v2] ARM: orion5x: constify gpio_led
In-Reply-To: <ed1e5c5986f45d1fffc87781b655ae8cc3603c21.1514267721.git.arvind.yadav.cs@gmail.com>
References: <ed1e5c5986f45d1fffc87781b655ae8cc3603c21.1514267721.git.arvind.yadav.cs@gmail.com>
Message-ID: <201712270643.vwuxnNim%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arvind,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm-soc/for-next]
[also build test ERROR on v4.15-rc5 next-20171222]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Arvind-Yadav/MIPS-Alchemy-constify-gpio_led/20171227-043658
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git for-next
config: arm-multi_v5_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/mach-orion5x/dns323-setup.c: In function 'dns323_init':
>> arch/arm/mach-orion5x/dns323-setup.c:577:32: error: assignment of member 'active_low' in read-only object
       dns323ab_leds[0].active_low = 1;
                                   ^

vim +/active_low +577 arch/arm/mach-orion5x/dns323-setup.c

6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  536  
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  537  static void __init dns323_init(void)
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  538  {
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  539  	/* Setup basic Orion functions. Need to be called early. */
9dd0b194 arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-03-27  540  	orion5x_init();
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  541  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  542  	/* Identify revision */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  543  	system_rev = dns323_identify_rev();
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  544  	pr_info("DNS-323: Identified HW revision %c1\n", 'A' + system_rev);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  545  
f93e4159 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-22  546  	/* Just to be tricky, the 5182 has a completely different
f93e4159 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-22  547  	 * set of MPP modes to the 5181.
f93e4159 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-22  548  	 */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  549  	switch(system_rev) {
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  550  	case DNS323_REV_A1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  551  		orion5x_mpp_conf(dns323a_mpp_modes);
79e90dd5 arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-05-28  552  		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  553  		break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  554  	case DNS323_REV_B1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  555  		orion5x_mpp_conf(dns323b_mpp_modes);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  556  		break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  557  	case DNS323_REV_C1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  558  		orion5x_mpp_conf(dns323c_mpp_modes);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  559  		break;
f93e4159 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-22  560  	}
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  561  
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  562  	/* setup flash mapping
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  563  	 * CS3 holds a 8 MB Spansion S29GL064M90TFIR4
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  564  	 */
4ca2c040 arch/arm/mach-orion5x/dns323-setup.c Thomas Petazzoni       2013-07-26  565  	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
4ca2c040 arch/arm/mach-orion5x/dns323-setup.c Thomas Petazzoni       2013-07-26  566  				    ORION_MBUS_DEVBUS_BOOT_ATTR,
4ca2c040 arch/arm/mach-orion5x/dns323-setup.c Thomas Petazzoni       2013-07-26  567  				    DNS323_NOR_BOOT_BASE,
5d1190ea arch/arm/mach-orion5x/dns323-setup.c Thomas Petazzoni       2013-03-21  568  				    DNS323_NOR_BOOT_SIZE);
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  569  	platform_device_register(&dns323_nor_flash);
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  570  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  571  	/* Sort out LEDs, Buttons and i2c devices */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  572  	switch(system_rev) {
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  573  	case DNS323_REV_A1:
b2a731aa arch/arm/mach-orion5x/dns323-setup.c Laurie Bradshaw        2010-02-10  574  		/* The 5181 power LED is active low and requires
b2a731aa arch/arm/mach-orion5x/dns323-setup.c Laurie Bradshaw        2010-02-10  575  		 * DNS323_GPIO_LED_POWER1 to also be low.
b2a731aa arch/arm/mach-orion5x/dns323-setup.c Laurie Bradshaw        2010-02-10  576  		 */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21 @577  		 dns323ab_leds[0].active_low = 1;
5ccc8dab arch/arm/mach-orion5x/dns323-setup.c Arnaud Patard          2010-04-03  578  		 gpio_request(DNS323_GPIO_LED_POWER1, "Power Led Enable");
b2a731aa arch/arm/mach-orion5x/dns323-setup.c Laurie Bradshaw        2010-02-10  579  		 gpio_direction_output(DNS323_GPIO_LED_POWER1, 0);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  580  		/* Fall through */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  581  	case DNS323_REV_B1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  582  		i2c_register_board_info(0, dns323ab_i2c_devices,
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  583  				ARRAY_SIZE(dns323ab_i2c_devices));
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  584  		break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  585  	case DNS323_REV_C1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  586  		/* Hookup LEDs & Buttons */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  587  		dns323_gpio_leds.dev.platform_data = &dns323c_led_data;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  588  		dns323_button_device.dev.platform_data = &dns323c_button_data;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  589  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  590  		/* Hookup i2c devices and fan driver */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  591  		i2c_register_board_info(0, dns323c_i2c_devices,
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  592  				ARRAY_SIZE(dns323c_i2c_devices));
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  593  		platform_device_register_simple("dns323c-fan", 0, NULL, 0);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  594  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  595  		/* Register fixup for the PHY LEDs */
32ff4971 arch/arm/mach-orion5x/dns323-setup.c Arnd Bergmann          2014-03-13  596  		if (!IS_BUILTIN(CONFIG_PHYLIB))
32ff4971 arch/arm/mach-orion5x/dns323-setup.c Arnd Bergmann          2014-03-13  597  			break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  598  		phy_register_fixup_for_uid(MARVELL_PHY_ID_88E1118,
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  599  					   MARVELL_PHY_ID_MASK,
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  600  					   dns323c_phy_fixup);
b2a731aa arch/arm/mach-orion5x/dns323-setup.c Laurie Bradshaw        2010-02-10  601  	}
b2a731aa arch/arm/mach-orion5x/dns323-setup.c Laurie Bradshaw        2010-02-10  602  
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  603  	platform_device_register(&dns323_gpio_leds);
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  604  	platform_device_register(&dns323_button_device);
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  605  
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  606  	/*
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  607  	 * Configure peripherals.
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  608  	 */
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  609  	if (dns323_read_mac_addr() < 0)
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  610  		printk("DNS-323: Failed to read MAC address\n");
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  611  	orion5x_ehci0_init();
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  612  	orion5x_eth_init(&dns323_eth_data);
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  613  	orion5x_i2c_init();
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  614  	orion5x_uart0_init();
a93f44c1 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-19  615  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  616  	/* Remaining GPIOs */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  617  	switch(system_rev) {
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  618  	case DNS323_REV_A1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  619  		/* Poweroff GPIO */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  620  		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  621  		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  622  			pr_err("DNS-323: failed to setup power-off GPIO\n");
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  623  		pm_power_off = dns323a_power_off;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  624  		break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  625  	case DNS323_REV_B1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  626  		/* 5182 built-in SATA init */
f93e4159 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-22  627  		orion5x_sata_init(&dns323_sata_data);
f93e4159 arch/arm/mach-orion5x/dns323-setup.c Matt Palmer            2008-10-22  628  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  629  		/* The DNS323 rev B1 has flag to indicate the system is up.
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  630  		 * Without this flag set, power LED will flash and cannot be
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  631  		 * controlled via leds-gpio.
cf11052a arch/arm/mach-orion5x/dns323-setup.c Erik Benada            2010-01-24  632  		 */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  633  		if (gpio_request(DNS323_GPIO_SYSTEM_UP, "SYS_READY") == 0)
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  634  			gpio_direction_output(DNS323_GPIO_SYSTEM_UP, 1);
cf11052a arch/arm/mach-orion5x/dns323-setup.c Erik Benada            2010-01-24  635  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  636  		/* Poweroff GPIO */
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  637  		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
044f6c7c arch/arm/mach-orion5x/dns323-setup.c Lennert Buytenhek      2008-04-22  638  		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  639  			pr_err("DNS-323: failed to setup power-off GPIO\n");
cf11052a arch/arm/mach-orion5x/dns323-setup.c Erik Benada            2010-01-24  640  		pm_power_off = dns323b_power_off;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  641  		break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  642  	case DNS323_REV_C1:
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  643  		/* 5182 built-in SATA init */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  644  		orion5x_sata_init(&dns323_sata_data);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  645  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  646  		/* Poweroff GPIO */
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  647  		if (gpio_request(DNS323C_GPIO_POWER_OFF, "POWEROFF") != 0 ||
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  648  		    gpio_direction_output(DNS323C_GPIO_POWER_OFF, 0) != 0)
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  649  			pr_err("DNS-323: failed to setup power-off GPIO\n");
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  650  		pm_power_off = dns323c_power_off;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  651  
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  652  		/* Now, -this- should theorically be done by the sata_mv driver
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  653  		 * once I figure out what's going on there. Maybe the behaviour
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  654  		 * of the LEDs should be somewhat passed via the platform_data.
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  655  		 * for now, just whack the register and make the LEDs happy
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  656  		 *
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  657  		 * Note: AFAIK, rev B1 needs the same treatement but I'll let
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  658  		 * somebody else test it.
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  659  		 */
3904a393 arch/arm/mach-orion5x/dns323-setup.c Thomas Petazzoni       2012-09-11  660  		writel(0x5, ORION5X_SATA_VIRT_BASE + 0x2c);
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  661  		break;
6e2daa49 arch/arm/mach-orion5x/dns323-setup.c Benjamin Herrenschmidt 2010-06-21  662  	}
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  663  }
555a3656 arch/arm/mach-orion/dns323-setup.c   Herbert Valerio Riedel 2007-11-12  664  

:::::: The code at line 577 was first introduced by commit
:::::: 6e2daa49420777190c133d7097dd8d5c05b475ac [ARM] orion5x: Base support for DNS-323 rev C1

:::::: TO: Benjamin Herrenschmidt <benh@kernel.crashing.org>
:::::: CC: Nicolas Pitre <nico@fluxnic.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29878 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171227/de105675/attachment-0001.gz>
