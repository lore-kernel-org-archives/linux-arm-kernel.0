From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Tue, 13 Nov 2012 06:03:20 +0900
Subject: [PATCH 1/2] ARM: kirkwood: Add Plat'Home OpenBlocks A6 support
In-Reply-To: <20121112120535.GA22029@lunn.ch>
References: <1352720819-21923-1-git-send-email-iwamatsu@nigauri.org>
 <20121112120535.GA22029@lunn.ch>
Message-ID: <CABMQnVK5SbT5mbugruZdNursXQiWJOQD4sreEMS1v6GO7PH0mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andrew.

Thank you for your review.

On Mon, Nov 12, 2012 at 9:05 PM, Andrew Lunn <andrew@lunn.ch> wrote:
> Hi Nobuhiro
>
> This is a good start. A few comments below.
>
> On Mon, Nov 12, 2012 at 08:46:59PM +0900, Nobuhiro Iwamatsu wrote:
>> Add support for Plat'Home OpenBlocks A6 using the device tree
>> where possible.
>> This commit supports SATA, USB, ether and serial console.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> ---
>>  arch/arm/boot/dts/Makefile                   |    3 +-
>>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   39 ++++++++++++
>>  arch/arm/configs/kirkwood_defconfig          |    1 +
>>  arch/arm/mach-kirkwood/Kconfig               |    7 +++
>>  arch/arm/mach-kirkwood/Makefile              |    1 +
>>  arch/arm/mach-kirkwood/board-dt.c            |    4 ++
>>  arch/arm/mach-kirkwood/board-openblocks_a6.c |   86 ++++++++++++++++++++++++++
>>  arch/arm/mach-kirkwood/common.h              |    6 ++
>>  8 files changed, 146 insertions(+), 1 deletion(-)
>>  create mode 100644 arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>>  create mode 100644 arch/arm/mach-kirkwood/board-openblocks_a6.c
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b994045..ce053a4 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -41,7 +41,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
>>       kirkwood-lschlv2.dtb \
>>       kirkwood-lsxhl.dtb \
>>       kirkwood-ts219-6281.dtb \
>> -     kirkwood-ts219-6282.dtb
>> +     kirkwood-ts219-6282.dtb \
>> +     kirkwood-openblocks_a6.dtb
>>  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>>       msm8960-cdp.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>> new file mode 100644
>> index 0000000..6493edc
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
>> @@ -0,0 +1,39 @@
>> +/dts-v1/;
>> +
>> +/include/ "kirkwood.dtsi"
>> +
>> +/ {
>> +     model = "Plat'Home OpenBlocksA6";
>> +     compatible = "plathome,openblocks-a6", "marvell,kirkwood-88f6283", "marvell,kirkwood";
>
> Ah, interesting. A 88f6283. I'm a bit surprised this actually works!
> This variant is not listed in kirkwood_id(). So do you see messages
> like:
>
> "Device-Unknown"
>
> and
>
> "MPP setup: unknown kirkwood variant"

No, I can not see these message.
88f6283 is same as MV88F6282-Rev-A1. Because this has same CPU ID as
MV88F6282-Rev-A1.
What kind of value should I set here?
>
>> +
>> +     memory {
>> +             device_type = "memory";
>> +             reg = <0x00000000 0x20000000>;
>> +     };
>> +
>> +     chosen {
>> +             bootargs = "console=ttyS0,115200n8 earlyprintk root=/dev/nfs ip=bootp";
>
> Please remove root=/dev/nfs and ip=bootp. We want the box to boot on
> its own without help from the network.
>

This is my mistake.
I will fix.

>> +     };
>> +
>> +     ocp at f1000000 {
>> +             serial at 12000 {
>> +                     clock-frequency = <200000000>;
>> +                     status = "ok";
>> +             };
>> +
>> +             serial at 12100 {
>> +                     clock-frequency = <200000000>;
>> +                     status = "ok";
>> +             };
>> +
>> +             nand at 3000000 {
>> +                     chip-delay = <25>;
>> +                     status = "ok";
>> +             };
>> +
>> +             sata at 80000 {
>> +                     nr-ports = <1>;
>> +                     status = "okay";
>> +             };
>> +     };
>> +};
>> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
>> index 74eee0c..8b5988c 100644
>> --- a/arch/arm/configs/kirkwood_defconfig
>> +++ b/arch/arm/configs/kirkwood_defconfig
>> @@ -27,6 +27,7 @@ CONFIG_MACH_GOFLEXNET_DT=y
>>  CONFIG_MACH_LSXL_DT=y
>>  CONFIG_MACH_IOMEGA_IX2_200_DT=y
>>  CONFIG_MACH_KM_KIRKWOOD_DT=y
>> +CONFIG_MACH_OPENBLOCKS_A6_DT=y
>>  CONFIG_MACH_TS219=y
>>  CONFIG_MACH_TS41X=y
>>  CONFIG_MACH_DOCKSTAR=y
>> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
>> index 50bca50..830bb5c 100644
>> --- a/arch/arm/mach-kirkwood/Kconfig
>> +++ b/arch/arm/mach-kirkwood/Kconfig
>> @@ -130,6 +130,13 @@ config MACH_KM_KIRKWOOD_DT
>>         Say 'Y' here if you want your kernel to support the
>>         Keymile Kirkwood Reference Desgin, using Flattened Device Tree.
>>
>> +config MACH_OPENBLOCKS_A6_DT
>> +     bool "Plat'Home OpenBlocks A6 (Flattened Device Tree)"
>> +     select ARCH_KIRKWOOD_DT
>> +     help
>> +       Say 'Y' here if you want your kernel to support the
>> +       Plat'Home OpenBlocks A6 (Flattened Device Tree).
>> +
>>  config MACH_TS219
>>       bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
>>       help
>> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
>> index 294779f..ee38f9d 100644
>> --- a/arch/arm/mach-kirkwood/Makefile
>> +++ b/arch/arm/mach-kirkwood/Makefile
>> @@ -31,3 +31,4 @@ obj-$(CONFIG_MACH_GOFLEXNET_DT)             += board-goflexnet.o
>>  obj-$(CONFIG_MACH_LSXL_DT)           += board-lsxl.o
>>  obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT) += board-iomega_ix2_200.o
>>  obj-$(CONFIG_MACH_KM_KIRKWOOD_DT)    += board-km_kirkwood.o
>> +obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)  += board-openblocks_a6.o
>> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
>> index d94872f..c3aa0e2 100644
>> --- a/arch/arm/mach-kirkwood/board-dt.c
>> +++ b/arch/arm/mach-kirkwood/board-dt.c
>> @@ -94,6 +94,9 @@ static void __init kirkwood_dt_init(void)
>>       if (of_machine_is_compatible("keymile,km_kirkwood"))
>>               km_kirkwood_init();
>>
>> +     if (of_machine_is_compatible("plathome,openblocks-a6"))
>> +             openblocks_a6_init();
>> +
>>       of_platform_populate(NULL, kirkwood_dt_match_table,
>>                            kirkwood_auxdata_lookup, NULL);
>>  }
>> @@ -110,6 +113,7 @@ static const char *kirkwood_dt_board_compat[] = {
>>       "buffalo,lsxl",
>>       "iom,ix2-200",
>>       "keymile,km_kirkwood",
>> +     "plathome,openblocks-a6",
>>       NULL
>>  };
>>
>> diff --git a/arch/arm/mach-kirkwood/board-openblocks_a6.c b/arch/arm/mach-kirkwood/board-openblocks_a6.c
>> new file mode 100644
>> index 0000000..ee6f4c6
>> --- /dev/null
>> +++ b/arch/arm/mach-kirkwood/board-openblocks_a6.c
>> @@ -0,0 +1,86 @@
>> +/*
>> + * Copyright 2012 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
>> + *
>> + * arch/arm/mach-kirkwood/board-openblocks_a6.c
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-private.h>
>> +#include "common.h"
>> +#include "mpp.h"
>> +
>> +static struct mv643xx_eth_platform_data openblocks_ge00_data = {
>> +     .phy_addr       = MV643XX_ETH_PHY_ADDR(0),
>> +};
>> +
>> +static unsigned int openblocks_a6_mpp_config[] __initdata = {
>> +     MPP0_NF_IO2,
>> +     MPP1_NF_IO3,
>> +     MPP2_NF_IO4,
>> +     MPP3_NF_IO5,
>> +     MPP4_NF_IO6,
>> +     MPP5_NF_IO7,
>> +     MPP6_SYSRST_OUTn,
>> +     /* MPP7_GPO, */
>
> Any reason not to actually have MPP7_GPO here?
> Is it being used as a GPO line?

