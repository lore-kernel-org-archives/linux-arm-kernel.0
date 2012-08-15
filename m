From: alanbutty12@gmail.com (alan butler)
Date: Wed, 15 Aug 2012 19:00:42 +0100
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <20120815135427.GF22226@titan.lakedaemon.net>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
 <20120814235653.GA22226@titan.lakedaemon.net>
 <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
 <20120815111209.GB22226@titan.lakedaemon.net>
 <CAMW5Ufb-8NrWu6vsJ+RezrLEGj-Wfm5Tc+0BK9_2qzn671FrpQ@mail.gmail.com>
 <20120815121145.GC22226@titan.lakedaemon.net>
 <CADhrpJ4-4n15yfttBBFQOdOkKag0gaeqYgB4DFre3aG+R4Vq+Q@mail.gmail.com>
 <20120815135427.GF22226@titan.lakedaemon.net>
Message-ID: <CADhrpJ5JEGQWAjwu5+=Hy_gFjWLkkrzj9E0dZ-vxMk9x+M5uCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2012 14:54, Jason Cooper <jason@lakedaemon.net> wrote:
> On Wed, Aug 15, 2012 at 01:43:24PM +0100, alan butler wrote:
>> On 15 August 2012 13:11, Jason Cooper <jason@lakedaemon.net> wrote:
>> > On Wed, Aug 15, 2012 at 07:55:42AM -0400, Josh Coombs wrote:
>> > > >> Sorry i meant board-dt in the previous message and the name just
>> > > >> getting used to the mail program on os x aswel. I have run through the
>> > > >> checkpatch.pl script and it tells me there are no errors but i just
>> > > >> found out a few minutes ago theres a fix for the 2 sata ports not
>> > > >> working (on all kirkwood devices as far as i know) so i am going to
>> > > >> test that now as it envolves modifying a line in the dts file.
>> > > >
>> > > > Ok.  Please let everyone know in the comment portion of the patch (after
>> > > > the --- line) that your patch depends on this fix.  I haven't seen the
>> > > > patch you're referring to yet.  I'll keep my eye out for it.
>> > >
>> > > What he's referring to is needing to up the coherent_pool size to get
>> > > a Kirkwood device with two SATA ports to init completely.  I brought
>> > > the topic up on arm-kernel under the subject 'Potential Regression in
>> > > 3.6-rc1 - Kirkwood SATA' and Aaro Koskinen suggested the root cause
>> > > and potential fix of adding coherent_pool=1M to the bootargs.  I
>> > > didn't think to cc you in the discussion, sorry about that.  So there
>> > > isn't a pending patch yet, just a suggestion of altered bootargs.
>> >
>> > Yes, I saw that discussion.  Setting coherent_pool=1M was a way of
>> > diagnosing the problem.  It allowed the system to boot, which tells us
>> > where the problem lies.  But it did not fix the problem in the code.
>> > *That's* the patch I was referring to.  Which I haven't seen, yet. ;-)
>>
>> I could not get the way to use git figured out so i will send the
>> patch here though the browser based gmail interface and hope i do not
>> cause or get in too much trouble.
>
> It's doing some linewrapping, but it's fine for review.  When you
> resubmit for inclusion, you'll need to get that fixed up.
>
>> And my patch contains that part of
>> the altered bootargs so i hope that wont cause a problem either.
>
> Not a problem for review and testing, but I'm going to hold off on
> pulling it until we have the core problem fixed.
>
>> diff -urN linuxorig//arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>> linux//arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>> --- linuxorig//arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>> 1970-01-01 01:00:00.000000000 +0100
>> +++ linux//arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts    2012-08-15
>> 10:17:35.000000000 +0100
>> @@ -0,0 +1,77 @@
>> +/dts-v1/;
>> +
>> +/include/ "kirkwood.dtsi"
>> +
>> +/ {
>> +    model = "Iomega StorCenter ix2-200";
>> +    compatible = "iom,ix2-200", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>> +
>> +    memory {
>> +        device_type = "memory";
>> +        reg = <0x00000000 0x10000000>;
>> +    };
>> +
>> +    chosen {
>> +        bootargs = "console=ttyS0,115200n8 earlyprintk
>> root=LABEL=ROOTFS coherent_pool=1M";
>
> watch the linewrap.  Also, please remove the root= declaration and the
> coherent_pool=.  Once we get that fixed, your patch won't need it.
>
>> +    };
>> +
>> +    ocp at f1000000 {
>> +        i2c at 11000 {
>> +            status = "okay";
>> +
>> +            lm63: lm63 at 4c {
>> +                compatible = "national,lm63";
>> +                reg = <0x4c>;
>> +            };
>> +        };
>> +
>> +        serial at 12000 {
>> +            clock-frequency = <200000000>;
>> +            status = "ok";
>> +        };
>> +
>> +        nand at 3000000 {
>> +            status = "okay";
>> +
>> +            partition at 100000 {
>> +                label = "uImage";
>> +                reg = <0x100000 0x300000>;
>> +                read-only;
>> +            };
>> +
>> +            partition at 400000 {
>> +                label = "uInitrd";
>> +                reg = <0x540000 0x1000000>;
>> +            };
>
> is there a partition for u-boot and the u-boot environment?
>
>> +        };
>> +        sata at 80000 {
>> +            compatible = "marvell,orion-sata";
>> +            reg = <0x80000 0x5000>;
>> +            interrupts = <21>;
>> +            status = "okay";
>> +            nr-ports = <2>;
>> +        };
>> +
>> +    };
>> +    gpio-leds {
>> +        compatible = "gpio-leds";
>> +
>> +        power_led {
>> +            label = "status:white:power_led";
>> +            gpios = <&gpio0 16 0>;
>> +            linux,default-trigger = "default-on";
>> +        };
>> +        rebuild_led {
>> +            label = "status:white:rebuild_led";
>> +            gpios = <&gpio1 5 0>;
>> +        };
>> +        health_led {
>> +            label = "status:red:health_led";
>> +            gpios = <&gpio1 6 0>;
>> +        };
>> +        backup_led {
>> +            label = "status:blue:backup_led";
>> +            gpios = <&gpio0 15 0>;
>> +        };
>> +    };
>> +};
>> diff -urN linuxorig//arch/arm/mach-kirkwood/board-dt.c
>> linux//arch/arm/mach-kirkwood/board-dt.c
>> --- linuxorig//arch/arm/mach-kirkwood/board-dt.c    2012-08-15
>> 12:48:11.000000000 +0100
>> +++ linux//arch/arm/mach-kirkwood/board-dt.c    2012-08-15
>> 13:17:47.000000000 +0100
>> @@ -87,6 +87,9 @@
>>     if (of_machine_is_compatible("buffalo,lsxl"))
>>         lsxl_init();
>>
>> +    if (of_machine_is_compatible("iom,ix2-200"))
>> +        iomega_ix2_200_init();
>> +
>>     of_platform_populate(NULL, kirkwood_dt_match_table,
>>                  kirkwood_auxdata_lookup, NULL);
>>  }
>> @@ -100,6 +103,7 @@
>>     "qnap,ts219",
>>     "seagate,goflexnet",
>>     "buffalo,lsxl",
>> +    "iom,ix2-200",
>
> Please double check that this is a leading tab, and not a collection of
> spaces.  checkpatch.pl should have coughed on this if it was wrong.
> Could also be mail client mangling.
>
>>     NULL
>>  };
>>
>> diff -urN linuxorig//arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> linux//arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> --- linuxorig//arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> 1970-01-01 01:00:00.000000000 +0100
>> +++ linux//arch/arm/mach-kirkwood/board-iomega_ix2_200.c    2012-08-15
>> 10:16:55.000000000 +0100
>> @@ -0,0 +1,138 @@
>> +/*
>> + * arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> + *
>> + * Iomega StorCenter ix2-200
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/irq.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/ata_platform.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <linux/ethtool.h>
>> +#include <net/dsa.h>
>> +#include <linux/gpio.h>
>> +#include <linux/leds.h>
>> +#include <linux/gpio_keys.h>
>> +#include <linux/i2c.h>
>> +#include <linux/input.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <mach/kirkwood.h>
>> +#include "common.h"
>> +#include "mpp.h"
>> +
>> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
>> +    .phy_addr       = MV643XX_ETH_PHY_NONE,
>> +    .speed          = SPEED_1000,
>> +    .duplex         = DUPLEX_FULL,
>> +};
>> +
>> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
>> +    .phy_addr    = MV643XX_ETH_PHY_ADDR(11),
>> +};
>> +
>> +/****************************************************************************
>> + * GPIO Attached Keys
>> + ****************************************************************************/
>> +
>> +#define iomega_ix2_200_GPIO_KEY_RESET    12
>> +#define iomega_ix2_200_GPIO_KEY_POWER    14
>> +#define iomega_ix2_200_GPIO_KEY_OTB        35
>> +
>> +#define iomega_ix2_200_SW_RESET    0x00
>> +#define iomega_ix2_200_SW_POWER    0x01
>> +#define iomega_ix2_200_SW_OTB    0x02
>> +
>> +static struct gpio_keys_button iomega_ix2_200_buttons[] = {
>> +    {
>> +        .type        = EV_SW,
>> +        .code       = iomega_ix2_200_SW_RESET,
>> +        .gpio       = iomega_ix2_200_GPIO_KEY_RESET,
>> +        .desc       = "Reset Button",
>> +        .active_low     = 1,
>> +        .debounce_interval = 100,
>> +    },
>> +    {
>> +        .type        = EV_SW,
>> +        .code       = iomega_ix2_200_SW_POWER,
>> +        .gpio       = iomega_ix2_200_GPIO_KEY_POWER,
>> +        .desc       = "Power Button",
>> +        .active_low     = 1,
>> +        .debounce_interval = 100,
>> +    },
>> +    {
>> +        .type        = EV_SW,
>> +        .code       = iomega_ix2_200_SW_OTB,
>> +        .gpio       = iomega_ix2_200_GPIO_KEY_OTB,
>> +        .desc       = "OTB Button",
>> +        .active_low     = 1,
>> +        .debounce_interval = 100,
>> +    },
>> +
>> +};
>> +
>> +static struct gpio_keys_platform_data iomega_ix2_200_button_data = {
>> +    .buttons    = iomega_ix2_200_buttons,
>> +    .nbuttons       = ARRAY_SIZE(iomega_ix2_200_buttons),
>> +};
>> +
>> +static struct platform_device iomega_ix2_200_button_device = {
>> +    .name       = "gpio-keys",
>> +    .id         = -1,
>> +    .num_resources  = 0,
>> +    .dev        = {
>> +        .platform_data  = &iomega_ix2_200_button_data,
>> +    },
>> +};
>> +
>
> All of the above (gpio keys) can be removed and described in the DT.
> Please look at:
>
> da3fd4c ARM: Kirkwood: Describe iconnect keys in DT.
>
> which is currently at:
>
> git://git.infradead.org/users/jcooper/linux.git boards-for-v3.7
>
>> +static unsigned int iomega_ix2_200_mpp_config[] __initdata = {
>> +    MPP12_GPIO,                             /* Reset Button */
>> +    MPP14_GPIO,                             /* Power Button */
>> +    MPP15_GPIO,                             /* Backup LED (blue) */
>> +    MPP16_GPIO,                             /* Power LED (white) */
>> +    MPP35_GPIO,                             /* OTB Button */
>> +    MPP36_GPIO,                             /* Rebuild LED (white) */
>> +    MPP37_GPIO,                             /* Health LED (red) */
>> +    MPP38_GPIO,                             /* SATA LED brightness control 1 */
>> +    MPP39_GPIO,                             /* SATA LED brightness control 2 */
>> +    MPP40_GPIO,                             /* Backup LED brightness
>> control 1 */
>> +    MPP41_GPIO,                             /* Backup LED brightness
>> control 2 */
>> +    MPP42_GPIO,                             /* Power LED brightness
>> control 1 */
>> +    MPP43_GPIO,                             /* Power LED brightness
>> control 2 */
>> +    MPP44_GPIO,                             /* Health LED brightness
>> control 1 */
>> +    MPP45_GPIO,                             /* Health LED brightness
>> control 2 */
>> +    MPP46_GPIO,                             /* Rebuild LED brightness
>> control 1 */
>> +    MPP47_GPIO,                             /* Rebuild LED brightness
>> control 2 */
>> +    0
>> +};
>> +
>> +void __init iomega_ix2_200_init(void)
>> +{
>> +    /*
>> +     * Basic setup. Needs to be called early.
>> +     */
>> +    kirkwood_mpp_conf(iomega_ix2_200_mpp_config);
>> +
>> +    kirkwood_ehci_init();
>> +
>> +    kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
>> +    kirkwood_ge01_init(&iomega_ix2_200_ge01_data);
>
>
>> +    kirkwood_uart0_init();
>> +    platform_device_register(&iomega_ix2_200_button_device);
>
> These two lines can be removed, the second after describing the gpio
> keys in the DT.  Make sure you have CONFIG_SERIAL_OF_PLATFORM=y in your
> config.
>
>> +}
>> +
>> +static int __init iomega_ix2_200_pci_init(void)
>> +{
>> +    if (of_machine_is_compatible("iom,ix2-200"))
>> +        kirkwood_pcie_init(KW_PCIE0);
>> +    return 0;
>> +}
>> +subsys_initcall(iomega_ix2_200_pci_init);
>> +
>> diff -urN linuxorig//arch/arm/mach-kirkwood/common.h
>> linux//arch/arm/mach-kirkwood/common.h
>> --- linuxorig//arch/arm/mach-kirkwood/common.h    2012-08-15
>> 12:48:11.000000000 +0100
>> +++ linux//arch/arm/mach-kirkwood/common.h    2012-08-15
>> 12:54:07.000000000 +0100
>> @@ -94,6 +94,12 @@
>>  static inline void lsxl_init(void) {};
>>  #endif
>>
>> +#ifdef CONFIG_MACH_IOMEGA_IX2_200_DT
>> +void iomega_ix2_200_init(void);
>> +#else
>> +static inline void iomega_ix2_200_init(void) {};
>> +#endif
>> +
>>  /* early init functions not converted to fdt yet */
>>  char *kirkwood_id(void);
>>  void kirkwood_l2_init(void);
>> diff -urN linuxorig//arch/arm/mach-kirkwood/Kconfig
>> linux//arch/arm/mach-kirkwood/Kconfig
>> --- linuxorig//arch/arm/mach-kirkwood/Kconfig    2012-08-15
>> 12:48:11.000000000 +0100
>> +++ linux//arch/arm/mach-kirkwood/Kconfig    2012-08-15 12:54:55.000000000 +0100
>> @@ -195,6 +195,13 @@
>>       Say 'Y' here if you want your kernel to support the
>>       HP t5325 Thin Client.
>>
>> +config MACH_IOMEGA_IX2_200_DT
>> +    bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
>> +    select ARCH_KIRKWOOD_DT
>> +    help
>> +      Say 'Y' here if you want your kernel to support the
>> +      Iomega StorCenter ix2-200 (Flattened Device Tree).
>> +
>>  endmenu
>>
>>  endif
>> diff -urN linuxorig//arch/arm/mach-kirkwood/Makefile
>> linux//arch/arm/mach-kirkwood/Makefile
>> --- linuxorig//arch/arm/mach-kirkwood/Makefile    2012-08-15
>> 12:48:11.000000000 +0100
>> +++ linux//arch/arm/mach-kirkwood/Makefile    2012-08-15
>> 12:55:17.000000000 +0100
>> @@ -28,3 +28,4 @@
>>  obj-$(CONFIG_MACH_TS219_DT)        += board-ts219.o tsx1x-common.o
>>  obj-$(CONFIG_MACH_GOFLEXNET_DT)        += board-goflexnet.o
>>  obj-$(CONFIG_MACH_LSXL_DT)        += board-lsxl.o
>> +obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)    += board-iomega_ix2_200.o
>> diff -urN linuxorig//arch/arm/mach-kirkwood/Makefile.boot
>> linux//arch/arm/mach-kirkwood/Makefile.boot
>> --- linuxorig//arch/arm/mach-kirkwood/Makefile.boot    2012-08-15
>> 13:07:03.000000000 +0100
>> +++ linux//arch/arm/mach-kirkwood/Makefile.boot    2012-08-15
>> 12:55:43.000000000 +0100
>> @@ -11,3 +11,4 @@
>>  dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
>>  dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
>>  dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
>> +dtb-$(CONFIG_MACH_IOMEGA_IX2_200_DT) += kirkwood-iomega_ix2_200.dtb
>
> ...
>
>> Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
>
> This will need to go above the --- line, which you don't have in this
> email.
>
> Since you have this patch as a file, do the following:
>
> # after the git checkout command in my previous instructions
>
> patch -Np0 <../my_patch_file
>         # you may need 1 instead here, depends on the patch.
>
> git diff HEAD
>         # review the output, quit out and fix anything that isn't
>         # right. review again with the same command.  Once it looks
>         # correct, proceed
>
> git add .
>
> # you'll probably need to do these two if this is a new repo:
>         git config --add user.name "Alan M Butler"
>         git config --add user.email "alanbutty12 at gmail.com"
>
> git commit -s
>         # The first line should be "ARM: Kirkwood: ...".  This will
>         # become the subject of the email submission
>
> # now, pickup in my original instructions with 'git format-patch'
>
> hth,
>
> Jason.

