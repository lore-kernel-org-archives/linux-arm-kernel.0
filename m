From: marvin24@gmx.de (Marc Dietrich)
Date: Sat, 21 Dec 2013 23:11:58 +0100
Subject: [PATCH 2/2] ARM: tegra: paz00: Add LVDS support to device tree
In-Reply-To: <bcf12ecec69ef4e38e74a9be9c45e8bd2bd9ffcc.1387656959.git.marvin24@gmx.de>
References: <f03a644deb858f10affb7b039f9982bac81b02c9.1387656959.git.marvin24@gmx.de>
 <bcf12ecec69ef4e38e74a9be9c45e8bd2bd9ffcc.1387656959.git.marvin24@gmx.de>
Message-ID: <1519363.agF5fhqzYs@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, Stephen, I mistyped your email address in the first post.

On Saturday 21 December 2013 21:38:13 Marc Dietrich wrote:
> Add backlight and panel nodes for the PAZ00 TFT LCD panel.
> 
> Signed-off-by: Marc Dietrich <marvin24@gmx.de>
> ---
> This should enable everything needed. Unfortunately, in my tests it only
> switches on the backlight, but the display controller blocks in some
> infinit loop, so we get no output (and no working system). I post it here
> in case I missed something obvious...

In fact it turns out to be some heisenbug because in one out of ten tries it 
actually works. The other nine cases it prints:

