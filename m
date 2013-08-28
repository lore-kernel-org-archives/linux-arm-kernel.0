From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 28 Aug 2013 08:14:03 -0400
Subject: [PATCH RFC v2 5/6] ARM: add Armada 1500 and Sony NSZ-GS7
 device tree files
In-Reply-To: <1377648874-6714-6-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376682098-10580-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1377648874-6714-6-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130828121403.GL19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 28, 2013 at 02:14:33AM +0200, Sebastian Hesselbarth wrote:
> This adds very basic device tree files for the Marvell Armada 1500 SoC
> (88DE3100) and the Sony NSZ-GS7 GoogleTV board. Currently, SoC only has
> nodes for cpus, some clocks, l2 cache controller, local timer, apb timers,
> uart, and interrupt controllers. The Sony NSZ-GS7 is a GoogleTV consumer
> device comprising the Armada 1500 SoC above.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Changelog:
> v1->v2:
> - add binding documentation (Reported by Jason Cooper)
> - change l2cc from aurora to tauros3 (Reported by Thomas Petazzoni)
> - add copyright reference
> - adapt compatibles to mach-berlin instead of mach-mvebu
> 
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: linux-doc at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  .../devicetree/bindings/arm/marvell,berlin.txt     |   23 ++
>  arch/arm/boot/dts/Makefile                         |    2 +
>  arch/arm/boot/dts/mv88de3100-sony-nsz-gs7.dts      |   29 +++
>  arch/arm/boot/dts/mv88de3100.dtsi                  |  222 ++++++++++++++++++++
>  4 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell,berlin.txt
>  create mode 100644 arch/arm/boot/dts/mv88de3100-sony-nsz-gs7.dts
>  create mode 100644 arch/arm/boot/dts/mv88de3100.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
> new file mode 100644
> index 0000000..a4c3056
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/marvell,berlin.txt
> @@ -0,0 +1,23 @@
> +Marvell Berlin (88DE3xxx) family SoCs Device Tree Bindings
> +---------------------------------------------------------------
> +
> +Boards with a SoC of the Marvell Berlin (88DE3xxx) family, e.g. Armada 1500
> +shall have the following properties:
> +
> +* Required root node properties:
> +compatible: must contain "marvell,berlin"
> +
> +In addition, the above compatible shall be extended with the specific
> +SoC used, i.e.
> +    "marvell,88de3100"	for Marvell 88DE3100 (Armada 1500),
> +    "marvell,88de3010"	for Marvell 88DE3010 (Armada 1000),
> +    "marvell,88de3005"	for Marvell 88DE3005 (Armada 1500-mini)
> +
> +* Example:
> +
> +/ {
> +	model = "Sony NSZ-GS7";
> +	compatible = "marvell,88de3100", "marvell,berlin";

I would make this:

	compatible = "sony,nsz-gs7", "marvell,88de3100", "marvell,berlin";

> +
> +	...
> +}
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d45058e..2989b51 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -43,6 +43,8 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
>  
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
>  dtb-$(CONFIG_ARCH_BCM) += bcm11351-brt.dtb
> +dtb-$(CONFIG_ARCH_BERLIN) += \
> +	mv88de3100-sony-nsz-gs7.dtb
>  dtb-$(CONFIG_ARCH_DAVINCI) += da850-enbw-cmc.dtb \
>  	da850-evm.dtb
>  dtb-$(CONFIG_ARCH_DOVE) += dove-cm-a510.dtb \
> diff --git a/arch/arm/boot/dts/mv88de3100-sony-nsz-gs7.dts b/arch/arm/boot/dts/mv88de3100-sony-nsz-gs7.dts
> new file mode 100644
> index 0000000..1081bc1
> --- /dev/null
> +++ b/arch/arm/boot/dts/mv88de3100-sony-nsz-gs7.dts
> @@ -0,0 +1,29 @@
> +/*
> + * Device Tree file for Sony NSZ-GS7
> + *
> + * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include "mv88de3100.dtsi"
> +
> +/ {
> +	model = "Sony NSZ-GS7";
> +	compatible = "sony,nsz-gs7", "marvell,88de3100", "marvell,berlin";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk verbose debug";

I would remove 'verbose debug' before official submission, no point to
defaulting to log-spammer.

thx,

Jason.
