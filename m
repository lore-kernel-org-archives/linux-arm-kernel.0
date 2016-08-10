From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 10 Aug 2016 13:32:03 +0530
Subject: [PATCH 2/4] ARM: dts: da850: Add an aemif node
In-Reply-To: <57AADC63.90405@ti.com>
References: <20160809171518.22690-1-kbeldan@baylibre.com>
 <20160809171518.22690-3-kbeldan@baylibre.com> <57AADC63.90405@ti.com>
Message-ID: <57AADF7B.1070102@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 August 2016 01:18 PM, Sekhar Nori wrote:
> On Tuesday 09 August 2016 10:45 PM, Karl Beldan wrote:
>> Currently the davinci da8xx boards use the mach-davinci aemif code.
>> Instantiating an aemif node into the DT allows to use the ti-aemif
>> memory driver and is another step to better DT support.
>> Also it will allow to properly pass the emif timings via DT.
>>
>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
>> ---
>>  arch/arm/boot/dts/da850.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>> index bc10e7e..f62928c 100644
>> --- a/arch/arm/boot/dts/da850.dtsi
>> +++ b/arch/arm/boot/dts/da850.dtsi
>> @@ -411,6 +411,16 @@
>>  			dma-names = "tx", "rx";
>>  		};
>>  	};
>> +	aemif: aemif at 68000000 {
>> +		compatible = "ti,da850-aemif";
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +
>> +		reg = <0x68000000 0x00008000>;
>> +		ranges = <0 0 0x60000000 0x08000000
>> +			  1 0 0x68000000 0x00008000>;
>> +		status = "disabled";
>> +	};
>>  	nand_cs3 at 62000000 {
>>  		compatible = "ti,davinci-nand";
>>  		reg = <0x62000000 0x807ff
> 
> The nand node should be part of aemif node like it is done for keystone
> boards.

Actually, can you move the nand node out of da850.dtsi completely. Its
much better to keep da850.dtsi restricted to soc-internal devices and
keep the board level devices like NAND flash in <board>.dts file.

Similarly, can you move the NAND pinmux definitions too to the
da850-evm.dts file?

There is advantage in keeping common pinmux definitions in da850.dtsi so
each board doe not have to repeat them. But AEMIF is an exception as its
usage can really be varied (NAND, NOR, SRAM, other). Plus, different
boards are likely to use different chip selects so coming up with some
pinmux definitions which will be reused widely is really unlikely.

Thanks,
Sekhar
