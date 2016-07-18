From: robh@kernel.org (Rob Herring)
Date: Sun, 17 Jul 2016 21:23:55 -0500
Subject: [PATCH v2 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <20160707222114.1673-4-stephen.boyd@linaro.org>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-4-stephen.boyd@linaro.org>
Message-ID: <20160718022355.GA8568@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2016 at 03:20:54PM -0700, Stephen Boyd wrote:
> The qcom HSIC ULPI phy doesn't have any bits set in the vendor or
> product ID registers. This makes it impossible to make a ULPI
> driver match against the ID registers. Add support to discover
> the ULPI phys via DT/device properties to help alleviate this
> problem. In the DT case, we'll look for a ULPI bus node
> underneath the device registering the ULPI viewport (or the
> parent of that device to support chipidea's device layout) and
> then match up the phy node underneath that with the ULPI device
> that's created.
> 
> The side benefit of this is that we can use standard properties
> in the phy node like clks, regulators, gpios, etc. because we
> don't have firmware like ACPI to turn these things on for us. And
> we can use the DT phy binding to point our phy consumer to the
> phy provider.
> 
> Furthermore, this avoids any problems with reading the ID
> registers before the phy is powered up. The ULPI bus supports
> native enumeration by reading the vendor ID and product ID
> registers at device creation time, but we can't be certain that
> those register reads will succeed if the phy is not powered.
> 
> If the ULPI spec had some generic power sequencing for these
> registers we could put that into the ULPI bus layer and power up
> the device before reading the ID registers. Unfortunately this
> doesn't exist and the power sequence is usually device specific.
> By having the vendor and product ID properties in ACPI or DT, we
> can match up devices with drivers without having to read the
> hardware before it's powered up and avoid this problem.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/ulpi.txt | 35 ++++++++++++
>  drivers/usb/common/ulpi.c                      | 74 +++++++++++++++++++++++++-
>  2 files changed, 107 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/ulpi.txt b/Documentation/devicetree/bindings/usb/ulpi.txt
> new file mode 100644
> index 000000000000..c649ca5b0996
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ulpi.txt
> @@ -0,0 +1,35 @@
> +ULPI bus binding
> +----------------
> +
> +Phys that are behind a ULPI connection can be described with the following
> +binding. The host controller shall have a "ulpi" named node as a child, and
> +that node shall have one enabled node underneath it representing the ulpi
> +device on the bus.
> +
> +PROPERTIES
> +----------
> +
> +- ulpi-vendor:
> +    Usage: optional
> +    Value type: <u16>
> +    Definition: The USB-IF assigned vendor id for this device
> +
> +- ulpi-product:
> +    Usage: required if ulpi-vendor is present
> +    Value type: <u16>
> +    Definition: The vendor assigned product id for this device
> +
> +EXAMPLE
> +-------
> +
> +usb {
> +	compatible = "vendor,usb-controller";
> +
> +	ulpi {
> +		phy {
> +			compatible = "vendor,phy";
> +			ulpi-vendor = /bits/ 16 <0x1d6b>;
> +			ulpi-product = /bits/ 16 <0x0002>;
> +		};
> +	};

I'm still having concerns about describing both phys and devices. If I 
have a controller with 2 ports and 2 devices attached, I'd have 
something like this under the USB controller:

ulpi {
	phy at 1 {
	};
	phy at 2 {
	};
};

dev at 1 {
...
};

dev at 2 {
...
};


That doesn't seem the best, but I don't have a better suggestion. Maybe 
the device nodes need to go under the phy nodes?

Rob