[    1.995067] rfkill_gpio rfkill_gpio: wifi_rfkill device registered.
[    2.001459] Registering SWP/SWPB emulation handler
[    2.011632] [drm:drm_get_minor], 
[    2.016473] [drm:drm_get_minor], new minor assigned 64
[    2.021648] [drm:drm_get_minor], 
[    2.026319] [drm:drm_get_minor], new minor assigned 0
[    2.033465] [drm:drm_sysfs_connector_add], adding "HDMI-A-1" to sysfs
[    2.040402] [drm:drm_sysfs_hotplug_event], generating hotplug event
[    2.048115] [drm:drm_sysfs_connector_add], adding "LVDS-1" to sysfs
[    2.054642] [drm:drm_sysfs_hotplug_event], generating hotplug event
[    2.061341] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.068027] [drm] No driver support for vblank timestamp query.
[    2.094947] random: nonblocking pool is initialized
[  240.885976] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  240.892462]       Not tainted 3.13.0-rc4-next-20131220-00003-gbcf12ec #11
[  240.900030] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables 
this message.
[  240.907997] swapper/0       D c05653b8     0     1      0 0x00000000
[  240.914457] [<c05653b8>] (__schedule) from [<c0564bcc>] 
(schedule_timeout+0x174/0x1ec)
[  240.922512] [<c0564bcc>] (schedule_timeout) from [<c056603c>] 
(wait_for_common+0xb0/0x144)
[  240.930913] [<c056603c>] (wait_for_common) from [<c0038db8>] 
(flush_workqueue+0xec/0x570)
[  240.939227] [<c0038db8>] (flush_workqueue) from [<c02b7048>] 
(deferred_probe_initcall+0x50/0x80)
[  240.948143] [<c02b7048>] (deferred_probe_initcall) from [<c00089f4>] 
(do_one_initcall+0xe4/0x140)
[  240.957179] [<c00089f4>] (do_one_initcall) from [<c0784be8>] 
(kernel_init_freeable+0xfc/0x1c8)
[  240.965936] [<c0784be8>] (kernel_init_freeable) from [<c055eb94>] 
(kernel_init+0x8/0x118)
[  240.974180] [<c055eb94>] (kernel_init) from [<c000e678>] 
(ret_from_fork+0x14/0x3c)
[  261.904891] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=2100 
jiffies g=4294967023 c=4294967022 q=1)
[  261.914827] CPU: 0 PID: 55 Comm: kworker/u4:2 Not tainted 3.13.0-rc4-
next-20131220-00003-gbcf12ec #11
[  261.924042] Workqueue: deferwq deferred_probe_work_func
[  261.929285] [<c0015b2c>] (unwind_backtrace) from [<c00117e0>] 
(show_stack+0x10/0x14)
[  261.937036] [<c00117e0>] (show_stack) from [<c0563180>] 
(dump_stack+0x80/0xcc)
[  261.944261] [<c0563180>] (dump_stack) from [<c006ce00>] 
(rcu_check_callbacks+0x408/0x850)
[  261.952442] [<c006ce00>] (rcu_check_callbacks) from [<c002fbe0>] 
(update_process_times+0x38/0x58)
[  261.961312] [<c002fbe0>] (update_process_times) from [<c0076894>] 
(tick_sched_timer+0x44/0x74)
[  261.969929] [<c0076894>] (tick_sched_timer) from [<c00422a4>] 
(__run_hrtimer.isra.15+0x58/0x114)
[  261.978711] [<c00422a4>] (__run_hrtimer.isra.15) from [<c0042bd0>] 
(hrtimer_interrupt+0xfc/0x288)
[  261.987579] [<c0042bd0>] (hrtimer_interrupt) from [<c001509c>] 
(twd_handler+0x2c/0x40)
[  261.995500] [<c001509c>] (twd_handler) from [<c006719c>] 
(handle_percpu_devid_irq+0x68/0x84)
[  262.003935] [<c006719c>] (handle_percpu_devid_irq) from [<c0063b14>] 
(generic_handle_irq+0x20/0x30)
[  262.012977] [<c0063b14>] (generic_handle_irq) from [<c000ee94>] 
(handle_IRQ+0x38/0x94)
[  262.020890] [<c000ee94>] (handle_IRQ) from [<c0008698>] 
(gic_handle_irq+0x28/0x5c)
[  262.028456] [<c0008698>] (gic_handle_irq) from [<c0012300>] 
(__irq_svc+0x40/0x70)
[  262.035931] Exception stack(0xdb29bc98 to 0xdb29bce0)
[  262.040974] bc80:                                                       
c0814780 00000000
[  262.049145] bca0: ffff8ba1 00000000 00000002 0000001d 00000000 db29a000 
00000002 c07c6080
[  262.057316] bcc0: 00000000 db860000 00000000 db29bce0 c0029898 c0029914 
20000113 ffffffff
[  262.065500] [<c0012300>] (__irq_svc) from [<c0029914>] 
(__do_softirq+0x8c/0x208)
[  262.072895] [<c0029914>] (__do_softirq) from [<c0029dd0>] 
(irq_exit+0xa0/0xec)
[  262.080115] [<c0029dd0>] (irq_exit) from [<c000ee98>] 
(handle_IRQ+0x3c/0x94)
[  262.087158] [<c000ee98>] (handle_IRQ) from [<c0008698>] 
(gic_handle_irq+0x28/0x5c)
[  262.094723] [<c0008698>] (gic_handle_irq) from [<c0012300>] 
(__irq_svc+0x40/0x70)
[  262.102197] Exception stack(0xdb29bd50 to 0xdb29bd98)
[  262.107243] bd40:                                     c0814114 a0000113 
00000000 e0a00000
[  262.115413] bd60: db2f9410 c07cc3d0 00000020 db2f9810 00000002 00000000 
00000000 db860000
[  262.123582] bd80: 00000000 db29bd98 c02a3b6c c02a3b84 60000113 ffffffff
[  262.130198] [<c0012300>] (__irq_svc) from [<c02a3b84>] 
(tegra_output_rgb_disable+0x58/0xe0)
[  262.138548] [<c02a3b84>] (tegra_output_rgb_disable) from [<c02a360c>] 
(tegra_encoder_dpms+0x68/0xc0)
[  262.147675] [<c02a360c>] (tegra_encoder_dpms) from [<c02808ac>] 
(drm_encoder_disable+0x64/0x68)
[  262.156370] [<c02808ac>] (drm_encoder_disable) from [<c02809b8>] 
(drm_helper_disable_unused_functions+0x108/0x134)
[  262.166713] [<c02809b8>] (drm_helper_disable_unused_functions) from 
[<c029f5dc>] (tegra_drm_fb_init+0x88/0x110)
[  262.176794] [<c029f5dc>] (tegra_drm_fb_init) from [<c029e32c>] 
(tegra_drm_load+0x94/0xc0)
[  262.184977] [<c029e32c>] (tegra_drm_load) from [<c028c904>] 
(drm_dev_register+0x70/0x130)
[  262.193151] [<c028c904>] (drm_dev_register) from [<c029df14>] 
(drm_host1x_init+0x2c/0x88)
[  262.201328] [<c029df14>] (drm_host1x_init) from [<c02ab7b0>] 
(host1x_subdev_register+0xb4/0xd0)
[  262.210024] [<c02ab7b0>] (host1x_subdev_register) from [<c02abf00>] 
(host1x_client_register+0xf4/0x11c)
[  262.219412] [<c02abf00>] (host1x_client_register) from [<c02a21ec>] 
(tegra_dc_probe+0x118/0x1ec)
[  262.228196] [<c02a21ec>] (tegra_dc_probe) from [<c02b86d4>] 
(platform_drv_probe+0x18/0x48)
[  262.236457] [<c02b86d4>] (platform_drv_probe) from [<c02b7334>] 
(driver_probe_device+0x118/0x234)
[  262.245334] [<c02b7334>] (driver_probe_device) from [<c02b5a6c>] 
(bus_for_each_drv+0x44/0x8c)
[  262.253855] [<c02b5a6c>] (bus_for_each_drv) from [<c02b71e4>] 
(device_attach+0x70/0x88)
[  262.261854] [<c02b71e4>] (device_attach) from [<c02b68ec>] 
(bus_probe_device+0x84/0xa8)
[  262.269853] [<c02b68ec>] (bus_probe_device) from [<c02b6cdc>] 
(deferred_probe_work_func+0x60/0x8c)
[  262.278808] [<c02b6cdc>] (deferred_probe_work_func) from [<c0039da4>] 
(process_one_work+0xfc/0x350)
[  262.287850] [<c0039da4>] (process_one_work) from [<c003a3fc>] 
(worker_thread+0x13c/0x384)
[  262.296022] [<c003a3fc>] (worker_thread) from [<c003facc>] 
(kthread+0xc4/0xe0)
[  262.303242] [<c003facc>] (kthread) from [<c000e678>] 
(ret_from_fork+0x14/0x3c)


