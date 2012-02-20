From: joancarles@fqingenieria.es (joancarles)
Date: Mon, 20 Feb 2012 10:15:42 +0100
Subject: [2.6.39.3] [MX25] oops in driver_register for ADC touchscreen support
 (imx_adc_ts)
Message-ID: <50e2a71500444a5e1b951e5856d474bf@mail.fqingenieria.es>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

We're trying to get our ADC working (actually generic 4-way touchscreen 
support via ADC) on a custom PCB using the i.MX25 infrastructure. It 
seems that there are not a lot of people out there, who have tried the 
Freescale implementation (based on their latest kernel drop: 2.6.31) of 
the ADC driver for touchscreen support. Freescale's support with regard 
to kernel development for out-of-tree implementation, somewhat 
understandably, has so far been close to non-existent.

Here is our crash dump:

[    1.636986] i.MX ADC input touchscreen: trying to load.
[    1.642470] i.MX ADC input touchscreen: ADC ready.
[    1.647530] i.MX ADC input touchscreen: input device allocated.
[    1.653583] usb 2-1: not running at top speed; connect to a high 
speed hub
[    1.661499] input: imx_adc_ts as /devices/virtual/input/input0
[    1.667570] usb 2-1: New USB device found, idVendor=0424, 
idProduct=2513
[    1.674309] usb 2-1: New USB device strings: Mfr=0, Product=0, 
SerialNumber=0
[    1.685746] i.MX ADC input touchscreen: input device registered.
[    1.692270] i.MX ADC input touchscreen loaded.
[    1.696881] imxdi_rtc imxdi_rtc.0: setting system clock to 
1970-01-01 00:00:00 UTC (0)
[    1.705016] i.MX ADC: imx_adc_read_ts start reading
[    1.711638] i.MX ADC: imx_adc_interrupt handler called
[    1.716805] i.MX ADC: imx_adc_interrupt waking up tsq
[    1.722717] hub 2-1:1.0: USB hub found
[    1.727755] hub 2-1:1.0: 3 ports detected
[    1.731882] i.MX ADC: imx_adc_read_ts before event interruptible
[    1.738197] i.MX ADC: imx_adc_read_ts after event interruptible
[    1.744289] i.MX ADC: imx_adc_read_ts finished reading
[    1.849692] i.MX ADC: imx_adc_read_ts filling samples
[    1.867547] i.MX ADC: imx_adc_read_ts before mutex
[    1.872378] i.MX ADC: imx_adc_read_ts after mutex
[    1.877165] Unable to handle kernel NULL pointer dereference at 
virtual address 00000024
[    1.885280] pgd = c0004000
[    1.887998] [00000024] *pgd=00000000
[    1.891602] Internal error: Oops: 5 [#1] PREEMPT
[    1.896232] last sysfs file:
[    1.899213] Modules linked in:
[    1.902298] CPU: 0    Not tainted  (2.6.39.3-sid1-2.1.8-rc+ #44)
[    1.908357] PC is at input_handle_event+0x244/0x4d0
[    1.913265] LR is at input_event+0x7c/0xac
[    1.917386] pc : [<c02a7934>]    lr : [<c02a7ce8>]    psr: 20000093
[    1.917403] sp : c397ff58  ip : 00000000  fp : 00000000
[    1.928905] r10: 00000000  r9 : 00000000  r8 : 00000013
[    1.934150] r7 : 00000000  r6 : 00000001  r5 : c3965400  r4 : 
00000003
[    1.940699] r3 : 00000018  r2 : 00000018  r1 : 00000003  r0 : 
00000000
[    1.947252] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  
Segment kernel
[    1.954673] Control: 0005317f  Table: 80004000  DAC: 00000017
[    1.960440] Process imx_adc_ts (pid: 37, stack limit = 0xc397e270)
[    1.966642] Stack: (0xc397ff58 to 0xc3980000)
[    1.971022] ff40:                                                    
   00000003 c397e000
[    1.979240] ff60: c3965400 00000001 00000013 c02a7ce8 c060d620 
00000000 00000000 c060d620
[    1.987458] ff80: c060d620 00000000 00000000 c02aa124 00000000 
000004c8 0000049b 00000593
[    1.995675] ffa0: 00000000 00000840 000008dc 00000870 00000001 
00000001 00000013 c381df78
[    2.003892] ffc0: 00000000 c02aa0b0 00000013 c0056928 00000000 
00000000 00000000 00000001
[    2.012113] ffe0: c397ffe0 c397ffe0 c381df78 c005689c c002a890 
c002a890 fbecc297 f3ffe7e7
[    2.020361] [<c02a7934>] (input_handle_event+0x244/0x4d0) from 
[<c02a7ce8>] (input_event+0x7c/0xac)
[    2.029466] [<c02a7ce8>] (input_event+0x7c/0xac) from [<c02aa124>] 
(ts_thread+0x74/0xd0)
[    2.037629] [<c02aa124>] (ts_thread+0x74/0xd0) from [<c0056928>] 
(kthread+0x8c/0x94)
[    2.045442] [<c0056928>] (kthread+0x8c/0x94) from [<c002a890>] 
(kernel_thread_exit+0x0/0x8)
[    2.053840] Code: 0a00001f e59530fc e0861086 e0833181 (e593300c)
[    2.060090] ---[ end trace 24451e1ee97aa5a2 ]---
[    2.064748] note: imx_adc_ts[37] exited with preempt_count 1

I have attached the modified (adapted due to various kernel changes 
between 2.6.31 and 2.6.39.3 and sprinkled some printk's for better 
understanding in initial forward-port) imx_adc_ts and imx_adc drivers 
for viewing pleasure.

When enabling mutex and spinlock debugging, the machine oopses and 
hangs forever, leaving us with following dump:

[    1.418168] INFO: trying to register non-static key.
[    1.423176] the code is fine but needs lockdep annotation.
[    1.428683] turning off the locking correctness validator.
[    1.434264] [<c002e6a8>] (unwind_backtrace+0x0/0x130) from 
[<c0065ae4>] (__lock_acquire.clone.16+0x5d0/0xc90)
[    1.444255] [<c0065ae4>] (__lock_acquire.clone.16+0x5d0/0xc90) from 
[<c00666d4>] (lock_acquire+0x5c/0x70)
[    1.453896] [<c00666d4>] (lock_acquire+0x5c/0x70) from [<c03f1af0>] 
(_raw_spin_lock_irqsave+0x4c/0x60)
[    1.463269] [<c03f1af0>] (_raw_spin_lock_irqsave+0x4c/0x60) from 
[<c02a4944>] (di_int_enable+0x18/0x38)
[    1.472718] [<c02a4944>] (di_int_enable+0x18/0x38) from [<c02a4a94>] 
(di_write_wait+0x30/0x1b8)
[    1.481472] [<c02a4a94>] (di_write_wait+0x30/0x1b8) from 
[<c02a4e58>] (dryice_rtc_probe+0x17c/0x2b4)
[    1.490663] [<c02a4e58>] (dryice_rtc_probe+0x17c/0x2b4) from 
[<c0209a78>] (platform_drv_probe+0x14/0x18)
[    1.500202] [<c0209a78>] (platform_drv_probe+0x14/0x18) from 
[<c02089f0>] (driver_probe_device+0xd8/0x214)
[    1.509909] [<c02089f0>] (driver_probe_device+0xd8/0x214) from 
[<c0208bc0>] (__driver_attach+0x94/0x98)
[    1.519371] [<c0208bc0>] (__driver_attach+0x94/0x98) from 
[<c0207b30>] (bus_for_each_dev+0x54/0x7c)
[    1.528487] [<c0207b30>] (bus_for_each_dev+0x54/0x7c) from 
[<c020827c>] (bus_add_driver+0xb8/0x25c)
[    1.537592] [<c020827c>] (bus_add_driver+0xb8/0x25c) from 
[<c0208ee0>] (driver_register+0x78/0x13c)
[    1.546692] [<c0208ee0>] (driver_register+0x78/0x13c) from 
[<c0209cf8>] (platform_driver_probe+0x18/0x9c)
[    1.556328] [<c0209cf8>] (platform_driver_probe+0x18/0x9c) from 
[<c00294c4>] (do_one_initcall+0x30/0x16c)
[    1.565962] [<c00294c4>] (do_one_initcall+0x30/0x16c) from 
[<c000891c>] (kernel_init+0x94/0x140)
[    1.574810] [<c000891c>] (kernel_init+0x94/0x140) from [<c002a870>] 
(kernel_thread_exit+0x0/0x8)
[    7.321116] BUG: spinlock lockup on CPU#0, swapper/1, c3862490
[    7.327010] [<c002e6a8>] (unwind_backtrace+0x0/0x130) from 
[<c01d4a04>] (do_raw_spin_lock+0x124/0x140)
[    7.336387] [<c01d4a04>] (do_raw_spin_lock+0x124/0x140) from 
[<c03f1af8>] (_raw_spin_lock_irqsave+0x54/0x60)
[    7.346280] [<c03f1af8>] (_raw_spin_lock_irqsave+0x54/0x60) from 
[<c02a4944>] (di_int_enable+0x18/0x38)
[    7.355728] [<c02a4944>] (di_int_enable+0x18/0x38) from [<c02a4a94>] 
(di_write_wait+0x30/0x1b8)
[    7.364480] [<c02a4a94>] (di_write_wait+0x30/0x1b8) from 
[<c02a4e58>] (dryice_rtc_probe+0x17c/0x2b4)
[    7.373670] [<c02a4e58>] (dryice_rtc_probe+0x17c/0x2b4) from 
[<c0209a78>] (platform_drv_probe+0x14/0x18)
[    7.383207] [<c0209a78>] (platform_drv_probe+0x14/0x18) from 
[<c02089f0>] (driver_probe_device+0xd8/0x214)
[    7.392913] [<c02089f0>] (driver_probe_device+0xd8/0x214) from 
[<c0208bc0>] (__driver_attach+0x94/0x98)
[    7.402371] [<c0208bc0>] (__driver_attach+0x94/0x98) from 
[<c0207b30>] (bus_for_each_dev+0x54/0x7c)
[    7.411480] [<c0207b30>] (bus_for_each_dev+0x54/0x7c) from 
[<c020827c>] (bus_add_driver+0xb8/0x25c)
[    7.420583] [<c020827c>] (bus_add_driver+0xb8/0x25c) from 
[<c0208ee0>] (driver_register+0x78/0x13c)
[    7.429684] [<c0208ee0>] (driver_register+0x78/0x13c) from 
[<c0209cf8>] (platform_driver_probe+0x18/0x9c)
[    7.439317] [<c0209cf8>] (platform_driver_probe+0x18/0x9c) from 
[<c00294c4>] (do_one_initcall+0x30/0x16c)
[    7.448948] [<c00294c4>] (do_one_initcall+0x30/0x16c) from 
[<c000891c>] (kernel_init+0x94/0x140)
[    7.457794] [<c000891c>] (kernel_init+0x94/0x140) from [<c002a870>] 
(kernel_thread_exit+0x0/0x8)

Could someone please help us with the debugging? We're kind of stuck 
right now. It's interesting that we see two interrupts registered to IRQ 
46 in /proc/interrupts after boot and oops.

Best regards
-- 
Joan C. Abelaira
  FQ Ingenier?a Electr?nica, S.A.
Pol?gon Industrial Vilanoveta
Av. de les Roquetes, 9
E-08812 Sant Pere de Ribes (Barcelona)
SPAIN
Telf: +34 932 080 258
Fax: +34 934 592 893
M?vil: +34 638 331 745

http://www.fqingenieria.es/
email: joancarles at fqingenieria.es
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx_adc_ts.c
Type: text/x-c
Size: 3459 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120220/a09c3ff0/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: imx_adc.c
Type: text/x-c
Size: 31383 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120220/a09c3ff0/attachment-0003.bin>
