From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 8 Jan 2015 15:54:10 +0100
Subject: [PATCH v2 7/8] ARM: mvebu: Add Device Tree description of the
 Armada 388 SoC
In-Reply-To: <1420714305-7496-8-git-send-email-gregory.clement@free-electrons.com>
References: <1420714305-7496-1-git-send-email-gregory.clement@free-electrons.com>
 <1420714305-7496-8-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150108155410.576bae03@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu,  8 Jan 2015 11:51:44 +0100, Gregory CLEMENT wrote:
> This SoC belongs to the Armada 38x family. The main difference with
> the Armada 385 is that the 388 can handle two more SATA
> ports. Currently the only consequence is the use of a different
> compatible string for the pinctrl node, in order to be able to use the
> pins associated to this 2 new SATA ports.

I am not sure the pinmux is the only difference. Read on below.

> +#include "armada-385.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 388 family SoC";
> +	compatible = "marvell,armada388", "marvell,armada380";
> +	soc {

Please, one empty new line between the last property (compatible) and
the "soc" node.

> +		internal-regs {
> +			pinctrl at 18000 {
> +				compatible = "marvell,mv88f6828-pinctrl";
> +			};
> +		};
> +	};
> +};

So, the 380 and 385 have two SATA ports, presumably ports 0 and 1.
According to the Functional Specifications, section 3.1 (Internal
Address map), those two ports are located at 0xA8000. Ports 2 and 3,
which are only available on Armada 388, are located at 0xE0100 and
0xE0180 according to the same datasheet. So I believe that the node:

			sata at a8000 {
				compatible = "marvell,armada-380-ahci";
				reg = <0xa8000 0x2000>;
				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
				clocks = <&gateclk 15>;
				status = "disabled";
			};

should stay where it is in armada-38x.dtsi.

However, the node:

			sata at e0000 {
				compatible = "marvell,armada-380-ahci";
				reg = <0xe0000 0x2000>;
				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
				clocks = <&gateclk 30>;
				status = "disabled";
			};

should probably move into armada-388.dtsi, since it covers ports 2 and
3.

In addition, I believe that the existing armada-385-db.dts and
armada-385-rd.dts should be renamed to armada-388-db.dts and
armada-388-rd.dts, and they should include armada-388.dtsi instead. At
least it's sure for the DB (which has both SATA controllers enabled).
For the RD, it remains to be confirmed, but in general most Marvell
development platforms use the superset SoC, which has all the
functionalities.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