i did what you sujested and all commands worked except for the git
sendmail part so i do not know if I should still be sending you the
patch this way but here it is. i also defined the gpio keys in the dts
file like you said the same as with the iconnect but the kernel keeps
crashing with them defined in the dts is the support actualy there for
the keys? or have i just defined them wrong?

>From f55ed67347f4b10ebbe2adc29d134acaf362279a Mon Sep 17 00:00:00 2001
Message-Id: <cover.1345046444.git.alanbutty12@gmail.com>
From: Alan M Butler <alanbutty12@gmail.com>
Date: Wed, 15 Aug 2012 17:00:44 +0100
Subject: [PATCH] *** SUBJECT HERE ***

*** BLURB HERE ***

Alan M Butler (1):
  ARM: Kirkwood: Iomega_IX2_200     Signed-off-by: Alan M Butler
    <alanbutty12@gmail.com>

 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  111 +++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig                |    7 ++
 arch/arm/mach-kirkwood/Makefile               |    1 +
 arch/arm/mach-kirkwood/Makefile.boot          |    1 +
 arch/arm/mach-kirkwood/board-dt.c             |    4 +
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   80 ++++++++++++++++++
 arch/arm/mach-kirkwood/common.h               |    6 ++
 7 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c

-- 
1.7.5.4
>From f55ed67347f4b10ebbe2adc29d134acaf362279a Mon Sep 17 00:00:00 2001
Message-Id: <f55ed67347f4b10ebbe2adc29d134acaf362279a.1345046444.git.alanbutty12@gmail.com>
In-Reply-To: <cover.1345046444.git.alanbutty12@gmail.com>
References: <cover.1345046444.git.alanbutty12@gmail.com>
From: Alan M Butler <alanbutty12@gmail.com>
Date: Wed, 15 Aug 2012 16:52:56 +0100
Subject: [PATCH] ARM: Kirkwood: Iomega_IX2_200 Signed-off-by: Alan M Butler
 <alanbutty12@gmail.com>

