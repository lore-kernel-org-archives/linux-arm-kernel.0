From: davem@davemloft.net (David Miller)
Date: Wed, 14 Jan 2015 00:27:30 -0500 (EST)
Subject: [PATCH RESEND v2] net: fec: fix MDIO bus assignement for dual
 fec SoC's
In-Reply-To: <1421191221-23095-1-git-send-email-stefan@agner.ch>
References: <1421191221-23095-1-git-send-email-stefan@agner.ch>
Message-ID: <20150114.002730.1449798194556067465.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>
Date: Wed, 14 Jan 2015 00:20:21 +0100

> On i.MX28, the MDIO bus is shared between the two FEC instances.
> The driver makes sure that the second FEC uses the MDIO bus of the
> first FEC. This is done conditionally if FEC_QUIRK_ENET_MAC is set.
> However, in newer designs, such as Vybrid or i.MX6SX, each FEC MAC
> has its own MDIO bus. Simply removing the quirk FEC_QUIRK_ENET_MAC
> is not an option since other logic, triggered by this quirk, is
> still needed.
> 
> Furthermore, there are board designs which use the same MDIO bus
> for both PHY's even though the second bus would be available on the
> SoC side. Such layout are popular since it saves pins on SoC side.
> Due to the above quirk, those boards currently do work fine. The
> boards in the mainline tree with such a layout are:
> - Freescale Vybrid Tower with TWR-SER2 (vf610-twr.dts)
> - Freescale i.MX6 SoloX SDB Board (imx6sx-sdb.dts)
> 
> This patch adds a new quirk FEC_QUIRK_SINGLE_MDIO for i.MX28, which
> makes sure that the MDIO bus of the first FEC is used in any case.
> 
> However, the boards above do have a SoC with a MDIO bus for each FEC
> instance. But the PHY's are not connected in a 1:1 configuration. A
> proper device tree description is needed to allow the driver to
> figure out where to find its PHY. This patch fixes that shortcoming
> by adding a MDIO bus child node to the first FEC instance, along
> with the two PHY's on that bus, and making use of the phy-handle
> property to add a reference to the PHY's.
> 
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
