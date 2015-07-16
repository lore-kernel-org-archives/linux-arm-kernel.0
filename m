From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jul 2015 14:26:32 +0100
Subject: [PATCH v2 06/13] irqchip: kill off set_irq_flags usage
In-Reply-To: <alpine.DEB.2.11.1507121737030.20072@nanos>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-7-git-send-email-robh@kernel.org>
 <alpine.DEB.2.11.1507121737030.20072@nanos>
Message-ID: <20150716132632.GK7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 12, 2015 at 06:43:56PM +0200, Thomas Gleixner wrote:
> The probe function was added in the initial implementation of the
> driver (2006), so it predates device tree.
> 
> drivers/net/appletalk/ltpc.c
> drivers/net/arcnet/com20020-isa.c
> drivers/net/arcnet/com90io.c
> drivers/net/arcnet/com90xx.c
> 
> Surely not stuff you find on todays ARM systems
> 
> drivers/net/ethernet/8390/ne.c
> drivers/net/ethernet/8390/wd.c
> drivers/net/ethernet/amd/lance.c
> drivers/net/ethernet/amd/ni65.c
> drivers/net/ethernet/amd/pcnet32.c

pcnet32 is used on the Netwinder, which we still have supported in the ARM
tree.  Even worse, the Netwinder has the Cyberpro capture IRQ missing a
resistor, so it defaults to "asserted" and can trigger a stuck-IRQ, so
it's best not to allow probing of that known bad IRQ.

> Ditto
> 
> drivers/net/ethernet/smsc/smc911x.c
> drivers/net/ethernet/smsc/smc9194.c
> drivers/net/ethernet/smsc/smc91x.c
> 
> Those might still be, but on the DT based boards the probing should be
> completely irrelevant

SA11x0 stuff uses smc91x.c

> drivers/pcmcia/yenta_socket.c
> 
> Russell might still use that.

Some EBSA285 systems use that, Compaq Personal Server (which is my wireless
AP using hostap) does.

ucb1x00.c definitely uses IRQ probing on SA11x0 platforms.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
