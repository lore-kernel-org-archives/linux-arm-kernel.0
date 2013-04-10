From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 10 Apr 2013 11:23:13 -0600
Subject: [PATCH 1/3] ARM: tegra: pcie: Add tegra3 support
In-Reply-To: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
References: <1365435688-4179-1-git-send-email-jagarwal@nvidia.com>
Message-ID: <5165A001.9030408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/2013 09:41 AM, Jay Agarwal wrote:
> Signed-off-by: Jay Agarwal <jagarwal@nvidia.com>
> 
> - Enable pcie root port 2 for cardhu
> - Make private data structure for each SOC
> - Add required tegra3 clocks and regulators
> - Add tegra3 specific code in enable controller
> - Modify clock tree to get clocks based on device
> - Based on git://gitorious.org/thierryreding/linux.git

Did you test these patches? They don't work for me on my Cardhu A04.

First off, I had to change the num-lanes properties to match Cardhu's
actual configuration:

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> index d64d12c..6426226 100644
> --- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
> +++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
> @@ -143,8 +143,17 @@
>                 vdd-supply = <&ldo1_reg>;
>                 avdd-supply = <&ldo2_reg>;
>  
> +               pci at 1,0 {
> +                       nvidia,num-lanes = <4>;
> +               };
> +
> +               pci at 2,0 {
> +                       nvidia,num-lanes = <1>;
> +               };
> +
>                 pci at 3,0 {
>                         status = "okay";
> +                       nvidia,num-lanes = <1>;
>                 };
>         };
>  

However, even after doing that, the driver doesn't detect anything
attached to port at 3,0, even though I have the board plugged into the
docking station, and hence the PCI Ethernet should be detected:

> [    3.103860] tegra-pcie 3000.pcie-controller: 4x1, 1x2 configuration
> [    3.113755] tegra-pcie 3000.pcie-controller: probing port 2, using 1 lanes
> [    3.324364] tegra-pcie 3000.pcie-controller: link 2 down, retrying
> [    3.534249] tegra-pcie 3000.pcie-controller: link 2 down, retrying
> [    3.744160] tegra-pcie 3000.pcie-controller: link 2 down, retrying
> [    3.751359] tegra-pcie 3000.pcie-controller: link 2 down, ignoring

(I see the same messages even without fixing the lane configuration,
exception for the first configuration message obviously prints something
different).

Are you testing with U-Boot, or using our binary bootloader? Upstream
code must be tested with U-Boot, to make sure it doesn't rely on any HW
programming performed by the bootloader.
