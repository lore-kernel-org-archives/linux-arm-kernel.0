From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 9 Aug 2018 09:53:21 +0200
Subject: [PATCH v2 3/4] ARM64: dts: meson-gx: add dmcbus and canvas nodes.
In-Reply-To: <3221c65f87f8fd3541e0188186cb0259327cb671.camel@baylibre.com>
References: <20180807220011.24436-1-maxi.jourdan@wanadoo.fr>
 <20180807220011.24436-4-maxi.jourdan@wanadoo.fr>
 <3221c65f87f8fd3541e0188186cb0259327cb671.camel@baylibre.com>
Message-ID: <fcbfff13-aec5-c571-3a5e-a3d571505342@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2018 10:41, Jerome Brunet wrote:
> On Wed, 2018-08-08 at 00:00 +0200, Maxime Jourdan wrote:
>> Wrap the canvas node in a syscon node.
>>
>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> index b8dc4dbb391b..c98198662ae2 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
>> @@ -423,6 +423,23 @@
>>  			};
>>  		};
>>  
>> +		dmcbus: bus at c8838000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xc8838000 0x0 0x1000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xc8838000 0x0 0x1000>;
>> +
>> +			sysctrl_DMC: system-controller at 0 {
>> +				compatible = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";
>> +				reg = <0x0 0x0 0x0 0x1000>;
>> +
>> +				canvas: canvas-provider at 0 {
>> +					compatible = "amlogic,canvas";
> 
> If there is only one canvas provider under "sysctrl_DMC" and it has no reg
> property , you should not put a unit-address (@0) here. (same for the
> documentation patch)
> 
> You may have seen unit-address without a reg property used elsewhere (ASoC
> simple-card, my recent axg-sound-card), when there is multiple node with the
> same node-name (ex: dai-link).
> 
> As Martin pointed out, the DT spec says we should not use unit-address unless
> there is a reg property. We did not get Rob's view on this and we might have to
> update this later on. In your case, unless I missed something, you should
> definitely not have it
> 
> nitpick regarding the node-name (canvas-provider). If appropriate, we should try
> to stick to one of the generic names proposed in the spec. I wonder if the
> canvas provider could be viewed as a "memory" or "memory-controller"

It's not really a memory or memory-controller, it's a Lookup Table on top of the memory controller,
nothing really matches here...

> 
> So, what about this ? Just a proposition, feel free to comment ;)
> 
> 	sysctrl_DMC: system-controller at 0 {							compatib
> le = "amlogic,gx-dmc-sysctrl", "syscon", "simple-mfd";> 		reg =
> <0x0 0x0 0x0 0x1000>;
> 	
> 		canvas: memory-controller {
> 			compatible = "amlogic,canvas";
> 		}
> 
> [...]
> 
> 
>> +				};
>> +			};
>> +		};
>> +
>>  		hiubus: bus at c883c000 {
>>  			compatible = "simple-bus";
>>  			reg = <0x0 0xc883c000 0x0 0x2000>;
> 
> 
