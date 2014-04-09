From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 9 Apr 2014 22:53:13 +0800
Subject: [PATCH 00/15] ARM: sunxi: add A31 PL pins support
In-Reply-To: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397051478-4113-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAGb2v66XCN2ar1wj+a1+ZwdcdJ3gzJ+nDiO9bu52OwK+mBB_Hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Wed, Apr 9, 2014 at 9:51 PM, Boris BREZILLON
<boris.brezillon@free-electrons.com> wrote:
> Hello,
>
> This series rework the sunxi pinctrl driver to support the PLx pins
> available on the A31 SoC.

Thanks for working on this. I mentioned to Maxime on IRC yesterday that
we have complete pinctrl drivers for both A31 and A23, based on our current
pinctrl-sunxi driver, in the A23 SDK. These have the complete pin mapping.

> It also add missing A31 reset controller DT bindings documentation.
>
> I need those PL pins (actually I only need PL0 and PL1) to support
> the P2WI bus, which in turn is used to communicate with the AXP221
> PMIC.

If you could, please add all the PL and PM pins.
As I said, you can find complete definitions in the A23 SDK.

> Let me know if these changes are too intrusive.

I wonder if we should do a separate driver for the new PIO controller.
Clearly it's a separate IP block, with it's own clock and reset controls.

Allwinner sources list this block as "R_PIO". I suggest using this name.
Clearly "pioL" does not cover all the functionality.

I have started to document the PRCM block: http://linux-sunxi.org/PRCM

Last, please send the patches to the linux-sunxi mailing list as well.
At the very least, Hans will see them and add them to sunxi-devel branch.


Cheers,
ChenYu

> Best Regards,
>
> Boris
>
> Boris BREZILLON (15):
>   ARM: sunxi: dt: list all pinctrl compatible strings
>   ARM: sunxi: dt: document pinctrl clock related properties
>   ARM: sunxi: dt: add pinctrl clock-names properties
>   pinctrl: sunxi: specify clk name when retrieving pinctrl pio clk
>   clk: sunxi: add A31 APB0 clk gate defintions
>   clk: sunxi: add A31 APB0 gates compatible string to the documentation
>   ARM: sunxi: dt: define A31's APB0 clk gates node
>   reset: sunxi: document sunxi's reset controllers bindings
>   clk: sunxi: add A31 APB0 reset line defintions
>   pinctrl: sunxi: add PL pin definitions
>   pinctrl: sunxi: add support for A31 PL pins
>   pinctrl: sunxi: retrieve and enable PL clk gate for A31 SoC
>   pinctrl: sunxi: retrieve and enable PL reset line for A31 SoC
>   pinctrl: sunxi: define A31 PL0/PL1 pins
>   ARM: sunxi: dt: add support for A31's PL pins
>
>  Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |  13 +-
>  .../bindings/reset/allwinner,sunxi-clock-reset.txt |  21 +++
>  arch/arm/boot/dts/sun4i-a10.dtsi                   |   1 +
>  arch/arm/boot/dts/sun5i-a10s.dtsi                  |   1 +
>  arch/arm/boot/dts/sun5i-a13.dtsi                   |   1 +
>  arch/arm/boot/dts/sun6i-a31.dtsi                   |  25 ++-
>  arch/arm/boot/dts/sun7i-a20.dtsi                   |   1 +
>  drivers/clk/sunxi/clk-sunxi.c                      |   5 +
>  drivers/pinctrl/pinctrl-sunxi-pins.h               |   8 +
>  drivers/pinctrl/pinctrl-sunxi.c                    | 205 +++++++++++++++------
>  drivers/pinctrl/pinctrl-sunxi.h                    |  39 +++-
>  12 files changed, 264 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt
>
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