---
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  111 +++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig                |    7 ++
 arch/arm/mach-kirkwood/Makefile               |    1 +
 arch/arm/mach-kirkwood/Makefile.boot          |    1 +
 arch/arm/mach-kirkwood/board-dt.c             |    4 +
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   80 ++++++++++++++++++
 arch/arm/mach-kirkwood/common.h               |    6 ++
 7 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
 create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c

diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
new file mode 100644
index 0000000..7863009
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -0,0 +1,111 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "Iomega StorCenter ix2-200";
+	compatible = "iom,ix2-200", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		i2c at 11000 {
+			status = "okay";
+
+			lm63: lm63 at 4c {
+				compatible = "national,lm63";
+				reg = <0x4c>;
+			};
+		};
+
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		nand at 3000000 {
+			status = "okay";
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x100000>;
+				read-only;
+			};
+
+			partition at a0000 {
+				label = "env";
+				reg = <0xa0000 0x20000>;
+			};
+
+			partition at 100000 {
+				label = "uImage";
+				reg = <0x100000 0x300000>;
+				read-only;
+			};
+
+			partition at 400000 {
+				label = "uInitrd";
+				reg = <0x540000 0x1000000>;
+			};
+		};
+		sata at 80000 {
+			compatible = "marvell,orion-sata";
+			reg = <0x80000 0x5000>;
+			interrupts = <21>;
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+	};
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		power_led {
+			label = "status:white:power_led";
+			gpios = <&gpio0 16 0>;
+			linux,default-trigger = "default-on";
+		};
+		rebuild_led {
+			label = "status:white:rebuild_led";
+			gpios = <&gpio1 5 0>;
+		};
+		health_led {
+			label = "status:red:health_led";
+			gpios = <&gpio1 6 0>;
+		};
+		backup_led {
+			label = "status:blue:backup_led";
+			gpios = <&gpio0 15 0>;
+		};
+	};
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		button at 1 {
+			label = "OTB Button";
+			linux,code = <0x00>;
+			gpios = <&gpio1 4 1>;
+			debounce-interval = <100>;
+		};
+		button at 2 {
+			label = "Reset";
+			linux,code = <0x01>;
+			gpios = <&gpio0 12 1>;
+			debounce-interval = <100>;
+		};
+		button at 3 {
+			label = "Power";
+			linux,code = <0x028>;
+			gpios = <&gpio0 14 1>;
+			debounce-interval = <100>;
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index ca5c15a..bee8451 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -195,6 +195,13 @@ config MACH_T5325
 	  Say 'Y' here if you want your kernel to support the
 	  HP t5325 Thin Client.

+config MACH_IOMEGA_IX2_200_DT
+	bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  Iomega StorCenter ix2-200 (Flattened Device Tree).
+
 endmenu

 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 055c85a..f5484dc 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
 obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
 obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
 obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
+obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT)	+= board-iomega_ix2_200.o
diff --git a/arch/arm/mach-kirkwood/Makefile.boot
b/arch/arm/mach-kirkwood/Makefile.boot
index 2a576ab..f8ef771 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -11,3 +11,4 @@ dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb
 dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
 dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
 dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
