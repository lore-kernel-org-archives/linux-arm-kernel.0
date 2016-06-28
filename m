From: robh@kernel.org (Rob Herring)
Date: Tue, 28 Jun 2016 15:56:42 -0500
Subject: [PATCH 02/21] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160626072838.28082-3-stephen.boyd@linaro.org>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-3-stephen.boyd@linaro.org>
Message-ID: <20160628205642.GP3737@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 26, 2016 at 12:28:19AM -0700, Stephen Boyd wrote:
> The qcom HSIC ulpi phy doesn't have any bits set in the vendor or
> product id ulpi registers. This makes it impossible to make a
> ulpi driver match against the id registers. Add support to
> discover the ulpi phys via DT to help alleviate this problem.
> We'll look for a ulpi bus node underneath the device registering
> the ulpi viewport (or the parent of that device to support
> chipidea's device layout) and then match up the phy node
> underneath that with the ulpi device that's created.
> 
> The side benefit of this is that we can use standard DT
> properties in the phy node like clks, regulators, gpios, etc.
> because we don't have firmware like ACPI to turn these things on
> for us. And we can use the DT phy binding to point our phy
> consumer to the phy provider.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/ulpi.txt | 20 +++++++++
>  drivers/usb/common/ulpi.c                      | 56 +++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt
> 
> diff --git a/Documentation/devicetree/bindings/usb/ulpi.txt b/Documentation/devicetree/bindings/usb/ulpi.txt
> new file mode 100644
> index 000000000000..ca179dc4bd50
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ulpi.txt
> @@ -0,0 +1,20 @@
> +ULPI bus binding
> +----------------
> +
> +Phys that are behind a ULPI connection can be described with the following
> +binding. The host controller shall have a "ulpi" named node as a child, and
> +that node shall have one enabled node underneath it representing the ulpi
> +device on the bus.

This needs to co-exist with the USB bus binding which has the controller 
ports for the child nodes. Maybe use the phy binding?

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
> +		};
> +	};
> +};
