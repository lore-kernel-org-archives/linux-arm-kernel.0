From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 21 Oct 2015 21:18:45 +0200
Subject: [PATCH 0/6] ARM: sunxi: Introduce Allwinner H3 support
In-Reply-To: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
References: <1445444007-4260-1-git-send-email-jenskuske@gmail.com>
Message-ID: <5627E515.6050505@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

On 21-10-15 18:13, Jens Kuske wrote:
> Hi everyone,
>
> This is v3 of my patch series introducing basic kernel support for Allwinner's
> H3 SoC. It mainly adds basic clocks and pinctrl. It also adds interrupts,
> timers, watchdog, RTC, dmaengine, MMC and UARTs, which are mostly compatible
> to those in earlier SoCs like A23 and A31, and can simply be reused.
>
> These patches are based on Maxime's sunxi/for-next branch from
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git
>
>
> Patch 1 improves the sunxi divs clock to read the name of the base factor clock
> from devicetree instead of hardcoding it, which allows us to reuse sun6i-pll6
> for our pll8.
>
> Patch 2 adds support for the basic clocks.
>
> Patch 3 adds the pin sets for the H3 main PIO.
>
> Patch 4 adds a new compatible for the H3 reset controller
>
> Patch 5 adds the DTSI for the H3.
>
> Patch 6 adds a DTS for the Orange Pi Plus SBC, which these patches
> were developed and tested with.

Great to see that you've started working on this again. Last weekend I
ended up working on this too together with Reinder E.N. de Haan <reinder@mveas.com>
(added to the Cc).

We took a slightly different approach for the gates clocks, see:

https://github.com/jwrdegoede/linux-sunxi/commits/sunxi-wip

And specifically:

https://github.com/jwrdegoede/linux-sunxi/commit/80a1afe319d5d1a0c426d42e75d37f0c64e8ea0b

Combined with:

https://github.com/jwrdegoede/linux-sunxi/commit/d508da5feb5048f6674d6b24b58ac9058fb9d877

This deals with the per gate parents the same way the rockchip
clock code does, and it seems to be quite a bit less code then your solution.

So now we've two solutions to chose from :) Since you seem to be back to
working on this I'll refrain from doing any further work, at least
without coordinating. Maxime, can you let us know which solution for the
gates clock parents is best, or tell us if you think both solutions are
no good :)

(I wanted to get in touch with you about the work done this weekend,
but your posting of this v3 has sorta pre-empted that).

Other then the slightly different solution for the gates, the code in my tree
is a straight forward port of your v2.

Thanks for your work on this!

Regards,

Hans


p.s.

I'm teaching a kernel driver course at my local hackerspace in the netherlands:

https://revspace.nl/KernelDriverProgrammingCourse2015

Which is where our work on this this weekend originated. The next planned
course day is November 1st and I expect Reinder to be working on the H3
again then. I think the plan was to tackle USB next. Reinder can you confirm
this ?  If you (Jens) want to work on USB before then, that is fine, but please
coordinate their is plenty to do, so no need for us to be doing (more) double
work.







>
>
> Changes since v2:
> - add mbus clock
> - add Maxime's suggestion to take the substring up to the first "_" as name
>    for the divs base clock
> - use A31 pll6 for H3 pll6
> - use a clock similar to the new simple gates for H3 bus gates
> - drop the pinctrl-as-module patch since pinctrl and gpio don't seem to be
>    ready for removable drivers
> - documentation and machine support are merged already
>
> Changes since v1:
> - Update sunxi README in Documentation
> - Add the multiple parents gates and use them for bus-gates instead of
>    ahb1, ahb2, apb1 and apb2 gates
> - Merge the pll8 clock with sun6i pll6
> - Merge the ahb12, apb1 and apb2 resets to bus-resets with own compatible
> - Add sun6i_timer_init to sun8i machine
> - Remove the single SoC names from machine definition, its sun8i family
> - Make the pinctrl driver tristate and put its Kconfig entry in the right order
> - Rename pinctrl "scr" to "sim" and clock "sim" to "scr" to match user manual
> - Remove the address paragraph from GPL in dts and dtsi
> - Some style cleanup and line wrapping in dtsi
> - Add ARM architected timers
> - dmaengine isn't included anymore, it is merged already
>
> Best Regards,
> Jens
>
>
> Jens Kuske (6):
>    clk: sunxi: Let divs clocks read the base factor clock name from
>      devicetree
>    clk: sunxi: Add H3 clocks support
>    pinctrl: sunxi: Add H3 PIO controller support
>    reset: sunxi: Add compatible for Allwinner H3 bus resets
>    ARM: dts: sunxi: Add Allwinner H3 DTSI
>    ARM: dts: sun8i: Add Orange Pi Plus support
>
>   Documentation/devicetree/bindings/clock/sunxi.txt  |   2 +
>   .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +
>   .../bindings/reset/allwinner,sunxi-clock-reset.txt |   1 +
>   arch/arm/boot/dts/Makefile                         |   3 +-
>   arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  77 +++
>   arch/arm/boot/dts/sun8i-h3.dtsi                    | 499 ++++++++++++++++++++
>   drivers/clk/sunxi/Makefile                         |   1 +
>   drivers/clk/sunxi/clk-bus-gates.c                  | 105 +++++
>   drivers/clk/sunxi/clk-sunxi.c                      |  47 +-
>   drivers/pinctrl/sunxi/Kconfig                      |   4 +
>   drivers/pinctrl/sunxi/Makefile                     |   1 +
>   drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c           | 516 +++++++++++++++++++++
>   drivers/reset/reset-sunxi.c                        |   1 +
>   13 files changed, 1245 insertions(+), 13 deletions(-)
>   create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
>   create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
>   create mode 100644 drivers/clk/sunxi/clk-bus-gates.c
>   create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun8i-h3.c
>
