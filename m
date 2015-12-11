From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 11 Dec 2015 22:29:13 +0100
Subject: [PATCH v3 0/5] Add reboot notifier driver for rockchip platform
In-Reply-To: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
References: <1447840044-19689-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <45323116.BWNAaZT5p4@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 18. November 2015, 17:47:24 schrieb Andy Yan:
> rockchip platform have a protocol to pass the kernel reboot
> mode to bootloader by some special registers when system reboot.
> By this way the bootloader can take different action according
> to the different kernel reboot mode, for example, command
> "reboot loader" will reboot the board to rockusb mode, this is
> a very convenient way to get the board enter download mode.
> And Android system also use this protocol to pass "recovery"?
> ?fastboot? reboot mode to bootloader. In upstream land, We found
> tegra platform also use this mechanism.
> 
> Before this version, I have sent two Series, which can be found
> at [0] [1]
> [0] https://patchwork.kernel.org/patch/7140751/
> [1] https://patchwork.kernel.org/patch/7153531/

just so it doesn't get lost, this ties into a slightly more generic approach, 
John Stultz is doing for the android reboot reasons:

http://thread.gmane.org/gmane.linux.kernel/2103447

The only difference is that we'd need to use the pmu syscon for it.



> Changes in v3:
>  - rename a pinctrl node in rk3288-veyron, the original name will be
>    used in the incoming reboot notifier driver
>  - add dt binding
>  - move from mach-rockchip to drivers/soc/rockchip, as the tegra does
>  - use dts pass the related register
>  - add DT node
> 
> Changes in v2:
>   - check cpu dt node
>   - remove a unnecessary of_put_node in function rockchip_get_pmu_regmap
>   - fix a align issue
>   - use reboot_notifier instead of restart_handler
> 
> Andy Yan (5):
>   ARM: dts: rockchip: rk3288-veyron: rename pinctrl node reboot to reset
>   dt-bindings: soc: add document for rockchip reboot notifier driver
>   soc: rockchip: add reboot notifier driver
>   ARM: dts: rockchip: add reboot node
>   ARM64: dts: rockchip: add reboot node
> 
>  .../bindings/soc/rockchip/rockchip-reboot.txt      | 18 ++++
>  arch/arm/boot/dts/rk3288-veyron.dtsi               |  2 +-
>  arch/arm/boot/dts/rk3288.dtsi                      |  6 ++
>  arch/arm/boot/dts/rk3xxx.dtsi                      |  6 ++
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  6 ++
>  drivers/soc/rockchip/Kconfig                       |  7 ++
>  drivers/soc/rockchip/Makefile                      |  1 +
>  drivers/soc/rockchip/loader.h                      | 22 +++++
>  drivers/soc/rockchip/reboot.c                      | 98
> ++++++++++++++++++++++ 9 files changed, 165 insertions(+), 1 deletion(-)
>  create mode 100644
> Documentation/devicetree/bindings/soc/rockchip/rockchip-reboot.txt create
> mode 100644 drivers/soc/rockchip/loader.h
>  create mode 100644 drivers/soc/rockchip/reboot.c
