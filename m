From: lkp@intel.com (kbuild test robot)
Date: Sat, 21 Jul 2018 06:17:42 +0800
Subject: [PATCH RESEND 3/7] of: address: Add parent pointer to the
 __of_translate_address args
In-Reply-To: <2f1db1ad423dcc845cab311432826da4976d2363.1532098561.git-series.maxime.ripard@bootlin.com>
References: <2f1db1ad423dcc845cab311432826da4976d2363.1532098561.git-series.maxime.ripard@bootlin.com>
Message-ID: <201807210600.vaStMI4d%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

I love your patch! Yet something to improve:

[auto build test ERROR on ]

url:    https://github.com/0day-ci/linux/commits/Maxime-Ripard/sunxi-Add-DT-representation-for-the-MBUS-controller/20180721-052652
base:    
config: x86_64-randconfig-x011-201828 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers//of/address.c: In function 'of_translate_ioport':
>> drivers//of/address.c:742:38: error: passing argument 2 of '__of_translate_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
                                         ^~~~~~~
   drivers//of/address.c:571:12: note: expected 'struct device_node *' but argument is of type 'const __be32 * {aka const unsigned int *}'
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers//of/address.c:742:47: error: passing argument 3 of '__of_translate_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
                                                  ^~~~~~~~
   drivers//of/address.c:571:12: note: expected 'const __be32 * {aka const unsigned int *}' but argument is of type 'char *'
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers//of/address.c:742:57: error: passing argument 4 of '__of_translate_address' from incompatible pointer type [-Werror=incompatible-pointer-types]
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
                                                            ^
   drivers//of/address.c:571:12: note: expected 'const char *' but argument is of type 'struct device_node **'
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
>> drivers//of/address.c:742:10: error: too few arguments to function '__of_translate_address'
     taddr = __of_translate_address(dev, in_addr, "ranges", &host);
             ^~~~~~~~~~~~~~~~~~~~~~
   drivers//of/address.c:571:12: note: declared here
    static u64 __of_translate_address(struct device_node *dev,
               ^~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__of_translate_address +742 drivers//of/address.c

dbbdee94 Grant Likely              2010-06-08  556  
dbbdee94 Grant Likely              2010-06-08  557  /*
dbbdee94 Grant Likely              2010-06-08  558   * Translate an address from the device-tree into a CPU physical address,
dbbdee94 Grant Likely              2010-06-08  559   * this walks up the tree and applies the various bus mappings on the
dbbdee94 Grant Likely              2010-06-08  560   * way.
dbbdee94 Grant Likely              2010-06-08  561   *
dbbdee94 Grant Likely              2010-06-08  562   * Note: We consider that crossing any level with #size-cells == 0 to mean
dbbdee94 Grant Likely              2010-06-08  563   * that translation is impossible (that is we are not dealing with a value
dbbdee94 Grant Likely              2010-06-08  564   * that can be mapped to a cpu physical address). This is not really specified
dbbdee94 Grant Likely              2010-06-08  565   * that way, but this is traditionally the way IBM at least do things
65af618d Zhichang Yuan             2018-03-15  566   *
65af618d Zhichang Yuan             2018-03-15  567   * Whenever the translation fails, the *host pointer will be set to the
65af618d Zhichang Yuan             2018-03-15  568   * device that had registered logical PIO mapping, and the return code is
65af618d Zhichang Yuan             2018-03-15  569   * relative to that node.
dbbdee94 Grant Likely              2010-06-08  570   */
47b1e689 Kim Phillips              2012-10-08 @571  static u64 __of_translate_address(struct device_node *dev,
0e8dae87 Maxime Ripard             2018-07-20  572  				  struct device_node *parent,
65af618d Zhichang Yuan             2018-03-15  573  				  const __be32 *in_addr, const char *rprop,
65af618d Zhichang Yuan             2018-03-15  574  				  struct device_node **host)
dbbdee94 Grant Likely              2010-06-08  575  {
dbbdee94 Grant Likely              2010-06-08  576  	struct of_bus *bus, *pbus;
47b1e689 Kim Phillips              2012-10-08  577  	__be32 addr[OF_MAX_ADDR_CELLS];
dbbdee94 Grant Likely              2010-06-08  578  	int na, ns, pna, pns;
dbbdee94 Grant Likely              2010-06-08  579  	u64 result = OF_BAD_ADDR;
dbbdee94 Grant Likely              2010-06-08  580  
0d638a07 Rob Herring               2017-06-01  581  	pr_debug("** translation for device %pOF **\n", dev);
dbbdee94 Grant Likely              2010-06-08  582  
dbbdee94 Grant Likely              2010-06-08  583  	/* Increase refcount at current level */
dbbdee94 Grant Likely              2010-06-08  584  	of_node_get(dev);
dbbdee94 Grant Likely              2010-06-08  585  
0e8dae87 Maxime Ripard             2018-07-20  586  	if (!parent) {
65af618d Zhichang Yuan             2018-03-15  587  		*host = NULL;
dbbdee94 Grant Likely              2010-06-08  588  		/* Get parent & match bus type */
dbbdee94 Grant Likely              2010-06-08  589  		parent = of_get_parent(dev);
dbbdee94 Grant Likely              2010-06-08  590  		if (parent == NULL)
dbbdee94 Grant Likely              2010-06-08  591  			goto bail;
0e8dae87 Maxime Ripard             2018-07-20  592  	}
0e8dae87 Maxime Ripard             2018-07-20  593  
dbbdee94 Grant Likely              2010-06-08  594  	bus = of_match_bus(parent);
dbbdee94 Grant Likely              2010-06-08  595  
59f5ca48 Andrew Murray             2012-12-13  596  	/* Count address cells & copy address locally */
dbbdee94 Grant Likely              2010-06-08  597  	bus->count_cells(dev, &na, &ns);
dbbdee94 Grant Likely              2010-06-08  598  	if (!OF_CHECK_COUNTS(na, ns)) {
0d638a07 Rob Herring               2017-06-01  599  		pr_debug("Bad cell count for %pOF\n", dev);
dbbdee94 Grant Likely              2010-06-08  600  		goto bail;
dbbdee94 Grant Likely              2010-06-08  601  	}
dbbdee94 Grant Likely              2010-06-08  602  	memcpy(addr, in_addr, na * 4);
dbbdee94 Grant Likely              2010-06-08  603  
0d638a07 Rob Herring               2017-06-01  604  	pr_debug("bus is %s (na=%d, ns=%d) on %pOF\n",
0d638a07 Rob Herring               2017-06-01  605  	    bus->name, na, ns, parent);
606ad42a Rob Herring               2016-06-15  606  	of_dump_addr("translating address:", addr, na);
dbbdee94 Grant Likely              2010-06-08  607  
dbbdee94 Grant Likely              2010-06-08  608  	/* Translate */
dbbdee94 Grant Likely              2010-06-08  609  	for (;;) {
65af618d Zhichang Yuan             2018-03-15  610  		struct logic_pio_hwaddr *iorange;
65af618d Zhichang Yuan             2018-03-15  611  
dbbdee94 Grant Likely              2010-06-08  612  		/* Switch to parent bus */
dbbdee94 Grant Likely              2010-06-08  613  		of_node_put(dev);
dbbdee94 Grant Likely              2010-06-08  614  		dev = parent;
dbbdee94 Grant Likely              2010-06-08  615  		parent = of_get_parent(dev);
dbbdee94 Grant Likely              2010-06-08  616  
dbbdee94 Grant Likely              2010-06-08  617  		/* If root, we have finished */
dbbdee94 Grant Likely              2010-06-08  618  		if (parent == NULL) {
606ad42a Rob Herring               2016-06-15  619  			pr_debug("reached root node\n");
dbbdee94 Grant Likely              2010-06-08  620  			result = of_read_number(addr, na);
dbbdee94 Grant Likely              2010-06-08  621  			break;
dbbdee94 Grant Likely              2010-06-08  622  		}
dbbdee94 Grant Likely              2010-06-08  623  
65af618d Zhichang Yuan             2018-03-15  624  		/*
65af618d Zhichang Yuan             2018-03-15  625  		 * For indirectIO device which has no ranges property, get
65af618d Zhichang Yuan             2018-03-15  626  		 * the address from reg directly.
65af618d Zhichang Yuan             2018-03-15  627  		 */
65af618d Zhichang Yuan             2018-03-15  628  		iorange = find_io_range_by_fwnode(&dev->fwnode);
65af618d Zhichang Yuan             2018-03-15  629  		if (iorange && (iorange->flags != LOGIC_PIO_CPU_MMIO)) {
65af618d Zhichang Yuan             2018-03-15  630  			result = of_read_number(addr + 1, na - 1);
65af618d Zhichang Yuan             2018-03-15  631  			pr_debug("indirectIO matched(%pOF) 0x%llx\n",
65af618d Zhichang Yuan             2018-03-15  632  				 dev, result);
65af618d Zhichang Yuan             2018-03-15  633  			*host = of_node_get(dev);
65af618d Zhichang Yuan             2018-03-15  634  			break;
65af618d Zhichang Yuan             2018-03-15  635  		}
65af618d Zhichang Yuan             2018-03-15  636  
dbbdee94 Grant Likely              2010-06-08  637  		/* Get new parent bus and counts */
dbbdee94 Grant Likely              2010-06-08  638  		pbus = of_match_bus(parent);
dbbdee94 Grant Likely              2010-06-08  639  		pbus->count_cells(dev, &pna, &pns);
dbbdee94 Grant Likely              2010-06-08  640  		if (!OF_CHECK_COUNTS(pna, pns)) {
0d638a07 Rob Herring               2017-06-01  641  			pr_err("Bad cell count for %pOF\n", dev);
dbbdee94 Grant Likely              2010-06-08  642  			break;
dbbdee94 Grant Likely              2010-06-08  643  		}
dbbdee94 Grant Likely              2010-06-08  644  
0d638a07 Rob Herring               2017-06-01  645  		pr_debug("parent bus is %s (na=%d, ns=%d) on %pOF\n",
0d638a07 Rob Herring               2017-06-01  646  		    pbus->name, pna, pns, parent);
dbbdee94 Grant Likely              2010-06-08  647  
dbbdee94 Grant Likely              2010-06-08  648  		/* Apply bus translation */
dbbdee94 Grant Likely              2010-06-08  649  		if (of_translate_one(dev, bus, pbus, addr, na, ns, pna, rprop))
dbbdee94 Grant Likely              2010-06-08  650  			break;
dbbdee94 Grant Likely              2010-06-08  651  
dbbdee94 Grant Likely              2010-06-08  652  		/* Complete the move up one level */
dbbdee94 Grant Likely              2010-06-08  653  		na = pna;
dbbdee94 Grant Likely              2010-06-08  654  		ns = pns;
dbbdee94 Grant Likely              2010-06-08  655  		bus = pbus;
dbbdee94 Grant Likely              2010-06-08  656  
606ad42a Rob Herring               2016-06-15  657  		of_dump_addr("one level translation:", addr, na);
dbbdee94 Grant Likely              2010-06-08  658  	}
dbbdee94 Grant Likely              2010-06-08  659   bail:
dbbdee94 Grant Likely              2010-06-08  660  	of_node_put(parent);
dbbdee94 Grant Likely              2010-06-08  661  	of_node_put(dev);
dbbdee94 Grant Likely              2010-06-08  662  
dbbdee94 Grant Likely              2010-06-08  663  	return result;
dbbdee94 Grant Likely              2010-06-08  664  }
dbbdee94 Grant Likely              2010-06-08  665  
0131d897 Sebastian Andrzej Siewior 2010-12-01  666  u64 of_translate_address(struct device_node *dev, const __be32 *in_addr)
dbbdee94 Grant Likely              2010-06-08  667  {
65af618d Zhichang Yuan             2018-03-15  668  	struct device_node *host;
65af618d Zhichang Yuan             2018-03-15  669  	u64 ret;
65af618d Zhichang Yuan             2018-03-15  670  
0e8dae87 Maxime Ripard             2018-07-20  671  	ret = __of_translate_address(dev, NULL, in_addr, "ranges", &host);
65af618d Zhichang Yuan             2018-03-15  672  	if (host) {
65af618d Zhichang Yuan             2018-03-15  673  		of_node_put(host);
65af618d Zhichang Yuan             2018-03-15  674  		return OF_BAD_ADDR;
65af618d Zhichang Yuan             2018-03-15  675  	}
65af618d Zhichang Yuan             2018-03-15  676  
65af618d Zhichang Yuan             2018-03-15  677  	return ret;
dbbdee94 Grant Likely              2010-06-08  678  }
dbbdee94 Grant Likely              2010-06-08  679  EXPORT_SYMBOL(of_translate_address);
dbbdee94 Grant Likely              2010-06-08  680  
0131d897 Sebastian Andrzej Siewior 2010-12-01  681  u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
dbbdee94 Grant Likely              2010-06-08  682  {
65af618d Zhichang Yuan             2018-03-15  683  	struct device_node *host;
65af618d Zhichang Yuan             2018-03-15  684  	u64 ret;
65af618d Zhichang Yuan             2018-03-15  685  
0e8dae87 Maxime Ripard             2018-07-20  686  	ret = __of_translate_address(dev, NULL, in_addr, "dma-ranges", &host);
65af618d Zhichang Yuan             2018-03-15  687  
65af618d Zhichang Yuan             2018-03-15  688  	if (host) {
65af618d Zhichang Yuan             2018-03-15  689  		of_node_put(host);
65af618d Zhichang Yuan             2018-03-15  690  		return OF_BAD_ADDR;
65af618d Zhichang Yuan             2018-03-15  691  	}
65af618d Zhichang Yuan             2018-03-15  692  
65af618d Zhichang Yuan             2018-03-15  693  	return ret;
dbbdee94 Grant Likely              2010-06-08  694  }
dbbdee94 Grant Likely              2010-06-08  695  EXPORT_SYMBOL(of_translate_dma_address);
dbbdee94 Grant Likely              2010-06-08  696  
0131d897 Sebastian Andrzej Siewior 2010-12-01  697  const __be32 *of_get_address(struct device_node *dev, int index, u64 *size,
dbbdee94 Grant Likely              2010-06-08  698  		    unsigned int *flags)
dbbdee94 Grant Likely              2010-06-08  699  {
0131d897 Sebastian Andrzej Siewior 2010-12-01  700  	const __be32 *prop;
dbbdee94 Grant Likely              2010-06-08  701  	unsigned int psize;
dbbdee94 Grant Likely              2010-06-08  702  	struct device_node *parent;
dbbdee94 Grant Likely              2010-06-08  703  	struct of_bus *bus;
dbbdee94 Grant Likely              2010-06-08  704  	int onesize, i, na, ns;
dbbdee94 Grant Likely              2010-06-08  705  
dbbdee94 Grant Likely              2010-06-08  706  	/* Get parent & match bus type */
dbbdee94 Grant Likely              2010-06-08  707  	parent = of_get_parent(dev);
dbbdee94 Grant Likely              2010-06-08  708  	if (parent == NULL)
dbbdee94 Grant Likely              2010-06-08  709  		return NULL;
dbbdee94 Grant Likely              2010-06-08  710  	bus = of_match_bus(parent);
dbbdee94 Grant Likely              2010-06-08  711  	bus->count_cells(dev, &na, &ns);
dbbdee94 Grant Likely              2010-06-08  712  	of_node_put(parent);
5d61b165 Stephen Warren            2012-07-25  713  	if (!OF_CHECK_ADDR_COUNT(na))
dbbdee94 Grant Likely              2010-06-08  714  		return NULL;
dbbdee94 Grant Likely              2010-06-08  715  
dbbdee94 Grant Likely              2010-06-08  716  	/* Get "reg" or "assigned-addresses" property */
dbbdee94 Grant Likely              2010-06-08  717  	prop = of_get_property(dev, bus->addresses, &psize);
dbbdee94 Grant Likely              2010-06-08  718  	if (prop == NULL)
dbbdee94 Grant Likely              2010-06-08  719  		return NULL;
dbbdee94 Grant Likely              2010-06-08  720  	psize /= 4;
dbbdee94 Grant Likely              2010-06-08  721  
dbbdee94 Grant Likely              2010-06-08  722  	onesize = na + ns;
dbbdee94 Grant Likely              2010-06-08  723  	for (i = 0; psize >= onesize; psize -= onesize, prop += onesize, i++)
dbbdee94 Grant Likely              2010-06-08  724  		if (i == index) {
dbbdee94 Grant Likely              2010-06-08  725  			if (size)
dbbdee94 Grant Likely              2010-06-08  726  				*size = of_read_number(prop + na, ns);
dbbdee94 Grant Likely              2010-06-08  727  			if (flags)
dbbdee94 Grant Likely              2010-06-08  728  				*flags = bus->get_flags(prop);
dbbdee94 Grant Likely              2010-06-08  729  			return prop;
dbbdee94 Grant Likely              2010-06-08  730  		}
dbbdee94 Grant Likely              2010-06-08  731  	return NULL;
dbbdee94 Grant Likely              2010-06-08  732  }
dbbdee94 Grant Likely              2010-06-08  733  EXPORT_SYMBOL(of_get_address);
dbbdee94 Grant Likely              2010-06-08  734  
65af618d Zhichang Yuan             2018-03-15  735  static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
65af618d Zhichang Yuan             2018-03-15  736  			u64 size)
65af618d Zhichang Yuan             2018-03-15  737  {
65af618d Zhichang Yuan             2018-03-15  738  	u64 taddr;
65af618d Zhichang Yuan             2018-03-15  739  	unsigned long port;
65af618d Zhichang Yuan             2018-03-15  740  	struct device_node *host;
65af618d Zhichang Yuan             2018-03-15  741  
65af618d Zhichang Yuan             2018-03-15 @742  	taddr = __of_translate_address(dev, in_addr, "ranges", &host);
65af618d Zhichang Yuan             2018-03-15  743  	if (host) {
65af618d Zhichang Yuan             2018-03-15  744  		/* host-specific port access */
65af618d Zhichang Yuan             2018-03-15  745  		port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
65af618d Zhichang Yuan             2018-03-15  746  		of_node_put(host);
65af618d Zhichang Yuan             2018-03-15  747  	} else {
65af618d Zhichang Yuan             2018-03-15  748  		/* memory-mapped I/O range */
65af618d Zhichang Yuan             2018-03-15  749  		port = pci_address_to_pio(taddr);
65af618d Zhichang Yuan             2018-03-15  750  	}
65af618d Zhichang Yuan             2018-03-15  751  
65af618d Zhichang Yuan             2018-03-15  752  	if (port == (unsigned long)-1)
65af618d Zhichang Yuan             2018-03-15  753  		return OF_BAD_ADDR;
65af618d Zhichang Yuan             2018-03-15  754  
65af618d Zhichang Yuan             2018-03-15  755  	return port;
65af618d Zhichang Yuan             2018-03-15  756  }
65af618d Zhichang Yuan             2018-03-15  757  

:::::: The code at line 742 was first introduced by commit
:::::: 65af618d2c559f8eb19d80d03a23029651a59de4 of: Add missing I/O range exception for indirect-IO devices

:::::: TO: Zhichang Yuan <yuanzhichang@hisilicon.com>
:::::: CC: Bjorn Helgaas <helgaas@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34695 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180721/a9ec3680/attachment-0001.gz>
