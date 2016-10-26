From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Oct 2016 15:39:19 -0500
Subject: [PATCH 1/6] dt: bindings: Add Allwinner Q8 tablets hardware
 manager bindings
In-Reply-To: <20161014075337.10452-2-hdegoede@redhat.com>
References: <20161014075337.10452-1-hdegoede@redhat.com>
 <20161014075337.10452-2-hdegoede@redhat.com>
Message-ID: <20161026203919.63izobxnn2h33oh2@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2016 at 09:53:32AM +0200, Hans de Goede wrote:
> Allwinnner A13 / A23 / A33 based Q8 tablets are popular cheap 7" tablets
> of which a new batch is produced every few weeks. Each batch uses a
> different mix of touchscreen, accelerometer and wifi peripherals.
> 
> Given that each batch is different creating a devicetree for each variant
> is not desirable, work is being done on a Q8 tablet hardware manager which
> auto-detects the touchscreen and accelerometer and will update the dt with
> what it has found, so that a single generic dt can be used for these tablets.
> 
> This commit adds dt-bindings for this hardware manager.
> 
> Note the wifi is connected to a discoverable bus (sdio or usb) and will be
> autodetected by the mmc resp. usb subsystems.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../misc/allwinner,sunxi-q8-hardwaremgr.txt        | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> 
> diff --git a/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt b/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> new file mode 100644
> index 0000000..a81b258
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/allwinner,sunxi-q8-hardwaremgr.txt
> @@ -0,0 +1,71 @@
> +Q8 tablet hardware manager
> +--------------------------
> +
> +Allwinnner A13 / A23 / A33 based Q8 tablets are popular cheap 7" tablets of
> +which a new batch is produced every few weeks. Each batch uses a different
> +mix of touchscreen, accelerometer and wifi peripherals.
> +
> +Given that each batch is different creating a devicetree for each variant is
> +not desirable. The Q8 tablet hardware manager bindings are bindings for an os
> +module which auto-detects the touchscreen and accelerometer so that a single
> +generic dts can be used for these tablets.
> +
> +The wifi is connected to a discoverable bus and will be autodetected by the os.
> +
> +Required properties:
> + - toplevel / machine compatible, one of:
> +	"allwinner,q8-a13"
> +	"allwinner,q8-a23"
> +	"allwinner,q8-a33"
> + - touchscreen node   : There must be a template touchscreen node named
> +			"touchscreen", this must be a child node of the
> +			touchscreen i2c bus
> + - accelerometer node : There must be a template accelerometer node named
> +			"accelerometer", this must be a child node of the
> +			accelerometer i2c bus
> +
> +touchscreen node required properties:
> + - interrupt-parent   : phandle pointing to the interrupt controller
> +			serving the touchscreen interrupt
> + - interrupts         : interrupt specification for the touchscreen interrupt
> + - power-gpios        : Specification for the pin connected to the touchscreen's
> +			enable / wake pin. This needs to be driven high to
> +			enable the touchscreen controller

enable-gpios is the common name.

I was going to say you need to list possible compatible strings here 
also. However, I now wonder if this binding doc is even needed. The 
binding docs should just be the bindings for each touchscreen or 
accelerometer. The fact that the node is completed at run-time whether 
the bootloader or kernel doesn't matter for the binding definition. When 
and it is completed is orthogonal to the binding definition.

Rob
