From: zac.wheeler@gmail.com (Zac Wheeler)
Date: Mon, 18 Oct 2010 17:00:42 -0700
Subject: Problems with atmel_spi & ads7846 w/ hwmon enabled in 2.6.30
Message-ID: <AANLkTim5LfdfaXqL_fVm2JCKekAmD9EY68+GbL_Tno6K@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm hoping  there is an spi expert out there who can offer some
insight into what is wrong with our setup and/or the atmel_spi driver.

We are using an AT91SAM9261S board w/ the SPI driver. It has also
happened on AT91SAM9261 boards.
I am seeing multiple NULL pointer dereferences in atmel_spi_interrupt.
Steps to reproduce:
** In board-whatever.c set up the drivers as follows:
static struct ads7846_platform_data ads_info = {
.model = 7846,
.vref_mv = 2500,
.debounce_max = 0, //disable debounce
.get_pendown_state = ads7846_pendown_state,
}

static struct spi_board_info whatever_spi_devices[] = {
{
.modalias = "ads7846",
.chip_select = 1,
.max_speed_hz = 125000*16,
.bus_num = 1,
.platform_data = &ads_info
.irq = AT91SAM9261_ID_IRQ0,
},
};

static int ads7846_pendown_state(void)
{
return !at91_get_gpio_value(AT91_PIN_PC2);
}

** Compile 2.6.30 kernel for 9261 with ads7846 driver compiled in with
hwmon enabled (so /sys/bus/spi/devices/spiX.X/in0_input and other
sysfs files exist)

