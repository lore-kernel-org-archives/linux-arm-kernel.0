From: mporter@konsulko.com (Matt Porter)
Date: Mon, 6 Apr 2015 09:32:08 -0400
Subject: [PATCH v4 05/10] eeprom: Add bindings for simple eeprom framework
In-Reply-To: <1427752679-17261-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1427752679-17261-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20150406133208.GH30984@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:57:59PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for simple eeprom framework which allows eeprom
> consumers to talk to eeprom providers to get access to eeprom cell data.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [Maxime Ripard: intial version of eeprom framework]
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../devicetree/bindings/eeprom/eeprom.txt          | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/eeprom/eeprom.txt
> 
> diff --git a/Documentation/devicetree/bindings/eeprom/eeprom.txt b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> new file mode 100644
> index 0000000..fb71d46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/eeprom/eeprom.txt
> @@ -0,0 +1,58 @@
> += EEPROM Data Device Tree Bindings =
> +
> +This binding is intended to represent the location of hardware
> +configuration data stored in EEPROMs.
> +
> +On a significant proportion of boards, the manufacturer has stored
> +some data on an EEPROM-like device, for the OS to be able to retrieve
> +these information and act upon it. Obviously, the OS has to know
> +about where to retrieve these data from, and where they are stored on
> +the storage device.

Since this binding (and the kernel framework supporting it) describes
non-volatile memory devices other than EEPROMs (e.g. EFuses) it should
be named more generically like "nvmem".

> +
> +This document is here to document this.
> +
> += Data providers =
> +Contains bindings specific to provider drivers and data cells as children
> +to this node.
> +
> += Data cells =
> +These are the child nodes of the provider which contain data cell
> +information like offset and size in eeprom provider.
> +
> +Required properties:
> +reg:	specifies the offset in byte within that storage device, and the length
> +	in bytes of the data we care about.
> +	There could be more then one offset-length pairs in this property.
> +
> +Optional properties:
> +As required by specific data parsers/interpreters.

The generic binding could really use a "read-only" property here as this
is a common hardware attribute for many nvmem devices. A serial EEPROM
commonly has a write protect pin which may be hard-wired such that the
hardware description should reflect that. An EFuse is typically blown with
the required information at manufacturing time (for an end product case)
and would be marked with the "read-only" flag.

Having this optional flag in the generic binding would allow the
framework to hint to consumers about the inability to write to the
provided region.

The framework sysfs attributes provide a userspace EEPROM consumer where
it would be useful information to know that a data provider region is
read only rather than having the exported writeable attribute simply
fail a write cycle. This would allow the consumer to be aware that a
failed write (if even attempted) is expected if the data provider
advertised itself as read-only.

-Matt

> +
> +For example:
> +
> +	/* Provider */
> +	qfprom: qfprom at 00700000 {
> +		compatible 	= "qcom,qfprom";
> +		reg		= <0x00700000 0x8000>;
> +		...
> +
> +		/* Data cells */
> +		tsens_calibration: calib at 4404 {
> +			reg = <0x4404 0x10>;
> +		};
> +
> +		serial_number: sn {
> +			reg = <0x104 0x4>, <0x204 0x4>, <0x30c 0x4>;
> +
> +		};
> +		...
> +	};
> +
> += Data consumers =
> +Are device nodes which consume eeprom data cells.
> +
> +For example:
> +
> +	tsens {
> +		...
> +		calibration = <&tsens_calibration>;
> +	};
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
