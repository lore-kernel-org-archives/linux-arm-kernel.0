From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 7 Sep 2016 20:12:32 -0500
Subject: [PATCH v4 03/22] usb: ulpi: Support device discovery via DT
In-Reply-To: <20160907213519.27340-4-stephen.boyd@linaro.org>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-4-stephen.boyd@linaro.org>
Message-ID: <CAL_JsqJbk2TGmASK974hO0n+Y3DmB3tbggbd9wXCNa9Ug9QdDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 7, 2016 at 4:35 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> The qcom HSIC ULPI phy doesn't have any bits set in the vendor or
> product ID registers. This makes it impossible to make a ULPI
> driver match against the ID registers. Add support to discover
> the ULPI phys via DT help alleviate this problem. In the DT case,
> we'll look for a ULPI bus node underneath the device registering
> the ULPI viewport (or the parent of that device to support
> chipidea's device layout) and then match up the phy node
> underneath that with the ULPI device that's created.
>
> The side benefit of this is that we can use standard properties
> in the phy node like clks, regulators, gpios, etc. because we
> don't have firmware like ACPI to turn these things on for us. And
> we can use the DT phy binding to point our phy consumer to the
> phy provider.
>
> The ULPI bus code supports native enumeration by reading the
> vendor ID and product ID registers at device creation time, but
> we can't be certain that those register reads will succeed if the
> phy is not powered up. To avoid any problems with reading the ID
> registers before the phy is powered we fallback to DT matching
> when the ID reads fail.
>
> If the ULPI spec had some generic power sequencing for these
> registers we could put that into the ULPI bus layer and power up
> the device before reading the ID registers. Unfortunately this
> doesn't exist and the power sequence is usually device specific.
> By having the device matched up with DT we can avoid this
> problem.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/ulpi.txt | 20 +++++++
>  drivers/usb/common/ulpi.c                      | 77 ++++++++++++++++++++++++--
>  2 files changed, 92 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt

Acked-by: Rob Herring <robh@kernel.org>

But one concern below.

> -static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> +static int ulpi_of_register(struct ulpi *ulpi)
> +{
> +       struct device_node *np = NULL, *child;
> +
> +       /* Find a ulpi bus underneath the parent or the parent of the parent */

parent of the parent is called the grandparent.

> +       if (ulpi->dev.parent->of_node)
> +               np = of_find_node_by_name(ulpi->dev.parent->of_node, "ulpi");
> +       else if (ulpi->dev.parent->parent && ulpi->dev.parent->parent->of_node)
> +               np = of_find_node_by_name(ulpi->dev.parent->parent->of_node,

First setting "parent = ulpi->dev.parent" would make this a bit easier
on the eyes.

When is it valid to be the grandparent? The binding doesn't mention that.

Rob
