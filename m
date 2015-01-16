From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 16 Jan 2015 09:08:49 +0800
Subject: [PATCH v8 0/6] mfd: AXP20x: Add support for AXP202 and AXP209
In-Reply-To: <1419303194-3075-1-git-send-email-wens@csie.org>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
Message-ID: <CAGb2v66PiN334hvDMD2GrEOnqxvVzun0V3seeWCz-g9ZNLahTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 10:53 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> Hi everyone,
>
> This is v8 of the AXP20x PMIC patches. These are the remaining patches
> of the original series: PEK (power button) input driver, binding docs,
> and defconfig updates.
>
> Mark raised some questions during v7 about the first patch, specifically
> about the "x-powers,dcdc-workmode" property. I've expanded the regulator
> parts of the DT bindings doc. Mark, if you could take a look and give us
> your blessing?
>
> Dmitry, you were OK with the input bits going through the MFD tree, is
> that still the case?
>
> If there are no more problems, maybe Lee could take patches 1~4, and
> Maxime can take the defconfig patches through his tree.

Hi Lee,

Can we get the last remaining patches (1 & 2) merged?

Thanks
ChenYu

> Thanks
> ChenYu
>
>
> Changes since v7:
>
>         - DT bindings
>           * Clarified the AXP's interrupt source
>           * Added explaination for "x-powers,dcdc-workmode" property
>           * Made regulator supply properties optional. They can be omitted
>             when the input is unregulated, as is the case when they are
>             connected to the IPSOUT output on the PMIC.
>           * Used real world example (Cubieboard2) for regulator nodes
>
>         - Fixed paths for PEK sysfs entries.
>
>         - PEK driver
>           * Made axp20x_pek_remove() in PEK driver static.
>           * Removed driver owner field.
>           * Wrapped some lines over 80 characters.
>
>
> Original cover letter from v7:
>
>
> During the merging of v6 several patches were left out. This v7 comprises
> all the patches that are still pending.
>
> //--
>
> AXP209 and AXP202 are the PMUs (Power Management Unit) used by A10, A13
> and A20 SoCs and developed by X-Powers, a sister company of Allwinner.
> AXP20x comprises an adaptive USB-Compatible PWM charger, 2 BUCK DC-DC
> converters, 5 LDOs, multiple 12-bit ADCs of voltage, current and temperature
> as well as 4 configurable GPIOs.
>
> This set of patches introduces the core driver and support for two different
> subsystems:
>         - Regulators
>         - PEK (Power Enable Key)
>
> Changes since v1:
>
>         - Added a new standalone patch for defconfig
>
>         - MFD core:
>           * Removed axp,system-power-controller property
>
>         - Bindings documentation:
>           * Corrected description for dcdc-workmode property
>           * Removed unused axp20x-pek compatible
>
>         - Input misc PEK driver:
>           * Fixed seconds in lower case
>
>         - Regulators subsystem:
>           * Fixed axp20x_set_suspend_voltage()
>           * Switched to using multi-bit control for regulators
>           * When "regulators" node is not found driver doesn't quit
>           * Driver is now using devm_regulator_register()
>           * Added module_platform_driver() instead of subsys_initcall()
>
>         - DT:
>           * Added new DTSI for AXP209
>           * Added support for cubietruck and olinuxino-micro
>
> Changes since v2:
>
>         - Added a new patch for multi_v7_defconfig to enable MFD core
>           and subsystems
>
>         - DT:
>           * Dropped axp,system-power-controller property from DTS
>           * Moved compatible and interrupt-related properties from the
>             DTSI file to the DTS board files
>
>         - Regulators subsystem:
>           * Deleted useless struct axp20x_regulators
>           * Added a warning when out of specs values are used for the
>             dcdc frequency
>
>         - MFD core:
>           * Fixed coding style
>           * Removed IDs from device table for i2c
>
>         - Bindings documentation:
>           * Several corrections and fixes
>
> Changes since v3:
>
>         - Removed x-powers-axp209.dtsi file
>         - Rewritten bindings document
>
>         - MFD core:
>           * Fixed casting
>           * Better comments / documentation
>
>         - Input misc PEK driver:
>           * Timings are now expressed in ms and the sysfs appies the
>             closest possible value
>           * No more useless pretty-printing
>           * Removed devm_request_threaded_irq in favour of
>             devm_request_any_context_irq
>           * Moved from input attributes to platform device attributes
>
>         - Regulators subsystem:
>           * Removed suspend mode (axp20x_set_suspend_voltage)
>           * Added regulators input supply
>
>         - DT:
>           * DTs doesn't include anymore the dtsi
>           * Added input supplies for regulators
>
> Changes since v4:
>
>         - Removed regulator patches already applied / acked by Mark Brown
>
>         - Input misc PEK driver:
>           * Don't print anymore the "us" unit
>           * Added cleanup for attributes when unbindind the device
>           * Fixed error code returned when device_create_file() fails
>
>         - DT:
>           * Enable all the regulators on at boot-time
>           * Removed min and max microvolts for all the regulators but DCDC2
>           * Moved the axp_ipsout regulator outside the MFD node
>
>         - MFD core:
>           * The supply regulators are now specified in the MFD driver using
>             regulator_bulk_register_supply_alias() and the .parent_supplies
>             in the MFD cell
>
> Changes since v5:
>         - Added ACKs
>         - Fixed compilation warning (reported by Hans De Goede)
>         - Vendor-prefixes are now sorted
>         - Removed DT patch
>
>
> Carlo Caione (6):
>   mfd: AXP20x: Add bindings documentation
>   dt-bindings: add vendor-prefix for X-Powers
>   input: misc: Add driver for AXP20x Power Enable Key
>   input: misc: Add ABI docs for AXP20x PEK
>   ARM: sunxi: Add AXP20x support in defconfig
>   ARM: sunxi: Add AXP20x support multi_v7_defconfig
>
>  .../ABI/testing/sysfs-driver-input-axp-pek         |  11 +
>  Documentation/devicetree/bindings/mfd/axp20x.txt   |  97 +++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/configs/multi_v7_defconfig                |   3 +
>  arch/arm/configs/sunxi_defconfig                   |   3 +
>  drivers/input/misc/Kconfig                         |  11 +
>  drivers/input/misc/Makefile                        |   1 +
>  drivers/input/misc/axp20x-pek.c                    | 282 +++++++++++++++++++++
>  8 files changed, 409 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pek
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>  create mode 100644 drivers/input/misc/axp20x-pek.c
>
> --
> 2.1.4
>
