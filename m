From: simon@sequanux.org (Simon Guinot)
Date: Thu, 30 Jun 2011 21:49:10 +0000
Subject: [PATCH v2] ARM: kirkwood: Add support for Buffalo LS-XHL
In-Reply-To: <BANLkTim-qB+ArwxX0o8dAqU3--Uex4TWBw@mail.gmail.com>
References: <1307655488-12811-1-git-send-email-michael@walle.cc>
	<1307655488-12811-2-git-send-email-michael@walle.cc>
	<BANLkTim-qB+ArwxX0o8dAqU3--Uex4TWBw@mail.gmail.com>
Message-ID: <20110630214910.GI31228@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bj?rn,

On Thu, Jun 30, 2011 at 10:58:15PM +0200, Bj?rn Forsman wrote:
> Hi Michael,
> 
> On 9 June 2011 23:38, Michael Walle <michael@walle.cc> wrote:
> > Add support for the Buffalo Linkstation XHL. This NAS box is based on a
> > Marvell Kirkwood chip at 1.2 GHz and features 256 MB RAM, 512kb SPI boot
> > flash, gigabit ethernet and one SATA port.
> >
> > Signed-off-by: Michael Walle <michael@walle.cc>
> > ---
> > ?arch/arm/configs/kirkwood_defconfig ?| ? ?1 +
> > ?arch/arm/mach-kirkwood/Kconfig ? ? ? | ? ?6 +
> > ?arch/arm/mach-kirkwood/Makefile ? ? ?| ? ?1 +
> > ?arch/arm/mach-kirkwood/lsxhl-setup.c | ?313 ++++++++++++++++++++++++++++++++++
> > ?arch/arm/tools/mach-types ? ? ? ? ? ?| ? ?1 +
> > ?5 files changed, 322 insertions(+), 0 deletions(-)
> > ?create mode 100644 arch/arm/mach-kirkwood/lsxhl-setup.c
> 
> First, thanks a lot for posting this, I've been wanting mainline
> support for this device for a long time :-)
> 
> I tried this patch on my LS-XHL and found two issues:
> 
> 1) When setting the fan speed to 0, the system produces a lot of GPIO
> fan alarm IRQs and then the kernel reports that it's disabling the
> GPIO fan alarm IRQ altogether:
> 
> $ echo 0 | sudo tee /sys/bus/platform/devices/gpio-fan/fan1_target
> Message from syslogd at localhost at Jun 30 22:44:28 ...
>  kernel:Disabling IRQ #104
> $ dmesg
> [...]
> irq 104: nobody cared (try booting with the "irqpoll" option)
> [<c0031210>] (unwind_backtrace+0x0/0xf0) from [<c0072d44>]
> (__report_bad_irq.clone.6+0x24/0xec)
> [<c0072d44>] (__report_bad_irq.clone.6+0x24/0xec) from [<c0073040>]
> (note_interrupt+0x1d4/0x234)
> [<c0073040>] (note_interrupt+0x1d4/0x234) from [<c00717d4>]
> (handle_irq_event_percpu+0xa8/0x1ac)
> [<c00717d4>] (handle_irq_event_percpu+0xa8/0x1ac) from [<c007192c>]
> (handle_irq_event+0x54/0x84)
> [<c007192c>] (handle_irq_event+0x54/0x84) from [<c0073bac>]
> (handle_edge_irq+0xa4/0x1a0)
> [<c0073bac>] (handle_edge_irq+0xa4/0x1a0) from [<c0071144>]
> (generic_handle_irq+0x30/0x44)
> [<c0071144>] (generic_handle_irq+0x30/0x44) from [<c00361d4>]
> (orion_gpio_irq_handler+0xa4/0xb4)
> [<c00361d4>] (orion_gpio_irq_handler+0xa4/0xb4) from [<c0071144>]
> (generic_handle_irq+0x30/0x44)
> [<c0071144>] (generic_handle_irq+0x30/0x44) from [<c002c030>]
> (asm_do_IRQ+0x30/0x84)
> [<c002c030>] (asm_do_IRQ+0x30/0x84) from [<c0391348>] (__irq_svc+0x48/0xa8)
> Exception stack(0xc2181f18 to 0xc2181f60)
> 1f00:                                                       c2181f60 fed20204
> 1f20: 00000000 20000013 00000202 c05609c4 c2180000 00000001 c05609c4 c04bdbd8
> 1f40: c05609a0 0000000a 006881e0 c2181f60 c0043580 c0043070 20000013 ffffffff
> [<c0391348>] (__irq_svc+0x48/0xa8) from [<c0043070>] (__do_softirq+0x4c/0x124)
> [<c0043070>] (__do_softirq+0x4c/0x124) from [<c0043580>] (irq_exit+0x90/0x98)
> [<c0043580>] (irq_exit+0x90/0x98) from [<c002c034>] (asm_do_IRQ+0x34/0x84)
> [<c002c034>] (asm_do_IRQ+0x34/0x84) from [<c039154c>] (__irq_usr+0x4c/0xa0)
> Exception stack(0xc2181fb0 to 0xc2181ff8)
> 1fa0:                                     00000001 bef0ead0 0000003f 00000001
> 1fc0: 0009c9cd 0000006f 00000004 bef0eaf8 0009c9c8 00000036 00000001 00000002
> 1fe0: 00000005 bef0eaf8 00077bd0 00077be4 00000010 ffffffff
> handlers:
> [<c0280ed8>] fan_alarm_irq_handler
> Disabling IRQ #104
> 
> $ cat /proc/interrupts
>            CPU0
>   1:      14919  orion_irq  orion_tick
>   5:          2  orion_irq  mv_xor.0
>   6:          2  orion_irq  mv_xor.1
>   7:          2  orion_irq  mv_xor.2
>   8:          2  orion_irq  mv_xor.3
>  15:       2714  orion_irq  eth1
>  19:          0  orion_irq  ehci_hcd:usb1
>  21:       4560  orion_irq  sata_mv
>  22:          0  orion_irq  mv_crypto
>  33:        279  orion_irq
>  46:         36  orion_irq  mv643xx_eth
>  47:          0  orion_irq  mv643xx_eth
>  53:          0  orion_irq  rtc-mv
> 104:     100000         -  GPIO fan alarm
> 105:          0         -  Function Button
> 106:          0         -  Power-auto Switch
> 107:          0         -  Power-on Switch
> Err:          0
> 
> 
> 2) Pressing the FUNC button or moving the power switch seems to hang
> the device; my SSH connection freezes and the only way back is a
> reboot. One time I managed to capture this output before the box froze
> (I only moved the power switch this time):
> 
> $ evtest  /dev/input/event0
> Input driver version is 1.0.1
> Input device ID: bus 0x19 vendor 0x1 product 0x1 version 0x100
> Input device name: "gpio-keys"
> Supported events:
>   Event type 0 (Sync)
>   Event type 5 (?)
>     Event code 0 (?)
>     Event code 1 (?)
> Testing ... (interrupt to exit)
> Event: time 1309463461.949923, type 5 (?), code 1 (?), value 1
> Event: time 1309463461.949926, -------------- Report Sync ------------
> Event: time 1309463462.070543, type 5 (?), code 1 (?), value 0
> Event: time 1309463462.070545, -------------- Report Sync ------------
> Event: time 1309463462.070658, type 5 (?), code 0 (?), value 1
> Event: time 1309463462.070660, -------------- Report Sync ------------
> 
> And at the same time, in another terminal:
> 
> $ cat /proc/interrupts
>            CPU0
>   1:      15567  orion_irq  orion_tick
>   5:          2  orion_irq  mv_xor.0
>   6:          2  orion_irq  mv_xor.1
>   7:          2  orion_irq  mv_xor.2
>   8:          2  orion_irq  mv_xor.3
>  15:       1965  orion_irq  eth1
>  19:          0  orion_irq  ehci_hcd:usb1
>  21:       4675  orion_irq  sata_mv
>  22:          0  orion_irq  mv_crypto
>  33:        268  orion_irq
>  46:         36  orion_irq  mv643xx_eth
>  47:          0  orion_irq  mv643xx_eth
>  53:          0  orion_irq  rtc-mv
> 104:          0         -  GPIO fan alarm
> 105:          0         -  Function Button
> 106:        775         -  Power-auto Switch
> 107:   10154532         -  Power-on Switch
> Err:          0
> 
> So, the power switch also seem to suffer from some interrupt overload;
> 10154532 IRQs for Power-auto Switch is not right...right?
> 
> Have you seen this behaviour?
> 
> I can do more testing if someone can point me in the right direction.
> (I don't have serial port access to the box, so it's a bit of a
> crippled development environment. But it will have to do.)

It is probably related to a edge GPIO interrupts bug:
http://lists.arm.linux.org.uk/lurker/message/20110629.200122.012d23be.en.html

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110630/c9d3e94f/attachment.sig>