** Boot board (you'll need tslib installed to make this easy)

** Run `ts_test &` (send to background)

** Run `while [ 1 ] ; do cat /sys/bus/spi/devices/spi1.1/in0_input;
cat /sys/bus/spi/devices/spi1.1/in1_input; done

** Run your finger around on the touchscreen and wait for the Oops.

Either this one:

Unable to handle kernel NULL pointer dereference at virtual address 00000016
pgd = c3920000
[00000016] *pgd=23907031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: sht21 zd1211rw
CPU: 0    Not tainted  (2.6.30 #53)
PC is at atmel_spi_interrupt+0x148/0x25c
LR is at atmel_spi_interrupt+0x18/0x25c
pc : [<c04a3220>]    lr : [<c04a30f0>]    psr: 20000013
sp : c3ac1d38  ip : c4878000  fp : c069f900
r10: 0000000a  r9 : c069f92c  r8 : c3ac0000
r7 : c33ed000  r6 : c33ed0e0  r5 : c33ed0d8  r4 : 00000000
r3 : 00000202  r2 : c4878000  r1 : 00000008  r0 : c33ed0d8
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 23920000  DAC: 00000015
Process thermd (pid: 354, stack limit = 0xc3ac0268)
Stack: (0xc3ac1d38 to 0xc3ac2000)
1d20:                                                       00000000 00000003
1d40: c3ac1d7c c331c2e0 00000000 00000000 0000000d c03017ec 0000000d c067a924
1d60: c331c2e0 c067a960 0000000d c0303218 c069f900 0000000d c06899d4 c3ac1e20
1d80: c3ac1ec0 c02ba03c ffffffff fefff000 0000000d c02baa94 00000000 c3ac0000
1da0: 00000102 20000013 0000000d 00000102 00000000 c3ac1ec0 c3ac0000 c069f92c
1dc0: 0000000a c069f900 c3ac1ec4 c3ac1de0 c02ba04c c02dd598 20000013 ffffffff
1de0: 0000000d 00000002 00000000 0000000d c06899d4 00000000 c3ac1ec0 00000002
1e00: 00000000 00000000 c3ac1eb4 c02ba04c ffffffff fefff000 0000000d c02baa94
1e20: c3ac1ec0 c38e40e0 ffffffff 60000013 7fffffff c3ac1ebc c3ac0000 c3ac1ec0
1e40: 00000002 00000000 00000000 c3ac1eb4 00000001 c3ac1e68 c0591acc c0591ad8
1e60: 60000013 ffffffff c3ac1eb4 c058fe00 ffffffff 00000001 c38e40e0 c02d3510
1e80: c3ac1ed0 c3ac1ed0 60000013 c303f4e0 c39e2208 c3ac1ebc c33d9800 c39e2208
1ea0: c39e2204 c303f4e0 00000fff c3ac1eb8 c04a2574 c058fd00 00020202 00000001
1ec0: 00000001 dead4ead ffffffff ffffffff c3ac1e80 c3ac1e80 00000001 00000002
1ee0: c39e2200 c04ce978 c33d9800 c31ca000 c33c9938 c068dc38 c3ac1f80 c3ac0000
1f00: c30dc7b8 c04ceaf4 c068dc38 c303f4e8 c0693e2c c046a968 00000fff c303f4e8
1f20: c30dc7a0 c036c3b0 c067f85c c067f894 00000100 0005f490 c069f92c c392fc80
1f40: 0005f490 c3ac1f80 00000fff 0005f490 c3ac0000 00000000 0005a940 c0329b50
1f60: 00000100 c0304478 c069f900 00000000 00000000 c392fc80 00000fff c0329cb8
1f80: 00000000 00000000 00000008 00000000 00000000 00000fff 0005f490 00000003
1fa0: c02bafa8 c02bae00 00000000 00000fff 0000000d 0005f490 00000fff 0005db84
1fc0: 00000000 00000fff 0005f490 00000003 0005a92c bef38950 00000fff 0005a940
1fe0: 400e6388 bef38838 400c04e8 401285bc 20000010 0000000d 00000000 00000000
[<c04a3220>] (atmel_spi_interrupt+0x148/0x25c) from [<c03017ec>]
(handle_IRQ_event+0x5c/0x134)
[<c03017ec>] (handle_IRQ_event+0x5c/0x134) from [<c0303218>]
(handle_level_irq+0x8c/0x118)
[<c0303218>] (handle_level_irq+0x8c/0x118) from [<c02ba03c>] (_text+0x3c/0x80)
[<c02ba03c>] (_text+0x3c/0x80) from [<c02baa94>] (__irq_svc+0x34/0x60)
Exception stack(0xc3ac1d98 to 0xc3ac1de0)
1d80:                                                       00000000 c3ac0000
1da0: 00000102 20000013 0000000d 00000102 00000000 c3ac1ec0 c3ac0000 c069f92c
1dc0: 0000000a c069f900 c3ac1ec4 c3ac1de0 c02ba04c c02dd598 20000013 ffffffff
[<c02baa94>] (__irq_svc+0x34/0x60) from [<c02ba04c>] (_text+0x4c/0x80)
[<c02ba04c>] (_text+0x4c/0x80) from [<0000000d>] (0xd)
Exception stack(0xc3ac1df0 to 0xc3ac1e38)
1de0:                                     c06899d4 00000000 c3ac1ec0 00000002
1e00: 00000000 00000000 c3ac1eb4 c02ba04c ffffffff fefff000 0000000d c02baa94
1e20: c3ac1ec0 c38e40e0 ffffffff 60000013 7fffffff c3ac1ebc
Code: e58c3018 e5952010 e59f3108 e5823120 (e1d401b6)
Kernel panic - not syncing: Fatal exception in interrupt
[<c02c0e00>] (unwind_backtrace+0x0/0xe4) from [<c058f9d8>] (panic+0x3c/0x128)
[<c058f9d8>] (panic+0x3c/0x128) from [<c02bee64>] (die+0x11c/0x14c)
[<c02bee64>] (die+0x11c/0x14c) from [<c02c1d94>] (__do_kernel_fault+0x70/0x80)
[<c02c1d94>] (__do_kernel_fault+0x70/0x80) from [<c02c1ed4>]
(do_page_fault+0x130/0x238)
[<c02c1ed4>] (do_page_fault+0x130/0x238) from [<c02ba26c>]
(do_DataAbort+0x34/0x98)
[<c02ba26c>] (do_DataAbort+0x34/0x98) from [<c02baa4c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc3ac1cf0 to 0xc3ac1d38)
1ce0:                                     c33ed0d8 00000008 c4878000 00000202
1d00: 00000000 c33ed0d8 c33ed0e0 c33ed000 c3ac0000 c069f92c 0000000a c069f900
1d20: c4878000 c3ac1d38 c04a30f0 c04a3220 20000013 ffffffff
[<c02baa4c>] (__dabt_svc+0x4c/0x60) from [<c04a30f0>]
(atmel_spi_interrupt+0x18/0x25c)
[<c04a30f0>] (atmel_spi_interrupt+0x18/0x25c) from [<c03017ec>]
(handle_IRQ_event+0x5c/0x134)
[<c03017ec>] (handle_IRQ_event+0x5c/0x134) from [<c0303218>]
(handle_level_irq+0x8c/0x118)
[<c0303218>] (handle_level_irq+0x8c/0x118) from [<c02ba03c>] (_text+0x3c/0x80)
[<c02ba03c>] (_text+0x3c/0x80) from [<c02baa94>] (__irq_svc+0x34/0x60)
Exception stack(0xc3ac1d98 to 0xc3ac1de0)
1d80:                                                       00000000 c3ac0000
1da0: 00000102 20000013 0000000d 00000102 00000000 c3ac1ec0 c3ac0000 c069f92c
1dc0: 0000000a c069f900 c3ac1ec4 c3ac1de0 c02ba04c c02dd598 20000013 ffffffff
[<c02baa94>] (__irq_svc+0x34/0x60) from [<c02ba04c>] (_text+0x4c/0x80)
[<c02ba04c>] (_text+0x4c/0x80) from [<0000000d>] (0xd)
Exception stack(0xc3ac1df0 to 0xc3ac1e38)
1de0:                                     c06899d4 00000000 c3ac1ec0 00000002
1e00: 00000000 00000000 c3ac1eb4 c02ba04c ffffffff fefff000 0000000d c02baa94
1e20: c3ac1ec0 c38e40e0 ffffffff 60000013 7fffffff c3ac1ebc

Where atmel_spi_interrupt +0x148 appears to point at:

if (xfer->cs_change)
{
cs_deactivate(as, msg->spi);
udelay(1);
cs_activate(as, msg->spi);
}

Changing that if to:
if(1)
seems to prevent the touchscreen driver from reporting events
if(0)
gets us beyond it and into the following Oops, which I am having
trouble determining the execution point of:

Unable to handle kernel NULL pointer dereference at virtual address 00000016
pgd = c392c000
[00000016] *pgd=2391d031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: sht21 zd1211rw
CPU: 0    Not tainted  (2.6.30 #57)
PC is at atmel_spi_interrupt+0xec/0x1f8
LR is at atmel_spi_interrupt+0x18/0x1f8
pc : [<c04a3344>]    lr : [<c04a3270>]    psr: 20000013
sp : c3917d60  ip : c4878000  fp : c069f900
r10: 0000000a  r9 : c069f92c  r8 : c3916000
r7 : c33ed000  r6 : c33ed0e0  r5 : c33ed0d8  r4 : 00000000
r3 : 00000202  r2 : c4878000  r1 : 00000008  r0 : c33ed0d8
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 2392c000  DAC: 00000015
Process thermd (pid: 4292, stack limit = 0xc3916268)
Stack: (0xc3917d60 to 0xc3918000)
7d60: 00000000 c303f4e0 c3145c04 c331c2e0 00000000 00000000 0000000d c03017ec
7d80: 0000000d c067a924 c331c2e0 c067a960 0000000d c0303218 c069f900 0000000d
7da0: c06899d4 c3917e48 c33ed0d8 c02ba03c ffffffff fefff000 0000000d c02baa94
7dc0: 00000000 c3916000 00000102 20000013 00000000 00000102 00000000 c33ed0d8
7de0: c3916000 c069f92c 0000000a c069f900 c3145ca0 c3917e08 c02ba04c c02dd5ac
7e00: 20000013 ffffffff 0000000d c303f4e0 c3145c04 0000000d c06899d4 00000000
7e20: c33ed0d8 c303f4e0 c3145c04 ffffffff 00000fff c02ba04c ffffffff fefff000
7e40: 0000000d c02baa94 c33ed0d8 c31d4440 ffffffff 00000001 60000013 c3145c04
7e60: c3145c08 c33ed0d8 c303f4e0 c3145c04 ffffffff 00000fff c3145c58 c3917e90
7e80: c0591c04 c0591c10 60000013 ffffffff 60000013 c04a35b4 c067b060 c303f4e0
7ea0: c3145c08 c3917ebc c33d9800 c3145c08 c303f4e0 c04a26e4 00020202 00000001
7ec0: 00000001 dead4ead ffffffff ffffffff c3917ed0 c3917ed0 00000001 00000002
7ee0: c3145c00 c04cea94 c33d9800 c312d000 c33c9908 c068dc38 c3917f80 c3916000
7f00: c3a90258 c04ceb50 c068dc38 c303f4e8 c0693e40 c046aae8 00000fff c303f4e8
7f20: c3a90240 c036c3b0 c067f85c c067f894 00000100 0005e470 00000000 c31d0260
7f40: 0005e470 c3917f80 00000fff 0005e470 c3916000 00000000 0005a940 c0329b50
7f60: c35992f8 0000000a bec797cc 00000000 00000000 c31d0260 00000fff c0329cb8
7f80: 00000000 00000000 400e6000 00000000 00000000 00000fff 0005e470 00000003
7fa0: c02bafa8 c02bae00 00000000 00000fff 0000000a 0005e470 00000fff 0005d04c
7fc0: 00000000 00000fff 0005e470 00000003 0005a92c bec79960 00000fff 0005a940
7fe0: 400e6388 bec79848 400c04e8 401285bc 20000010 0000000a 00000000 00000000
[<c04a3344>] (atmel_spi_interrupt+0xec/0x1f8) from [<c03017ec>]
(handle_IRQ_event+0x5c/0x134)
[<c03017ec>] (handle_IRQ_event+0x5c/0x134) from [<c0303218>]
(handle_level_irq+0x8c/0x118)
[<c0303218>] (handle_level_irq+0x8c/0x118) from [<c02ba03c>] (_text+0x3c/0x80)
[<c02ba03c>] (_text+0x3c/0x80) from [<c02baa94>] (__irq_svc+0x34/0x60)
Exception stack(0xc3917dc0 to 0xc3917e08)
7dc0: 00000000 c3916000 00000102 20000013 00000000 00000102 00000000 c33ed0d8
7de0: c3916000 c069f92c 0000000a c069f900 c3145ca0 c3917e08 c02ba04c c02dd5ac
7e00: 20000013 ffffffff
[<c02baa94>] (__irq_svc+0x34/0x60) from [<c02ba04c>] (_text+0x4c/0x80)
[<c02ba04c>] (_text+0x4c/0x80) from [<0000000d>] (0xd)
Exception stack(0xc3917e18 to 0xc3917e60)
7e00:                                                       c06899d4 00000000
7e20: c33ed0d8 c303f4e0 c3145c04 ffffffff 00000fff c02ba04c ffffffff fefff000
7e40: 0000000d c02baa94 c33ed0d8 c31d4440 ffffffff 00000001 60000013 c3145c04
Code: e58c3018 e5952010 e59f3100 e5823120 (e1d401b6)
Kernel panic - not syncing: Fatal exception in interrupt
[<c02c0e00>] (unwind_backtrace+0x0/0xe4) from [<c058faf4>] (panic+0x3c/0x128)
[<c058faf4>] (panic+0x3c/0x128) from [<c02bee64>] (die+0x11c/0x14c)
[<c02bee64>] (die+0x11c/0x14c) from [<c02c1d94>] (__do_kernel_fault+0x70/0x80)
[<c02c1d94>] (__do_kernel_fault+0x70/0x80) from [<c02c1ed4>]
(do_page_fault+0x130/0x238)
[<c02c1ed4>] (do_page_fault+0x130/0x238) from [<c02ba26c>]
(do_DataAbort+0x34/0x98)
[<c02ba26c>] (do_DataAbort+0x34/0x98) from [<c02baa4c>] (__dabt_svc+0x4c/0x60)
Exception stack(0xc3917d18 to 0xc3917d60)
7d00:                                                       c33ed0d8 00000008
7d20: c4878000 00000202 00000000 c33ed0d8 c33ed0e0 c33ed000 c3916000 c069f92c
7d40: 0000000a c069f900 c4878000 c3917d60 c04a3270 c04a3344 20000013 ffffffff
[<c02baa4c>] (__dabt_svc+0x4c/0x60) from [<c04a3270>]
(atmel_spi_interrupt+0x18/0x1f8)
[<c04a3270>] (atmel_spi_interrupt+0x18/0x1f8) from [<c03017ec>]
(handle_IRQ_event+0x5c/0x134)
[<c03017ec>] (handle_IRQ_event+0x5c/0x134) from [<c0303218>]
(handle_level_irq+0x8c/0x118)
[<c0303218>] (handle_level_irq+0x8c/0x118) from [<c02ba03c>] (_text+0x3c/0x80)
[<c02ba03c>] (_text+0x3c/0x80) from [<c02baa94>] (__irq_svc+0x34/0x60)
Exception stack(0xc3917dc0 to 0xc3917e08)
7dc0: 00000000 c3916000 00000102 20000013 00000000 00000102 00000000 c33ed0d8
7de0: c3916000 c069f92c 0000000a c069f900 c3145ca0 c3917e08 c02ba04c c02dd5ac
7e00: 20000013 ffffffff
[<c02baa94>] (__irq_svc+0x34/0x60) from [<c02ba04c>] (_text+0x4c/0x80)
[<c02ba04c>] (_text+0x4c/0x80) from [<0000000d>] (0xd)
Exception stack(0xc3917e18 to 0xc3917e60)
7e00:                                                       c06899d4 00000000
7e20: c33ed0d8 c303f4e0 c3145c04 ffffffff 00000fff c02ba04c ffffffff fefff000
7e40: 0000000d c02baa94 c33ed0d8 c31d4440 ffffffff 00000001 60000013 c3145c04

What seems to be happening is that spi bus messages get out of order.
You should notice notice nonsense touchscreen readings immediately
prior to the Oops, and wrong values on your ads7846 auxiliary inputs
being reported at the same time.

Any help or requests for additional information are appreciated. There
are no other devices on our hardware SPI bus, so I'm pretty certain
this is a driver/configuration issue.

Best Regards,
Zac
