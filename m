From: stefan@agner.ch (Stefan Agner)
Date: Thu, 31 Mar 2016 10:57:56 -0700
Subject: [PATCH 04/18] ARM: dts: vf610: add on-chip SRAM
In-Reply-To: <20160331083325.GX28207@tiger>
References: <1457576219-7971-1-git-send-email-stefan@agner.ch>
 <1457576219-7971-5-git-send-email-stefan@agner.ch>
 <20160331083325.GX28207@tiger>
Message-ID: <e6792f9813e0b8b346addebb3373d5af@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-31 01:33, Shawn Guo wrote:
> On Wed, Mar 09, 2016 at 06:16:45PM -0800, Stefan Agner wrote:
>> Add Vybrids massive on-chip SRAM areas. Make use of the memory
>> region functionality to denominate the retained SRAM area in
>> LPSTOP2 and LPSTOP3.
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> This one looks fine to me.  I was going to pick it up separately, but it
> doesn't apply.

... see below

>> ---
>>  arch/arm/boot/dts/vfxxx.dtsi | 37 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
>> index 909988d..b038ea4 100644
>> --- a/arch/arm/boot/dts/vfxxx.dtsi
>> +++ b/arch/arm/boot/dts/vfxxx.dtsi
>> @@ -91,6 +91,43 @@
>>  		interrupt-parent = <&gpc>;


I guess this gpc interrupt parent causes the apply problem. I will move
this patch to the top so it can be applied before the GPC driver and dt
changes.

--
Stefan


>>  		ranges;
>>
>> +		ocram0: sram at 3f000000 {
>> +			compatible = "mmio-sram";
>> +			reg = <0x3f000000 0x40000>;
>> +
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0x3f000000 0x40000>;
>> +
>> +			stbyram1 at 0 {
>> +				reg = <0x0 0x4000>;
>> +				label = "stbyram1";
>> +				pool;
>> +			};
>> +
>> +			stbyram2 at 4000 {
>> +				reg = <0x4000 0xc000>;
>> +				label = "stbyram2";
>> +				pool;
>> +			};
>> +		};
>> +
>> +		ocram1: sram at 3f040000 {
>> +			compatible = "mmio-sram";
>> +			reg = <0x3f040000 0x40000>;
>> +		};
>> +
>> +		gfxram0: sram at 3f400000 {
>> +			compatible = "mmio-sram";
>> +			reg = <0x3f400000 0x80000>;
>> +		};
>> +
>> +		/* used by L2 cache */
>> +		gfxram1: sram at 3f480000 {
>> +			compatible = "mmio-sram";
>> +			reg = <0x3f480000 0x80000>;
>> +		};
>> +
>>  		aips0: aips-bus at 40000000 {
>>  			compatible = "fsl,aips-bus", "simple-bus";
>>  			#address-cells = <1>;
>> --
>> 2.7.2
>>
>>
