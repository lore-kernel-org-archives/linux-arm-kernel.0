From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Jan 2016 08:31:00 -0600
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160112143100.GA14628@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 02:37:21PM +0100, Maxime Ripard wrote:
> Some boards, in order to power devices that have a quite high power
> consumption, wire multiple regulators in parallel.
> 
> In such a case, the regulators need to be kept in sync, all of them being
> enabled or disabled in parallel.
> 
> This also requires to expose only the voltages that are common to all the
> regulators.
> 
> Eventually support for changing the voltage in parallel should be added
> too, possibly with delays between each other to avoid having a too brutal
> peak consumption.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  .../bindings/regulator/coupled-voltage.txt         |  18 ++
>  drivers/regulator/Kconfig                          |   8 +
>  drivers/regulator/Makefile                         |   1 +
>  drivers/regulator/coupled-voltage-regulator.c      | 299 +++++++++++++++++++++
>  4 files changed, 326 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/coupled-voltage.txt
>  create mode 100644 drivers/regulator/coupled-voltage-regulator.c
> 
> diff --git a/Documentation/devicetree/bindings/regulator/coupled-voltage.txt b/Documentation/devicetree/bindings/regulator/coupled-voltage.txt
> new file mode 100644
> index 000000000000..f5401aab52f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/coupled-voltage.txt
> @@ -0,0 +1,18 @@
> +Coupled voltage regulators
> +
> +Required properties:
> +- compatible		: Must be "coupled-voltage-regulator".
> +
> +Optional properties:
> +- vinX-supply		: Phandle to the regulators it aggregates
> +
> +Any property defined as part of the core regulator binding defined in
> +regulator.txt can also be used.
> +
> +Example:
> +	vcc_wifi: wifi_reg {
> +		compatible = "coupled-voltage-regulator";
> +		regulator-name = "vcc-wifi";
> +		vin0-supply = <&reg_ldo3>;
> +		vin1-supply = <&reg_ldo4>;
> +	};

Why not just make ?-supply a list of phandles? That would be simpler 
than a virtual regulator.

Rob
