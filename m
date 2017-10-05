From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 15:50:37 -0500
Subject: [PATCH v2 01/10] pinctrl: move gpio-axp209 to pinctrl
In-Reply-To: <e193f8efe9092171ebeffb77ab77422179fd3cab.1506428208.git-series.quentin.schulz@free-electrons.com>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <e193f8efe9092171ebeffb77ab77422179fd3cab.1506428208.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20171005205037.hxtoyeryiolflkda@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 02:17:11PM +0200, Quentin Schulz wrote:
> To prepare the driver for the upcoming pinctrl features, move the GPIO
> driver AXP209 from GPIO to pinctrl subsystem.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt       |  30 +-
>  Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt |  30 +-
>  drivers/gpio/Kconfig                                         |   6 +-
>  drivers/gpio/Makefile                                        |   1 +-
>  drivers/gpio/gpio-axp209.c                                   | 188 +-------
>  drivers/pinctrl/Kconfig                                      |   6 +-
>  drivers/pinctrl/Makefile                                     |   1 +-
>  drivers/pinctrl/pinctrl-axp209.c                             | 188 +++++++-
>  8 files changed, 225 insertions(+), 225 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/gpio/gpio-axp209.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
>  delete mode 100644 drivers/gpio/gpio-axp209.c
>  create mode 100644 drivers/pinctrl/pinctrl-axp209.c
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> deleted file mode 100644
> index a661130..0000000
> --- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -AXP209 GPIO controller
> -
> -This driver follows the usual GPIO bindings found in
> -Documentation/devicetree/bindings/gpio/gpio.txt
> -
> -Required properties:
> -- compatible: Should be "x-powers,axp209-gpio"
> -- #gpio-cells: Should be two. The first cell is the pin number and the
> -  second is the GPIO flags.
> -- gpio-controller: Marks the device node as a GPIO controller.
> -
> -This node must be a subnode of the axp20x PMIC, documented in
> -Documentation/devicetree/bindings/mfd/axp20x.txt
> -
> -Example:
> -
> -axp209: pmic at 34 {
> -	compatible = "x-powers,axp209";
> -	reg = <0x34>;
> -	interrupt-parent = <&nmi_intc>;
> -	interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> -	interrupt-controller;
> -	#interrupt-cells = <1>;
> -
> -	axp_gpio: gpio {
> -		compatible = "x-powers,axp209-gpio";
> -		gpio-controller;
> -		#gpio-cells = <2>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> new file mode 100644
> index 0000000..a661130
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-axp209.txt
> @@ -0,0 +1,30 @@
> +AXP209 GPIO controller
> +
> +This driver follows the usual GPIO bindings found in
> +Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Required properties:
> +- compatible: Should be "x-powers,axp209-gpio"
> +- #gpio-cells: Should be two. The first cell is the pin number and the
> +  second is the GPIO flags.
> +- gpio-controller: Marks the device node as a GPIO controller.

Maybe there's some reason to move the driver, but the binding describes 
a gpio-controller so it should remain in bindings/gpio/. Binding and 
driver directories aren't one to one necessarily.

Rob
