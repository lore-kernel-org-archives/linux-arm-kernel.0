From: lkp@intel.com (kbuild test robot)
Date: Fri, 28 Oct 2016 07:34:00 +0800
Subject: [PATCH v3 1/3] PM / OPP: Expose _of_get_opp_desc_node as
 dev_pm_opp API
In-Reply-To: <20161027214131.1725-2-d-gerlach@ti.com>
Message-ID: <201610280714.775pYCIq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.9-rc2]
[cannot apply to pm/linux-next next-20161027]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Dave-Gerlach/cpufreq-Introduce-TI-CPUFreq-OPP-Driver/20161028-054633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/base/power/opp/of.c:184:6: error: redefinition of 'dev_pm_opp_of_remove_table'
    void dev_pm_opp_of_remove_table(struct device *dev)
         ^
   In file included from drivers/base/power/opp/opp.h:21:0,
                    from drivers/base/power/opp/of.c:22:
   include/linux/pm_opp.h:218:20: note: previous definition of 'dev_pm_opp_of_remove_table' was here
    static inline void dev_pm_opp_of_remove_table(struct device *dev)
                       ^
>> drivers/base/power/opp/of.c:191:21: error: redefinition of 'dev_pm_opp_of_get_opp_desc_node'
    struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
                        ^
   In file included from drivers/base/power/opp/opp.h:21:0,
                    from drivers/base/power/opp/of.c:22:
   include/linux/pm_opp.h:236:35: note: previous definition of 'dev_pm_opp_of_get_opp_desc_node' was here
    static inline struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
                                      ^
   drivers/base/power/opp/of.c:434:5: error: redefinition of 'dev_pm_opp_of_add_table'
    int dev_pm_opp_of_add_table(struct device *dev)
        ^
   In file included from drivers/base/power/opp/opp.h:21:0,
                    from drivers/base/power/opp/of.c:22:
   include/linux/pm_opp.h:213:19: note: previous definition of 'dev_pm_opp_of_add_table' was here
    static inline int dev_pm_opp_of_add_table(struct device *dev)
                      ^
   drivers/base/power/opp/of.c:474:6: error: redefinition of 'dev_pm_opp_of_cpumask_remove_table'
    void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
         ^
   In file included from drivers/base/power/opp/opp.h:21:0,
                    from drivers/base/power/opp/of.c:22:
   include/linux/pm_opp.h:227:20: note: previous definition of 'dev_pm_opp_of_cpumask_remove_table' was here
    static inline void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
                       ^
   drivers/base/power/opp/of.c:492:5: error: redefinition of 'dev_pm_opp_of_cpumask_add_table'
    int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
        ^
   In file included from drivers/base/power/opp/opp.h:21:0,
                    from drivers/base/power/opp/of.c:22:
   include/linux/pm_opp.h:222:19: note: previous definition of 'dev_pm_opp_of_cpumask_add_table' was here
    static inline int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
                      ^
   drivers/base/power/opp/of.c:545:5: error: redefinition of 'dev_pm_opp_of_get_sharing_cpus'
    int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev,
        ^
   In file included from drivers/base/power/opp/opp.h:21:0,
                    from drivers/base/power/opp/of.c:22:
   include/linux/pm_opp.h:231:19: note: previous definition of 'dev_pm_opp_of_get_sharing_cpus' was here
    static inline int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
                      ^

vim +/dev_pm_opp_of_get_opp_desc_node +191 drivers/base/power/opp/of.c

   178	 * Locking: The internal opp_table and opp structures are RCU protected.
   179	 * Hence this function indirectly uses RCU updater strategy with mutex locks
   180	 * to keep the integrity of the internal data structures. Callers should ensure
   181	 * that this function is *NOT* called under RCU protection or in contexts where
   182	 * mutex cannot be locked.
   183	 */
 > 184	void dev_pm_opp_of_remove_table(struct device *dev)
   185	{
   186		_dev_pm_opp_remove_table(dev, false);
   187	}
   188	EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
   189	
   190	/* Returns opp descriptor node for a device, caller must do of_node_put() */
 > 191	struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev)
   192	{
   193		/*
   194		 * TODO: Support for multiple OPP tables.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 46043 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161028/0c934d6a/attachment-0001.gz>
