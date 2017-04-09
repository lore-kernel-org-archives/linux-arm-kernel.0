From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 9 Apr 2017 08:52:11 +0800
Subject: [arm:phy 18/50] drivers/net//phy/marvell10g.c:65:2: note: in
 expansion of macro 'if'
Message-ID: <201704090809.yON2PMpO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   2a416f7ccadf42117c5e02bb77c4af72197771c8
commit: bf9689f7fa0c6be6afd87735fb4e5f0a2f7812fd [18/50] net: phy: add Marvell Alaska X 88X3310 10Gigabit PHY support
config: i386-randconfig-x013-201715 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout bf9689f7fa0c6be6afd87735fb4e5f0a2f7812fd
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/phy.h:19:0,
                    from drivers/net//phy/marvell10g.c:7:
   drivers/net//phy/marvell10g.c: In function 'mv3310_config_init':
   drivers/net//phy/marvell10g.c:67:27: error: 'PHY_INTERFACE_MODE_XAUI' undeclared (first use in this function)
         phydev->interface != PHY_INTERFACE_MODE_XAUI &&
                              ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/net//phy/marvell10g.c:65:2: note: in expansion of macro 'if'
     if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
     ^~
   drivers/net//phy/marvell10g.c:67:27: note: each undeclared identifier is reported only once for each function it appears in
         phydev->interface != PHY_INTERFACE_MODE_XAUI &&
                              ^
   include/linux/compiler.h:160:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/net//phy/marvell10g.c:65:2: note: in expansion of macro 'if'
     if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
     ^~

vim +/if +65 drivers/net//phy/marvell10g.c

     1	/*
     2	 * Marvell 10G 88x3310 PHY driver
     3	 *
     4	 * Based upon the ID registers, this PHY appears to be a mixture of IPs
     5	 * from two different companies.
     6	 */
   > 7	#include <linux/phy.h>
     8	
     9	enum {
    10		/* These registers appear at 0x800X and 0xa00X - the 0xa00X control
    11		 * registers appear to set themselves to the 0x800X when AN is
    12		 * restarted, but status registers appear readable from either.
    13		 */
    14		MV_AN_CTRL1000		= 0x8000, /* 1000base-T control register */
    15		MV_AN_STAT1000		= 0x8001, /* 1000base-T status register */
    16	
    17		MV_AN_RESULT		= 0xa016,
    18		MV_AN_RESULT_SPD_10	= BIT(12),
    19		MV_AN_RESULT_SPD_100	= BIT(13),
    20		MV_AN_RESULT_SPD_1000	= BIT(14),
    21		MV_AN_RESULT_SPD_10000	= BIT(15),
    22	};
    23	
    24	static int mv3310_modify(struct phy_device *phydev, int devad, u16 reg,
    25				 u16 mask, u16 bits)
    26	{
    27		int old, val, ret;
    28	
    29		old = phy_read_mmd(phydev, devad, reg);
    30		if (old < 0)
    31			return old;
    32	
    33		val = (old & ~mask) | (bits & mask);
    34		if (val == old)
    35			return 0;
    36	
    37		ret = phy_write_mmd(phydev, devad, reg, val);
    38	
    39		return ret < 0 ? ret : 1;
    40	}
    41	
    42	static int mv3310_probe(struct phy_device *phydev)
    43	{
    44		u32 mmd_mask = MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
    45	
    46		if (!phydev->is_c45 ||
    47		    (phydev->c45_ids.devices_in_package & mmd_mask) != mmd_mask)
    48			return -ENODEV;
    49	
    50		return 0;
    51	}
    52	
    53	static int mv3310_soft_reset(struct phy_device *phydev)
    54	{
    55		return 0;
    56	}
    57	
    58	static int mv3310_config_init(struct phy_device *phydev)
    59	{
    60		__ETHTOOL_DECLARE_LINK_MODE_MASK(supported) = { 0, };
    61		u32 mask;
    62		int val;
    63	
    64		/* Check that the PHY interface type is compatible */
  > 65		if (phydev->interface != PHY_INTERFACE_MODE_SGMII &&
    66		    phydev->interface != PHY_INTERFACE_MODE_XGMII &&
    67		    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
    68		    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24961 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170409/2082f59e/attachment-0001.gz>
