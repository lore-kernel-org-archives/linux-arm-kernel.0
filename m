From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 9 Jul 2013 21:36:05 +0200
Subject: NSA310 + DT
In-Reply-To: <51DC564A.8050002@harsszegi.com>
References: <51DC564A.8050002@harsszegi.com>
Message-ID: <20130709193605.GC26223@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 08:28:26PM +0200, Tibor Harsszegi wrote:
> Hello Andrew,
> 
> sorry to bug you, but honestly couldn't find better way than this :(

Hi Tibor

Its not a problem to bug me, but please also CC: the arm kernel
mailing list. This board port was contributed by Tero Jaasko
<tero.jaasko@gmail.com>, so its good to also ask him.

> I have some issues.

A basic question to start with. Are you using the default kernel
configuration for kirkwood? Which kernel version are you using?
 
> a.) With the current NSA310 .dts the sensors are not working (at
> least on my NSA310). The reason is that the i2c sensors is a lm85
> kind

Do you know what address it is using on the i2c bus? It looks like it
would be one of: 0x2c, 0x2d, 0x2e. Does you board also have the
adt7476?

You will need to edit arch/arm/boot/dts/kirkwood-nsa310.dts and add
something like:

                        lm85: lm85 at 2c {
                                compatible = "lm85";
                                reg = <0x2c>;
                        };

inside the i2c at 11000 node.

> b.) uart0 is not recognized at all during boot, I cannot see that
> 8250 would recognize the UART at the mmaped area, however the .DTS
> config seems fine

Do you see anything like:

Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
f1012000.serial: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
console [ttyS0] enabled
f1012100.serial: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A

> c.) LEDs are also not working, this is also strange, as the .DTS
> seems to be just fine as well.

How do you mean not working? Is /sys/class/leds/ empty? Or when you
change the brightness value, nothing happens?

       Andrew
