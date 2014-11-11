From: acourbot@nvidia.com (Alexandre Courbot)
Date: Tue, 11 Nov 2014 15:37:43 +0900
Subject: [PATCH v4 REPOST 1/5] of: Add descriptions of thermtrip properties
 to Tegra PMC bindings
In-Reply-To: <1415625137-4791-2-git-send-email-mikko.perttunen@kapsi.fi>
References: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
 <1415625137-4791-2-git-send-email-mikko.perttunen@kapsi.fi>
Message-ID: <5461AEB7.70507@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2014 10:12 PM, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
>
> Hardware-triggered thermal reset requires configuring the I2C
> reset procedure. This configuration is read from the device tree,
> so document the relevant properties in the binding documentation.
>
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Wei Ni <wni@nvidia.com>
> Tested-by: Wei Ni <wni@nvidia.com>
> ---
>   .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 24 ++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 68ac65f..dc13fb0 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -47,6 +47,21 @@ Required properties when nvidia,suspend-mode=<0>:
>     sleep mode, the warm boot code will restore some PLLs, clocks and then
>     bring up CPU0 for resuming the system.
>
> +Hardware-triggered thermal reset:
> +On Tegra30, Tegra114 and Tegra124, if the 'i2c-thermtrip' subnode exists,
> +hardware-triggered thermal reset will be enabled.
> +
> +Required properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'):
> +- nvidia,i2c-bus : Phandle to I2C bus containing the PMU
> +- nvidia,bus-addr : Bus address of the PMU on the I2C bus
> +- nvidia,reg-addr : I2C register address to write poweroff command to
> +- nvidia,reg-data : Poweroff command to write to PMU

This binding is taking two different routes to provide values to the driver:

1) It uses a phandle for i2c-bus (which must then be provided by another 
binding implemented in the two following patches)

2) It uses direct values for bus-addr, reg-addr and reg-data.

Do we need to use both approaches? bus-addr could just as well be 
obtained through a phandle to the i2c device and reading its reg 
property. From this phandle you could also go back up to the bus, making 
the i2c-bus property unnecessary. reg-addr and reg-data cannot be 
specified that way, obviously.

Actually I think I'd prefer to see i2c-bus become an integer property 
instead of a phandle, because at the end of the day it is a value field 
of a particular register and the reference is only used to retrieve that 
value. It is not like we are actually going to call functions on the bus 
instance or change its state. And for the single purpose of retrieving 
that value, this binding requires the addition of a new property on the 
bus node that will probably never be used for something else.

We can also imagine that some design may not have a PMIC device in the 
DT but still want to use the thermal reset feature. In this case, it is 
again preferable to use direct values.