Yes. MPP7 is assigned to GPO in this target boatd.
And GPO is not used.
The following is also the same.
If unnecessary, I will delete these lines.

>
> Same question for all the other commented out GPIOs.
>
>> +     MPP8_UART1_RTS,
>> +     MPP9_UART1_CTS,
>> +     MPP10_UART0_TXD,
>> +     MPP11_UART0_RXD,
>> +     /* MPP12_GPIO, */
>> +     MPP13_UART1_TXD,
>> +     MPP14_UART1_RXD,
>> +     MPP15_UART0_RTS,
>> +     MPP16_UART0_CTS,
>> +     /* MPP17_GPIO, */
>> +     MPP18_NF_IO0,
>> +     MPP19_NF_IO1,
>> +     MPP20_GPIO,     /* CFG 0 */
>> +     MPP21_GPIO, /* CFG 1 */
>> +     MPP22_GPIO,     /* CFG 2 */
>> +     MPP23_GPIO,     /* CFG 3 */
>
> Are these four above DIP switches?

Yes. I will change comment to DIP SW.
>
>> +     MPP24_GPIO, /* GPIO 0 */
>> +     MPP25_GPIO, /* GPIO 1 */
>> +     MPP26_GPIO, /* GPIO 2 */
>> +     MPP27_GPIO, /* GPIO 3 */
>> +     MPP28_GPIO, /* GPIO 4 */
>> +     MPP29_GPIO, /* GPIO 5 */
>> +     MPP30_GPIO, /* GPIO 6 */
>> +     MPP31_GPIO, /* GPIO 7 */
>> +     /* MPP32_GPIO, */
>> +     /* MPP33_GPO, */
>> +     /* MPP34_GPIO, */
>> +     /* MPP35_GPIO, */
>> +     MPP36_TW1_SDA,
>> +     MPP37_TW1_SCK,
>> +     MPP38_GPIO,     /* INIT */
>> +     MPP39_GPIO, /* USB OC */
>> +     /* MPP40_GPIO, */
>> +     MPP41_GPIO,     /* LED: Red */
>> +     MPP42_GPIO,     /* LED: Yellow */
>> +     MPP43_GPIO,     /* LED: Green */
>> +     /* MPP44_GPIO, */
>> +     /* MPP45_GPIO, */
>> +     /* MPP46_GPIO, */
>> +     /* MPP47_GPIO, */
>> +     /* MPP48_GPIO, */
>> +     /* MPP49_GPIO, */
>> +     0,
>> +};
>> +
>> +void __init openblocks_a6_init(void)
>> +{
>> +     /*
>> +      * Basic setup. Needs to be called early.
>> +      */
>> +     kirkwood_mpp_conf(openblocks_a6_mpp_config);
>> +     kirkwood_uart0_init();
>
> You don't need this. The DT description is enough to get the uart
> working.

OK, I will remove.

>
>> +     kirkwood_ehci_init();
>> +     kirkwood_ge00_init(&openblocks_ge00_data);
>> +}
>> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
>> index bcffd7c..0d0159e 100644
>> --- a/arch/arm/mach-kirkwood/common.h
>> +++ b/arch/arm/mach-kirkwood/common.h
>> @@ -112,6 +112,12 @@ void km_kirkwood_init(void);
>>  static inline void km_kirkwood_init(void) {};
>>  #endif
>>
>> +#ifdef CONFIG_MACH_OPENBLOCKS_A6_DT
>> +void openblocks_a6_init(void);
>> +#else
>> +static inline void openblocks_a6_init(void) {};
>> +#endif
>> +
>>  /* early init functions not converted to fdt yet */
>>  char *kirkwood_id(void);
>>  void kirkwood_l2_init(void);
>> --
>> 1.7.10.4
>>

Thanks,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
