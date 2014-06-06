From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 06 Jun 2014 12:22:13 +0100
Subject: [PATCH v2 5/7] ARM: shmobile: r8a7791 dtsi: Add SYS-DMAC0 and
 SYS-DMAC1 nodes
In-Reply-To: <2440127.sDc7m91LPu@avalon>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-6-git-send-email-geert+renesas@glider.be>
 <2440127.sDc7m91LPu@avalon>
Message-ID: <5391A465.5080403@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/14 13:25, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Monday 02 June 2014 15:42:09 Geert Uytterhoeven wrote:
>> Add nodes for the SYS-DMA controllers, SYS-DMAC0 and SYS-DMAC1. These
>> both share the same device sources, so are wrapped in the shdma-mux
>> node to allow both to be used.
>>
>> Cfr. the r8a7790 version by Ben Dooks.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - No changes
>>
>>  arch/arm/boot/dts/r8a7791.dtsi | 69 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
>> index e5c35d784ec8..37685ef32ea0 100644
>> --- a/arch/arm/boot/dts/r8a7791.dtsi
>> +++ b/arch/arm/boot/dts/r8a7791.dtsi
>> @@ -11,6 +11,7 @@
>>   */
>>
>>  #include <dt-bindings/clock/r8a7791-clock.h>
>> +#include <dt-bindings/dma/r8a7791-dma.h>
>>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>
>> @@ -55,6 +56,74 @@
>>  		};
>>  	};
>>
>> +	dma0: dma-mux at 0 {
>> +		compatible = "renesas,shdma-mux";
>> +		#dma-cells = <2>;
>> +		dma-channels = <30>;
>> +		dma-requests = <256>;
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		sysdma0: dma-controller at e6700020 {
>> +			compatible = "renesas,shdma-r8a7791";
>> +			reg = <0 0xe6700020 0 0xffc0>;
> 
> Even though the registered defined in the datasheet start at 0xe6700020, the 
> documentation clearly states that "The base address of registers for the 
> lower-numbered channels  (0 to 14) is H'E670 0000". I'm also wondering where 
> the size comes from, if you want to span the 0xe6700000 to 0xe670ffff range, 
> the size should be 0xffe0, not 0xffc0.

There seems to be no registers below the 0x20 point and therefore all
current implementations assume that the first register is the point
for the start. 0xffc0 is wrong, should be 0xffe0.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
