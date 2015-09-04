From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 4 Sep 2015 10:05:14 +0200
Subject: [PATCH v3 01/18] platform: delay OF device-driver matches until
 late_initcall
In-Reply-To: <55CE3D04.8000607@ti.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <1438870315-18689-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_Jsq+GLMZe-f6qEi=7i1YrrWc6k99RpGkOyCd5KkYDiyt0QA@mail.gmail.com>
 <CAAObsKBapFqzr+4YEXJfcJWMd+tkaBqYbGiFTntHStAP=+P-_Q@mail.gmail.com>
 <55C4E597.1010701@ti.com>
 <CAAObsKDJsuhuQfLbxq27Mtm1T_Auz7Gohp8PDyK7rNNDyaGhcg@mail.gmail.com>
 <55CE3D04.8000607@ti.com>
Message-ID: <CAAObsKCFwB41Kv8S3PKE4KF83q68MuPfch2AS2wXzYn-nXrrtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2015 at 21:09, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
> Hi Tomeu,
>
> On 08/09/2015 04:03 PM, Tomeu Vizoso wrote:
>> On 7 August 2015 at 19:06, Grygorii Strashko <grygorii.strashko@ti.com> wrote:
>>> On 08/07/2015 10:11 AM, Tomeu Vizoso wrote:
>>>> On 6 August 2015 at 22:19, Rob Herring <robherring2@gmail.com> wrote:
>>>>> On Thu, Aug 6, 2015 at 9:11 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>>>>> Delay matches of platform devices with OF nodes until late_initcall,
>>>>>> when we are sure that all built-in drivers have been registered already.
>>>>>> This is needed to prevent deferred probes because of some drivers not
>>>>>> having registered yet.
>>>>>>
>>>>>> The reason why only platform devices are delayed is that some other
>>>>>> devices are expected to be probed earlier than late_initcall, for
>>>>>> example, the system PNP driver needs to probe its devices in
>>>>>> fs_initcall.
>>>>>>
>>>>>> Additionally, only platform devices with OF nodes are delayed because
>>>>>> some machines may depend on oter platform devices being registered at
>>>>>> specific times.
>>>>>
>>>>> How do we know that these probes occur before the unused clocks and
>>>>> regulators are turned off? Just getting lucky (as is deferred probe)?
>>>>> Can we do this one level earlier so we have a level left to do things
>>>>> after probe.
>>>>
>>>> Those are already late_initcall_sync so I guess we're fine.
>>>
>>> I wouldn't be so sure :(
>>> FYI:
>>> http://git.ti.com/ti-linux-kernel/ti-linux-kernel/commit/763d643bbfc0f445c6685c541fcae3c370e4314a
>
> I'm very sorry for delayed reply.
>
> First of all, I'd like to say that proposition to move drivers probing/matching
> one layer early (device_initcall_sync) is reasonable
> (and I've already mentioned the same here https://lkml.org/lkml/2015/6/3/979).

Yeah, I have submitted this change to kernelci and I'm awaiting the
results. Note though that none of the boards in there (currently 91)
had any problem when probes were deferred until late_initcall.

>> If I understand the situation correctly, this is one more instance of
>> starting to do some work at some point and hoping that something else
>> that started before has already finished happening. If that's the
>> case, how does this series make that worst?
>
> You going to increase pressure on the late boot stages without taking
> into account that there could be platforms which perfectly works
> just using init_calls. And the fact that drivers will be not probed at
> expected time could be very surprising for them.

Well, they work perfectly until a driver in the dependency chain
starts deferring its probe, or gets renamed/moved and thus probed
later, or async probing gets enabled, etc. Then the boot breaks and
someone has to spend an evening adding printks all along the place.

I know that things have worked to date, but it's so fragile to have to
impose order by manually ordering things in the makefiles and fiddling
with initcall levels that we had to introduce the very big hammer that
deferred probing is, to assure that we get a working system at the
end.

But probing devices in a random order and relying on the return value
of the probe callback to retry them later means that we can no longer
warn about failed probes because the norm now is for them to fail a
few times before they succeed. And that also means that if you want
for, say, the panel to be up and running as soon as possible during
boot, you have to do an absurd amount of fiddling in the DT to have
the nodes in dependency order.

But if drivers and initcalls explicitly try to acquire the resources
they depend on instead of just hoping for them to be there, then
of_device_probe should end up being called and will ensure the
dependencies are there at the point when they are needed.

> Or, there should be an option to disable this functionality.

Yeah, Rob suggested it already. I will be adding such an option just
in case it's useful to someone.

>> During this development I have found many hacks intended to put some
>> order, even if not enough care was taken to make sure that the order
>> was guaranteed. In general I would recommend for moving code into
>> proper drivers and have them to defer the probe of their devices if
>> some dependency isn't fulfilled at that moment.
>
> Unfortunately, not everything can be moved to drivers or it could be
> just unreasonable.

Hopefully those initcalls can state their dependencies explicitly
(which should end up causing the required devices to be probed).

>> Once that's done and we have a safe and reliable boot, we can avoid
>> those deferred probes by fulfilling the dependency on-demand as this
>> series shows.
>>
>> There was some recent thread about how the disabling of unused clocks
>> and regulators isn't really safe because after late_initcall_sync more
>> drivers can be registered from modules. Furthermore, there's async
>> device probes.
>
> Clocks and regulators are safe, problems may happen first of all with
> platform's specific initcalls.

Guess that starting to process the deferred queue in
device_initcall_sync will help with these (in the next revision).

Thanks,

Tomeu

> Just take a look how many late_initcalls defined now in Kernel
> (grep -w -RI  "late_initcall" ./*) and everything which belongs
> to  /arch/* will be called before your probe_delayed_matches_initcall().
> The sequence of late_initcalls in /drivers/* is defined by
> /drivers/Makefile.
>
> #
> ./arch/um/kernel/process.c:late_initcall(make_proc_sysemu);
> ./arch/um/drivers/umcast_kern.c:late_initcall(register_umcast);
> ./arch/um/drivers/stdio_console.c:late_initcall(stdio_init);
> ./arch/um/drivers/pcap_kern.c:late_initcall(register_pcap);
> ./arch/um/drivers/ssl.c:late_initcall(ssl_init);
> ./arch/um/drivers/slip_kern.c:late_initcall(register_slip);
> ./arch/um/drivers/vde_kern.c:late_initcall(register_vde);
> ./arch/um/drivers/mconsole_kern.c:late_initcall(mc_add_console);
> ./arch/um/drivers/ubd_kern.c:late_initcall(ubd_init);
> ./arch/um/drivers/slirp_kern.c:late_initcall(register_slirp);
> ./arch/um/drivers/daemon_kern.c:late_initcall(register_daemon);
> ./arch/um/os-Linux/drivers/tuntap_kern.c:late_initcall(register_tuntap);
> ./arch/um/os-Linux/drivers/ethertap_kern.c:late_initcall(register_ethertap);
> ./arch/arm/kernel/pj4-cp0.c:late_initcall(pj4_cp0_init);
> ./arch/arm/kernel/setup.c:late_initcall(init_machine_late);
> ./arch/arm/kernel/xscale-cp0.c:late_initcall(xscale_cp0_init);
> ./arch/arm/kernel/swp_emulate.c:late_initcall(swp_emulation_init);
> ./arch/arm/kernel/thumbee.c:late_initcall(thumbee_init);
> ./arch/arm/kernel/traps.c:late_initcall(arm_mrc_hook_init);
> ./arch/arm/mach-mmp/pm-pxa910.c:late_initcall(pxa910_pm_init);
> ./arch/arm/mach-mmp/pm-mmp2.c:late_initcall(mmp2_pm_init);
> ./arch/arm/common/bL_switcher.c:late_initcall(bL_switcher_init);
> ./arch/arm/mach-pxa/sharpsl_pm.c:late_initcall(sharpsl_pm_init);
> ./arch/arm/kvm/coproc_a15.c:late_initcall(coproc_a15_init);
> ./arch/arm/kvm/coproc_a7.c:late_initcall(coproc_a7_init);
> ./arch/arm/mach-omap1/clock.c:late_initcall(clk_disable_unused);
> ./arch/arm/mach-omap1/clock.c:late_initcall(omap_clk_enable_autoidle_all);
> ./arch/arm/mach-omap1/clock.c:late_initcall(clk_debugfs_init);
> ./arch/arm/xen/enlighten.c:late_initcall(xen_pm_init);
> ./arch/arm/probes/kprobes/test-core.c:late_initcall(run_all_tests);
> ./arch/arm/mach-mvebu/pm-board.c:late_initcall(mvebu_armada_xp_gp_pm_init);
> ./arch/unicore32/kernel/fpu-ucf64.c:late_initcall(ucf64_init);
> ./arch/avr32/mm/tlb.c:late_initcall(proctlb_init);
> ./arch/sh/kernel/cpu/sh4a/smp-shx3.c:late_initcall(register_shx3_cpu_notifier);
> ./arch/sh/kernel/cpu/shmobile/pm.c:late_initcall(sh_pm_init);
> ./arch/sh/boards/mach-hp6xx/pm.c:late_initcall(hp6x0_pm_init);
> ./arch/xtensa/platforms/iss/console.c:late_initcall(rs_init);
> ./arch/frv/kernel/setup.c:late_initcall(setup_arch_serial);
> ./arch/powerpc/kernel/machine_kexec.c:late_initcall(kexec_setup);
> ./arch/powerpc/kernel/machine_kexec_64.c:late_initcall(export_htab_values);
> ./arch/powerpc/kernel/setup-common.c:late_initcall(check_cache_coherency);
> ./arch/powerpc/kernel/iommu.c:late_initcall(fail_iommu_debugfs);
> ./arch/powerpc/lib/code-patching.c:late_initcall(test_code_patching);
> ./arch/powerpc/lib/feature-fixups.c:late_initcall(test_feature_fixups);
> ./arch/powerpc/sysdev/ppc4xx_cpm.c:late_initcall(cpm_init);
> ./arch/powerpc/sysdev/dart_iommu.c:late_initcall(iommu_init_late_dart);
> ./arch/powerpc/sysdev/msi_bitmap.c:late_initcall(msi_bitmap_selftest);
> ./arch/tile/kernel/hardwall.c:late_initcall(dev_hardwall_init);
> ./arch/tile/kernel/smpboot.c:late_initcall(reset_init_affinity);
> ./arch/arm64/kernel/fpsimd.c:late_initcall(fpsimd_init);
> ./arch/arm64/kernel/armv8_deprecated.c:late_initcall(armv8_deprecated_init);
> ./arch/arm64/kvm/sys_regs_generic_v8.c:late_initcall(sys_reg_genericv8_init);
> ./arch/m68k/kernel/early_printk.c:late_initcall(unregister_early_console);
> ./arch/sparc/kernel/leon_pmc.c:late_initcall(leon_pmc_install);
> ./arch/sparc/kernel/sstate.c:late_initcall(sstate_running);
> ./arch/metag/kernel/setup.c:late_initcall(init_machine_late);
> ./arch/x86/kernel/tboot.c:late_initcall(tboot_late_init);
> ./arch/x86/kernel/cpu/mcheck/mce-severity.c:late_initcall(severities_debugfs_init);
> ./arch/x86/kernel/cpu/mcheck/mce_amd.c:late_initcall(threshold_init_device);
> ./arch/x86/kernel/cpu/mcheck/mce.c:late_initcall(mcheck_debugfs_init);
> ./arch/x86/kernel/mpparse.c:late_initcall(update_mp_table);
> ./arch/x86/kernel/apic/x2apic_uv_x.c:late_initcall(uv_init_heartbeat);
> ./arch/x86/kernel/apic/apic.c:late_initcall(lapic_insert_resource);
> ./arch/x86/kernel/apic/vector.c:late_initcall(print_ICs);
> ./arch/x86/kernel/apic/probe_32.c:late_initcall(print_ipi_mode);
> ./arch/x86/kernel/acpi/boot.c:late_initcall(hpet_insert_resource);
> ./arch/x86/crypto/aesni-intel_glue.c:late_initcall(aesni_init);
> ./arch/x86/mm/tlb.c:late_initcall(create_tlb_single_page_flush_ceiling);
> ./arch/x86/mm/pat.c:late_initcall(pat_memtype_list_init);
> ./arch/x86/platform/intel-mid/device_libs/platform_gpio_keys.c:late_initcall(pb_keys_init);
> ./arch/x86/pci/mmconfig-shared.c:late_initcall(pci_mmcfg_late_insert_resources);
> ./arch/arc/kernel/setup.c:late_initcall(init_late_machine);
> ./arch/mips/alchemy/devboards/pm.c:late_initcall(pm_init);
> ./arch/mips/loongson64/common/mem.c:late_initcall(find_vga_mem_init);
> ./arch/mips/txx9/generic/setup_tx4927.c:late_initcall(tx4927_late_init);
> ./arch/mips/txx9/generic/setup_tx4939.c:late_initcall(tx4939_late_init);
> ./arch/mips/txx9/generic/setup_tx4938.c:late_initcall(tx4938_late_init);
> ./arch/mips/cavium-octeon/setup.c:late_initcall(octeon_no_pci_release);
> ./arch/mips/cavium-octeon/flash_setup.c:late_initcall(octeon_flash_init);
> ./arch/mips/cavium-octeon/smp.c:late_initcall(register_cavium_notifier);
> ./arch/mips/mti-malta/malta-pm.c:late_initcall(malta_pm_setup);
> ./arch/mips/jz4740/pm.c:late_initcall(jz4740_pm_init);
> ./arch/mips/sgi-ip27/ip27-timer.c:late_initcall(sgi_ip27_rtc_devinit);
> ./arch/blackfin/kernel/cplbinfo.c:late_initcall(cplbinfo_init);
> ./arch/blackfin/kernel/bfin_dma.c:late_initcall(proc_dma_init);
> ./arch/blackfin/kernel/nmi.c:late_initcall(init_nmi_wdt_syscore);
> ./arch/blackfin/mach-bf609/pm.c:late_initcall(bf609_init_pm);
> ./arch/blackfin/mm/sram-alloc.c:late_initcall(sram_proc_init);
> ./arch/blackfin/mm/isram-driver.c:late_initcall(isram_test_init);
> ./block/blk-core.c:late_initcall(fail_make_request_debugfs);
> ./block/blk-timeout.c:late_initcall(fail_io_timeout_debugfs);
> ./crypto/async_tx/raid6test.c:late_initcall(raid6_test);
> ./drivers/clk/clk.c:late_initcall(clk_debug_init);
> ./drivers/mtd/ubi/build.c:late_initcall(ubi_init);
> ./drivers/mtd/devices/block2mtd.c:late_initcall(block2mtd_init);
> ./drivers/devfreq/exynos/exynos5_bus.c:late_initcall(exynos5_busfreq_int_init);
> ./drivers/devfreq/exynos/exynos4_bus.c:late_initcall(exynos4_busfreq_init);
> ./drivers/gpu/drm/omapdrm/omap_drv.c:late_initcall(omap_drm_init);
> ./drivers/gpu/drm/gma500/psb_drv.c:late_initcall(psb_init);
> ./drivers/video/logo/logo.c:late_initcall(fb_logo_late_init);
> ./drivers/of/fdt.c:late_initcall(of_fdt_raw_init);
> ./drivers/base/dd.c:late_initcall(deferred_probe_initcall);
> ./drivers/base/power/trace.c:late_initcall(late_resume_init);
> ./drivers/base/power/domain.c:late_initcall(genpd_poweroff_unused);
> ./drivers/base/power/domain.c:late_initcall(pm_genpd_debug_init);
> ./drivers/mfd/wl1273-core.c:late_initcall(wl1273_core_init);
> ./drivers/cpufreq/speedstep-centrino.c:late_initcall(centrino_init);
> ./drivers/cpufreq/amd_freq_sensitivity.c:late_initcall(amd_freq_sensitivity_init);
> ./drivers/cpufreq/sfi-cpufreq.c:late_initcall(sfi_cpufreq_init);
> ./drivers/cpufreq/powernow-k8.c:late_initcall(powernowk8_init);
> ./drivers/cpufreq/acpi-cpufreq.c:late_initcall(acpi_cpufreq_init);
> ./drivers/cpufreq/ia64-acpi-cpufreq.c:late_initcall(acpi_cpufreq_init);
> ./drivers/cpufreq/p4-clockmod.c:late_initcall(cpufreq_p4_init);
> ./drivers/cpufreq/pcc-cpufreq.c:late_initcall(pcc_cpufreq_init);
> ./drivers/cpufreq/powernow-k7.c:late_initcall(powernow_init);
> ./drivers/cpufreq/longhaul.c:late_initcall(longhaul_init);
> ./drivers/cpufreq/s3c24xx-cpufreq-debugfs.c:late_initcall(s3c_freq_debugfs_init);
> ./drivers/cpufreq/at32ap-cpufreq.c:late_initcall(at32_cpufreq_init);
> ./drivers/cpufreq/s3c24xx-cpufreq.c:late_initcall(s3c_cpufreq_initcall);
> ./drivers/sh/clk/core.c:late_initcall(clk_late_init);
> ./drivers/sh/intc/userimask.c:late_initcall(userimask_sysdev_init);
> ./drivers/net/netconsole.c:late_initcall(init_netconsole);
> ./drivers/net/vxlan.c:late_initcall(vxlan_init_module);
> ./drivers/net/geneve.c:late_initcall(geneve_init_module);
> ./drivers/net/ethernet/ti/davinci_emac.c:late_initcall(davinci_emac_init);
> ./drivers/net/ethernet/ti/cpsw.c:late_initcall(cpsw_init);
> ./drivers/net/rionet.c:late_initcall(rionet_init);
> ./drivers/gpio/gpio-tegra.c:late_initcall(tegra_gpio_debuginit);
> ./drivers/block/hd.c:late_initcall(hd_init);
> ./drivers/thermal/db8500_cpufreq_cooling.c:late_initcall(db8500_cpufreq_cooling_init);
> ./drivers/staging/android/sync_debug.c:late_initcall(sync_debugfs_init);
> ./drivers/staging/wilc1000/linux_wlan.c:late_initcall(init_wilc_driver);
> ./drivers/iommu/dmar.c:late_initcall(dmar_free_unused_resources);
> ./drivers/watchdog/ie6xx_wdt.c:late_initcall(ie6xx_wdt_init);
> ./drivers/watchdog/intel_scu_watchdog.c:late_initcall(intel_scu_watchdog_init);
> ./drivers/tty/serial/mpsc.c:late_initcall(mpsc_late_console_init);
> ./drivers/media/platform/omap/omap_vout.c:late_initcall(omap_vout_init);
> ./drivers/media/pci/cx25821/cx25821-alsa.c:late_initcall(cx25821_alsa_init);
> ./drivers/media/pci/saa7134/saa7134-alsa.c:late_initcall(saa7134_alsa_init);
> ./drivers/dma/dmatest.c:late_initcall(dmatest_init);
> ./drivers/rapidio/rio-scan.c:late_initcall(rio_basic_attach);
> ./drivers/xen/xenbus/xenbus_probe_frontend.c:late_initcall(boot_wait_for_devices);
> ./drivers/platform/x86/dell-laptop.c:late_initcall(dell_init);
> ./drivers/firmware/memmap.c:late_initcall(firmware_memmap_init);
> ./drivers/firmware/edd.c:late_initcall(edd_init);
> ./drivers/firmware/efi/reboot.c:late_initcall(efi_shutdown_init);
> ./drivers/input/keyboard/gpio_keys.c:late_initcall(gpio_keys_init);
> ./drivers/pci/pci.c:late_initcall(pci_resource_alignment_sysfs_init);
> ./drivers/pci/pci-sysfs.c:late_initcall(pci_sysfs_init);
> ./drivers/macintosh/via-pmu-led.c:late_initcall(via_pmu_led_init);
> ./drivers/macintosh/via-pmu-event.c:late_initcall(via_pmu_event_init);
> ./drivers/ide/sgiioc4.c:late_initcall(ioc4_ide_init); /* Call only after IDE init is done */
> ./drivers/ide/ide-cs.c:late_initcall(init_ide_cs);
> ./drivers/rtc/Kconfig:    The driver for this RTC device must be loaded before late_initcall
> ./drivers/rtc/hctosys.c:late_initcall(rtc_hctosys);
> ./drivers/irqchip/irq-vic.c:late_initcall(vic_pm_init);
> ./drivers/power/avs/smartreflex.c:late_initcall(sr_init);
> ./drivers/power/charger-manager.c:late_initcall(charger_manager_init);
> ./fs/btrfs/super.c:late_initcall(init_btrfs_fs);
> ./fs/afs/main.c:late_initcall(afs_init);        /* must be called after net/ to create socket */
> ./fs/ubifs/super.c:late_initcall(ubifs_init);
> ./kernel/sched/core.c:late_initcall(sched_init_debug);
> ./kernel/time/timekeeping_debug.c:late_initcall(tk_debug_sleep_time_init);
> ./kernel/taskstats.c:late_initcall(taskstats_init);
> ./kernel/printk/printk.c:late_initcall(printk_late_init);
> ./kernel/bpf/arraymap.c:late_initcall(register_array_map);
> ./kernel/bpf/arraymap.c:late_initcall(register_prog_array_map);
> ./kernel/bpf/hashtab.c:late_initcall(register_htab_map);
> ./kernel/trace/trace_events.c:late_initcall(event_trace_self_tests_init);
> ./kernel/trace/bpf_trace.c:late_initcall(register_kprobe_prog_ops);
> ./kernel/trace/trace.c:late_initcall(clear_boot_tracer);
> ./kernel/trace/trace_kprobe.c:late_initcall(kprobe_trace_self_tests_init);
> ./kernel/trace/trace_events_filter.c:late_initcall(ftrace_test_event_filter);
> ./kernel/trace/trace_kdb.c:late_initcall(kdb_ftrace_register);
> ./kernel/trace/ring_buffer.c:late_initcall(test_ringbuffer);
> ./kernel/kprobes.c:late_initcall(debugfs_kprobe_init);
> ./kernel/rcu/update.c:late_initcall(rcu_verify_early_boot_tests);
> ./kernel/panic.c:late_initcall(init_oops_id);
> ./kernel/system_keyring.c:late_initcall(load_system_certificate_list);
> ./kernel/power/qos.c:late_initcall(pm_qos_power_init);
> ./kernel/power/Kconfig:   late_initcall.
> ./kernel/power/main.c:late_initcall(pm_debugfs_init);
> ./kernel/power/suspend_test.c:late_initcall(test_suspend);
> ./lib/list_sort.c:late_initcall(list_sort_test);
> ./lib/random32.c:late_initcall(prandom_reseed);
> ./mm/kmemleak.c:late_initcall(kmemleak_late_init);
> ./mm/failslab.c:late_initcall(failslab_debugfs_init);
> ./mm/memory.c:late_initcall(fault_around_debugfs);
> ./mm/early_ioremap.c:late_initcall(check_early_ioremap_leak);
> ./mm/cma_debug.c:late_initcall(cma_debugfs_init);
> ./mm/page_owner.c:late_initcall(pageowner_init)
> ./mm/page_alloc.c:late_initcall(fail_page_alloc_debugfs);
> ./mm/swapfile.c:late_initcall(max_swapfiles_check);
> ./mm/zswap.c:late_initcall(init_zswap);
> ./net/ipv4/ipconfig.c:late_initcall(ip_auto_config);
> ./net/ipv4/tcp_cong.c:late_initcall(tcp_congestion_default);
> ./net/core/filter.c:late_initcall(register_sk_filter_ops);
> ./net/bluetooth/selftest.c:late_initcall(bt_selftest_init);
> ./security/integrity/evm/evm_main.c:late_initcall(init_evm);
> ./security/integrity/ima/ima_main.c:late_initcall(init_ima);    /* Start IMA after the TPM is available */
> ./security/apparmor/crypto.c:late_initcall(init_profile_hash);
> ./security/keys/trusted.c:late_initcall(init_trusted);
> ./security/keys/encrypted-keys/encrypted.c:late_initcall(init_encrypted);
> ./security/keys/process_keys.c:late_initcall(init_root_keyring);
> ./sound/soc/fsl/p1022_rdk.c:late_initcall(p1022_rdk_init);
> ./sound/soc/fsl/phycore-ac97.c:late_initcall(imx_phycore_init);
>
> --
> regards,
> -grygorii
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
