From: olof@lixom.net (Olof Johansson)
Date: Fri, 4 Nov 2011 13:29:05 -0700
Subject: [PATCH v4 1/4] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <1319721864-30067-1-git-send-email-rnayak@ti.com>
References: <1319721864-30067-1-git-send-email-rnayak@ti.com>
Message-ID: <20111104202905.GA3918@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 27, 2011 at 06:54:24PM +0530, Rajendra Nayak wrote:
> The helper routine is meant to be used by the regulator drivers
> to extract the regulator_init_data structure from the data
> that is passed from device tree.
> 'consumer_supplies' which is part of regulator_init_data is not extracted
> as the regulator consumer mappings are passed through DT differently,
> implemented in subsequent patches.
> Similarly the regulator<-->parent/supply mapping is handled in
> subsequent patches.
> 
> Also add documentation for regulator bindings to be used to pass
> regulator_init_data struct information from device tree.
> 
> Some of the regulator properties which are linux and board specific,
> are left out since its not clear if they can
> be in someway embedded into the kernel or passed in from DT.
> They will be revisited later.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  .../devicetree/bindings/regulator/regulator.txt    |   33 ++++++++
>  drivers/regulator/Kconfig                          |    7 ++
>  drivers/regulator/Makefile                         |    1 +
>  drivers/regulator/of_regulator.c                   |   81 ++++++++++++++++++++
>  include/linux/regulator/of_regulator.h             |   20 +++++
>  5 files changed, 142 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/regulator.txt
>  create mode 100644 drivers/regulator/of_regulator.c
>  create mode 100644 include/linux/regulator/of_regulator.h
> 
> diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
> new file mode 100644
> index 0000000..c488bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/regulator.txt
> @@ -0,0 +1,33 @@
> +Voltage/Current Regulators
> +

There should be a mandatory compatible field here, right? I.e. a topmost
generic one, "regulator" or similar.

> +Optional properties:
> +- regulator-name: A string used as a descriptive name for regulator outputs

Ah, there it is. Ignore my previous comment then, Mark. :)

> +- regulator-min-uV: smallest voltage consumers may set
> +- regulator-max-uV: largest voltage consumers may set
> +- regulator-uV-offset: Offset applied to voltages to compensate for voltage drops
> +- regulator-min-uA: smallest current consumers may set
> +- regulator-max-uA: largest current consumers may set
> +- regulator-always-on: boolean, regulator should never be disabled
> +- regulator-boot-on: bootloader/firmware enabled regulator

Once you have a compatible field that can determine what kind of device node,
and binding, this is, you can drop the regulator- prefix and save some space in
the device tree. Properties are rarely prefixed by their subsystem. Only
exception would/could be the regulator-name property where it could make
sense to keep the prefix.

Also, lower-caps is common instead of V and A.

> +- <name>-supply: phandle to the parent supply/regulator node

Having a fixed name here instead of a free form string would probably be a good
idea?



-Olof
