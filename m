From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 10:54:36 -0600
Subject: [PATCH 2/6] ARM: tegra20: convert device tree files to use CLK
 defines
In-Reply-To: <1368443225-16978-3-git-send-email-hdoyu@nvidia.com>
References: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
 <1368443225-16978-3-git-send-email-hdoyu@nvidia.com>
Message-ID: <51911ACC.5010507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 05:07 AM, Hiroshi Doyu wrote:
> Replace magic number in tegra_car:
> 
> -               clocks = <&tegra_car 28>;
> +               clocks = <&tegra_car CLK_HOST1X>;

Patches 2, 4, 6 look basically fine. I'd also like slightly more
explanation in the commit description here. How about:

=====
Use the Tegra20 CAR binding header (tegra20-car.h) to replace magic
numbers in the device tree. For example,

-               clocks = <&tegra_car 28>;
+               clocks = <&tegra_car CLK_HOST1X>;
=====

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

>  #include <dt-bindings/gpio/tegra-gpio.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clk/tegra20-car.h>

Can we keep the include files sorted?

One dependency issue with patches 2: There is a series of USB patches
(which Venu posted in the last couple of days) that fix the USB binding
to be complete. These will change the set of clocks referenced by the
EHCI and USB PHY nodes. I would like Venu's patches to be applied first,
since those DT changes will need to be merged into the USB tree so that
the USB tree can apply the subsequent driver changes. Can you hold off
on reposting your series until after I've applied Venu's changes, and
rebase this series on top of them? Hopefully it shouldn't take too long
to get Venu's series applied. Thanks.