+dtb-$(CONFIG_MACH_IOMEGA_IX2_200_DT) += kirkwood-iomega_ix2_200.dtb
diff --git a/arch/arm/mach-kirkwood/board-dt.c
b/arch/arm/mach-kirkwood/board-dt.c
index e4eb450..a932ae9 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -87,6 +87,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("buffalo,lsxl"))
 		lsxl_init();

+	if (of_machine_is_compatible("iom,ix2-200"))
+		iomega_ix2_200_init()
+
 	of_platform_populate(NULL, kirkwood_dt_match_table,
 			     kirkwood_auxdata_lookup, NULL);
 }
@@ -100,6 +103,7 @@ static const char *kirkwood_dt_board_compat[] = {
 	"qnap,ts219",
 	"seagate,goflexnet",
 	"buffalo,lsxl",
+	"iom,ix2-200",
 	NULL
 };

diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
new file mode 100644
index 0000000..a6bb98e
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
@@ -0,0 +1,80 @@
+/*
+ * arch/arm/mach-kirkwood/board-iomega_ix2_200.c
+ *
+ * Iomega StorCenter ix2-200
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/irq.h>
+#include <linux/mtd/partitions.h>
+#include <linux/ata_platform.h>
+#include <linux/mv643xx_eth.h>
+#include <linux/ethtool.h>
+#include <net/dsa.h>
+#include <linux/gpio.h>
+#include <linux/leds.h>
+#include <linux/i2c.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+#include "mpp.h"
+
+static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
+	.phy_addr       = MV643XX_ETH_PHY_NONE,
+	.speed          = SPEED_1000,
+	.duplex         = DUPLEX_FULL,
+};
+
+static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
+	.phy_addr	= MV643XX_ETH_PHY_ADDR(11),
+};
+
+static unsigned int iomega_ix2_200_mpp_config[] __initdata = {
+	MPP12_GPIO,			/* Reset Button */
+	MPP14_GPIO,			/* Power Button */
+	MPP15_GPIO,			/* Backup LED (blue) */
+	MPP16_GPIO,			/* Power LED (white) */
+	MPP35_GPIO,			/* OTB Button */
+	MPP36_GPIO,			/* Rebuild LED (white) */
+	MPP37_GPIO,			/* Health LED (red) */
+	MPP38_GPIO,			/* SATA LED brightness control 1 */
+	MPP39_GPIO,			/* SATA LED brightness control 2 */
+	MPP40_GPIO,			/* Backup LED brightness control 1 */
+	MPP41_GPIO,			/* Backup LED brightness control 2 */
+	MPP42_GPIO,			/* Power LED brightness control 1 */
+	MPP43_GPIO,			/* Power LED brightness control 2 */
+	MPP44_GPIO,			/* Health LED brightness control 1 */
+	MPP45_GPIO,			/* Health LED brightness control 2 */
+	MPP46_GPIO,			/* Rebuild LED brightness control 1 */
+	MPP47_GPIO,			/* Rebuild LED brightness control 2 */
+	0
+};
+
+void __init iomega_ix2_200_init(void)
+{
+	/*
+	 * Basic setup. Needs to be called early.
+	 */
+	kirkwood_mpp_conf(iomega_ix2_200_mpp_config);
+
+	kirkwood_ehci_init();
+
+	kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
+	kirkwood_ge01_init(&iomega_ix2_200_ge01_data);
+}
+
+static int __init iomega_ix2_200_pci_init(void)
+{
+	if (of_machine_is_compatible("iom,ix2-200"))
+		kirkwood_pcie_init(KW_PCIE0);
+	return 0;
+}
+subsys_initcall(iomega_ix2_200_pci_init);
+
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 304dd1a..d5d4064 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -94,6 +94,12 @@ void lsxl_init(void);
 static inline void lsxl_init(void) {};
 #endif

+#ifdef CONFIG_MACH_IOMEGA_IX2_200_DT
+void iomega_ix2_200_init(void);
+#else
+static inline void iomega_ix2_200_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
-- 
1.7.5.4
