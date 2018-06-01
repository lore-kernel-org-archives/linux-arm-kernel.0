From: frieder.schrempf@exceet.de (Frieder Schrempf)
Date: Fri, 1 Jun 2018 11:27:13 +0200
Subject: [PATCH 05/11] ARM: dts: Reflect change of FSL QSPI driver and
 remove unused properties
In-Reply-To: <20180530171057.39f1a2be@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-6-git-send-email-frieder.schrempf@exceet.de>
 <20180530171057.39f1a2be@bbrezillon>
Message-ID: <d6512adf-2d48-5bdc-d793-a7c1fcabc177@exceet.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 30.05.2018 17:10, Boris Brezillon wrote:
> On Wed, 30 May 2018 15:14:34 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> The FSL QSPI driver was moved to the SPI framework and it now
>> acts as a SPI controller. Therefore the subnodes need to set
>> spi-[rx/tx]-bus-width = <4>, so quad mode is used just as before.
> 
> We should try to keep the current behavior even when
> spi-[rx/tx]-bus-width are not defined. How about considering
> spi-[rx/tx]-bus-width as board constraints and then let the core pick
> the best mode based on these constraints plus the SPI NOR chip
> limitations.

Ok, I'll try to adjust this, so we can leave spi-[rx/tx]-bus-width 
undefined and still get quad mode as default if possible.

> 
>>
>> Also the properties 'bus-num', 'fsl,spi-num-chipselects' and
>> 'fsl,spi-flash-chipselects' were never read by the driver and
>> can be removed.
>>
>> The 'reg' properties are adjusted to reflect the what bus and
>> chipselect the flash is connected to, as the new driver needs
>> this information.
>>
>> The property 'fsl,qspi-has-second-chip' is not needed anymore
>> and will be removed after the old driver was disabled to avoid
>> breaking ls1021a-moxa-uc-8410a.dts.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>>   arch/arm/boot/dts/imx6sx-sdb-reva.dts       | 8 ++++++--
>>   arch/arm/boot/dts/imx6sx-sdb.dts            | 8 ++++++--
>>   arch/arm/boot/dts/imx6ul-14x14-evk.dtsi     | 2 ++
>>   arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts | 5 ++---
>>   4 files changed, 16 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
>> index e3533e7..1a6f680 100644
>> --- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
>> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
>> @@ -131,13 +131,17 @@
>>   		#size-cells = <1>;
>>   		compatible = "spansion,s25fl128s", "jedec,spi-nor";
>>   		spi-max-frequency = <66000000>;
>> +		spi-rx-bus-width = <4>;
>> +		spi-tx-bus-width = <4>;
>>   	};
>>   
>> -	flash1: s25fl128s at 1 {
>> -		reg = <1>;
>> +	flash1: s25fl128s at 2 {
>> +		reg = <2>;
> 
> Hm, you're breaking backward compat here. Can we try to re-use the
> old numbering scheme instead of patching all DTs?

Unfortunately in the current setup, the definitions for the reg property 
are already broken.

For example imx6sx-sdb.dts seems to have one chip connected on bus A, 
CS0 and one on bus B, CS0. It has reg set to 0 for the first and 1 for 
the second chip.

While fsl-ls208xa-qds.dtsi uses the same hw setup, but has reg set to 0 
and 2.

So either way we need to change the reg property at some place.
So the best approach in my opinion is to fix the definitions to use a 
single scheme and while at it also remove the fsl,qspi-has-second-chip 
property, that is not needed if a single consistent scheme for the reg 
properties is used.

Regards,

Frieder
