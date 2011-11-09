From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 9 Nov 2011 10:13:28 +0100
Subject: [RFC 6/8] of: add clock providers
In-Reply-To: <1320801583-12774-7-git-send-email-grant.likely@secretlab.ca>
References: <1320801583-12774-1-git-send-email-grant.likely@secretlab.ca>
 <1320801583-12774-7-git-send-email-grant.likely@secretlab.ca>
Message-ID: <20111109091328.GY16886@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2011 at 06:19:41PM -0700, Grant Likely wrote:
> Based on work by Ben Herrenschmidt and Jeremy Kerr, this patch adds an
> of_clk_get function to allow platforms to retrieve clock data from the
> device tree.
> 
> Platform register a provider through of_clk_add_provider, which will be
> called when a device references the provider's OF node for a clock
> reference.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
>  .../devicetree/bindings/clock/clock-bindings.txt   |  109 +++++++++++++++++
>  drivers/of/Kconfig                                 |    6 +
>  drivers/of/Makefile                                |    1 +
>  drivers/of/clock.c                                 |  129 ++++++++++++++++++++
>  include/linux/of_clk.h                             |   37 ++++++
>  5 files changed, 282 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/clock-bindings.txt
>  create mode 100644 drivers/of/clock.c
>  create mode 100644 include/linux/of_clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/clock-bindings.txt b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> new file mode 100644
> index 0000000..4770c7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/clock-bindings.txt
> @@ -0,0 +1,109 @@
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
> +Optional properties:
> +clock-output-name: Recommended to be a list of strings of clock output signal
> +		   names indexed by the first cell in the clock specifier.
> +		   However, the meaning of clock-output-names is domain
> +		   specific to the clock provider, and is only provided to
> +		   encourage using the same meaning for the majority of clock
> +		   providers.  This format may not work for clock providers
> +		   using a complex clock specifier format.  In those cases it
> +		   is recommended to omit this property and create a binding
> +		   specific names property.

If the clock-output-name property is omitted, does this mean a clock
provider only has a single output or does it mean that it's not known
how many clock outputs a provider actually has?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
