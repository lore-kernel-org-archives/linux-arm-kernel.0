From: shc_work@mail.ru (Alexander Shiyan)
Date: Fri, 2 Aug 2013 19:55:52 +0400
Subject: [PATCH 07/10] ARM: clps711x: Add CLPS711X irqchip driver
In-Reply-To: <20130802105754.GF2884@e106331-lin.cambridge.arm.com>
References: <1374172501-26796-1-git-send-email-shc_work@mail.ru>
 <1374172501-26796-8-git-send-email-shc_work@mail.ru>
 <20130802105754.GF2884@e106331-lin.cambridge.arm.com>
Message-ID: <20130802195552.2f95c855fc20d6b3a205e40f@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2 Aug 2013 11:57:54 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Thu, Jul 18, 2013 at 07:34:58PM +0100, Alexander Shiyan wrote:
> > This adds the irqchip driver for Cirrus Logic CLPS711X series SoCs.
> > Designed primarily for migration CLPS711X subarch for multiplatform & DT,
> > for this as the "OF" and "not-OF" calls implemented.
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> > ---
> >  .../interrupt-controller/cirrus,clps711x-intc.txt  |  42 ++++
> >  arch/arm/Kconfig                                   |   2 -
> >  drivers/irqchip/Kconfig                            |   6 +
> >  drivers/irqchip/Makefile                           |   1 +
> >  drivers/irqchip/irq-clps711x.c                     | 277 +++++++++++++++++++++
> >  5 files changed, 326 insertions(+), 2 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
> >  create mode 100644 drivers/irqchip/irq-clps711x.c
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
> > new file mode 100644
> > index 0000000..26f8983
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/cirrus,clps711x-intc.txt
> > @@ -0,0 +1,42 @@
> > +Cirrus Logic CLPS711X Interrupt Controller
> > +
> > +Required properties:
> > +
> > +- compatible: Should be "cirrus,clps711x-intc"
> > +- reg: Specifies base physical address of the registers set
> > +- interrupt-controller: Identifies the node as an interrupt controller
> > +- #interrupt-cells: Specifies the number of cells needed to encode an
> > +  interrupt source. The value shall be 1.
> > +
> > +The interrupt sources are as follows:
> > +ID     Name    Description
> > +---------------------------
> > +1:     BLINT   Battery low (FIQ)
> > +3:     MCINT   Media changed (FIQ)
> > +4:     CSINT   CODEC sound
> > +5:     EINT1   External 1
> > +6:     EINT2   External 2
> > +7:     EINT3   External 3
> > +8:     TC1OI   TC1 under flow
> > +9:     TC2OI   TC2 under flow
> > +10:    RTCMI   RTC compare match
> > +11:    TINT    64Hz tick
> > +12:    UTXINT1 UART1 transmit FIFO half empty
> > +13:    URXINT1 UART1 receive FIFO half full
> > +14:    UMSINT  UART1 modem status changed
> > +15:    SSEOTI  SSI1 end of transfer
> > +16:    KBDINT  Keyboard
> > +17:    SS2RX   SSI2 receive FIFO half or greater full
> > +18:    SS2TX   SSI2 transmit FIFO less than half empty
> > +28:    UTXINT2 UART2 transmit FIFO half empty
> > +29:    URXINT2 UART2 receive FIFO half full
> > +32:    DAIINT  DAI interface (FIQ)
> 
> Surely that's specific to the SoC the interrupt controller is used in,
> not the interrupt controller IP itself?

[...]
> > +static const struct {
> > +#define CLPS711X_FLAG_EN       (1 << 0)
> > +#define CLPS711X_FLAG_FIQ      (1 << 1)
> > +       unsigned int    flags;
> > +       phys_addr_t     phys_eoi;
> > +} clps711x_irqs[] __initconst = {
> > +       [1]     = { CLPS711X_FLAG_FIQ, CLPS711X_BLEOI, },
> > +       [3]     = { CLPS711X_FLAG_FIQ, CLPS711X_MCEOI, },
> > +       [4]     = { CLPS711X_FLAG_EN, CLPS711X_COEOI, },
> > +       [5]     = { CLPS711X_FLAG_EN, },
> > +       [6]     = { CLPS711X_FLAG_EN, },
> > +       [7]     = { CLPS711X_FLAG_EN, },
> > +       [8]     = { CLPS711X_FLAG_EN, CLPS711X_TC1EOI, },
> > +       [9]     = { CLPS711X_FLAG_EN, CLPS711X_TC2EOI, },
> > +       [10]    = { CLPS711X_FLAG_EN, CLPS711X_RTCEOI, },
> > +       [11]    = { CLPS711X_FLAG_EN, CLPS711X_TEOI, },
> > +       [12]    = { CLPS711X_FLAG_EN, },
> > +       [13]    = { CLPS711X_FLAG_EN, },
> > +       [14]    = { CLPS711X_FLAG_EN, CLPS711X_UMSEOI, },
> > +       [15]    = { CLPS711X_FLAG_EN, CLPS711X_SRXEOF, },
> > +       [16]    = { CLPS711X_FLAG_EN, CLPS711X_KBDEOI, },
> > +       [17]    = { CLPS711X_FLAG_EN, },
> > +       [18]    = { CLPS711X_FLAG_EN, },
> > +       [28]    = { CLPS711X_FLAG_EN, },
> > +       [29]    = { CLPS711X_FLAG_EN, },
> > +       [32]    = { CLPS711X_FLAG_FIQ, },
> > +};
> 
> Isn't that SoC specific?

I absolutely do not understand the last two comments.
You are not difficult to describe them in other words?
Thanks.

-- 
Alexander Shiyan <shc_work@mail.ru>
