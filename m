From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 18 Apr 2017 01:45:07 +0200
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <172093673.40121.1492427140661@email.1und1.de>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
Message-ID: <3356403.SG1AWLv0Nc@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

Am Montag, 17. April 2017, 13:05:40 CEST schrieb Stefan Wahren:
> > Stefan Wahren <stefan.wahren@i2se.com> hat am 31. Oktober 2016 um 21:34 geschrieben:
> > 
> > 
> > I inspired by this issue [1] i build up a slightly modified setup with a
> > Raspberry Pi B (mainline kernel 4.9rc3), a powered 7 port USB hub and 5 Prolific
> > PL2303 USB to serial convertors. I modified the usb_test for dwc2 [2], which
> > only tries to open all ttyUSB devices one after the other. 
> > 
> > Unfortunately the complete system stuck after opening the first ttyUSB device (
> > heartbeat LED stop blinking, no reaction to debug UART). The only way to
> > reanimate the system is to powerdown the USB hub with the USB to serial
> > convertors.
> > 
> > [1] - https://github.com/raspberrypi/linux/issues/1692
> > [2] - https://gist.github.com/lategoodbye/dd0d30af27b6f101b03d5923b279dbaa
> 
> since this issue still exists with 4.11 (even without or with microframe scheduler enabled), i want to ask some additional questions:
> 
> Is this issue reproducible with other dwc2 platforms than bcm2835?
> Does the soft lockup also occurs after opening the second serial convertor or later?

A friend of mine uses a rk3288-veyron-jerry as work-device also with a
slightly interesting usb topology (multiple hubs, keyboard, mouse,
smartcard-reader and printer) but not usb-serial adapters.

On the 4.9 that is currently on there, the system sometimes locks up when
trying to print things, sadly there is no serial console on it and the lockup
also kills the whole ui and we haven't managed to dig deeper yet.
[cpufreq is set to 600MHz minimum to mitigate the worst dwc2 issues].


Heiko


