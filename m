From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 4 Mar 2018 22:58:03 +0100 (CET)
Subject: [PATCH 3/4] ARM: dts: bcm2835-rpi-zero-w: Add bcm43438 serial
 slave
In-Reply-To: <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-4-git-send-email-stefan.wahren@i2se.com>
 <84F7E645-59B4-4618-8C91-A5CD654E16A6@holtmann.org>
 <648118289.71086.1519593373795@email.1und1.de>
 <9D6209F2-5389-4F4E-844D-6A8683044F88@holtmann.org>
Message-ID: <395166283.280598.1520200683559@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcel,

> Marcel Holtmann <marcel@holtmann.org> hat am 25. Februar 2018 um 22:38 geschrieben:
> 
> 
> Hi Stefan,
> 
> >>> Add BCM43438 (bluetooth) as a serdev slave device of uart0 (pl011/ttyAMA0).
> >>> This allows to automatically insert the bcm43438 to the bluetooth
> >>> subsystem instead of relying on patched userspace helpers (hciattach).
> >>> 
> >>> In order to keep a debug UART we need to switch to uart1.
> >>> 
> >>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> >>> ---
> >>> arch/arm/boot/dts/bcm2835-rpi-zero-w.dts | 14 +++++++++++++-
> >>> 1 file changed, 13 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> index cf53436..b7f79f1 100644
> >>> --- a/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> +++ b/arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
> >>> @@ -131,6 +131,18 @@
> >>> 
> >>> &uart0 {
> >>> 	pinctrl-names = "default";
> >>> -	pinctrl-0 = <&uart0_gpio14>;
> >>> +	pinctrl-0 = <&uart0_gpio32 &uart0_ctsrts_gpio30>;
> >>> +	status = "okay";
> >>> +
> >>> +	bluetooth {
> >>> +		compatible = "brcm,bcm43438-bt";
> >>> +		max-speed = <2000000>;
> >>> +		shutdown-gpios = <&gpio 45 GPIO_ACTIVE_HIGH>;
> >>> +	};
> >>> +};
> >> 
> >> is the shutdown GPIO working as expected with this hardware. So even module unload and reload works fine?
> > 
> > Yes, unload and reload works fine. 
> > 
> >> Meaning we are getting back to the 115200 default baud rate on the UART?
> > 
> > I assume that, because reload works as expected. 
> 
> awesome. That is good news.
> 
> Since you said that the GPIO expander driver for the RPi 3 has been accepted, did you test it there as well? If so, then it would be good to get a patch that also provides shutdown-gpios for RPi 3.

so here comes the bad news. hci_bcm uses gpiod_set_value() which is for interrupt context, but the gpio expander can sleep. So we will get this warning:

[    4.802447] ------------[ cut here ]------------
[    4.802485] WARNING: CPU: 3 PID: 91 at drivers/gpio/gpiolib.c:2986 gpiod_set_value+0x50/0x58
[    4.802489] Modules linked in: hci_uart ac97_bus btbcm snd_pcm_dmaengine bluetooth snd_pcm snd_timer ecdh_generic snd soundcore bcm2835_thermal crc32_arm_ce
[    4.802543] CPU: 3 PID: 91 Comm: kworker/u8:2 Not tainted 4.16.0-rc3-next-20180302-dirty #4
[    4.802547] Hardware name: BCM2835
[    4.802562] Workqueue: events_unbound async_run_entry_fn
[    4.802593] [<c03119a4>] (unwind_backtrace) from [<c030cc24>] (show_stack+0x10/0x14)
[    4.802612] [<c030cc24>] (show_stack) from [<c0d8e9dc>] (dump_stack+0x8c/0xa0)
[    4.802628] [<c0d8e9dc>] (dump_stack) from [<c0343a2c>] (__warn+0xe0/0xf8)
[    4.802640] [<c0343a2c>] (__warn) from [<c0343b5c>] (warn_slowpath_null+0x40/0x48)
[    4.802652] [<c0343b5c>] (warn_slowpath_null) from [<c06d0de0>] (gpiod_set_value+0x50/0x58)
[    4.802693] [<c06d0de0>] (gpiod_set_value) from [<bf0e2e90>] (bcm_gpio_set_shutdown+0xc/0x14 [hci_uart])
[    4.802757] [<bf0e2e90>] (bcm_gpio_set_shutdown [hci_uart]) from [<bf0e2a64>] (bcm_gpio_set_power+0x18/0x140 [hci_uart])
[    4.802806] [<bf0e2a64>] (bcm_gpio_set_power [hci_uart]) from [<bf0e2e4c>] (bcm_serdev_probe+0x64/0x9c [hci_uart])
[    4.802848] [<bf0e2e4c>] (bcm_serdev_probe [hci_uart]) from [<c08f2528>] (driver_probe_device+0x254/0x32c)
[    4.802863] [<c08f2528>] (driver_probe_device) from [<c08f26a4>] (__driver_attach+0xa4/0xa8)
[    4.802878] [<c08f26a4>] (__driver_attach) from [<c08f08b8>] (bus_for_each_dev+0x74/0xb4)
[    4.802895] [<c08f08b8>] (bus_for_each_dev) from [<c0366498>] (async_run_entry_fn+0x44/0x108)
[    4.802910] [<c0366498>] (async_run_entry_fn) from [<c035d594>] (process_one_work+0x200/0x4f8)
[    4.802923] [<c035d594>] (process_one_work) from [<c035e4a8>] (worker_thread+0x4c/0x5d4)
[    4.802938] [<c035e4a8>] (worker_thread) from [<c0363300>] (kthread+0x150/0x158)
[    4.802952] [<c0363300>] (kthread) from [<c03010e8>] (ret_from_fork+0x14/0x2c)
[    4.802957] Exception stack(0xed959fb0 to 0xed959ff8)
[    4.802966] 9fa0:                                     00000000 00000000 00000000 00000000
[    4.802977] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.802986] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.802993] ---[ end trace b947f9d4c40fa261 ]---

Stefan

> 
> Regards
> 
> Marcel
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
