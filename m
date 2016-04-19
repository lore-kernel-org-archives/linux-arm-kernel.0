From: lkp@intel.com (kbuild test robot)
Date: Tue, 19 Apr 2016 20:49:52 +0800
Subject: [PATCH v4 1/5] ACPI / processor_idle: introduce
 ARCH_SUPPORTS_ACPI_PROCESSOR_CSTATE
In-Reply-To: <1461069013-13292-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <201604192041.pUqHza4O%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on pm/linux-next]
[also build test ERROR on v4.6-rc4 next-20160419]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/ACPI-processor_idle-Add-ACPI-v6-0-LPI-support/20160419-203500
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-x000-201616 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

Note: the linux-review/Sudeep-Holla/ACPI-processor_idle-Add-ACPI-v6-0-LPI-support/20160419-203500 HEAD c51fc2a756d7b0dce908a4ca043d1d458c400af5 builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   drivers/acpi/processor_idle.c: In function 'acpi_processor_cstate_first_run_checks':
>> drivers/acpi/processor_idle.c:943:3: error: 'status' undeclared (first use in this function)
      status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
      ^
   drivers/acpi/processor_idle.c:943:3: note: each undeclared identifier is reported only once for each function it appears in
   drivers/acpi/processor_idle.c: In function 'acpi_processor_power_init':
>> drivers/acpi/processor_idle.c:1062:14: warning: unused variable 'status' [-Wunused-variable]
     acpi_status status;
                 ^

vim +/status +943 drivers/acpi/processor_idle.c

   937		if (max_cstate < ACPI_C_STATES_MAX)
   938			pr_notice("ACPI: processor limited to max C-state %d\n",
   939				  max_cstate);
   940		first_run++;
   941	
   942		if (acpi_gbl_FADT.cst_control && !nocst) {
 > 943			status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
   944						    acpi_gbl_FADT.cst_control, 8);
   945			if (ACPI_FAILURE(status))
   946				ACPI_EXCEPTION((AE_INFO, status,
   947						"Notifying BIOS of _CST ability failed"));
   948		}
   949	}
   950	#else
   951	
   952	static inline int disabled_by_idle_boot_param(void) { return 0; }
   953	static inline void acpi_processor_cstate_first_run_checks(void) { }
   954	static int acpi_processor_get_power_info(struct acpi_processor *pr)
   955	{
   956		return -ENODEV;
   957	}
   958	
   959	static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
   960						   struct cpuidle_device *dev)
   961	{
   962		return -EINVAL;
   963	}
   964	
   965	static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
   966	{
   967		return -EINVAL;
   968	}
   969	
   970	#endif
   971	
   972	int acpi_processor_hotplug(struct acpi_processor *pr)
   973	{
   974		int ret = 0;
   975		struct cpuidle_device *dev;
   976	
   977		if (disabled_by_idle_boot_param())
   978			return 0;
   979	
   980		if (nocst)
   981			return -ENODEV;
   982	
   983		if (!pr->flags.power_setup_done)
   984			return -ENODEV;
   985	
   986		dev = per_cpu(acpi_cpuidle_device, pr->id);
   987		cpuidle_pause_and_lock();
   988		cpuidle_disable_device(dev);
   989		acpi_processor_get_power_info(pr);
   990		if (pr->flags.power) {
   991			acpi_processor_setup_cpuidle_cx(pr, dev);
   992			ret = cpuidle_enable_device(dev);
   993		}
   994		cpuidle_resume_and_unlock();
   995	
   996		return ret;
   997	}
   998	
   999	int acpi_processor_cst_has_changed(struct acpi_processor *pr)
  1000	{
  1001		int cpu;
  1002		struct acpi_processor *_pr;
  1003		struct cpuidle_device *dev;
  1004	
  1005		if (disabled_by_idle_boot_param())
  1006			return 0;
  1007	
  1008		if (nocst)
  1009			return -ENODEV;
  1010	
  1011		if (!pr->flags.power_setup_done)
  1012			return -ENODEV;
  1013	
  1014		/*
  1015		 * FIXME:  Design the ACPI notification to make it once per
  1016		 * system instead of once per-cpu.  This condition is a hack
  1017		 * to make the code that updates C-States be called once.
  1018		 */
  1019	
  1020		if (pr->id == 0 && cpuidle_get_driver() == &acpi_idle_driver) {
  1021	
  1022			/* Protect against cpu-hotplug */
  1023			get_online_cpus();
  1024			cpuidle_pause_and_lock();
  1025	
  1026			/* Disable all cpuidle devices */
  1027			for_each_online_cpu(cpu) {
  1028				_pr = per_cpu(processors, cpu);
  1029				if (!_pr || !_pr->flags.power_setup_done)
  1030					continue;
  1031				dev = per_cpu(acpi_cpuidle_device, cpu);
  1032				cpuidle_disable_device(dev);
  1033			}
  1034	
  1035			/* Populate Updated C-state information */
  1036			acpi_processor_get_power_info(pr);
  1037			acpi_processor_setup_cpuidle_states(pr);
  1038	
  1039			/* Enable all cpuidle devices */
  1040			for_each_online_cpu(cpu) {
  1041				_pr = per_cpu(processors, cpu);
  1042				if (!_pr || !_pr->flags.power_setup_done)
  1043					continue;
  1044				acpi_processor_get_power_info(_pr);
  1045				if (_pr->flags.power) {
  1046					dev = per_cpu(acpi_cpuidle_device, cpu);
  1047					acpi_processor_setup_cpuidle_cx(_pr, dev);
  1048					cpuidle_enable_device(dev);
  1049				}
  1050			}
  1051			cpuidle_resume_and_unlock();
  1052			put_online_cpus();
  1053		}
  1054	
  1055		return 0;
  1056	}
  1057	
  1058	static int acpi_processor_registered;
  1059	
  1060	int acpi_processor_power_init(struct acpi_processor *pr)
  1061	{
> 1062		acpi_status status;
  1063		int retval;
  1064		struct cpuidle_device *dev;
  1065	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 24581 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160419/c04ba571/attachment-0001.obj>
