From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2012 21:13:04 +0000
Subject: [PATCH 06/14] ARM: kirkwood: convert uart0 to devicetree.
In-Reply-To: <20120307192723.GE5050@titan.lakedaemon.net>
References: <cover.1331090356.git.jason@lakedaemon.net>
 <201203071831.31738.arnd@arndb.de>
 <20120307192723.GE5050@titan.lakedaemon.net>
Message-ID: <201203072113.04369.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 March 2012, Jason wrote:
> Grrr.  Now I'm getting frustrated.  I'm trying to boot without
> earlyprintk.  Evidently, something is wrong with the above, because the
> device boots all the way up (blinky lights come on), but I get no
> messages after the usual "Uncompressing Linux... done, booting the
> kernel."
> 
> Here's my most recent attempt:
> 
>         serial at f1012000 {
>                 device_type = "serial";
>                 compatible = "ns16550a";
>                 reg = <0xf1012000 0x100>; /*phys addr*/
>                 virt-reg = <0xfed12000>;  /*virt addr*/
>                 reg-shift = <2>;
>                 reg-io-width = <1>;
>                 interrupts = <33>;
>                 current-speed = <115200>;
>                 interrupt-parent = <&intc>;
>                 clock-frequency = <200000000>;
>         };
> 
> I've looked at what is done in the powerpc dt's, but, no luck.  When
> earlyprintk is enabled, I see no error messages, just:
> 
> bootconsole [earlycon0] enabled
> debug: skip boot console de-registration.
> ...
> Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
> 
> Any pointers?

My first guess was that clock-frequency is wrong, but it seems that
this one actually is correct, at least it's the same thing that
the platform code sets.

You should never need to pass the virtual address to a device,
most of all because it cannot be known to the device tree at all.
The of_serial driver (you did enable that one in Kconfig, right?)
sets UPF_IOREMAP for this reason, which means membase gets 
overwritten anyway.

You should also not need to set interrupt-parent in the device itself,
as long as it's set in the root node. This one should not hurt though.

Regarting the compatible value, you should check what 
/proc/tty/driver/serial contains when the system is up and running.
If you can log into the system through the network after booting it
up, you can also compare the contents of that file and the 'setserial'
output with what you got before the device tree conversion.

Finally, something could be wrong with the interrupt controller.
AFAICT, you register it through the device tree now, but it's also
getting initialized through kirkwood_init_irq, so the numbers
would all be wrong.

	Arnd
