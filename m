From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 8 Aug 2016 17:00:41 +0200
Subject: [PATCH 3/3] ARM: dts: imx6sx-udoo-neo: Add SD
In-Reply-To: <20160808141248.GI4678@tiger>
References: <1467691450-22975-1-git-send-email-afaerber@suse.de>
 <1467691450-22975-4-git-send-email-afaerber@suse.de>
 <20160808141248.GI4678@tiger>
Message-ID: <16912a4e-88c8-b11a-16bb-927ee6bf1775@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 08.08.2016 um 16:12 schrieb Shawn Guo:
> On Tue, Jul 05, 2016 at 06:04:10AM +0200, Andreas F?rber wrote:
>> Enable the SDHC node and model the SDIO_PWR GPIO as a regulator.
>> Use the SD card as default trigger for the red LED.
>>
>> Cc: Ettore Chimenti <ettore.chimenti@udoo.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  
>>
>>  arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
>> index e074409644d8..85f5e8606dab 100644
>> --- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
>> +++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
>> @@ -56,6 +56,7 @@
>>  			label = "udoo-neo:red:mmc";
>>  			gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
>>  			default-state = "off";
>> +			linux,default-trigger = "mmc0";
>>  		};
>>  
>>  		orange {
>> @@ -64,6 +65,17 @@
>>  			default-state = "keep";
>>  		};
>>  	};
>> +
>> +	sdio_pwr_reg: sd-gpio-regulator {
>> +		compatible = "regulator-fixed";
>> +		gpio = <&gpio6 1 GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		regulator-name = "SDIO_PWR";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		regulator-always-on;
>> +	};
> 
> Is it correct to model SDIO power control GPIO as a boot-on and
> always-on fixed regulator?  It will be powered-on even when SDIO driver
> is not enabled or loaded.

AFAIR the issue was that the driver does not use any -supply properties
where we could hook this regulator up for enabling. So modeling it as an
always-on regulator seemed like the only way to ensure it gets enabled
without relying on the bootloader?

Note that the board boots U-Boot from SD, so it is somewhat likely that
the rootfs will be on SD, too.

Do you spot anything missing or wrong on the SD node below that would
explain the reliability issues described in the cover letter?

Regards,
Andreas

P.S. Thanks for picking up 1/3 - was waiting on that for preparing a v2.

>>  };
>>  
>>  &cpu0 {
>> @@ -230,6 +242,17 @@
>>  				<MX6SX_PAD_CSI_DATA06__UART6_RTS_B	0x1b0b1>,
>>  				<MX6SX_PAD_CSI_DATA07__UART6_CTS_B	0x1b0b1>;
>>  		};
>> +
>> +		pinctrl_usdhc2: usdhc2grp {
>> +			fsl,pins =
>> +				<MX6SX_PAD_SD2_CMD__USDHC2_CMD		0x17059>,
>> +				<MX6SX_PAD_SD2_CLK__USDHC2_CLK		0x10059>,
>> +				<MX6SX_PAD_SD2_DATA0__USDHC2_DATA0	0x17059>,
>> +				<MX6SX_PAD_SD2_DATA1__USDHC2_DATA1	0x17059>,
>> +				<MX6SX_PAD_SD2_DATA2__USDHC2_DATA2	0x17059>,
>> +				<MX6SX_PAD_SD2_DATA3__USDHC2_DATA3	0x17059>,
>> +				<MX6SX_PAD_SD1_DATA0__GPIO6_IO_2	0x17059>; /* CD */
>> +		};
>>  	};
>>  };
>>  
>> @@ -259,3 +282,14 @@
>>  	uart-has-rtscts;
>>  	status = "disabled";
>>  };
>> +
>> +&usdhc2 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&pinctrl_usdhc2>;
>> +	bus-width = <4>;
>> +	cd-gpios = <&gpio6 2 GPIO_ACTIVE_LOW>;
>> +	no-1-8-v;
>> +	keep-power-in-suspend;
>> +	wakeup-source;
>> +	status = "okay";
>> +};

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
