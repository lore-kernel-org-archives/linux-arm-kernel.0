From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Fri, 9 Oct 2015 16:16:40 +0200
Subject: [PATCH v3] arm-soc: Add support for Sigma Designs Tango4
In-Reply-To: <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
References: <560EAA7C.3070302@free.fr> <5124277.UR9sg1IOHT@wuerfel>
 <560EFDB3.9010305@free.fr> <11113740.WL812ZaRcZ@wuerfel>
 <5612A473.8030405@sigmadesigns.com> <5613EF4C.30603@sigmadesigns.com>
 <CAL_JsqJ+WTBYF=sJWbkgNzL48H5AiXL4aoVV3DNiL6T_UQKQfg@mail.gmail.com>
Message-ID: <5617CC48.2020904@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 16:08, Rob Herring wrote:

> Marc Gonzalez wrote:
>
>> This patch adds support for Sigma Designs "Tango4" platform, which is
>> built around the ARM Cortex A9 MPCore (single and dual core SoCs).
>>
>> Tango4 is not to be confused with Tango3, which was built around a
>> MIPS 74kf CPU.
>>
>> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
>> ---
>> v3 changes: Updated clock tree DT (clk driver submitted)
>> ---
>>  arch/arm/Kconfig                          |   2 +
>>  arch/arm/Makefile                         |   1 +
>>  arch/arm/boot/dts/Makefile                |   2 +
>>  arch/arm/boot/dts/tango4-vantage-1172.dts |  17 ++++
>>  arch/arm/boot/dts/tango4.dtsi             | 133 ++++++++++++++++++++++++++++++
>>  arch/arm/mach-tangox/Kconfig              |  11 +++
>>  arch/arm/mach-tangox/Makefile             |   1 +
>>  arch/arm/mach-tangox/setup.c              |   7 ++
>>  8 files changed, 174 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
>>  create mode 100644 arch/arm/boot/dts/tango4.dtsi
>>  create mode 100644 arch/arm/mach-tangox/Kconfig
>>  create mode 100644 arch/arm/mach-tangox/Makefile
>>  create mode 100644 arch/arm/mach-tangox/setup.c
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index 1c5021002fe4..94a1a0277c94 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -934,6 +934,8 @@ source "arch/arm/mach-sunxi/Kconfig"
>>
>>  source "arch/arm/mach-prima2/Kconfig"
>>
>> +source "arch/arm/mach-tangox/Kconfig"
>> +
>>  source "arch/arm/mach-tegra/Kconfig"
>>
>>  source "arch/arm/mach-u300/Kconfig"
>> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
>> index 7451b447cc2d..7fcb4c63cdf7 100644
>> --- a/arch/arm/Makefile
>> +++ b/arch/arm/Makefile
>> @@ -203,6 +203,7 @@ machine-$(CONFIG_ARCH_SOCFPGA)              += socfpga
>>  machine-$(CONFIG_ARCH_STI)             += sti
>>  machine-$(CONFIG_ARCH_STM32)           += stm32
>>  machine-$(CONFIG_ARCH_SUNXI)           += sunxi
>> +machine-$(CONFIG_ARCH_TANGOX)          += tangox
>>  machine-$(CONFIG_ARCH_TEGRA)           += tegra
>>  machine-$(CONFIG_ARCH_U300)            += u300
>>  machine-$(CONFIG_ARCH_U8500)           += ux500
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 246473a244f6..2499295051d5 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -605,6 +605,8 @@ dtb-$(CONFIG_MACH_SUN8I) += \
>>  dtb-$(CONFIG_MACH_SUN9I) += \
>>         sun9i-a80-optimus.dtb \
>>         sun9i-a80-cubieboard4.dtb
>> +dtb-$(CONFIG_ARCH_TANGOX) += \
>> +       tango4-vantage-1172.dtb
>>  dtb-$(CONFIG_ARCH_TEGRA_2x_SOC) += \
>>         tegra20-harmony.dtb \
>>         tegra20-iris-512.dtb \
>> diff --git a/arch/arm/boot/dts/tango4-vantage-1172.dts b/arch/arm/boot/dts/tango4-vantage-1172.dts
>> new file mode 100644
>> index 000000000000..3eff944e2103
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tango4-vantage-1172.dts
>> @@ -0,0 +1,17 @@
>> +/dts-v1/;
>> +
>> +#include "tango4.dtsi"
>> +
>> +/ {
>> +       model = "Sigma Designs SMP8758 Vantage-1172 dev board";
>> +       compatible = "sigma,vantage-1172", "sigma,smp8758", "sigma,tango4";
>> +
>> +       chosen {
>> +               stdout-path = &uart;
>> +       };
>> +};
>> +
>> +&eth0 {
>> +       phy-connection-type = "rgmii";
>> +       max-speed = <1000>;
>> +};
>> diff --git a/arch/arm/boot/dts/tango4.dtsi b/arch/arm/boot/dts/tango4.dtsi
>> new file mode 100644
>> index 000000000000..c682617866e9
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/tango4.dtsi
>> @@ -0,0 +1,133 @@
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/ {
>> +       compatible = "sigma,tango4";
>> +
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
> 
> No memory node?
> 
> cpus node?
> 
> No pl310? A9 performance mon?

Can't these nodes be added at a later time?

Regards.
