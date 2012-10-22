From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 10:07:29 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <1350771032-11527-3-git-send-email-linux@prisktech.co.nz>
References: <1350771032-11527-1-git-send-email-linux@prisktech.co.nz>
 <1350771032-11527-3-git-send-email-linux@prisktech.co.nz>
Message-ID: <50856F41.7000205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2012 04:10 PM, Tony Prisk wrote:
> Add a binding document for ehci-platform driver.
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  .../devicetree/bindings/usb/ehci-platform.txt      |   27 ++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ehci-platform.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/ehci-platform.txt b/Documentation/devicetree/bindings/usb/ehci-platform.txt
> new file mode 100644
> index 0000000..930b19e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ehci-platform.txt
> @@ -0,0 +1,27 @@
> +Generic Platform EHCI Controller
> +-----------------------------------------------------
> +
> +Required properties:
> +- compatible : "linux,ehci-platform"

That compatible value doesn't look right. The HW isn't defined by Linux.
The binding is supposed to represent HW, not any single OS's use of that
HW or the way its driver works.

Something like "usb,ehci" might be more appropriate. Certainly, the
value should not be "linux,", nor derived from Linux's driver name.

> +Optional properties:
> +- caps-offset : offset to the capabilities register (default = 0)
> +- has-tt : controller has transaction translator(s).
> +- has-synopsys-hc-bug : controller has the synopsys hc bug

That would normally be determined by the driver based on the particular
compatible value that is in device tree.

> +- no-io-watchdog : controller does not need io watchdog
> +
> +- big-endian : descriptors and registers are both big endian. This
> +  is the equivalent of specifying big-endian-desc and big-endian-regs.
> +OR
> +- big-endian-desc : descriptors are in big-endian format
> +- big-endian-regs : mmio is in big-endian format

Hmmm. That looks odd. Presumably if those properties aren't specified,
the default is little-endian? Shouldn't this be a tri-state: big,
little, native, with default native? I don't know what the EHCI
specification mandates here (and if it does mandate something, the
default should match the specification). Isn't this something that
readl/writel would take care of, or are there cases where the register
endianness of just this one HW block mismatches all other HW blocks?

> +Example:
> +	ehci at d8007c00 {
> +		compatible = "ehci-platform";
> +		reg = <0xd8007c00 0x200>;
> +		interrupts = <43>;
> +		has-tt;
> +	};
> 
