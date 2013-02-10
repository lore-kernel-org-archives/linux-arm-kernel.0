From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Sun, 10 Feb 2013 11:31:53 +0800
Subject: [PATCH 1/2] tty: serial: remove __init on pl011 console ops
In-Reply-To: <20130209224138.GI17833@n2100.arm.linux.org.uk>
References: <1360151235-11980-1-git-send-email-haojian.zhuang@linaro.org>
 <20130206115219.GE17833@n2100.arm.linux.org.uk>
 <CAD6h2NSpo74UXUgH2OJniW=wzkxGeshta05AGgCpn26SCUSjYg@mail.gmail.com>
 <CACRpkdZX-YF+jzg453Vmfxo_2LLuASvZyQqLommaM4Xd3LpwfQ@mail.gmail.com>
 <20130206163811.GI17833@n2100.arm.linux.org.uk>
 <CAD6h2NS6bJS1KZfZ-3SGy6AR68Vn4fkR=TgwTEu50G_edfCP1w@mail.gmail.com>
 <CACxGe6t94S=kkfCkasO+ze35M-H06+WCA-J93BZaJfCzhWfoEQ@mail.gmail.com>
 <20130209224138.GI17833@n2100.arm.linux.org.uk>
Message-ID: <CAD6h2NQbpH4KrDA7_-WYx+gzrA60fRHCk8D=-Je2fsEC-+z79Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 February 2013 06:41, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Feb 09, 2013 at 10:31:05PM +0000, Grant Likely wrote:
>> If it is a probe function, then yes the __init annotations need to be
>> removed or the driver needs to use platform_driver_probe(). This has
>> been the model as long as I can remember. As long as a driver has a
>> .probe hook, the driver core can call it at any time. Deferred probe
>> has only exposed the issue.
>>
>> If you want to discard the .probe() hook, then the probe() pointer
>> needs to be cleared from the driver structure before discarding the
>> sections. Otherwise the driver core can still call it which is what
>> happens in deferred probe and can happen if a device gets unbound from
>> a driver and then re-attached.
>
> You're talking about something completely different on the assumption
> that what is being talked about is the probe hook.  It isn't.  It's
> a path for the console initialization which has _always_ been __init
> marked since the dawn of time, because modules are not supposed to
> be calling that path.
>
> What has been exposed is that console drivers which have resources
> which are not immediately available no longer have the same guarantees
> that they used to have (that is, they will be called before the __init
> section is given away.)
>
> Remember: console drivers used not to support removal of themselves.
> Many still do not support that - in fact, these do not on the basis
> that they call register_console() but not unregister_console():
>
> drivers/net/ethernet/sgi/ioc3-eth.c
> drivers/s390/char/con3215.c
> drivers/s390/char/con3270.c
> drivers/s390/char/sclp_con.c
> drivers/s390/char/sclp_vt220.c
> drivers/tty/amiserial.c
> drivers/tty/bfin_jtag_comm.c
> drivers/tty/ehv_bytechan.c
> drivers/tty/hvc/hvsi.c
> drivers/tty/serial/21285.c
> drivers/tty/serial/68328serial.c
> drivers/tty/serial/8250/8250.c
> drivers/tty/serial/8250/8250_early.c
> drivers/tty/serial/altera_jtaguart.c
> drivers/tty/serial/altera_uart.c
> drivers/tty/serial/apbuart.c
> drivers/tty/serial/arc_uart.c
> drivers/tty/serial/atmel_serial.c
> drivers/tty/serial/bcm63xx_uart.c
> drivers/tty/serial/bfin_sport_uart.c
> drivers/tty/serial/bfin_uart.c
> drivers/tty/serial/cpm_uart/cpm_uart_core.c
> drivers/tty/serial/dz.c
> drivers/tty/serial/lantiq.c
> drivers/tty/serial/lpc32xx_hs.c
> drivers/tty/serial/m32r_sio.c
> drivers/tty/serial/mcf.c
> drivers/tty/serial/mpc52xx_uart.c
> drivers/tty/serial/mpsc.c
> drivers/tty/serial/netx-serial.c
> drivers/tty/serial/nwpserial.c
> drivers/tty/serial/pmac_zilog.c
> drivers/tty/serial/pnx8xxx_uart.c
> drivers/tty/serial/sa1100.c
> drivers/tty/serial/samsung.c
> drivers/tty/serial/sb1250-duart.c
> drivers/tty/serial/serial_core.c
> drivers/tty/serial/serial_ks8695.c
> drivers/tty/serial/serial_txx9.c
> drivers/tty/serial/sh-sci.c
> drivers/tty/serial/sirfsoc_uart.c
> drivers/tty/serial/uartlite.c
> drivers/tty/serial/vr41xx_siu.c
> drivers/tty/serial/xilinx_uartps.c
> drivers/tty/serial/zs.c
> drivers/tty/vt/vt.c

I agree on Russell. And console isn't the only one device.
In kernel_init_freeable(), we can find that we have an
assumption that all initial calls are already finished, and
we need to discard them & start the user-mode stuff.
But at that time, deferred probe may still not run since
they're in another kernel thread. It's very dangerous that
user mode stuff start running but device driver isn't ready
yet.

Then let's move to my error case. Serial driver fails to
bind pinctrl, and it's moved into deferred probe list. And
kernel_init_freeable() in kernel_init thread keeps working
on CPU, the deferred probe doesn't have chances to be
scheduled yet. So two issues happen.
1. /dev/console is accessed before serial driver is ready.
Since it fails, user can't input anything on console any
more.
2. __init memory section is released before serial driver
is ready. It results in system hang while deferred probe
runs.

Regards
Haojian
