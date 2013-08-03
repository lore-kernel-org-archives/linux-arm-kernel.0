From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 3 Aug 2013 21:45:41 +0200
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <20130802195552.2f95c855fc20d6b3a205e40f@mail.ru>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <20130802105754.GF2884@e106331-lin.cambridge.arm.com>
 <20130802195552.2f95c855fc20d6b3a205e40f@mail.ru>
Message-ID: <201308032145.41860.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 August 2013, Alexander Shiyan wrote:
> On Fri, 2 Aug 2013 11:57:54 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> > On Thu, Jul 18, 2013 at 07:34:58PM +0100, Alexander Shiyan wrote:

> > > +The interrupt sources are as follows:
> > > +ID     Name    Description
> > > +---------------------------
> > > +1:     BLINT   Battery low (FIQ)
> > > +3:     MCINT   Media changed (FIQ)
> > > +4:     CSINT   CODEC sound
> > > +5:     EINT1   External 1
> > > +6:     EINT2   External 2
> > > +7:     EINT3   External 3
> > > +8:     TC1OI   TC1 under flow
> > > +9:     TC2OI   TC2 under flow
> > > +10:    RTCMI   RTC compare match
> > > +11:    TINT    64Hz tick
> > > +12:    UTXINT1 UART1 transmit FIFO half empty
> > > +13:    URXINT1 UART1 receive FIFO half full
> > > +14:    UMSINT  UART1 modem status changed
> > > +15:    SSEOTI  SSI1 end of transfer
> > > +16:    KBDINT  Keyboard
> > > +17:    SS2RX   SSI2 receive FIFO half or greater full
> > > +18:    SS2TX   SSI2 transmit FIFO less than half empty
> > > +28:    UTXINT2 UART2 transmit FIFO half empty
> > > +29:    URXINT2 UART2 receive FIFO half full
> > > +32:    DAIINT  DAI interface (FIQ)
> > 
> > Surely that's specific to the SoC the interrupt controller is used in,
> > not the interrupt controller IP itself?
> 
> [...]
> > > +static const struct {
> > > +#define CLPS711X_FLAG_EN       (1 << 0)
> > > +#define CLPS711X_FLAG_FIQ      (1 << 1)
> > > +       unsigned int    flags;
> > > +       phys_addr_t     phys_eoi;
> > > +} clps711x_irqs[] __initconst = {
> > > +       [1]     = { CLPS711X_FLAG_FIQ, CLPS711X_BLEOI, },
> > > +       [3]     = { CLPS711X_FLAG_FIQ, CLPS711X_MCEOI, },
> > > +       [4]     = { CLPS711X_FLAG_EN, CLPS711X_COEOI, },
> > > +       [5]     = { CLPS711X_FLAG_EN, },
> > > +       [6]     = { CLPS711X_FLAG_EN, },
> > > +       [7]     = { CLPS711X_FLAG_EN, },
> > > +       [8]     = { CLPS711X_FLAG_EN, CLPS711X_TC1EOI, },
> > > +       [9]     = { CLPS711X_FLAG_EN, CLPS711X_TC2EOI, },
> > > +       [10]    = { CLPS711X_FLAG_EN, CLPS711X_RTCEOI, },
> > > +       [11]    = { CLPS711X_FLAG_EN, CLPS711X_TEOI, },
> > > +       [12]    = { CLPS711X_FLAG_EN, },
> > > +       [13]    = { CLPS711X_FLAG_EN, },
> > > +       [14]    = { CLPS711X_FLAG_EN, CLPS711X_UMSEOI, },
> > > +       [15]    = { CLPS711X_FLAG_EN, CLPS711X_SRXEOF, },
> > > +       [16]    = { CLPS711X_FLAG_EN, CLPS711X_KBDEOI, },
> > > +       [17]    = { CLPS711X_FLAG_EN, },
> > > +       [18]    = { CLPS711X_FLAG_EN, },
> > > +       [28]    = { CLPS711X_FLAG_EN, },
> > > +       [29]    = { CLPS711X_FLAG_EN, },
> > > +       [32]    = { CLPS711X_FLAG_FIQ, },
> > > +};
> > 
> > Isn't that SoC specific?
> 
> I absolutely do not understand the last two comments.
> You are not difficult to describe them in other words?

The point that Mark was making is that the both the binding and the driver
should be written to only specify what the interrupt controller itself
looks like, not how any of the lines are connected or configured.

For instance, if the same interrupt controller is used in another SoC
(ep93xx?) but that soc has an i2c controller connected to IRQ 4 rather than
the sound, the driver should still be usable unmodified.

Unfortunately, the EOI register offset cannot be computed from the
interrupt number. What Mark was getting at here is that it could be
done in a more generic way if you define the interrupt specifier to
take three cells instead of one, and pass the flag and EOI number
along with the interrupt number, e.g.

	serial at abcd0000 {
		reg = <0xabcd0000 10000>;
		interrupts = <12 0 0>, <13 0 0>, <14 1 6>;
	}

Where '1' signifies the use of an EOI register, and '6' is the index of that register,
so you can compute the actual register as (0x600 + i * 0x40).

I don't actually think that would be much of an improvement though, as the controller
can be considered 'complex', so I'm also fine with your approach. Maybe Mark has some
further thoughts on this.

On Thursday 18 July 2013, Alexander Shiyan wrote:
> +static void __iomem __init *clps711x_ioremap_one(phys_addr_t reg)
> +{
> +       void __iomem *ret;
> +
> +       if (!request_mem_region(clps711x_intc->phys_base + reg, SZ_4, NULL))
> +               return ERR_PTR(-EBUSY);
> +
> +       ret = ioremap(clps711x_intc->phys_base + reg, SZ_4);
> +       if (!ret)
> +               return ERR_PTR(-ENOMEM);
> +
> +       return ret;

Another unrelated comment: Doing repeated ioremap() and request_mem_region calls
is rather wasteful as every single call will consume resources. Better do a single
ioremap in the probe function and just add the offsets later.

	Arnd
