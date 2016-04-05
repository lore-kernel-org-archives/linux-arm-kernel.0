From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 5 Apr 2016 19:59:14 +0800
Subject: [arm-platforms:irq/percpu-partition 1/5]
 kernel/irq/irqdomain.c:268:13: error: 'const struct irq_domain_ops' has no
 member named 'select'
Message-ID: <201604051912.A6F2jtZv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/percpu-partition
head:   7b0d6b7f6f31f6e849b3195d87231246ce96df03
commit: 07d4b0d25aba679db1864881fa51f55d0540f006 [1/5] irqdomain: Allow domain matching on irq_fwspec
config: i386-randconfig-s0-04051858 (attached as .config)
reproduce:
        git checkout 07d4b0d25aba679db1864881fa51f55d0540f006
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   kernel/irq/irqdomain.c: In function 'irq_find_matching_fwspec':
>> kernel/irq/irqdomain.c:268:13: error: 'const struct irq_domain_ops' has no member named 'select'
      if (h->ops->select && fwspec->param_count)
                ^
   kernel/irq/irqdomain.c:269:15: error: 'const struct irq_domain_ops' has no member named 'select'
       rc = h->ops->select(h, fwspec, bus_token);
                  ^

vim +268 kernel/irq/irqdomain.c

   262		 * bus_token == DOMAIN_BUS_ANY matches any domain, any other
   263		 * values must generate an exact match for the domain to be
   264		 * selected.
   265		 */
   266		mutex_lock(&irq_domain_mutex);
   267		list_for_each_entry(h, &irq_domain_list, link) {
 > 268			if (h->ops->select && fwspec->param_count)
   269				rc = h->ops->select(h, fwspec, bus_token);
   270			else if (h->ops->match)
   271				rc = h->ops->match(h, to_of_node(fwnode), bus_token);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25161 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160405/7234a7d4/attachment-0001.obj>
