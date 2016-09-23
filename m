From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 17:17:30 -0500
Subject: [PATCH v3 3/4] regulator: axp20x: add the AXP803
In-Reply-To: <6c9e5c21df09a1feb1b00aa000c3c0f77e51eac3.1474621107.git.moinejf@free.fr>
References: <cover.1474621107.git.moinejf@free.fr>
 <6c9e5c21df09a1feb1b00aa000c3c0f77e51eac3.1474621107.git.moinejf@free.fr>
Message-ID: <20160923221730.GA10276@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2016 at 09:00:42AM +0200, Jean-Francois Moine wrote:
> The X-Powers AXP803 PMIC is close to the AXP809 with more outputs.
> It is used in some Allwinner boards as the Sinovoip BananaPi M64
> and the Pine A64.
> 
> Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> ---
> not tested
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt |  32 +++-
>  drivers/mfd/axp20x.c                             |  13 ++
>  drivers/regulator/Makefile                       |   3 +-
>  drivers/regulator/axp803.c                       | 225 +++++++++++++++++++++++
>  include/linux/mfd/axp20x.h                       |   1 +
>  5 files changed, 271 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/regulator/axp803.c
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index 8f3ad9a..3332d02 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -6,12 +6,13 @@ axp202 (X-Powers)
>  axp209 (X-Powers)
>  axp221 (X-Powers)
>  axp223 (X-Powers)
> +axp803 (X-Powers)
>  axp809 (X-Powers)
>  
>  Required properties:
>  - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
> -	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp806",
> -	      "x-powers,axp809"
> +	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp803",
> +	      "x-powers,axp806", "x-powers,axp809"

If you respin this, please reformat this to one per line.

Acked-by: Rob Herring <robh@kernel.org>

>  - reg: The I2C slave address or RSB hardware address for the AXP chip
>  - interrupt-parent: The parent interrupt controller
>  - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> @@ -86,6 +87,33 @@ LDO_IO1		: LDO		: ips-supply		: GPIO 1
>  RTC_LDO		: LDO		: ips-supply		: always on
>  DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
>  
> +AXP803 regulators, type, and corresponding input supply names:
> +
> +Regulator	  Type		  Supply Name		  Notes
> +---------	  ----		  -----------		  -----
> +DCDC1		: DC-DC buck	: vin1-supply
> +DCDC2		: DC-DC buck	: vin2-supply
> +DCDC3		: DC-DC	buck	: vin3-supply
> +DCDC4		: DC-DC	buck	: vin4-supply
> +DCDC5		: DC-DC	buck	: vin5-supply
> +DCDC6		: DC-DC	buck	: vin6-supply
> +ALDO1		: LDO		: aldoin-supply	: shared supply
> +ALDO2		: LDO		: aldoin-supply	: shared supply
> +ALDO3		: LDO		: aldoin-supply	: shared supply
> +DLDO1		: LDO		: dldoin-supply	: shared supply
> +DLDO2		: LDO		: dldoin-supply	: shared supply
> +DLDO3		: LDO		: dldoin-supply	: shared supply
> +DLDO4		: LDO		: dldoin-supply	: shared supply
> +ELDO1		: LDO		: eldoin-supply	: shared supply
> +ELDO2		: LDO		: eldoin-supply	: shared supply
> +ELDO3		: LDO		: eldoin-supply	: shared supply
> +FLDO1		: LDO		: fldoin-supply	: shared supply
> +FLDO2		: LDO		: fldoin-supply	: shared supply
> +RTC_LDO		: LDO		: ips-supply	: always on
> +LDO_IO0		: LDO		: ips-supply	: GPIO 0
> +LDO_IO1		: LDO		: ips-supply	: GPIO 1
> +DC1SW		: On/Off Switch	:		: DCDC1 secondary output
> +
>  AXP806 regulators, type, and corresponding input supply names:
>  
>  Regulator	  Type		  Supply Name		  Notes
