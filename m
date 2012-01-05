From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 5 Jan 2012 13:17:36 +0000
Subject: [PATCH 5/6] gpio: tegra: Dynamically allocate IRQ base, and
 support DT
In-Reply-To: <1325702378-20863-5-git-send-email-swarren@nvidia.com>
References: <1325702378-20863-1-git-send-email-swarren@nvidia.com>
 <1325702378-20863-5-git-send-email-swarren@nvidia.com>
Message-ID: <20120105131736.GC4641@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Jan 04, 2012 at 11:39:37AM -0700, Stephen Warren wrote:
> Enhance the driver to dynamically allocate the base IRQ number, and
> create an IRQ domain for itself. The use of an IRQ domain ensures that
> any device tree node interrupts properties are correctly parsed.
> 
> Describe interrupt-related properties in the device tree binding docs,
> and the contents of "child" node interrupts property.
> 
> Update tegra*.dtsi to specify the required interrupt-related properties.
> 
> Finally, remove the definition of TEGRA_GPIO_TO_IRQ; this macro no longer
> gives correct results since the IRQ numbers for GPIOs are dynamically
> allocated.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch depends on:
> http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm.git
> devel-stable c87fb57346fc7653ace98769f148e0dcd88ac1ee
> ---
>  .../devicetree/bindings/gpio/gpio_nvidia.txt       |   12 +++++++++
>  arch/arm/boot/dts/tegra20.dtsi                     |    2 +
>  arch/arm/boot/dts/tegra30.dtsi                     |    2 +
>  arch/arm/mach-tegra/include/mach/gpio-tegra.h      |    2 -
>  drivers/gpio/gpio-tegra.c                          |   25 ++++++++++++++-----
>  5 files changed, 34 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> index 50b363c..d114e19 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
> @@ -8,6 +8,16 @@ Required properties:
>    second cell is used to specify optional parameters:
>    - bit 0 specifies polarity (0 for normal, 1 for inverted)
>  - gpio-controller : Marks the device node as a GPIO controller.
> +- #interrupt-cells : Should be 2.
> +  The first cell is the GPIO number.
> +  The second cell is used to specify flags:
> +    bits[3:0] trigger type and level flags:
> +      1 = low-to-high edge triggered.
> +      2 = high-to-low edge triggered.
> +      4 = active high level-sensitive.
> +      8 = active low level-sensitive.
> +      Valid combinations are 1, 2, 3, 4, 8.

It looks to me like the tegra gpio driver can do IRQ_TYPE_EDGE_BOTH so I 
would expect 12 to be a valid combination too no?

Jamie
