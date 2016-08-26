From: lkp@intel.com (kbuild test robot)
Date: Sat, 27 Aug 2016 07:28:12 +0800
Subject: [PATCH v5 09/16] PM / cpu_domains: Initialize CPU PM domains
 from DT
In-Reply-To: <1472242678-33700-10-git-send-email-lina.iyer@linaro.org>
Message-ID: <201608270717.ribEwoZc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lina,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.8-rc3 next-20160825]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lina-Iyer/PM-SoC-idle-support-using-PM-domains/20160827-042847
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-r0-201634 (attached as .config)
compiler: gcc-5 (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/base/power/cpu_domains.c:327:5: error: redefinition of 'of_setup_cpu_pd_single'
    int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
        ^
   In file included from drivers/base/power/cpu_domains.c:13:0:
   include/linux/cpu_domains.h:59:19: note: previous definition of 'of_setup_cpu_pd_single' was here
    static inline int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
                      ^
>> drivers/base/power/cpu_domains.c:368:5: error: redefinition of 'of_setup_cpu_pd'
    int of_setup_cpu_pd(const struct cpu_pd_ops *ops)
        ^
   In file included from drivers/base/power/cpu_domains.c:13:0:
   include/linux/cpu_domains.h:62:19: note: previous definition of 'of_setup_cpu_pd' was here
    static inline int of_setup_cpu_pd(const struct cpu_pd_ops *ops)
                      ^

vim +/of_setup_cpu_pd_single +327 drivers/base/power/cpu_domains.c

   321	 * If the CPU PM domain exists already, then the CPU is attached to
   322	 * that CPU PD. If it doesn't, the domain is created, the @ops are
   323	 * set for power_on/power_off callbacks and then the CPU is attached
   324	 * to that domain. If the domain was created outside this framework,
   325	 * then we do not attach the CPU to the domain.
   326	 */
 > 327	int of_setup_cpu_pd_single(int cpu, const struct cpu_pd_ops *ops)
   328	{
   329	
   330		struct device_node *dn, *np;
   331		struct generic_pm_domain *genpd;
   332		struct cpu_pm_domain *cpu_pd;
   333	
   334		np = of_get_cpu_node(cpu, NULL);
   335		if (!np)
   336			return -ENODEV;
   337	
   338		dn = of_parse_phandle(np, "power-domains", 0);
   339		of_node_put(np);
   340		if (!dn)
   341			return -ENODEV;
   342	
   343		/* Find the genpd for this CPU, create if not found */
   344		genpd = of_get_cpu_domain(dn, ops, cpu);
   345		of_node_put(dn);
   346		if (IS_ERR(genpd))
   347			return PTR_ERR(genpd);
   348	
   349		cpu_pd = to_cpu_pd(genpd);
   350		if (!cpu_pd) {
   351			pr_err("%s: Genpd was created outside CPU PM domains\n",
   352					__func__);
   353			return -ENOENT;
   354		}
   355	
   356		return cpu_pd_attach_cpu(genpd, cpu);
   357	}
   358	EXPORT_SYMBOL(of_setup_cpu_pd_single);
   359	
   360	/**
   361	 * of_setup_cpu_pd() - Setup the PM domains for all CPUs
   362	 *
   363	 * @ops: The PM domain suspend/resume ops for all the domains
   364	 *
   365	 * Setup the CPU PM domain and attach all possible CPUs to their respective
   366	 * domains. The domains are created if not already and then attached.
   367	 */
 > 368	int of_setup_cpu_pd(const struct cpu_pd_ops *ops)
   369	{
   370		int cpu;
   371		int ret;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27955 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160827/b829dff8/attachment-0001.obj>
