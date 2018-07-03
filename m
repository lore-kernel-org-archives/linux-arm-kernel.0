From: lkp@intel.com (kbuild test robot)
Date: Tue, 3 Jul 2018 10:05:34 +0800
Subject: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
In-Reply-To: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
References: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <201807030918.9GVhQmQf%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.18-rc3 next-20180702]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mathieu-Poirier/perf-Add-ioctl-for-PMU-driver-configuration/20180703-064327
config: s390-defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=s390 

All error/warnings (new ones prefixed by >>):

>> arch/s390/kernel/perf_cpum_sf.c:1606:1: error: expected identifier or '(' before '{' token
    {
    ^
>> arch/s390/kernel/perf_cpum_sf.c:1604:14: warning: 'aux_buffer_setup' used but never defined
    static void *aux_buffer_setup(struct perf_event *event, void **pages,
                 ^~~~~~~~~~~~~~~~

vim +1606 arch/s390/kernel/perf_cpum_sf.c

ca5955cd Pu Hou          2016-11-11  1589  
ca5955cd Pu Hou          2016-11-11  1590  /*
ca5955cd Pu Hou          2016-11-11  1591   * aux_buffer_setup() - Setup AUX buffer for diagnostic mode sampling
ca5955cd Pu Hou          2016-11-11  1592   * @cpu:	On which to allocate, -1 means current
ca5955cd Pu Hou          2016-11-11  1593   * @pages:	Array of pointers to buffer pages passed from perf core
ca5955cd Pu Hou          2016-11-11  1594   * @nr_pages:	Total pages
ca5955cd Pu Hou          2016-11-11  1595   * @snapshot:	Flag for snapshot mode
ca5955cd Pu Hou          2016-11-11  1596   *
ca5955cd Pu Hou          2016-11-11  1597   * This is the callback when setup an event using AUX buffer. Perf tool can
ca5955cd Pu Hou          2016-11-11  1598   * trigger this by an additional mmap() call on the event. Unlike the buffer
ca5955cd Pu Hou          2016-11-11  1599   * for basic samples, AUX buffer belongs to the event. It is scheduled with
ca5955cd Pu Hou          2016-11-11  1600   * the task among online cpus when it is a per-thread event.
ca5955cd Pu Hou          2016-11-11  1601   *
ca5955cd Pu Hou          2016-11-11  1602   * Return the private AUX buffer structure if success or NULL if fails.
ca5955cd Pu Hou          2016-11-11  1603   */
ceb39bf0 Mathieu Poirier 2018-07-02 @1604  static void *aux_buffer_setup(struct perf_event *event, void **pages,
ceb39bf0 Mathieu Poirier 2018-07-02  1605  			      int nr_pages, bool snapshot);
ca5955cd Pu Hou          2016-11-11 @1606  {
ca5955cd Pu Hou          2016-11-11  1607  	struct sf_buffer *sfb;
ca5955cd Pu Hou          2016-11-11  1608  	struct aux_buffer *aux;
ca5955cd Pu Hou          2016-11-11  1609  	unsigned long *new, *tail;
ca5955cd Pu Hou          2016-11-11  1610  	int i, n_sdbt;
ca5955cd Pu Hou          2016-11-11  1611  
ca5955cd Pu Hou          2016-11-11  1612  	if (!nr_pages || !pages)
ca5955cd Pu Hou          2016-11-11  1613  		return NULL;
ca5955cd Pu Hou          2016-11-11  1614  
ca5955cd Pu Hou          2016-11-11  1615  	if (nr_pages > CPUM_SF_MAX_SDB * CPUM_SF_SDB_DIAG_FACTOR) {
ca5955cd Pu Hou          2016-11-11  1616  		pr_err("AUX buffer size (%i pages) is larger than the "
ca5955cd Pu Hou          2016-11-11  1617  		       "maximum sampling buffer limit\n",
ca5955cd Pu Hou          2016-11-11  1618  		       nr_pages);
ca5955cd Pu Hou          2016-11-11  1619  		return NULL;
ca5955cd Pu Hou          2016-11-11  1620  	} else if (nr_pages < CPUM_SF_MIN_SDB * CPUM_SF_SDB_DIAG_FACTOR) {
ca5955cd Pu Hou          2016-11-11  1621  		pr_err("AUX buffer size (%i pages) is less than the "
ca5955cd Pu Hou          2016-11-11  1622  		       "minimum sampling buffer limit\n",
ca5955cd Pu Hou          2016-11-11  1623  		       nr_pages);
ca5955cd Pu Hou          2016-11-11  1624  		return NULL;
ca5955cd Pu Hou          2016-11-11  1625  	}
ca5955cd Pu Hou          2016-11-11  1626  
ca5955cd Pu Hou          2016-11-11  1627  	/* Allocate aux_buffer struct for the event */
ca5955cd Pu Hou          2016-11-11  1628  	aux = kmalloc(sizeof(struct aux_buffer), GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1629  	if (!aux)
ca5955cd Pu Hou          2016-11-11  1630  		goto no_aux;
ca5955cd Pu Hou          2016-11-11  1631  	sfb = &aux->sfb;
ca5955cd Pu Hou          2016-11-11  1632  
ca5955cd Pu Hou          2016-11-11  1633  	/* Allocate sdbt_index for fast reference */
ca5955cd Pu Hou          2016-11-11  1634  	n_sdbt = (nr_pages + CPUM_SF_SDB_PER_TABLE - 1) / CPUM_SF_SDB_PER_TABLE;
ca5955cd Pu Hou          2016-11-11  1635  	aux->sdbt_index = kmalloc_array(n_sdbt, sizeof(void *), GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1636  	if (!aux->sdbt_index)
ca5955cd Pu Hou          2016-11-11  1637  		goto no_sdbt_index;
ca5955cd Pu Hou          2016-11-11  1638  
ca5955cd Pu Hou          2016-11-11  1639  	/* Allocate sdb_index for fast reference */
ca5955cd Pu Hou          2016-11-11  1640  	aux->sdb_index = kmalloc_array(nr_pages, sizeof(void *), GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1641  	if (!aux->sdb_index)
ca5955cd Pu Hou          2016-11-11  1642  		goto no_sdb_index;
ca5955cd Pu Hou          2016-11-11  1643  
ca5955cd Pu Hou          2016-11-11  1644  	/* Allocate the first SDBT */
ca5955cd Pu Hou          2016-11-11  1645  	sfb->num_sdbt = 0;
ca5955cd Pu Hou          2016-11-11  1646  	sfb->sdbt = (unsigned long *) get_zeroed_page(GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1647  	if (!sfb->sdbt)
ca5955cd Pu Hou          2016-11-11  1648  		goto no_sdbt;
ca5955cd Pu Hou          2016-11-11  1649  	aux->sdbt_index[sfb->num_sdbt++] = (unsigned long)sfb->sdbt;
ca5955cd Pu Hou          2016-11-11  1650  	tail = sfb->tail = sfb->sdbt;
ca5955cd Pu Hou          2016-11-11  1651  
ca5955cd Pu Hou          2016-11-11  1652  	/*
ca5955cd Pu Hou          2016-11-11  1653  	 * Link the provided pages of AUX buffer to SDBT.
ca5955cd Pu Hou          2016-11-11  1654  	 * Allocate SDBT if needed.
ca5955cd Pu Hou          2016-11-11  1655  	 */
ca5955cd Pu Hou          2016-11-11  1656  	for (i = 0; i < nr_pages; i++, tail++) {
ca5955cd Pu Hou          2016-11-11  1657  		if (require_table_link(tail)) {
ca5955cd Pu Hou          2016-11-11  1658  			new = (unsigned long *) get_zeroed_page(GFP_KERNEL);
ca5955cd Pu Hou          2016-11-11  1659  			if (!new)
ca5955cd Pu Hou          2016-11-11  1660  				goto no_sdbt;
ca5955cd Pu Hou          2016-11-11  1661  			aux->sdbt_index[sfb->num_sdbt++] = (unsigned long)new;
ca5955cd Pu Hou          2016-11-11  1662  			/* Link current page to tail of chain */
ca5955cd Pu Hou          2016-11-11  1663  			*tail = (unsigned long)(void *) new + 1;
ca5955cd Pu Hou          2016-11-11  1664  			tail = new;
ca5955cd Pu Hou          2016-11-11  1665  		}
ca5955cd Pu Hou          2016-11-11  1666  		/* Tail is the entry in a SDBT */
ca5955cd Pu Hou          2016-11-11  1667  		*tail = (unsigned long)pages[i];
ca5955cd Pu Hou          2016-11-11  1668  		aux->sdb_index[i] = (unsigned long)pages[i];
ca5955cd Pu Hou          2016-11-11  1669  	}
ca5955cd Pu Hou          2016-11-11  1670  	sfb->num_sdb = nr_pages;
ca5955cd Pu Hou          2016-11-11  1671  
ca5955cd Pu Hou          2016-11-11  1672  	/* Link the last entry in the SDBT to the first SDBT */
ca5955cd Pu Hou          2016-11-11  1673  	*tail = (unsigned long) sfb->sdbt + 1;
ca5955cd Pu Hou          2016-11-11  1674  	sfb->tail = tail;
ca5955cd Pu Hou          2016-11-11  1675  
ca5955cd Pu Hou          2016-11-11  1676  	/*
ca5955cd Pu Hou          2016-11-11  1677  	 * Initial all SDBs are zeroed. Mark it as empty.
ca5955cd Pu Hou          2016-11-11  1678  	 * So there is no need to clear the full indicator
ca5955cd Pu Hou          2016-11-11  1679  	 * when this event is first added.
ca5955cd Pu Hou          2016-11-11  1680  	 */
ca5955cd Pu Hou          2016-11-11  1681  	aux->empty_mark = sfb->num_sdb - 1;
ca5955cd Pu Hou          2016-11-11  1682  
ca5955cd Pu Hou          2016-11-11  1683  	debug_sprintf_event(sfdbg, 4, "aux_buffer_setup: setup %lu SDBTs"
ca5955cd Pu Hou          2016-11-11  1684  			    " and %lu SDBs\n",
ca5955cd Pu Hou          2016-11-11  1685  			    sfb->num_sdbt, sfb->num_sdb);
ca5955cd Pu Hou          2016-11-11  1686  
ca5955cd Pu Hou          2016-11-11  1687  	return aux;
ca5955cd Pu Hou          2016-11-11  1688  
ca5955cd Pu Hou          2016-11-11  1689  no_sdbt:
ca5955cd Pu Hou          2016-11-11  1690  	/* SDBs (AUX buffer pages) are freed by caller */
ca5955cd Pu Hou          2016-11-11  1691  	for (i = 0; i < sfb->num_sdbt; i++)
ca5955cd Pu Hou          2016-11-11  1692  		free_page(aux->sdbt_index[i]);
ca5955cd Pu Hou          2016-11-11  1693  	kfree(aux->sdb_index);
ca5955cd Pu Hou          2016-11-11  1694  no_sdb_index:
ca5955cd Pu Hou          2016-11-11  1695  	kfree(aux->sdbt_index);
ca5955cd Pu Hou          2016-11-11  1696  no_sdbt_index:
ca5955cd Pu Hou          2016-11-11  1697  	kfree(aux);
ca5955cd Pu Hou          2016-11-11  1698  no_aux:
ca5955cd Pu Hou          2016-11-11  1699  	return NULL;
ca5955cd Pu Hou          2016-11-11  1700  }
ca5955cd Pu Hou          2016-11-11  1701  

:::::: The code at line 1606 was first introduced by commit
:::::: ca5955cdeae744edd3dcc65d677e833fc29658c2 s390/cpumf: introduce AUX buffer for dump diagnostic sample data

:::::: TO: Pu Hou <bjhoupu@linux.vnet.ibm.com>
:::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 10840 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180703/2e382d40/attachment-0001.gz>
