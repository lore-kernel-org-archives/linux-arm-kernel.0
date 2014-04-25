From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 25 Apr 2014 22:55:36 +0200
Subject: [PATCH v2 1/5] ARM: dts: Add syscon handle in pmu node for
 exynos5250
In-Reply-To: <1398426857-5097-2-git-send-email-pankaj.dubey@samsung.com>
References: <1396425778-4379-1-git-send-email-pankaj.dubey@samsung.com>
 <1398426857-5097-1-git-send-email-pankaj.dubey@samsung.com>
 <1398426857-5097-2-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <535ACBC8.5090703@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pankaj,

On 25.04.2014 13:54, Pankaj Dubey wrote:
> Add "samsung,syscon-phandle" property pointing to PMU node
> to access PMU register via PMU regmap handle.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5250.dtsi |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 3742331..52801af 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -173,6 +173,7 @@
>   	pmu_system_controller: system-controller at 10040000 {
>   		compatible = "samsung,exynos5250-pmu", "syscon";
>   		reg = <0x10040000 0x5000>;
> +		samsung,syscon-phandle = <&pmu_system_controller>;
>   	};
>
>   	watchdog at 101D0000 {
>

This looks strange. A node that refers back to itself. If I understand 
correctly, you are relying on the fact that if you don't use 
platform_driver model for the PMU driver, it won't bind to this node and 
instead the generic syscon driver will. I'm afraid this is incorrect, 
because the PMU driver should normally use the driver model.

I see two possible options to solve this problem:

1) Instead, the PMU driver should bind to this node and become a syscon 
provider. This will require a small change in the syscon API, which 
would be reasonable anyway:

  a) instead of using driver_find_device() and dev_get_drvdata() in 
syscon_node_to_regmap(), a local list of syscon structs should be kept 
in this driver and then the look-up would just iterate over this list, 
that could contain external syscon implementations as well,

  b) syscon_register() function should be provided to register an 
external syscon provider from other drivers, like Exynos PMU driver.

Another solution would be:

2) Register a static platform device from Exynos PMU driver, with 
.of_node set to PMU node and .name to "syscon" to instantiate the syscon 
device and create a syscon provider, even though the PMU driver would be 
bound to the node.

The change mentioned in point 1.a) should be implemented regardless of 
which solution is chosen, as iterating over all devices in the system 
and relying on their driver_data is rather a poor practice. A local list 
would be faster - all syscons to iterate over, instead of all devices in 
the system, and more flexible - a single device could be a provider of 
multiple resources.

As for the solution for Exynos PMU itself, I tend to prefer 2), as it 
wouldn't require additional functions exported from the syscon driver.

Best regards,
Tomasz
