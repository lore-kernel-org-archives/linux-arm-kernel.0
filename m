From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 18 Nov 2018 18:12:15 +0100
Subject: [PATCH v5 08/12] dt-bindings: mediatek: Change the binding for
 mmsys clocks
In-Reply-To: <20181116231522.GA18006@bogus>
References: <20181116125449.23581-1-matthias.bgg@kernel.org>
 <20181116125449.23581-9-matthias.bgg@kernel.org>
 <20181116231522.GA18006@bogus>
Message-ID: <2a23e407-4cd4-2e2b-97a5-4e2bb96846e0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/17/18 12:15 AM, Rob Herring wrote:
> On Fri, Nov 16, 2018 at 01:54:45PM +0100, matthias.bgg at kernel.org wrote:
>> From: Matthias Brugger <mbrugger@suse.com>
>>
>> On SoCs with no publical available HW or no working graphic stack
>> we change the devicetree binding for the mmsys clock part. This
>> way we don't need to register a platform device explicitly in the
>> drm driver. Instead we can create a mmsys child which invokes the
>> clock driver.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 21 ++++++++++++-------
>>  .../display/mediatek/mediatek,disp.txt        |  4 ++++
>>  2 files changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> index 4468345f8b1a..d4e205981363 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
>> @@ -1,4 +1,4 @@
>> -Mediatek mmsys controller
>> +Mediatek mmsys clock controller
>>  ============================
>>  
>>  The Mediatek mmsys controller provides various clocks to the system.
>> @@ -6,18 +6,25 @@ The Mediatek mmsys controller provides various clocks to the system.
>>  Required Properties:
>>  
>>  - compatible: Should be one of:
>> -	- "mediatek,mt2712-mmsys", "syscon"
>> -	- "mediatek,mt6797-mmsys", "syscon"
>> +	- "mediatek,mt2712-mmsys-clk", "syscon"
>> +	- "mediatek,mt6797-mmsys-clk", "syscon"
> 
> Doesn't match the example.>
>>  - #clock-cells: Must be 1
>>  
>> -The mmsys controller uses the common clk binding from
>> +The mmsys clock controller uses the common clk binding from
>>  Documentation/devicetree/bindings/clock/clock-bindings.txt
>>  The available clocks are defined in dt-bindings/clock/mt*-clk.h.
>> +It is a child of the mmsys block, see binding at:
>> +Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>>  
>>  Example:
>>  
>> -mmsys: clock-controller at 14000000 {
>> -	compatible = "mediatek,mt8173-mmsys", "syscon";
>> +mmsys: syscon at 14000000 {
>> +	compatible = "mediatek,mt2712-mmsys", "syscon", "simple-mfd";
>>  	reg = <0 0x14000000 0 0x1000>;
>> -	#clock-cells = <1>;
>> +
>> +	mmsys_clk: clock-controller at 14000000 {
>> +		compatible = "mediatek,mt2712-mmsys-clk";
>> +		#clock-cells = <1>;
> 
> This goes against the general direction of not defining separate nodes 
> for providers with no resources.
> 
> Why do you need this and what does it buy if you have to continue to 
> support the existing chips?
> 

It would show explicitly that the mmsys block is used to probe two
drivers, one for the gpu and one for the clocks. Otherwise that is
hidden in the drm driver code. I think it is cleaner to describe that in
the device tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: pEpkey.asc
Type: application/pgp-keys
Size: 1774 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181118/5b4f0374/attachment.bin>
