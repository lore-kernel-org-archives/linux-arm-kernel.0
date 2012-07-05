From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 5 Jul 2012 16:43:11 +0200
Subject: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
In-Reply-To: <4FF5A15A.8070309@googlemail.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <1341325365-21393-2-git-send-email-andrew@lunn.ch>
 <201207051225.55390.arnd@arndb.de> <20120705130819.GV17534@lunn.ch>
 <4FF5A15A.8070309@googlemail.com>
Message-ID: <20120705144311.GB17534@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 05, 2012 at 04:14:50PM +0200, Sebastian Hesselbarth wrote:
> On 07/05/2012 03:08 PM, Andrew Lunn wrote:
> >The issue is knowing what IRQ number to use for the secondary
> >interrupts.
> >
> >Orion use generic chip interrupts, both for the main interrupts and
> >the GPIO interrupts. This does not yet support irq domain, so i have
> >to layer a legacy domain on top. The legacy domain needs to know the
> >first IRQ and the number of IRQs. For the primary IRQs that is
> >easy. However, GPIO IRQ is not so easy, it depends on how many primary
> >IRQs there are. This is not fixed. Orion5x has 32, Dove 64, kirkwood,
> >64, and mv78xx0 has 96. I need to know this number when adding the
> >GPIO secondary IRQ legacy domain. By calling orion_gpio_of_init() in
> >the orion_add_irq_domain() i have this number to hand. If i used to
> >entries in the match table, i would have to put this number into some
> >global variable, or somehow ask the IRQ subsystem what the next free
> >IRQ number is.
> 
> Andrew,
> 
> is it possible to group all gpio banks into one DT description?

Everything is possible. 

I did think about having just one gpio controller, since as you said,
it makes it easier to describe gpios = <&gpio 71 0>; instead of gpios
= <&gpio3 7 0>; But most SoCs seem to have multiple GPIO controllers
in the .dtsi files. Only picoxcell has banks inside a single gpio
controller. So it would be a bit unusual.
 
What you suggest also adds a lot of complexity to the code and
probably means a lot less of the code can be shared with non-DT GPIO
handling code.

The natural size of a GPIO controller is 32 lines, not 8. The current
interrupt handling does not actually care which IRQ of a bank of 32
lines fired, it looks at all lines. The handler_data in the IRQ points
to the GPIO chip, not a subsection of the GPIO chip.

> 	bank5 at e8400 {
> 		reg = <0xe8400 0x20>;
> 		ngpio = <8>;
> 		marvell,orion-gpio-output-only;

Some Orions mixed GPIOs GPOs and GPIs within one controller. So that
is not generic enough. Probably the pinmux DT description needs to be
able to specify per pin what a line can do.

     Andrew
