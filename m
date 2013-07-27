From: digetx@gmail.com (Dmitry Osipenko)
Date: Sat, 27 Jul 2013 20:20:38 +0400
Subject: [PATCH 0/8] ARM: tegra: support LP1 suspend mode
In-Reply-To: <2389689.JgQlW00RdN@ax5200p>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
 <2389689.JgQlW00RdN@ax5200p>
Message-ID: <51F3F356.8080709@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

27.07.2013 20:12, Marc Dietrich ?????:
> On Friday 26 July 2013 17:15:02 Joseph Lo wrote:
>> This series adds the support of LP1 suspend mode for Tegra.
>>
>> Verified on Seaboard, Cardhu and Dalmore.
> 
> tested on AC100 and worked fine, except
> 
> [   68.448007] PM: Syncing filesystems ... done.
> [   71.370086] Freezing user space processes ... (elapsed 0.001 seconds) done.
> [   71.370088] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) 
> done.
> [   71.371253] Suspending console(s) (use no_console_suspend to debug)
> [   71.638481] PM: suspend of devices complete after 266.604 msecs
> [   71.638905] PM: late suspend of devices complete after 0.417 msecs
> [   71.639477] PM: noirq suspend of devices complete after 0.568 msecs
> [   71.639480] Disabling non-boot CPUs ...
> [   71.640242] CPU1: shutdown
> [   71.641216] Entering suspend state LP1
> [   71.641267] Enabling non-boot CPUs ...
> [   71.643125] CPU1: Booted secondary processor
> [   71.643449] CPU1 is up
> [   71.643786] PM: noirq resume of devices complete after 0.331 msecs
> [   71.644300] PM: early resume of devices complete after 0.364 msecs
> [   71.648038] ------------[ cut here ]------------
> [   71.648061] WARNING: CPU: 0 PID: 1025 at kernel/irq/manage.c:529 
> irq_set_irq_wake+0xb8/0xf0()
> [   71.648064] Unbalanced IRQ 384 wake disable
> [   71.648068] Modules linked in:
> [   71.648075] CPU: 0 PID: 1025 Comm: bash Not tainted 3.11.0-rc2-
> next-20130726-00008-gef01509-dirty #6
> [   71.648107] [<c001551c>] (unwind_backtrace+0x0/0xf8) from [<c001154c>] 
> (show_stack+0x10/0x14)
> [   71.648128] [<c001154c>] (show_stack+0x10/0x14) from [<c0515288>] 
> (dump_stack+0x80/0xc4)
> [   71.648142] [<c0515288>] (dump_stack+0x80/0xc4) from [<c0025340>] 
> (warn_slowpath_common+0x64/0x88)
> [   71.648151] [<c0025340>] (warn_slowpath_common+0x64/0x88) from [<c00253f8>] 
> (warn_slowpath_fmt+0x30/0x40)
> [   71.648161] [<c00253f8>] (warn_slowpath_fmt+0x30/0x40) from [<c007ff8c>] 
> (irq_set_irq_wake+0xb8/0xf0)
> [   71.648178] [<c007ff8c>] (irq_set_irq_wake+0xb8/0xf0) from [<c0334d00>] 
> (tps6586x_rtc_resume+0x30/0x38)
> [   71.648192] [<c0334d00>] (tps6586x_rtc_resume+0x30/0x38) from [<c02951d0>] 
> (platform_pm_resume+0x2c/0x4c)
> [   71.648202] [<c02951d0>] (platform_pm_resume+0x2c/0x4c) from [<c0299d40>] 
> (dpm_run_callback.isra.5+0x18/0x38)
> [   71.648211] [<c0299d40>] (dpm_run_callback.isra.5+0x18/0x38) from 
> [<c029a044>] (device_resume+0xb0/0x170)
> [   71.648219] [<c029a044>] (device_resume+0xb0/0x170) from [<c029aeb4>] 
> (dpm_resume+0xe8/0x20c)
> [   71.648227] [<c029aeb4>] (dpm_resume+0xe8/0x20c) from [<c029b174>] 
> (dpm_resume_end+0xc/0x18)
> [   71.648245] [<c029b174>] (dpm_resume_end+0xc/0x18) from [<c005e480>] 
> (suspend_devices_and_enter+0xdc/0x2f8)
> [   71.648256] [<c005e480>] (suspend_devices_and_enter+0xdc/0x2f8) from 
> [<c005e810>] (pm_suspend+0x174/0x1e8)
> [   71.648265] [<c005e810>] (pm_suspend+0x174/0x1e8) from [<c005d710>] 
> (state_store+0x6c/0xbc)
> [   71.648285] [<c005d710>] (state_store+0x6c/0xbc) from [<c01eca78>] 
> (kobj_attr_store+0x14/0x20)
> [   71.648298] [<c01eca78>] (kobj_attr_store+0x14/0x20) from [<c011e970>] 
> (sysfs_write_file+0x168/0x198)
> [   71.648312] [<c011e970>] (sysfs_write_file+0x168/0x198) from [<c00cd060>] 
> (vfs_write+0xb0/0x188)
> [   71.648321] [<c00cd060>] (vfs_write+0xb0/0x188) from [<c00cd410>] 
> (SyS_write+0x3c/0x70)
> [   71.648330] [<c00cd410>] (SyS_write+0x3c/0x70) from [<c000e560>] 
> (ret_fast_syscall+0x0/0x30)
> [   71.648334] ---[ end trace e5ed8212ac4db5da ]---
> [   72.063578] mmc1: power class selection to bus width 8 failed
> [   72.297753] usb 2-1: reset high-speed USB device number 2 using tegra-ehci
> [   72.567736] usb 3-1: reset high-speed USB device number 2 using tegra-ehci
> [   73.022058] usb 3-1.3: reset high-speed USB device number 4 using tegra-
> ehci
> [   73.216064] usb 3-1.2: reset high-speed USB device number 3 using tegra-
> ehci
> [   73.360225] PM: resume of devices complete after 1715.937 msecs
> [   73.361008] Restarting tasks ... done.
> 
> and sdcard being offline after resume (fixed by CONFIG_MMC_UNSAFE_RESUME=y). 
> Anyway, thanks for your great work!
> 
> Tested-By: Marc Dietrich <marvin24@gmx.de>
> 
>> And tested with THUMB2_KERNEL as well.
>>
>> P.S.
>> A known issue on Dalmore, the LP1 resume may take 10 ~ 15 seconds due to
>> the 792MHz BCT. It can't be reproduced on Seaboard or Cardhu. And the
>> root cause of this is about the default settings of EMC registers that
>> cause the DRAM can't leave self-refresh mode immediately. If you want
>> to test with quick LP1 resume on Dalmore, I can provide another HACK for
>> this.
>>
>> Joseph Lo (8):
>>   ARM: tegra: add common resume handling code for LP1 resuming
>>   ARM: tegra: config the polarity of the request of sys clock
>>   clk: tegra114: add LP1 suspend/resume support
>>   ARM: tegra: add common LP1 suspend support
>>   ARM: tegra30: add LP1 suspend support
>>   ARM: tegra20: add LP1 suspend support
>>   ARM: tegra114: add LP1 suspend support
>>   ARM: dts: tegra: enable LP1 suspend mode
>>
>>  arch/arm/boot/dts/tegra114-dalmore.dts     |   2 +-
>>  arch/arm/boot/dts/tegra20-colibri-512.dtsi |   2 +-
>>  arch/arm/boot/dts/tegra20-harmony.dts      |   2 +-
>>  arch/arm/boot/dts/tegra20-paz00.dts        |   2 +-
>>  arch/arm/boot/dts/tegra20-seaboard.dts     |   2 +-
>>  arch/arm/boot/dts/tegra20-tamonten.dtsi    |   2 +-
>>  arch/arm/boot/dts/tegra20-trimslice.dts    |   2 +-
>>  arch/arm/boot/dts/tegra20-ventana.dts      |   2 +-
>>  arch/arm/boot/dts/tegra20-whistler.dts     |   2 +-
>>  arch/arm/boot/dts/tegra30-beaver.dts       |   2 +-
>>  arch/arm/boot/dts/tegra30-cardhu.dtsi      |   2 +-
>>  arch/arm/mach-tegra/Makefile               |   3 +
>>  arch/arm/mach-tegra/iomap.h                |   6 +
>>  arch/arm/mach-tegra/pm-tegra20.c           |  37 ++
>>  arch/arm/mach-tegra/pm-tegra30.c           |  37 ++
>>  arch/arm/mach-tegra/pm.c                   | 121 +++++-
>>  arch/arm/mach-tegra/pm.h                   |  23 ++
>>  arch/arm/mach-tegra/pmc.c                  |  36 +-
>>  arch/arm/mach-tegra/pmc.h                  |   3 +
>>  arch/arm/mach-tegra/reset-handler.S        |  13 +
>>  arch/arm/mach-tegra/reset.c                |   2 +
>>  arch/arm/mach-tegra/reset.h                |   4 +
>>  arch/arm/mach-tegra/sleep-tegra20.S        | 300 ++++++++++++++
>>  arch/arm/mach-tegra/sleep-tegra30.S        | 615
>> +++++++++++++++++++++++++++++ arch/arm/mach-tegra/sleep.S                | 
>>  8 +-
>>  arch/arm/mach-tegra/sleep.h                |  18 +
>>  drivers/clk/tegra/clk-tegra114.c           |  32 ++
>>  27 files changed, 1259 insertions(+), 21 deletions(-)
>>  create mode 100644 arch/arm/mach-tegra/pm-tegra20.c
>>  create mode 100644 arch/arm/mach-tegra/pm-tegra30.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
I had same warn on 3.8.
https://bitbucket.org/digetx/picasso-kernel/commits/a86dc95ab48dd77eaa0463844cdf88a5acf9d842
