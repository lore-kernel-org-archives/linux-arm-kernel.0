From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 25 Apr 2016 23:55:21 +0300
Subject: [PATCH v2 3/4] arm: dts: lpc32xx: reparent SIC1 and SIC2
 interrupts from MIC
In-Reply-To: <1461600301.6934.5.camel@localhost>
References: <1461545990-25560-1-git-send-email-vz@mleia.com>
 <1461546041-25713-1-git-send-email-vz@mleia.com>
 <1461600301.6934.5.camel@localhost>
Message-ID: <571E8439.7080400@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 25.04.2016 19:05, Sylvain Lemieux wrote:
> Hi Vladimir,
> 
> On Mon, 2016-04-25 at 04:00 +0300, Vladimir Zapolskiy wrote:
>> The change adds separate device nodes for SIC1 and SIC2 interrupt
>> controllers and reparents all defined SIC1 and SIC2 interrupt
>> producers to the correspondent interrupt controller, this is needed to
>> perform switching to a new LPC32xx MIC/SIC interrupt controller driver.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>> Changes from v1 to v2:
>> * squashed two step change in lpc32xx.dtsi - new irqchip driver can be
>>   used (i.e. board boots with access to userspace) with old DTS file,
>>   so there is no need to fix DTS firstly and then switch to a new driver,
>> * removed "interrupt-controller-name" and "wakeup-sources" properties
>>   from all interrupt controllers,
>> * removed outdated comment.
>>
>>  arch/arm/boot/dts/lpc32xx.dtsi | 58 +++++++++++++++++++++++++++++-------------
>>  1 file changed, 41 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
>> index 73c4746..4570ddc 100644
>> --- a/arch/arm/boot/dts/lpc32xx.dtsi
>> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
>> @@ -92,7 +92,8 @@
> 
> ...
>>  
>> -			/*
>> -			 * MIC Interrupt controller includes:
>> -			 *   MIC @40008000
>> -			 *   SIC1 @4000C000
>> -			 *   SIC2 @40010000
>> -			 */
>>  			mic: interrupt-controller at 40008000 {
>>  				compatible = "nxp,lpc3220-mic";
>>  				interrupt-controller;
>> @@ -327,6 +326,28 @@
> 
> I think your are missing one change in your patch,
> the mic register range should be 0x4000, not 0xC000.
> 
> Everything else is OK.

Good catch, thank you for pointing it out, and let me fix it
immediately. Fortunately it is corrected in an example from v2 1/4.

>>  				#interrupt-cells = <2>;
>>  			};
>>  
>> +			sic1: interrupt-controller at 4000c000 {
>> +				compatible = "nxp,lpc3220-sic";
>> +				reg = <0x4000c000 0x4000>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +
>> +				interrupt-parent = <&mic>;
>> +				interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
>> +					     <30 IRQ_TYPE_LEVEL_LOW>;
>> +				};
>> +
>> +			sic2: interrupt-controller at 40010000 {
>> +				compatible = "nxp,lpc3220-sic";
>> +				reg = <0x40010000 0x4000>;
>> +				interrupt-controller;
>> +				#interrupt-cells = <2>;
>> +
>> +				interrupt-parent = <&mic>;
>> +				interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
>> +					     <31 IRQ_TYPE_LEVEL_LOW>;
>> +			};
>> +
> ...
> 

--
With best wishes,
Vladimir
