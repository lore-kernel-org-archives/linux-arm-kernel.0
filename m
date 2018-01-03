From: filip.matijevic.pz@gmail.com (=?UTF-8?Q?Filip_Matijevi=c4=87?=)
Date: Wed, 3 Jan 2018 07:55:52 +0100
Subject: [PATCH] nokia N9: Add support for magnetometer and touchscreen
In-Reply-To: <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
References: <20180102131722.GA20706@amd>
 <20180102172720.ghtez4d3d2fgcmj6@earth.universe>
Message-ID: <162367f0-7b07-cd8d-1c13-69e34abb0fc6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/02/2018 06:27 PM, Sebastian Reichel wrote:
> Hi,
> 
> On Tue, Jan 02, 2018 at 02:17:22PM +0100, Pavel Machek wrote:
>> This adds dts support for magnetometer and touchscreen on Nokia N9.
> 
> I think it makes sense to have this splitted.
> 
>> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>>
>> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
>> index 39e35f8..57a6679 100644
>> --- a/arch/arm/boot/dts/omap3-n9.dts
>> +++ b/arch/arm/boot/dts/omap3-n9.dts
>> @@ -36,6 +57,22 @@
>>  			};
>>  		};
>>  	};
>> +
>> +	touch at 4b {
> 
> touchscreen@
> 
>> +		compatible = "atmel,maxtouch";
>> +		reg = <0x4b>;
>> +		interrupt-parent = <&gpio2>;
>> +		interrupts = <29 2>; /* gpio_61, IRQF_TRIGGER_FALLING*/
> 
> reset-gpios = <&gpio3 17 GPIO_ACTIVE_SOMETHING>;
> 

I'm using reset-gpios = <&gpio3 17 0>;

>> +		vdd-supply = <&vio>;
>> +		avdd-supply = <&vaux1>;
> 
> Those two are not mentioned in the binding and not supported by the
> driver as far as I can see?
> 

Right, but vio and vaux1 need to be on - the reason why it's working at
all is because lis302 uses the same regulators and turns them on. IMHO
either we add the support for regulators to maxtouch driver or we add
regulator-always-on to vio and vaux1.

>> +	};
>> +};
> 
> Touchscreen with the same settings is required for n950, so it
> should be in the shared n950 + n9 file.
> 

As a side-note, there is no pinmux mentioned and usually I'd use
OMAP3_CORE1_IOPAD(0x20c8, PIN_INPUT | MUX_MODE4) /* gpio_61*/
OMAP3_CORE1_IOPAD(0x20f2, PIN_OUTPUT | MUX_MODE4) /* gpio_81*/

For reasons that I can't explain, first line (gpmc_nbe1->gpio_61) breaks
it for me, so I've commented it out. Still, if anyone has an idea what
is wrong with that please let me know.

>> +&i2c3 {
>> +	ak8975 at 0f {
>> +		compatible = "asahi-kasei,ak8975";
>> +		reg = <0x0f>;
>> +	};
>>  };
> 
> Looking at the N9 board file this is missing a rotation matrix. This
> is supported by the binding:
> 
> Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> 
>>  
>>  &isp {
> 
> -- Sebastian
> 

Best regards,
Filip
