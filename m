From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 3 Jul 2017 09:59:05 +0200
Subject: ARM: sunxi: "Unbalanced enable for IRQ 0" warning on A20
In-Reply-To: <aa19551d-c0dc-07c0-313a-d55dbda4d5ad@suse.de>
References: <aa19551d-c0dc-07c0-313a-d55dbda4d5ad@suse.de>
Message-ID: <d120b689-ed07-a926-499e-694e82830713@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

On 01/07/2017 12:51, Andreas F?rber wrote:
> Hi,
> 
> Just encountered the following warning on Cubietruck with v4.12-rc7.
> I'm assuming this is related to deferred module probing and some
> probe/remove mismatch?
> 
> Regards,
> Andreas
> 
> [   33.683928] thermal thermal_zone0: failed to read out thermal zone (-110)
> [   33.690870] ------------[ cut here ]------------
> [   33.690901] WARNING: CPU: 0 PID: 161 at ../kernel/irq/manage.c:529
> __enable_irq+0x54/0x88
> [   33.690905] Unbalanced enable for IRQ 0
> [   33.690910] Modules linked in: nls_cp437 vfat fat axp20x_usb_power
> axp20x_ac_power axp20x_regulator axp20x_adc sun4i_gpadc_iio(+)
> snd_soc_simple_card sun4i_codec snd_soc_spdif_tx
> snd_soc_simple_card_utils axp20x_pek industrialio gpio_axp209
> snd_soc_core snd_compress ac97_bus snd_pcm_dmaengine snd_pcm realtek
> snd_timer dwmac_sunxi axp20x_i2c stmmac_platform ir_lirc_codec sun4i_ts
> snd stmmac lirc_dev axp20x nvmem_sunxi_sid brcmfmac sunxi_cir rc_core
> sun4i_gpadc nvmem_core soundcore sunxi_wdt sun4i_ss des_generic sunxi
> phy_generic musb_hdrc udc_core sun4i_dma uio_pdrv_genirq uio leds_gpio
> cpufreq_dt btrfs xor xor_neon zlib_deflate raid6_pq ohci_platform
> cfg80211 rfkill brcmutil mmc_block ehci_platform ohci_hcd ehci_hcd
> i2c_mv64xxx pwm_sun4i ahci_sunxi libahci_platform usbcore phy_sun4i_usb
> extcon_core
> [   33.691107]  sunxi_mmc pwrseq_simple mmc_core sg dm_multipath dm_mod
> dax scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> [   33.691147] CPU: 0 PID: 161 Comm: kworker/0:2 Not tainted
> 4.12.0-rc7-1.gaec31ef-lpae #1
> [   33.691150] Hardware name: Allwinner sun7i (A20) Family
> [   33.691166] Workqueue: events deferred_probe_work_func
> [   33.691203] [<c044150c>] (unwind_backtrace) from [<c043a568>]
> (show_stack+0x20/0x28)
> [   33.691223] [<c043a568>] (show_stack) from [<c08079b0>]
> (dump_stack+0x94/0xa8)
> [   33.691243] [<c08079b0>] (dump_stack) from [<c04799cc>]
> (__warn+0xfc/0x114)
> [   33.691259] [<c04799cc>] (__warn) from [<c0479a28>]
> (warn_slowpath_fmt+0x44/0x4c)
> [   33.691277] [<c0479a28>] (warn_slowpath_fmt) from [<c04e0420>]
> (__enable_irq+0x54/0x88)
> [   33.691293] [<c04e0420>] (__enable_irq) from [<c04e0498>]
> (enable_irq+0x44/0x7c)
> [   33.691332] [<c04e0498>] (enable_irq) from [<bfb952cc>]
> (sun4i_gpadc_read+0x170/0x1d0 [sun4i_gpadc_iio])
> [   33.691416] [<bfb952cc>] (sun4i_gpadc_read [sun4i_gpadc_iio]) from
> [<bfb95884>] (sun4i_gpadc_temp_read+0x34/0x84 [sun4i_gpadc_iio])
> [   33.691446] [<bfb95884>] (sun4i_gpadc_temp_read [sun4i_gpadc_iio])
> from [<bfb95900>] (sun4i_gpadc_get_temp+0x2c/0x64 [sun4i_gpadc_iio])
> [   33.691473] [<bfb95900>] (sun4i_gpadc_get_temp [sun4i_gpadc_iio])
> from [<c0afe208>] (of_thermal_get_temp+0x30/0x40)
> [   33.691492] [<c0afe208>] (of_thermal_get_temp) from [<c0afd900>]
> (thermal_zone_get_temp+0x58/0x80)
> [   33.691510] [<c0afd900>] (thermal_zone_get_temp) from [<c0afad00>]
> (thermal_zone_device_update.part.9+0x28/0x1c8)
> [   33.691528] [<c0afad00>] (thermal_zone_device_update.part.9) from
> [<c0afb374>] (__thermal_cooling_device_register+0x2b0/0x380)
> [   33.691544] [<c0afb374>] (__thermal_cooling_device_register) from
> [<c0afb48c>] (thermal_of_cooling_device_register+0x18/0x20)
> [   33.691560] [<c0afb48c>] (thermal_of_cooling_device_register) from
> [<c0b00254>] (__cpufreq_cooling_register+0x354/0x620)
> [   33.691574] [<c0b00254>] (__cpufreq_cooling_register) from
> [<c0b005a4>] (of_cpufreq_power_cooling_register+0x24/0x2c)
> [   33.691598] [<c0b005a4>] (of_cpufreq_power_cooling_register) from
> [<bf6890b0>] (cpufreq_ready+0x84/0xd4 [cpufreq_dt])
> [   33.691623] [<bf6890b0>] (cpufreq_ready [cpufreq_dt]) from
> [<c0b0ec84>] (cpufreq_online+0x594/0x6d4)
> [   33.691638] [<c0b0ec84>] (cpufreq_online) from [<c0b0ee70>]
> (cpufreq_add_dev+0x88/0xc0)
> [   33.691652] [<c0b0ee70>] (cpufreq_add_dev) from [<c09eb324>]
> (subsys_interface_register+0x9c/0xd8)
> [   33.691669] [<c09eb324>] (subsys_interface_register) from
> [<c0b0cad4>] (cpufreq_register_driver+0x188/0x25c)
> [   33.691688] [<c0b0cad4>] (cpufreq_register_driver) from [<bf689600>]
> (dt_cpufreq_probe+0x98/0x1a4 [cpufreq_dt])
> [   33.691711] [<bf689600>] (dt_cpufreq_probe [cpufreq_dt]) from
> [<c09ef848>] (platform_drv_probe+0x60/0xc0)
> [   33.691725] [<c09ef848>] (platform_drv_probe) from [<c09ed22c>]
> (driver_probe_device+0x2ec/0x43c)
> [   33.691740] [<c09ed22c>] (driver_probe_device) from [<c09ed544>]
> (__device_attach_driver+0xb0/0x13c)
> [   33.691757] [<c09ed544>] (__device_attach_driver) from [<c09eafa8>]
> (bus_for_each_drv+0x54/0xa4)
> [   33.691772] [<c09eafa8>] (bus_for_each_drv) from [<c09ecd90>]
> (__device_attach+0xc4/0x148)
> [   33.691785] [<c09ecd90>] (__device_attach) from [<c09ed628>]
> (device_initial_probe+0x1c/0x24)
> [   33.691798] [<c09ed628>] (device_initial_probe) from [<c09ec130>]
> (bus_probe_device+0x98/0xa0)
> [   33.691811] [<c09ec130>] (bus_probe_device) from [<c09ec6fc>]
> (deferred_probe_work_func+0x88/0xd0)
> [   33.691827] [<c09ec6fc>] (deferred_probe_work_func) from [<c0494bd8>]
> (process_one_work+0x208/0x584)
> [   33.691844] [<c0494bd8>] (process_one_work) from [<c0495ba4>]
> (worker_thread+0x64/0x590)
> [   33.691858] [<c0495ba4>] (worker_thread) from [<c049b6b4>]
> (kthread+0x170/0x178)
> [   33.691876] [<c049b6b4>] (kthread) from [<c0435bc8>]
> (ret_from_fork+0x14/0x2c)
> [   33.691883] ---[ end trace 80e3e19af97711bd ]---
> 
> 

Thanks for reporting!

After a quick lookup, I think I've found several flaws in the code and
one that should be the cause of this bug.

1) I enable the irq in sun4i_gpadc_read and disable it in the irq
handler. In sun4i_gpadc_read I wait for a completion (with timeout)
which is 'set' in the handler. In case of a timeout, I do not disable
the irq in sun4i_gpadc_read so if no irq has occurred before
sun4i_gpadc_read is called once more, we'll have two enable_irq for no
disable. This is most likely to be the cause of the bug you reported.

2) In sun4i_irq_init, I register the irq (which enables it right away)
but I set an atomic flag for the interrupt handler to be sure no
interrupt is handled before we want to. I have a condition in the irq
handler on this atomic flag and if it fails, then I disable the irq
right in the irq handler. However, at the end of sun4i_irq_init, I also
disable that same irq, thus we could have two disables for one enable.

3) I do not handle spurious interruptions in the irq handlers so I might
mark the interrupt as handled while we haven't received the irq we were
waiting for.

I'll work on patches for these flaws.

Thanks,
Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
