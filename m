From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 28 Nov 2017 20:57:51 +0800
Subject: [arm:phy 25/27] drivers/net//phy/mdio_bus.c:542:1: error:
 redefinition of '__kstrtab___mdiobus_read'
Message-ID: <201711282049.F6B6Szqx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   git://git.armlinux.org.uk/~rmk/linux-arm.git phy
head:   95353e987453895fce5681bfa7077ae165af7cdb
commit: 442f18665fea21c9a2c571aaace96f7e36253962 [25/27] net: mdiobus: add unlocked accessors
config: tile-allyesconfig (attached as .config)
compiler: tilegx-linux-gcc (GCC) 4.6.2
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 442f18665fea21c9a2c571aaace96f7e36253962
        # save the attached .config to linux build tree
        make.cross ARCH=tile 

All errors (new ones prefixed by >>):

>> drivers/net//phy/mdio_bus.c:542:1: error: redefinition of '__kstrtab___mdiobus_read'
   drivers/net//phy/mdio_bus.c:517:1: note: previous definition of '__kstrtab___mdiobus_read' was here
   drivers/net//phy/mdio_bus.c:542:1: error: redefinition of '__ksymtab___mdiobus_read'
   drivers/net//phy/mdio_bus.c:517:1: note: previous definition of '__ksymtab___mdiobus_read' was here

vim +/__kstrtab___mdiobus_read +542 drivers/net//phy/mdio_bus.c

   518	
   519	/**
   520	 * __mdiobus_write - Unlocked version of the mdiobus_write function
   521	 * @bus: the mii_bus struct
   522	 * @addr: the phy address
   523	 * @regnum: register number to write
   524	 * @val: value to write to @regnum
   525	 *
   526	 * Write a MDIO bus register. Caller must hold the mdio bus lock.
   527	 *
   528	 * NOTE: MUST NOT be called from interrupt context.
   529	 */
   530	int __mdiobus_write(struct mii_bus *bus, int addr, int regnum, int val)
   531	{
   532		int err;
   533	
   534		WARN_ON_ONCE(!mutex_is_locked(&bus->mdio_lock));
   535	
   536		err = bus->write(bus, addr, regnum, val);
   537	
   538		trace_mdio_access(bus, 0, addr, regnum, val, err);
   539	
   540		return err;
   541	}
 > 542	EXPORT_SYMBOL(__mdiobus_read);
   543	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51517 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/afe002eb/attachment-0001.gz>
