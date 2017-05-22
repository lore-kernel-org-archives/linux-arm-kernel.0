From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Mon, 22 May 2017 19:29:14 +0300
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-b: add hi8435 device
In-Reply-To: <a74ee28c1c62fee5a5e75dda70a02990@agner.ch>
References: <20170522131010.3537-1-nikita.yoush@cogentembedded.com>
 <a74ee28c1c62fee5a5e75dda70a02990@agner.ch>
Message-ID: <076f6258-f0b4-6ba5-9670-e2c0582a92b5@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +	hi8435 at 1 {
>> +		compatible = "holt,hi8435";
>> +		reg = <1>;
>> +		spi-max-frequency = <20000000>;
>> +		gpios = <&gpio5 3 0>;
> 
> Nit: GPIO_ACTIVE_HIGH instead of 0?

Gray area here.

Chip's reset input is active LOW.

However, hi8435 driver historically was coded using inverted values
passed to gpiolib calls.  And there are setups in the wild with device
trees containing GPIO_ACTIVE_HIGH that I'd prefer not breaking.

To solve, I submitted a patch on hi8435 driver that changes to _raw()
gpio calls (thus making it independent of what is written in device
tree), and want [future] device trees not to contain explicitly written
gpio polarity.

Far not ideal but better than device trees explicitly stating
GPIO_ACTIVE_HIGH while it is active low.

Nikita
