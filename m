From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 24 Oct 2012 22:29:58 +0200
Subject: [PATCH 9/9] ARM: Kirkwood: Convert IX2-200 to pinctrl.
In-Reply-To: <20121024202010.GB21046@lunn.ch>
References: <1351090434-30499-1-git-send-email-andrew@lunn.ch>
 <1351090434-30499-10-git-send-email-andrew@lunn.ch>
 <20121024220429.50e2b0b8@skate> <20121024202010.GB21046@lunn.ch>
Message-ID: <20121024222958.45a08c5b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Wed, 24 Oct 2012 22:20:10 +0200, Andrew Lunn wrote:

> The reg maybe. Compatibility not. We need to tell pinctrl which of the
> 5 different variants of kirkwood this particular kirkwood is. See

Agreed.

> drivers/pinctrl/pinctrl-kirkwood.c
> 
> enum kirkwood_variant {
>         VARIANT_MV88F6180 = V(1, 0, 0, 0, 0),
>         VARIANT_MV88F6190 = V(0, 1, 0, 0, 0),
>         VARIANT_MV88F6192 = V(0, 0, 1, 0, 0),
>         VARIANT_MV88F6281 = V(0, 0, 0, 1, 0),
>         VARIANT_MV88F6282 = V(0, 0, 0, 0, 1),
> };
> 
> static struct of_device_id kirkwood_pinctrl_of_match[] __devinitdata = {
>         { .compatible = "marvell,88f6180-pinctrl", .data = &mv88f6180_info },
>         { .compatible = "marvell,88f6190-pinctrl", .data = &mv88f6190_info },
>         { .compatible = "marvell,88f6192-pinctrl", .data = &mv88f6192_info },
>         { .compatible = "marvell,88f6281-pinctrl", .data = &mv88f6281_info },
>         { .compatible = "marvell,88f6282-pinctrl", .data = &mv88f6282_info },
>         { }
> };
> 
> What SoC is mounted on a board is a property of the board....

The way we solved that on Armada XP is that we have a common
armada-xp.dtsi file with definitions common to all SoCs in the family.
Then, we have sub .dtsi files named armada-xp-mv78230.dtsi,
armada-xp-mv78260.dtsi and armada-xp-mv78460.dtsi that handle the
differences between specific SoCs in the family. For example, the
differences are: different compatible string for the pinctrl driver,
different number of CPUs, different number of pins and
therefore different number of GPIOs, different number of PCIe ports,
etc. But besides those differences, most units have a lot of common
definitions, that we factor out in armada-xp.dtsi.

So we have the following hierarchy:

 + armada-xp.dtsi
   + armada-xp-mv78230.dtsi
     + someboard-here.dts
   + armada-xp-mv78260.dtsi
     + openblocks-ax3-4.dts
   + armada-xp-mv78460.dtsi
     + armada-xp-db.dts

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
