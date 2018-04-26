From: lkp@intel.com (kbuild test robot)
Date: Thu, 26 Apr 2018 17:32:03 +0800
Subject: [PATCH V3 3/3] cpufreq: add suspend/resume support in Armada
 37xx DVFS driver
In-Reply-To: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
References: <e98965068836e673ea826e8a03fd01e168fce3ed.1524561482.git.viresh.kumar@linaro.org>
Message-ID: <201804261439.n2Ff25A0%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

I love your patch! Yet something to improve:

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.17-rc2 next-20180424]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Viresh-Kumar/cpufreq-dt-Allow-platforms-to-provide-suspend-resume-hooks/20180426-101030
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/cpufreq/armada-37xx-cpufreq.c: In function 'armada37xx_cpufreq_driver_init':
>> drivers/cpufreq/armada-37xx-cpufreq.c:268:3: error: label 'put_clk' used but not defined
      goto put_clk;
      ^~~~

vim +/put_clk +268 drivers/cpufreq/armada-37xx-cpufreq.c

   211	
   212	static int __init armada37xx_cpufreq_driver_init(void)
   213	{
   214		struct cpufreq_dt_platform_data pdata;
   215		struct armada_37xx_dvfs *dvfs;
   216		struct platform_device *pdev;
   217		unsigned long freq;
   218		unsigned int cur_frequency;
   219		struct regmap *nb_pm_base;
   220		struct device *cpu_dev;
   221		int load_lvl, ret;
   222		struct clk *clk;
   223	
   224		nb_pm_base =
   225			syscon_regmap_lookup_by_compatible("marvell,armada-3700-nb-pm");
   226	
   227		if (IS_ERR(nb_pm_base))
   228			return -ENODEV;
   229	
   230		/* Before doing any configuration on the DVFS first, disable it */
   231		armada37xx_cpufreq_disable_dvfs(nb_pm_base);
   232	
   233		/*
   234		 * On CPU 0 register the operating points supported (which are
   235		 * the nominal CPU frequency and full integer divisions of
   236		 * it).
   237		 */
   238		cpu_dev = get_cpu_device(0);
   239		if (!cpu_dev) {
   240			dev_err(cpu_dev, "Cannot get CPU\n");
   241			return -ENODEV;
   242		}
   243	
   244		clk = clk_get(cpu_dev, 0);
   245		if (IS_ERR(clk)) {
   246			dev_err(cpu_dev, "Cannot get clock for CPU0\n");
   247			return PTR_ERR(clk);
   248		}
   249	
   250		/* Get nominal (current) CPU frequency */
   251		cur_frequency = clk_get_rate(clk);
   252		if (!cur_frequency) {
   253			dev_err(cpu_dev, "Failed to get clock rate for CPU\n");
   254			clk_put(clk);
   255			return -EINVAL;
   256		}
   257	
   258		dvfs = armada_37xx_cpu_freq_info_get(cur_frequency);
   259		if (!dvfs) {
   260			clk_put(clk);
   261			return -EINVAL;
   262		}
   263	
   264		armada37xx_cpufreq_state = kmalloc(sizeof(*armada37xx_cpufreq_state),
   265						   GFP_KERNEL);
   266		if (!armada37xx_cpufreq_state) {
   267			ret = -ENOMEM;
 > 268			goto put_clk;
   269		}
   270	
   271		armada37xx_cpufreq_state->regmap = nb_pm_base;
   272	
   273		armada37xx_cpufreq_dvfs_setup(nb_pm_base, clk, dvfs->divider);
   274		clk_put(clk);
   275	
   276		for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR;
   277		     load_lvl++) {
   278			freq = cur_frequency / dvfs->divider[load_lvl];
   279	
   280			ret = dev_pm_opp_add(cpu_dev, freq, 0);
   281			if (ret)
   282				goto remove_opp;
   283		}
   284	
   285		/* Now that everything is setup, enable the DVFS at hardware level */
   286		armada37xx_cpufreq_enable_dvfs(nb_pm_base);
   287	
   288		pdata.suspend = armada37xx_cpufreq_suspend;
   289		pdata.resume = armada37xx_cpufreq_resume;
   290	
   291		pdev = platform_device_register_data(NULL, "cpufreq-dt", -1, &pdata,
   292						     sizeof(pdata));
   293		ret = PTR_ERR_OR_ZERO(pdev);
   294		if (ret)
   295			goto disable_dvfs;
   296	
   297		return 0;
   298	
   299	disable_dvfs:
   300		armada37xx_cpufreq_disable_dvfs(nb_pm_base);
   301	remove_opp:
   302		/* clean-up the already added opp before leaving */
   303		while (load_lvl-- > ARMADA_37XX_DVFS_LOAD_0) {
   304			freq = cur_frequency / dvfs->divider[load_lvl];
   305			dev_pm_opp_remove(cpu_dev, freq);
   306		}
   307	
   308		kfree(armada37xx_cpufreq_state);
   309	
   310		return ret;
   311	}
   312	/* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
   313	late_initcall(armada37xx_cpufreq_driver_init);
   314	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65227 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180426/314b0f77/attachment-0001.gz>
