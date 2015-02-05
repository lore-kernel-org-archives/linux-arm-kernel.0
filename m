From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 5 Feb 2015 18:05:43 +0100
Subject: [PATCH v3] MediaTek PMIC support
In-Reply-To: <1423149938-14471-1-git-send-email-s.hauer@pengutronix.de>
References: <1423149938-14471-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <CABuKBeK-EuWqsCkZcGgLpuL2_FsZwd1T6PwkZB5+kudKxfPZfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

2015-02-05 16:25 GMT+01:00 Sascha Hauer <s.hauer@pengutronix.de>:
> This series adds initial support for the MediaTek MT6397 PMIC and the
> necessary infrastructure to attach it on the MT8135 / MT8173 SoCs.
>
> The infrastructure includes:
>
> - pericfg / infracfg controller support
>   The pericfg / infracfg controllers contain miscellaneous registers for
>   reset controllers and clocks.
>
> - PMIC wrapper support
>   On MediaTek MT8135, MT8173 and other SoCs the PMIC is connected via
>   SPI. The SPI master interface is not directly visible to the CPU, but
>   only through the PMIC wrapper inside the SoC. The communication between
>   the SoC and the PMIC can optionally be encrypted. Also a non standard
>   Dual IO SPI mode can be used to increase speed. The MT8135 also supports
>   a special feature named "IP Pairing". With IP Pairing the pins of some
>   SoC internal peripherals can be on the PMIC. The signals of these pins
>   are routed over the SPI bus using the pwrap bridge. Because of these
>   optional non SPI conform features the PMIC driver is not implemented as
>   a SPI bus master driver.
>
> The MT6397 PMIC itself is implemented as a regular mfd device driver which
> uses regmap to access the PMIC registers.
>
> This series also adds regulator support for the MT6397 PMIC.
>
> The first 6 patches can be merged through the ARM SoC tree. The mfd
> patch is independent of the first 6 patches and can be merged through the
> mfd maintainer trees.

As clock driver and reset controller registers are mixed together in
Mediatek SoCs I would pretty like to see the reset driver in the clock
driver. This is also the way other SoCs handle this case.
As syscon is available at this time, both the clock and the reset
driver should use this (via syscon_node_to_regmap). For your reset
driver, this should be a minimal change as you already use regmap.

Please coordinate with James and Henry to get this into one series using syscon.

Thanks,
Matthias

>
> changes since v2:
>
> - put device tree docs into a separate patch
> - Fix lockdep issues in irq mt6397 handler
> - cosmetic changes
>
> Changes since v1:
>
> - document reset bindings for infracfg/pericfg
> - fix base addresses in infracfg binding example
> - Remove more Email addresses from Flora Fu (She is not working at
>   MediaTek anymore, her address is no longer valid)
> - drop Regulator support patch, it's already in next
>
> Sascha
>



-- 
motzblog.wordpress.com
