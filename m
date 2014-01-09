From: carlo.caione@gmail.com (Carlo Caione)
Date: Thu, 9 Jan 2014 14:59:06 +0100
Subject: [linux-sunxi] Re: [PATCH v2 3/3] ARM: sun7i: irqchip: Update the
 documentation
In-Reply-To: <14122384.i9DNmsOzpC@wuerfel>
References: <1389030097-10822-1-git-send-email-carlo.caione@gmail.com>
 <201401081229.45029.arnd@arndb.de>
 <CAOQ7t2bg7qmwnQ-7iqbKCqK8fNS5GC=G0BN2188FQhPLN3v9VQ@mail.gmail.com>
 <14122384.i9DNmsOzpC@wuerfel>
Message-ID: <CAOQ7t2YYr_gphkXnp1OVsR_sHoOdEhVzDMETjJ2FsDz=Pvh7xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 8, 2014 at 2:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 08 January 2014 12:49:10 Carlo Caione wrote:
>> >> +sc-nmi-intc at 01c00030 {
>> >> +       compatible = "allwinner,sun7i-sc-nmi";
>> >> +       interrupt-controller;
>> >> +       #interrupt-cells = <2>;
>> >> +       reg = <0x01c00030 0x0c>;
>> >> +       interrupt-parent = <&gic>;
>> >> +       interrupts = <0 0 1>;
>> >> +};
>> >
>> > Is <0 0 1> the correct representation of the NMI? This question has recently
>> > come up on IRC and I didn't know the answer at the time.
>>
>> Why shouldn't it be a correct representation? I think I missed the
>> discussion on IRC.
>
> For all I know, the NMI and the IRQ input to the CPU are separate pins,
> so the NMI irqchip is not actually cascaded to the GIC, and SPI-0
> might in fact be a different interrupt source.

In Allwinner A20/A31 SoCs NMI controller is an independent module
external and in cascade with the GIC. It catches the NMI pin's state
and generates irq to GIC.
(therefore NMI is not really not Non-maskable but it is a normal interrupt).
Here is an ascii-plot of the system (thanks to Maxime and the
Allwinner engineers for this)

           +---------+            +-----------+
           |         +------------+ FIQ       |
           |   GIC   |            |           |
           |         +------------+ INT   CPU |
           +--+---+--+            |           |
              |   |               |           |
              |   +------+        |           |
              |          |        |           |
 +-----+   +--+--+   +---+---+    |           |
 | AXP +-+-+ NMI +   | ALARM |    |           |
 +-----+ | +-----+   +---+---+    +-----------+
         |               |
         +---------------+

Best,

--
Carlo Caione
