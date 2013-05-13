From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 May 2013 10:46:27 -0600
Subject: [PATCH 1/6] ARM: tegra20: create a DT header defining CLK IDs
In-Reply-To: <1368443225-16978-2-git-send-email-hdoyu@nvidia.com>
References: <1368443225-16978-1-git-send-email-hdoyu@nvidia.com>
 <1368443225-16978-2-git-send-email-hdoyu@nvidia.com>
Message-ID: <519118E3.4060907@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2013 05:07 AM, Hiroshi Doyu wrote:
> To replace magic number in tegra_car:
> 
> -               clocks = <&tegra_car 28>;
> +               clocks = <&tegra_car CLK_HOST1X>;

I'd like slightly more description of the change here. What about:

=====
Create a header file to define the clock IDs used by the Tegra20 clock
binding. Remove the list of definitions from the binding documentation,
and refer the reader to the header file.

This will allow the same header to be used by both device tree files,
and drivers implementing this binding, which guarantees that the two
stay in sync. This also makes device trees more readable by using names
instead of magic numbers.
=====

I'm not sure exactly how these patches will get merged. For you
reference, I anticipate one of two things happening:

1)

* Patches 1, 3, 5 get put into a topic branch, and merged into both the
clk tree and the Tegra tree.

* Patches 2, 4, 6 get merged into the Tegra tree.

* The patches you're going to create for the drivers/clk code get merged
into Mike's clk tree

2)

* Mike ack's the patches you're going to create for the drivers/clk code.

* Everything gets merged through the Tegra tree.

This shouldn't impact you much, but just be aware that the drivers/clk
changes you create shouldn't depend on anything beyond patches 1, 3, 5
here and 3.10-rc1, then I can work out the merging with Mike without any
constraints.

> diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.txt

>  This binding uses the common clock binding:
>  Documentation/devicetree/bindings/clock/clock-bindings.txt
>  
> +You can find the actual assignment in "dt-bindings/clk/tegra20-car.h"

Can you move this text down into the description of clock-cells, i.e.
where you removed the original list of IDs? That'll keep the text in the
place it's most useful. I would also like to explicitly mention "include
file" and use <> rather than "", since that matches the syntax that
should be used in .dts files, i.e.:

=====
 - #clock-cells : Should be 1.
   In clock consumers, this cell represents the clock ID exposed by the
   CAR. The assignments may be found in header file
   <dt-bindings/clk/tegra20-car.h>.
=====

Similar comments for patches 3 and 5.
