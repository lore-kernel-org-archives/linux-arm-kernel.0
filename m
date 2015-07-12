From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 12 Jul 2015 18:43:56 +0200 (CEST)
Subject: [PATCH v2 06/13] irqchip: kill off set_irq_flags usage
In-Reply-To: <1436711211-18223-7-git-send-email-robh@kernel.org>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-7-git-send-email-robh@kernel.org>
Message-ID: <alpine.DEB.2.11.1507121737030.20072@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jul 2015, Rob Herring wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not

clear IRQ_NOPROBE, right?

> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.

Looking at the irq probe users:

drivers/input/touchscreen/ucb1400_ts.c
drivers/mfd/ucb1x00-core.c

The probe function was added in the initial implementation of the
driver (2006), so it predates device tree.

drivers/net/appletalk/ltpc.c
drivers/net/arcnet/com20020-isa.c
drivers/net/arcnet/com90io.c
drivers/net/arcnet/com90xx.c

Surely not stuff you find on todays ARM systems

drivers/net/ethernet/8390/ne.c
drivers/net/ethernet/8390/wd.c
drivers/net/ethernet/amd/lance.c
drivers/net/ethernet/amd/ni65.c
drivers/net/ethernet/amd/pcnet32.c

Ditto

drivers/net/ethernet/smsc/smc911x.c
drivers/net/ethernet/smsc/smc9194.c
drivers/net/ethernet/smsc/smc91x.c

Those might still be, but on the DT based boards the probing should be
completely irrelevant

drivers/net/hamradio/dmascc.c
drivers/net/wan/cosa.c
drivers/net/wan/sbni.c
drivers/parport/parport_pc.c

Surely not stuff you find on todays ARM systems

drivers/pcmcia/yenta_socket.c

Russell might still use that.

drivers/scsi/NCR53c406a.c
drivers/scsi/sym53c416.c
drivers/tty/cyclades.c

Surely not stuff you find on todays ARM systems

drivers/tty/serial/8250/8250_core.c

The irq probing is used by

    mach-imx/mach-mx31ads.c
    mach-iop32x/n2100.c

    and X86

So in most of the irqchip drivers, this is irrelevant.

Thanks,

	tglx
