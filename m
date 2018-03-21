From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 21 Mar 2018 14:23:45 +0100
Subject: [PATCH 2/3] arm64: dts: armada-3720-espressobin: make use of
 switch irq line
In-Reply-To: <20180321131536.GC11206@lunn.ch>
References: <20180321105005.18426-1-u.kleine-koenig@pengutronix.de>
 <20180321105005.18426-2-u.kleine-koenig@pengutronix.de>
 <20180321131536.GC11206@lunn.ch>
Message-ID: <20180321132345.psrs3n7whpjdabeo@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Wed, Mar 21, 2018 at 02:15:36PM +0100, Andrew Lunn wrote:
> On Wed, Mar 21, 2018 at 11:50:04AM +0100, Uwe Kleine-K?nig wrote:
> > The switch's INTn line is connected to the CPU's MPP2_23 pad. Wire this
> > up in the device tree. Note however that up to now the
> > marvell,armada3710-sb-pinctrl driver doesn't support level irqs, so the
> > switch driver doesn't make use of this feature.
> 
> So that actually happens here, if the interrupt cannot be used? I
> assume the mv88e6xxx driver does not fail the probe because the IRQ
> cannot be configured? What does happen?

Grml, I just tried with all patches applied and it results in:

[    4.777524] mv88e6085 d0032004.mdio-mii:01: switch 0x3410 detected: Marvell 88E6341, revision 0
[    4.794723] genirq: Setting trigger mode 8 for irq 41 failed (armada_37xx_irq_set_type+0x0/0x160)
[    4.804470] mv88e6085: probe of d0032004.mdio-mii:01 failed with error -22

. It (kind of) worked before your patch

	net: dsa: mv88e6xxx: Use the DT IRQ trigger mode

. So I guess this has to change to

+               interrupt-parent = <&gpiosb>;
+		/* actually the irq is active low, but gpiosb doesn't support that and falling edge seems to work just fine */
+               interrupts = <23 IRQ_TYPE_EDGE_FALLING>;

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
