From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 26 Mar 2015 15:37:57 +0100
Subject: [PATCH 1/5] drivers: soc: sunxi: Introduce SoC driver to map SRAMs
In-Reply-To: <20150324151944.GA4951@lukather>
References: <1426877569-11493-1-git-send-email-hdegoede@redhat.com>
 <1426877569-11493-2-git-send-email-hdegoede@redhat.com>
 <20150324151944.GA4951@lukather>
Message-ID: <551419C5.2010100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24-03-15 16:19, Maxime Ripard wrote:
> Hi,
>
> On Fri, Mar 20, 2015 at 07:52:45PM +0100, Hans de Goede wrote:
>> From: Maxime Ripard <maxime.ripard@free-electrons.com>
>>
>> The Allwinner SoCs have a handful of SRAM that can be either mapped to be
>> accessible by devices or the CPU.
>>
>> That mapping is controlled by an SRAM controller, and that mapping might not be
>> set by the bootloader, for example if the device wasn't used at all, or if
>> we're using solutions like the U-Boot's Falcon Boot.
>>
>> We could also imagine changing this at runtime for example to change the
>> mapping of these SRAMs to use them for suspend/resume or runtime memory rate
>> change, if that ever happens.
>>
>> These use cases require some API in the kernel to control that mapping,
>> exported through a drivers/soc driver.
>>
>> This driver also implement a debugfs file that shows the SRAM found in the
>> system, the current mapping and the SRAM that have been claimed by some drivers
>> in the kernel.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> [hdegoede at redhat.com: Changed compat string to sun4i-a10-sram-controller, as
>>   the sram controller is identical on sun4i, sun5i & sun7i, added devicetree
>>   binding documentation, fixed some checkpatch warnings]
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../devicetree/bindings/soc/sunxi/sram.txt         |  64 ++++++
>>   drivers/soc/Kconfig                                |   1 +
>>   drivers/soc/Makefile                               |   1 +
>>   drivers/soc/sunxi/Kconfig                          |  12 ++
>>   drivers/soc/sunxi/Makefile                         |   1 +
>>   drivers/soc/sunxi/sunxi_sram.c                     | 235 +++++++++++++++++++++
>>   include/linux/soc/sunxi/sunxi_sram.h               |  24 +++
>>   7 files changed, 338 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/sunxi/sram.txt
>>   create mode 100644 drivers/soc/sunxi/Kconfig
>>   create mode 100644 drivers/soc/sunxi/Makefile
>>   create mode 100644 drivers/soc/sunxi/sunxi_sram.c
>>   create mode 100644 include/linux/soc/sunxi/sunxi_sram.h
>>
>> diff --git a/Documentation/devicetree/bindings/soc/sunxi/sram.txt b/Documentation/devicetree/bindings/soc/sunxi/sram.txt
>> new file mode 100644
>> index 0000000..6e1bc80
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/sunxi/sram.txt
>> @@ -0,0 +1,64 @@
>> +Allwinnner sun4i / sun5i / sun7i SoC SRAM controllers
>> +-----------------------------------------------------
>> +
>> +Required properties:
>> +- compatible : "allwinner,sun4i-a10-sram-controller"
>> +- reg : sram controller register offset + length
>> +
>> +SRAM nodes
>> +----------
>> +
>> +Besides a node for the SRAM controller the devicetree must also contain a
>> +node for each SRAM block controlled by the controller.
>> +
>> +Required sram node properties:
>> +- compatible : "allwinner,sun4i-a10-sram"
>> +- allwinner,sram-name : should be one of
>> +  * "A1"
>> +  * "A2"
>> +  * "A3-A4"
>> +  * "D"
>> +
>> +Example
>> +-------
>> +
>> +/*
>> + * Note we use the address were mmio register start, not where
>                                ^ where
>
>> + * the SRAM blocks starts, this cannot be changed because doing
>                        ^ start
>
>> + * doing so would be a devicetree ABI change.
>
> One doing too many ? :)

Both fixed.

>> + */
>> +soc at 01c00000 {
>> +	compatible = "simple-bus";
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +	ranges;
>> +
>> +	sram at 00000000 {
>> +		compatible = "allwinner,sun4i-a10-sram";
>> +		reg = <0x00000000 0x4000>;
>> +		allwinner,sram-name = "A1";
>> +	};
>> +
>> +	sram at 00004000 {
>> +		compatible = "allwinner,sun4i-a10-sram";
>> +		reg = <0x00004000 0x4000>;
>> +		allwinner,sram-name = "A2";
>> +	};
>> +
>> +	sram at 00008000 {
>> +		compatible = "allwinner,sun4i-a10-sram";
>> +		reg = <0x00008000 0x4000>;
>> +		allwinner,sram-name = "A3-A4";
>> +	};
>> +
>> +	sram at 00010000 {
>> +		compatible = "allwinner,sun4i-a10-sram";
>> +		reg = <0x00010000 0x1000>;
>> +		allwinner,sram-name = "D";
>> +	};
>> +
>> +	sram-controller at 01c00000 {
>> +		compatible = "allwinner,sun4i-a10-sram-controller";
>> +		reg = <0x01c00000 0x30>;
>> +	};
>> +};
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index 76d6bd4..5d0f55d 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -1,6 +1,7 @@
>>   menu "SOC (System On Chip) specific Drivers"
>>
>>   source "drivers/soc/qcom/Kconfig"
>> +source "drivers/soc/sunxi/Kconfig"
>>   source "drivers/soc/ti/Kconfig"
>>   source "drivers/soc/versatile/Kconfig"
>>
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>> index 063113d..170bba3 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -3,6 +3,7 @@
>>   #
>>
>>   obj-$(CONFIG_ARCH_QCOM)		+= qcom/
>> +obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
>>   obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>>   obj-$(CONFIG_SOC_TI)		+= ti/
>>   obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
>> diff --git a/drivers/soc/sunxi/Kconfig b/drivers/soc/sunxi/Kconfig
>> new file mode 100644
>> index 0000000..212c634
>> --- /dev/null
>> +++ b/drivers/soc/sunxi/Kconfig
>> @@ -0,0 +1,12 @@
>> +#
>> +# Allwinner sunXi SoC drivers
>> +#
>> +config SUNXI_SRAM
>> +        tristate "Allwinner sunXi SRAM Controller"
>> +        depends on ARCH_SUNXI
>> +	default y
>
> The indentation is off.

That is because your original patch used 8 spaces instead of tabs,
fixed.

> Also, that could probably be turned into an hidden option, with a
> default y, so that we are sure that it's always going to be there.

Also done / fixed.

Regards,

Hans
