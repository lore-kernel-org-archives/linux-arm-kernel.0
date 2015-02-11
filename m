From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 11 Feb 2015 23:17:46 +0800
Subject: [resend PATCH v3 4/4] usb: phy: add phy-hi6220-usb
In-Reply-To: <20150210144807.GC16711@saruman.tx.rr.com>
References: <1423559404-13058-1-git-send-email-zhangfei.gao@linaro.org>
 <1423559404-13058-5-git-send-email-zhangfei.gao@linaro.org>
 <20150210144807.GC16711@saruman.tx.rr.com>
Message-ID: <54DB729A.9040306@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/2015 10:48 PM, Felipe Balbi wrote:

>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index c6d0c8e..405a3d0 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -173,6 +173,15 @@ config USB_MXS_PHY
>>
>>   	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
>>
>> +config USB_HI6220_PHY
>> +	tristate "hi6220 USB PHY support"
>> +	select USB_PHY
>> +	select MFD_SYSCON
>> +	help
>> +	  Enable this to support the HISILICON HI6220 USB PHY.
>> +
>> +	  To compile this driver as a module, choose M here.
>> +
>>   config USB_RCAR_PHY
>>   	tristate "Renesas R-Car USB PHY support"
>>   	depends on USB || USB_GADGET
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index 75f2bba..00172d3 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
>>   obj-$(CONFIG_TWL6030_USB)		+= phy-twl6030-usb.o
>>   obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
>>   obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
>> +obj-$(CONFIG_USB_HI6220_PHY)		+= phy-hi6220-usb.o
>
> new drivers only on drivers/phy/, sorry.
>
One more quesiton.
Should I also move Documentation/devicetree/bindings/usb/hi6220-usb.txt 
to Documentation/devicetree/bindings/phy/?

I describing both usb controller and phy here, is it still should be put 
under Documentation/devicetree/bindings/usb/?

Hisilicon hi6220 SoC USB controller
-----------------------------

usb controller is inherited from dwc2, refer dwc2.txt
-----

Required properties:
- compatible: "hisilicon,hi6220-usb"
Refer to dwc2.txt for dwc2 usb properties


PHY:
-----

Required properties:
- compatible: "hisilicon,hi6220-usb-phy"
- vcc-supply: phandle to the regulator that provides power to the PHY.
- clocks: phandle and clock specifier of the PHY clock.
- hisilicon,peripheral-syscon: phandle of syscon used to control peripheral.
- hisilicon,vbus-gpios: gpio of detecting vbus.
- hisilicon,id-gpios: gpio of detecting id.

Example:

	sys_ctrl: syscon at f7030000 {
		compatible = "hisilicon,sysctrl", "syscon";
	        reg = <0x0 0xf7030000 0x0 0x1000>;
	};

	usb_phy: usb-phy {
		compatible = "hisilicon,hi6220-usb-phy";
		vcc-supply = <&fixed_5v_hub>;
		hisilicon,vbus-gpios = <&gpio2 6 0>;
		hisilicon,id-gpios = <&gpio2 5 0>;
		hisilicon,peripheral-syscon = <&sys_ctrl>;
		clocks = <&clock_sys HI6220_USBOTG_HCLK>;
	};

	usb: usb at f72c0000 {
		compatible = "hisilicon,hi6220-usb";
		reg = <0x0 0xf72c0000 0x0 0x40000>;
		phys = <&usb_phy>;
		dr_mode = "otg";
		g-use-dma;
		g-rx-fifo-size = <512>;
		g-np-tx-fifo-size = <128>;
		g-tx-fifo-size = <128>;
		interrupts = <0 77 0x4>;
	};
