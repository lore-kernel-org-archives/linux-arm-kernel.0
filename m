From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 20 Mar 2017 15:22:15 +0200
Subject: [PATCH 2/2] spi: imx: fix use of native chip-selects with
 devicetree
In-Reply-To: <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
 <1489726983-17706-3-git-send-email-gerg@linux-m68k.org>
Message-ID: <f1cf2001-28b4-6a74-b98a-13336d74ff9d@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 03/17/2017 07:03 AM, Greg Ungerer wrote:
> The commonly used mechanism of specifying the hardware or native
> chip-select on an SPI device in devicetree (that is "cs-gpios = <0>")
> does not result in the native chip-select being configured for use.
> So external SPI devices that require use of the native chip-select
> will not work.
> 
> You can successfully specify native chip-selects if using a platform
> setup by specifying the cs-gpio as negative offset by 32. And that
> works correctly. You cannot use the same method in devicetree.
> 
> The logic in the spi-imx.c driver during probe uses core spi function
> of_spi_register_master() in spi.c to parse the "cs-gpios" devicetree tag.
> For valid GPIO values that will be recorded for use, all other entries in
> the cs_gpios list will be set to -ENOENT. So entries like "<0>" will be
> set to -ENOENT in the cs_gpios list.
> 
> When the SPI device registers are setup the code will use the GPIO
> listed in the cs_gpios list for the desired chip-select. If the cs_gpio
> is less then 0 then it is intended to be for a native chip-select, and
> its cs_gpio value is added to 32 to get the chipselect number to use.
> Problem is that with devicetree this can only ever be -ENOENT (which
> is -2), and that alone results in an invalid chip-select number. But also
> doesn't allow selection of the native chip-select at all.
> 
> To fix, if the cs_gpio specified for this spi device is not a
> valid GPIO then use the "chip_select" (that is the native chip-select
> number) for hardware setup.
> 

Can you please share an example of "cs-gpios" property for a particular
case, which I'm able to test? It is an Atmel AT93C66A EEPROM connected
to CSPI1 and sitting on chip select 2 (= selected by CSPI1_SS2), there
is no other SPI devices on CSPI1.

Since I raise the question, please add the correspondent updates and
and an example to Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt

In fact my expectation would be to have a device description like one
below:

&spi1 {
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_cspi1>;

	eeprom at 2 {
		compatible = "atmel,at93c66a";
		reg = <2>;
		spi-cs-high;
		spi-max-frequency = <1000000>;
	};
};

Note, that there is no cs-gpios property at all, which is mandatory
at the moment, and unit address / reg property defines chip select
number.

For that type of bindings locally I have a hackish spi-imx driver change,
which supports this option, but I'm unsure if it is universal enough.

--
With best wishes,
Vladimir
