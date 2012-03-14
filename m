From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 14 Mar 2012 15:55:55 +0800
Subject: [PATCH 2/7] of: add clock providers
In-Reply-To: <1331680947-29861-3-git-send-email-robherring2@gmail.com>
References: <1331680947-29861-1-git-send-email-robherring2@gmail.com>
 <1331680947-29861-3-git-send-email-robherring2@gmail.com>
Message-ID: <20120314075553.GE21337@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 06:22:22PM -0500, Rob Herring wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Based on work by Ben Herrenschmidt and Jeremy Kerr, this patch adds an
> of_clk_get function to allow platforms to retrieve clock data from the
> device tree.
> 
> Platform register a provider through of_clk_add_provider, which will be
> called when a device references the provider's OF node for a clock
> reference.
> 
> v3: - Clarified documentation
> 
> v2: - fixed errant ';' causing compile error
>     - Editorial fixes from Shawn Guo
>     - merged in adding lookup to clkdev
>     - changed property names to match established convention. After
>       working with the binding a bit it really made more sense to follow the
>       lead of 'reg', 'gpios' and 'interrupts' by making the input simply
>       'clocks' & 'clock-names' instead of 'clock-input-*', and to only use
>       clock-output* for the producer nodes. (Sorry Shawn, this will mean
>       you need to change some code, but it should be trivial)
>     - Add ability to inherit clocks from parent nodes by using an empty
>       'clock-ranges' property.  Useful for busses.  I could use some feedback
>       on the new property name, 'clock-ranges' doesn't feel right to me.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> Reviewed-by: Shawn Guo <shawn.guo@freescale.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Mike Turquette <mturquette@ti.com>
> ---
>  .../devicetree/bindings/clock/clock-bindings.txt   |  116 ++++++++++++++
>  .../devicetree/bindings/clock/fixed-clock.txt      |   21 +++
>  drivers/clk/clkdev.c                               |    9 +
>  drivers/of/Kconfig                                 |    6 +
>  drivers/of/Makefile                                |    1 +
>  drivers/of/clock.c                                 |  165 ++++++++++++++++++++
>  include/linux/of_clk.h                             |   37 +++++
>  7 files changed, 355 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/clock-bindings.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/fixed-clock.txt
>  create mode 100644 drivers/of/clock.c
>  create mode 100644 include/linux/of_clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> new file mode 100644
> index 0000000..3cb6746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -0,0 +1,116 @@
> +This binding is a work-in-progress, and are based on some experimental
> +work by benh[1].
> +
> +Sources of clock signal can be represented by any node in the device
> +tree.  Those nodes are designated as clock providers.  Clock consumer
> +nodes use a phandle and clock specifier pair to connect clock provider
> +outputs to clock inputs.  Similar to the gpio specifiers, a clock
> +specifier is an array of one more more cells identifying the clock
> +output on a device.  The length of a clock specifier is defined by the
> +value of a #clock-cells property in the clock provider node.
> +
> +[1] http://patchwork.ozlabs.org/patch/31551/
> +
> +==Clock providers==
> +
> +Required properties:
> +#clock-cells:	   Number of cells in a clock specifier; typically will be
> +		   set to 1
> +

We had a discussion[1] regarding it.

Regards,
Shawn

http://article.gmane.org/gmane.linux.drivers.devicetree/11554