> > 
> > pi at raspberrypi:~$ lsusb -t
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/3p, 480M
> >         |__ Port 1: Dev 3, If 0, Class=Vendor Specific Class, Driver=smsc95xx,
> > 480M
> >         |__ Port 2: Dev 11, If 0, Class=Hub, Driver=hub/4p, 480M
> >             |__ Port 3: Dev 15, If 0, Class=Vendor Specific Class,
> > Driver=pl2303, 12M
> >             |__ Port 1: Dev 12, If 0, Class=Hub, Driver=hub/4p, 480M
> >                 |__ Port 2: Dev 14, If 0, Class=Vendor Specific Class,
> > Driver=pl2303, 12M
> >                 |__ Port 3: Dev 16, If 0, Class=Vendor Specific Class,
> > Driver=pl2303, 12M
> >             |__ Port 4: Dev 17, If 0, Class=Vendor Specific Class,
> > Driver=pl2303, 12M
> >             |__ Port 2: Dev 13, If 0, Class=Vendor Specific Class,
> > Driver=pl2303, 12M
> > 
> > pi at raspberrypi:~$ ./usb_test
> > idle
> > opening [/dev/ttyUSB0] ok
> > [  232.658768] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s!
> > [usb_test:522]
> > [  232.678443] Modules linked in: pwm_bcm2835 vchiq(C)
> > [  232.678481] CPU: 0 PID: 522 Comm: usb_test Tainted: G         C
> >      4.9.0-rc3+ #33
> > [  232.678486] Hardware name: BCM2835
> > [  232.678498] task: cab54e40 task.stack: c688c000
> > [  232.678520] PC is at __do_softirq+0x68/0x2a8
> > [  232.678538] LR is at irq_exit+0xb8/0x120
> > [  232.678552] pc : [<c01014d0>]    lr : [<c0121270>]    psr: 60000113
> > sp : c688da60  ip : c688daa8  fp : c688daa4
> > [  232.678560] r10: c0b7f800  r9 : c688c000  r8 : 00400000
> > [  232.678567] r7 : 0000000a  r6 : cb802400  r5 : 00000000  r4 : 00000001
> > [  232.678575] r3 : 00000000  r2 : 00000100  r1 : 00400000  r0 : 00000000
> > [  232.678585] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [  232.678593] Control: 00c5387d  Table: 068a4008  DAC: 00000051
> > [  232.678604] CPU: 0 PID: 522 Comm: usb_test Tainted: G         C
> >      4.9.0-rc3+ #33
> > [  232.678609] Hardware name: BCM2835
> > [  232.678667] [<c010ecc0>] (unwind_backtrace) from [<c010bc28>]
> > (show_stack+0x20/0x24)
> > [  232.678695] [<c010bc28>] (show_stack) from [<c03684e0>]
> > (dump_stack+0x20/0x28)
> > [  232.678718] [<c03684e0>] (dump_stack) from [<c0108ee4>] (show_regs+0x1c/0x20)
> > [  232.678752] [<c0108ee4>] (show_regs) from [<c018ea00>]
> > (watchdog_timer_fn+0x140/0x19c)
> > [  232.678779] [<c018ea00>] (watchdog_timer_fn) from [<c015eefc>]
> > (__hrtimer_run_queues.constprop.3+0xec/0x210)
> > [  232.678798] [<c015eefc>] (__hrtimer_run_queues.constprop.3) from [<c015f210>]
> > (hrtimer_interrupt+0xa4/0x1cc)
> > [  232.678827] [<c015f210>] (hrtimer_interrupt) from [<c04eff58>]
> > (bcm2835_time_interrupt+0x40/0x48)
> > [  232.678865] [<c04eff58>] (bcm2835_time_interrupt) from [<c01537ec>]
> > (__handle_irq_event_percpu+0x68/0x1b8)
> > [  232.678891] [<c01537ec>] (__handle_irq_event_percpu) from [<c0153968>]
> > (handle_irq_event_percpu+0x2c/0x68)
> > [  232.678915] [<c0153968>] (handle_irq_event_percpu) from [<c01539dc>]
> > (handle_irq_event+0x38/0x4c)
> > [  232.678939] [<c01539dc>] (handle_irq_event) from [<c0156df8>]
> > (handle_level_irq+0xc4/0xf8)
> > [  232.678960] [<c0156df8>] (handle_level_irq) from [<c0152fd8>]
> > (generic_handle_irq+0x28/0x38)
> > [  232.678983] [<c0152fd8>] (generic_handle_irq) from [<c0153144>]
> > (__handle_domain_irq+0x90/0xb8)
> > [  232.679004] [<c0153144>] (__handle_domain_irq) from [<c01013f4>]
> > (bcm2835_handle_irq+0x30/0x48)
> > [  232.679022] [<c01013f4>] (bcm2835_handle_irq) from [<c010c7cc>]
> > (__irq_svc+0x6c/0x90)
> > [  232.679031] Exception stack(0xc688da10 to 0xc688da58)
> > [  232.679044] da00:                                     00000000 00400000
> > 00000100 00000000
> > [  232.679062] da20: 00000001 00000000 cb802400 0000000a 00400000 c688c000
> > c0b7f800 c688daa4
> > [  232.679078] da40: c688daa8 c688da60 c0121270 c01014d0 60000113 fffff000000
> > c687a300 c9374900 ca918b00 caff1200 c688db84
> > [  232.679235] db20: c688db28 c688db40 c04a1cf8 c049cb64 60000013 ffffffff
> > [  232.679272] [<c010c7cc>] (__irq_svc) from [<c049cb64>]
> > (_dwc2_hcd_urb_enqueue+0x414/0x560)
> > [  232.679302] [<c049cb64>] (_dwc2_hcd_urb_enqueue) from [<c04849ac>]
> > (usb_hcd_submit_urb+0x704/0x8c4)
> > [  232.679327] [<c04849ac>] (usb_hcd_submit_urb) from [<c048628c>]
> > (usb_submit_urb+0x438/0x4e0)
> > [  232.679358] [<c048628c>] (usb_submit_urb) from [<c04a9d60>]
> > (usb_serial_generic_submit_read_urb+0x50/0xc8)
> > [  232.679382] [<c04a9d60>] (usb_serial_generic_submit_read_urb) from
> > [<c04aa0a8>] (usb_serial_generic_submit_read_urbs+0x28/0x70)
> > [  232.679407] [<c04aa0a8>] (usb_serial_generic_submit_read_urbs) from
> > [<c04aa298>] (usb_serial_generic_open+0x44/0x4c)
> > [  232.679435] [<c04aa298>] (usb_serial_generic_open) from [<c04aebc4>]
> > (pl2303_open+0xc0/0xe0)
> > [  232.679458] [<c04aebc4>] (pl2303_open) from [<c04a744c>]
> > (serial_port_activate+0x54/0x8c)
> > [  232.679486] [<c04a744c>] (serial_port_activate) from [<c03c4014>]
> > (tty_port_open+0x84/0xd4)
> > [  232.679509] [<c03c4014>] (tty_port_open) from [<c04a7d40>]
> > (serial_open+0x34/0x5c)
> > [  232.679546] [<c04a7d40>] (serial_open) from [<c03bd3a8>]
> > (tty_open+0x380/0x534)
> > [  232.679578] [<c03bd3a8>] (tty_open) from [<c021e188>]
> > (chrdev_open+0x120/0x14c)
> > [  232.679612] [<c021e188>] (chrdev_open) from [<c0217368>]
> > (do_dentry_open+0x1b8/0x304)
> > [  232.679638] [<c0217368>] (do_dentry_open) from [<c021876c>]
> > (vfs_open+0x7c/0x80)
> > [  232.679663] [<c021876c>] (vfs_open) from [<c022834c>]
> > (path_openat+0xb60/0xd88)
> > [  232.679682] [<c022834c>] (path_openat) from [<c02285bc>]
> > (do_filp_open+0x48/0x94)
> > [  232.679704] [<c02285bc>] (do_filp_open) from [<c0218af4>]
> > (do_sys_open+0x12c/0x1cc)
> > [  232.679728] [<c0218af4>] (do_sys_open) from [<c0218bc4>] (SyS_open+0x30/0x34)
> > [  232.679754] [<c0218bc4>] (SyS_open) from [<c0108280>]
> > (ret_fast_syscall+0x0/0x3c)
> > [  233.852571] usb 1-1.2: clear tt 1 (9063) error -110
> > [  233.853046] usb 1-1.2.1: clear tt 1 (9073) error -110
> > [  234.892554] usb 1-1.2.1: clear tt 1 (9071) error -110
> > [  234.892995] usb 1-1.2: clear tt 1 (9061) error -110
> > [  235.932574] usb 1-1.2.1: clear tt 1 (9073) error -110
> > [  235.933542] usb 1-1.2: clear tt 1 (9063) error -110
> > [  236.972595] usb 1-1.2.1: clear tt 1 (9071) error -110
> > [  236.973235] usb 1-1.2: clear tt 1 (9061) error -110
> > [  238.012573] usb 1-1.2: clear tt 1 (9063) error -110
> > [  238.013052] usb 1-1.2.1: clear tt 1 (9073) error -110
> > [  238.013456] hub 1-1:1.0: hub_ext_port_status failed (err = -110)
> > [  239.052567] usb 1-1.2.1: clear tt 1 (9071) error -110
> > [  239.053076] usb 1-1.2: clear tt 1 (9061) error -110
> > [  240.092573] usb 1-1.2: clear tt 1 (9063) error -110
> > [  240.093050] usb 1-1.2.1: clear tt 1 (9073) error -110
> > [  240.239643] usb 1-1.2.1: USB disconnect, device number 5
> > [  240.239685] usb 1-1.2.1.2: USB disconnect, device number 7
> > [  240.262707] usb 1-1.2: clear tt 1 (9061) error -71
> > [  240.263123] usb 1-1.2.1: clear tt 1 (9071) error -71
> > [  240.263708] usb 1-1.2: USB disconnect, device number 4
> > [  694304] pl2303 ttyUSB0: pl2303 converter now disconnected from ttyUSB0
> > [  251.694645] pl2303 1-1.2.2:1.0: device disconnected
> > [  251.704668] usb 1-1.2.3: USB disconnect, device number 8
> > [  251.706468] pl2303 ttyUSB2: pl2303 converter now disconnected from ttyUSB2
> > [  251.706894] pl2303 1-1.2.3:1.0: device disconnected
> > [  251.714720] usb 1-1.2.4: USB disconnect, device number 10
> > [  251.733019] pl2303 ttyUSB4: pl2303 converter now disconnected from ttyUSB4
> > [  251.733459] pl2303 1-1.2.4:1.0: device disconnected
> > [  251.852767] hub 1-1.2:1.0: activate --> -19
> > 
> > _______________________________________________
> > linux-rpi-kernel mailing list
> > linux-rpi-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
> 
> 