Marc

> 
>  arch/arm/boot/dts/tegra20-paz00.dts |   46
> ++++++++++++++++++++++++++++++++++- 1 file changed, 45 insertions(+), 1
> deletion(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts index c7cd8e6..9a39a80 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -17,6 +17,14 @@
>  	};
> 
>  	host1x at 50000000 {
> +		dc at 54200000 {
> +			rgb {
> +				status = "okay";
> +
> +				nvidia,panel = <&panel>;
> +			};
> +		};
> +
>  		hdmi at 54280000 {
>  			status = "okay";
> 
> @@ -257,7 +265,11 @@
>  		status = "okay";
>  	};
> 
> -	i2c at 7000c000 {
> +	pwm: pwm at 7000a000 {
> +		status = "okay";
> +	};
> +
> +	lvds_ddc: i2c at 7000c000 {
>  		status = "okay";
>  		clock-frequency = <400000>;
> 
> @@ -475,6 +487,18 @@
>  		non-removable;
>  	};
> 
> +	backlight: backlight {
> +		compatible = "pwm-backlight";
> +
> +		enable-gpios = <&gpio TEGRA_GPIO(U, 4) GPIO_ACTIVE_HIGH>;
> +		pwms = <&pwm 0 5000000>;
> +
> +		brightness-levels = <0 16 32 48 64 80 96 112 128 144 160 176 192 208 
224
> 240 255>; +		default-brightness-level = <10>;
> +
> +		backlight-boot-off;
> +	};
> +
>  	clocks {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -509,6 +533,16 @@
>  		};
>  	};
> 
> +	panel: panel {
> +		compatible = "samsung,ltn101nt05", "simple-panel";
> +
> +		ddc-i2c-bus = <&lvds_ddc>;
> +		power-supply = <&vdd_pnl_reg>;
> +		enable-gpios = <&gpio TEGRA_GPIO(M, 6) GPIO_ACTIVE_HIGH>;
> +
> +		backlight = <&backlight>;
> +	};
> +
>  	regulators {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -522,6 +556,16 @@
>  			regulator-max-microvolt = <5000000>;
>  			regulator-always-on;
>  		};
> +
> +		vdd_pnl_reg: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "+3VS,vdd_pnl";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			gpio = <&gpio TEGRA_GPIO(A, 4) GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +		};
>  	};
> 
>  	sound {
