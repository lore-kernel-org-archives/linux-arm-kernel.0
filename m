From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 29 May 2018 18:46:10 +0300
Subject: [PATCH 2/2] arm64: dts: renesas: condor: add I2C0 support
In-Reply-To: <20180529131012.ohyqwmiaxiiw6noi@verge.net.au>
References: <e9c94553-be9d-0eec-a1ee-1713bb97fbab@cogentembedded.com>
 <61f6f4a4-e55c-06e0-cba1-7d90a556950a@cogentembedded.com>
 <20180529131012.ohyqwmiaxiiw6noi@verge.net.au>
Message-ID: <9bc27b57-cf26-3b03-6ec4-1e9788a46426@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

On 05/29/2018 04:10 PM, Simon Horman wrote:

>> Define the Condor board dependent part of the I2C0 device node.
>>
>> The I2C0 bus is populated by 2 ON Semiconductor PCA9654 I/O expanders
>> and Analog Devices  ADV7511W HDMI transmitter (but we're only describing
>> the former chips now).
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>> ---
>>  arch/arm64/boot/dts/renesas/r8a77980-condor.dts |   27 ++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
>> ===================================================================
>> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
>> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
>> @@ -80,6 +80,28 @@
>>  	clock-frequency = <32768>;
>>  };
>>  
>> +&i2c0 {
>> +	pinctrl-0 = <&i2c0_pins>;
>> +	pinctrl-names = "default";
>> +
>> +	status = "okay";
>> +	clock-frequency = <400000>;
>> +
>> +	io_expander0: gpio at 20 {
> 
> Hi Sergei,
> 
> I'm a little confused about where 0x20 and 0x21 are derived from.
> Could you explain a little?

   r-carv3h_system_evaluation_board_rev020.pdf, pp. 16-17, lower left corners.
The schematics gives the 8-bit read/write addresses but we use uniform 7-bit
I2C address in DTs.

>> +		compatible = "onnn,pca9654";
>> +		reg = <0x20>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +	};
>> +
>> +	io_expander1: gpio at 21 {
>> +		compatible = "onnn,pca9654";
>> +		reg = <0x21>;
>> +		gpio-controller;
>> +		#gpio-cells = <2>;
>> +	};
>> +};
>> +
>>  &mmc0 {
>>  	pinctrl-0 = <&mmc_pins>;
>>  	pinctrl-1 = <&mmc_pins_uhs>;
