From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 13 Aug 2014 09:35:44 +0200
Subject: [PATCH 1/3] of: Add descriptions of thermtrip properties to
 Tegra PMC bindings
In-Reply-To: <1407226380-747-2-git-send-email-mperttunen@nvidia.com>
References: <1407226380-747-1-git-send-email-mperttunen@nvidia.com>
 <1407226380-747-2-git-send-email-mperttunen@nvidia.com>
Message-ID: <20140813073541.GA17466@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 05, 2014 at 11:12:58AM +0300, Mikko Perttunen wrote:
> Hardware-triggered thermal reset requires configuring the I2C
> reset procedure. This configuration is read from the device tree,
> so document the relevant properties in the binding documentation.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  .../devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt    | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> index 68ac65f..140e2aa 100644
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
> @@ -38,6 +38,19 @@ Required properties when nvidia,suspend-mode is specified:
>  			      Core power good time in uS.
>  - nvidia,core-pwr-off-time : Core power off time in uS.
>  
> +Required properties for hardware-triggered thermal reset:
> +    (only tegra30, tegra114, tegra124)
> +- nvidia,thermtrip-pmu-i2c-addr : I2C address of the power management unit.
> +- nvidia,thermtrip-i2c-controller : Index of the I2C controller the PMU is
> +                                    attached to.

This duplicates information already associated with the PMU device. Can
this be turned into something like:

	nvidia,thermtrip-pmu: phandle to Power Management Unit

Then we can query the relevant information from the I2C client resolved
from the phandle.

One problem with that might be that the I2C controller index may not
match the hardware ID.

> +- nvidia,thermtrip-reg-addr : Address (byte) to send reset command to.
> +- nvidia,thermtrip-reg-data : Data (byte) to use as reset command.
> +
> +Optional properties for hardware-triggered thermal reset:
> +    (only tegra30, tegra114, tegra124)
> +- nvidia,thermtrip-pinmux : Pinmux ID used for I2C access.

I suppose this takes a phandle? If so the description should probably
say so.

> +- nvidia,thermtrip-pmu-16bit-ops : Use 16-bit operations.

What exactly does "16-bit operations" mean? And isn't this a property of
the I2C device, therefore could be queried from the I2C slave via the
phandle?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140813/edf4791e/attachment.sig>
