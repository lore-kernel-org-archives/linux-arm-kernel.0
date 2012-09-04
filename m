From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Sep 2012 14:36:36 +0000
Subject: [PATCH 1/4] net: mvneta: driver for Marvell Armada 370/XP network
 unit
In-Reply-To: <1346764004-16332-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1346764004-16332-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1346764004-16332-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <201209041436.36430.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 September 2012, Thomas Petazzoni wrote:
>  .../devicetree/bindings/net/marvell-neta.txt       |   24 +
>  drivers/net/ethernet/marvell/Kconfig               |   11 +
>  drivers/net/ethernet/marvell/Makefile              |    1 +
>  drivers/net/ethernet/marvell/mvneta.c              | 2732 ++++++++++++++++++++
>  drivers/net/ethernet/marvell/mvneta.h              |  496 ++++
>  5 files changed, 3264 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/marvell-neta.txt
>  create mode 100644 drivers/net/ethernet/marvell/mvneta.c
>  create mode 100644 drivers/net/ethernet/marvell/mvneta.h

I usually prefer putting the definitions into the .c file rather
than a separate header if there is only only file including it
anyway.

> diff --git a/Documentation/devicetree/bindings/net/marvell-neta.txt b/Documentation/devicetree/bindings/net/marvell-neta.txt
> new file mode 100644
> index 0000000..a031978
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/marvell-neta.txt
> @@ -0,0 +1,24 @@
> +* Marvell Armada 370 / Armada XP Ethernet Controller (NETA)
> +
> +Required properties:
> +- compatible: should be "marvell,neta".
> +- reg: address and length of the register set for the device.
> +- interrupts: interrupt for the device
> +- phy-mode: String, operation mode of the PHY interface. Supported
> +  values are "sgmii" and "rmii".
> +- phy-addr: Integer, address of the PHY.
> +- device_type: should be "network".
> +- clock-frequency: frequency of the peripheral clock of the SoC.
> +
> +Example:
> +
> +eth at d0070000 {
> +               compatible = "marvell,neta";
> +               reg = <0xd0070000 0x2500>;
> +               interrupts = <8>;
> +               device_type = "network";
> +               clock-frequency = <250000000>;
> +               status = "okay";
> +               phy-mode = "sgmii";
> +               phy-addr = <25>;

I think we normally put the phy into a separate device node on an
mdio bus and then use the of_phy_* functions to connect it to
the ethernet device.

	Arnd
