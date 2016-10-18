From: robh@kernel.org (Rob Herring)
Date: Tue, 18 Oct 2016 11:44:23 -0500
Subject: [PATCH v5 03/23] usb: ulpi: Support device discovery via DT
In-Reply-To: <20161018015636.11701-4-stephen.boyd@linaro.org>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-4-stephen.boyd@linaro.org>
Message-ID: <20161018164423.tex3norsrdnvc5oz@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 06:56:16PM -0700, Stephen Boyd wrote:
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
>  drivers/usb/common/ulpi.c                      | 79 ++++++++++++++++++++++++--
>  2 files changed, 93 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt

Acked-by: Rob Herring <robh@kernel.org>
