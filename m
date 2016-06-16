From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 16 Jun 2016 16:27:34 +0100
Subject: [PATCH v3] regulator: axp20x: Add support for the (external)
 drivebus regulator
In-Reply-To: <1464973184-17244-1-git-send-email-hdegoede@redhat.com>
References: <1464973184-17244-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20160616152734.GB21702@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we're reviewing documentation ...

On Fri, 03 Jun 2016, Hans de Goede wrote:
> The axp20x pmics have 2 power inputs, one called ACIN which is intended

s/pmics/PMICs/

> for to be supplied via a powerbarrel on the board and one called VBUS

s/for //

s/powerbarrel/barrel jack/

> which is intended to be supplied via an otg connector.

s/otg/OTG/

> In the VBUS case the pmic needs to know if the board is supplying power
> to the otg connector, because then it should not take any power from

s/pmic/PMIC/ and s/otg/OTG/ throughout

> its VBUS pin. The axp209 pmic has a N_VBUSEN input pin via which the

s/a/an/

> board can signal to the pmic whether the board is supplying power to the
> otg connector or not.
> 
> On the axp221/axp223 this pin can alternatively be used as an output
> which controls an external regulator which (optionally) supplies
> power to the otg connector from the board. When the pin is used as
> output it is called DRIVEVBUS in the datasheet.
> 
> This commit adds support for the DRIVEVBUS pin as an extra pmic
> controlled regulator. Since this is optional a new x-powers,drivebus dt

s/a/when a/

s/dt/DT/

> property is added. When this is present the misc-control register is
> written to change the N_VBUSEN input pin to DRIVEVBUS output pin mode and
> the extra drivebus regulator is registered with the regulator subsystem.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v2:
> -Set supply_name to just drivebus instead of drivevbus-supply
> -Fix some whitespace errors in the docs
> 
> Changes in v2:
> -Rename the dt property to drive-vbus-en
> -s/drivebus/drivevbus/
> -Add a line describing the drivevbus regulator to the table in
>  Documentation/devicetree/bindings/mfd/axp20x.txt
> -Set supply_name to drivevbus-supply
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt |  6 +++++
>  drivers/regulator/axp20x-regulator.c             | 30 ++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> index d20b103..585a955 100644
> --- a/Documentation/devicetree/bindings/mfd/axp20x.txt
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -22,6 +22,11 @@ Optional properties:
>  		      AXP152/20X: range:  750-1875, Default: 1.5 MHz
>  		      AXP22X/80X: range: 1800-4050, Default: 3   MHz
>  
> +- x-powers,drive-vbus-en: axp221 / axp223 only boolean, set this when the
> +		  N_VBUSEN pin is used as an output pin to control an external
> +		  regulator to drive the OTG VBus, rather then as an input pin
> +		  which signals whether the board is driving OTG VBus or not.
> +
>  - <input>-supply: a phandle to the regulator supply node. May be omitted if
>  		  inputs are unregulated, such as using the IPSOUT output
>  		  from the PMIC.
> @@ -79,6 +84,7 @@ ELDO3		: LDO		: eldoin-supply		: shared supply
>  LDO_IO0		: LDO		: ips-supply		: GPIO 0
>  LDO_IO1		: LDO		: ips-supply		: GPIO 1
>  RTC_LDO		: LDO		: ips-supply		: always on
> +DRIVEVBUS	: Enable output	: drivevbus-supply	: external regulator
>  
>  AXP809 regulators, type, and corresponding input supply names:

Ironically, the doc looks good. :)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
