From: lkp@intel.com (kbuild test robot)
Date: Sun, 17 Jun 2018 20:10:48 +0800
Subject: [arm-platforms:irq/fixes-4.19 23/23]
 drivers/irqchip/irq-gic-v3-its.c:2335:13: error: 'nr_cpu_idx' undeclared;
 did you mean 'nr_cpu_ids'?
Message-ID: <201806172046.o5ARazOK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/fixes-4.19
head:   2e077035935196976aa09ec043257efd56519810
commit: 2e077035935196976aa09ec043257efd56519810 [23/23] irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2e077035935196976aa09ec043257efd56519810
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-gic-v3-its.c: In function 'its_irq_domain_activate':
>> drivers/irqchip/irq-gic-v3-its.c:2335:13: error: 'nr_cpu_idx' undeclared (first use in this function); did you mean 'nr_cpu_ids'?
     if (cpu >= nr_cpu_idx) {
                ^~~~~~~~~~
                nr_cpu_ids
   drivers/irqchip/irq-gic-v3-its.c:2335:13: note: each undeclared identifier is reported only once for each function it appears in

vim +2335 drivers/irqchip/irq-gic-v3-its.c

  2320	
  2321	static int its_irq_domain_activate(struct irq_domain *domain,
  2322					   struct irq_data *d, bool reserve)
  2323	{
  2324		struct its_device *its_dev = irq_data_get_irq_chip_data(d);
  2325		u32 event = its_get_event_id(d);
  2326		const struct cpumask *cpu_mask = cpu_online_mask;
  2327		int cpu;
  2328	
  2329		/* get the cpu_mask of local node */
  2330		if (its_dev->its->numa_node >= 0)
  2331			cpu_mask = cpumask_of_node(its_dev->its->numa_node);
  2332	
  2333		/* Bind the LPI to the first possible CPU */
  2334		cpu = cpumask_first_and(cpu_mask, cpu_online_mask);
> 2335		if (cpu >= nr_cpu_idx) {
  2336			if (its_dev->its->flags & ITS_FLAGS_WORKAROUND_CAVIUM_23144)
  2337				return -EINVAL;
  2338	
  2339			cpu = cpumask_first(cpu_online_mask);
  2340		}
  2341	
  2342		its_dev->event_map.col_map[event] = cpu;
  2343		irq_data_update_effective_affinity(d, cpumask_of(cpu));
  2344	
  2345		/* Map the GIC IRQ and event to the device */
  2346		its_send_mapti(its_dev, d->hwirq, event);
  2347		return 0;
  2348	}
  2349	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 37440 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180617/5a3fb4bf/attachment-0001.gz>
