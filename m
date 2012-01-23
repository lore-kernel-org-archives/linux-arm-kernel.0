From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 23 Jan 2012 02:49:37 -0700 (MST)
Subject: [PATCH 2/2] tty: serial: OMAP: transmit FIFO threshold interrupts
 don't wake the chip
In-Reply-To: <CAAL8m4xAzAJWFZXaTeQQpTE2DbadH4zovSGcQsLjP=43GNiRiA@mail.gmail.com>
References: <20120121071934.18707.64258.stgit@dusk>
 <20120121072740.18707.87632.stgit@dusk>
 <CAAL8m4xAzAJWFZXaTeQQpTE2DbadH4zovSGcQsLjP=43GNiRiA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1201230204420.29673@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 23 Jan 2012, Govindraj wrote:

> On Sat, Jan 21, 2012 at 12:57 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > It seems that when the transmit FIFO threshold is reached on OMAP
> > UARTs, it does not result in a PRCM wakeup. ?This appears to be a
> > silicon bug. ?This means that if the MPU powerdomain is in a low-power
> > state, the MPU will not be awakened to refill the FIFO until the next
> > interrupt from another device.
> >
> > The best solution, at least for the short term, would be for the OMAP
> > serial driver to call a OMAP subarchitecture function to prevent the
> > MPU powerdomain from entering a low power state while the FIFO has
> > data to transmit. ?However, we no longer have a clean way to do this,
> > since patches that add platform_data function pointers have been
> > deprecated by the OMAP maintainer. ?So we attempt to work around this
> > as well. ?The workarounds depend on the setting of CONFIG_CPU_IDLE.
> >
> > When CONFIG_CPU_IDLE=n, the driver will now only transmit one byte at
> > a time. ?This causes the transmit FIFO threshold interrupt to stay
> > active until there is no more data to be sent. ?Thus, the MPU
> > powerdomain stays on during transmits. ?Aside from that energy
> > consumption penalty, each transmitted byte results in a huge number of
> > UART interrupts -- about five per byte. ?This wastes CPU time and is
> > quite inefficient, but is probably the most expedient workaround in
> > this case.
> >
> > When CONFIG_CPU_IDLE=y, there is a slightly more direct workaround:
> > the PM QoS constraint can be abused to keep the MPU powerdomain on.
> > This results in a normal number of interrupts, but, similar to the
> > above workaround, wastes power by preventing the MPU from entering
> > WFI.
> >
> > Future patches are planned for the 3.4 merge window to implement more
> > efficient, but also more disruptive, workarounds to these problems.
> >
> 
> With these two patches number of interrupts seems to increase by 24x
> after boot up.

If you re-read the patch description that you quoted above, you'll see 
that this behavior was clearly mentioned:

> > When CONFIG_CPU_IDLE=n, the driver will now only transmit one byte at
> > a time. ?This causes the transmit FIFO threshold interrupt to stay
> > active until there is no more data to be sent. ?Thus, the MPU
> > powerdomain stays on during transmits. ?Aside from that energy
> > consumption penalty, each transmitted byte results in a huge number of
> > UART interrupts -- about five per byte. ?This wastes CPU time and is
> > quite inefficient, but is probably the most expedient workaround in
> > this case.

> / # cat /proc/interrupts | grep "UART2"
>  74:       3902      INTC  OMAP UART2
> / #
> [...]
> 
> without these two patches + cpu_idle enabled

You should compare apples to apples.  The omap-serial.c without these two 
patches is unusable as a console when CONFIG_CPU_IDLE=n; there are long 
lags between transmit FIFO drains.  CONFIG_CPU_IDLE is the setting in the 
standard omap2plus_defconfig.

I guess it was never tested with that standard config?  Or were the
v3.3 omap-serial patch series submitted with this bug known?

> [...]
> 
> / #
> / # cat /proc/interrupts | grep "UART2"
>  74:        158      INTC  OMAP UART2
> / #

The only reason why the driver 'works' when CONFIG_CPU_IDLE=y is because 
the omap-serial.c RX path wakeup latency constraint calculation is broken.  
It adds a 1 microsecond latency constraint to the CPU, when it should be 
adding a ~ 1100 microsecond latency constraint to the CPU.  (Well, ~ 5500 
microsecond, but that's another issue.)

And this keeps the CPU from entering a low-power state not just during 
transmits, but during the entire time the driver is active for the console 
UART.

> I am using beagle xm and 3.3rc1
> 
> Looks like there are far two many uart irqs which
> keeps the mpu busy and thus preventing uart sluggishness.

Yes, that's known behavior, as described in the quoted patch description.  
It's not clear why the number of interrupts is ~5x the number of 
transmitted bytes, rather than say 2x the number of transmitted bytes.  
But the IRQ handler in omap-serial.c is also a mess, so that may have 
something to do with it.

Do you have a better workaround for the CONFIG_CPU_IDLE=n case that 
is acceptable for the -rc series?  If so, perhaps you can post it?


- Paul
