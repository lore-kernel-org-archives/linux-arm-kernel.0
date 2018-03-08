From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 8 Mar 2018 09:09:02 +0000
Subject: [PATCH 4/5] dt-bindings: pwm: sunxi: add new compatible strings
In-Reply-To: <20180308020822.35utrgw3ksoldr24@rob-hp-laptop>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-5-andre.przywara@arm.com>
 <20180308020822.35utrgw3ksoldr24@rob-hp-laptop>
Message-ID: <9431a141-8b9c-9743-0907-8f0720df34a2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/03/18 02:08, Rob Herring wrote:
> On Wed, Mar 07, 2018 at 02:07:18AM +0000, Andre Przywara wrote:
>> The PWM controllers found in the Allwinner A64, H5 and H6 SoCs are fully
>> compatible to the PWM controllers found in the A13 and H3.
> 
> If fully compatible, then shouldn't there be a fallback to one of the 
> existing compatible strings?

Yes, that was the idea. I was already wondering how we would
differentiate that from "real" compatible strings, but couldn't find
convincing examples. So should that read:

- compatible: should at least contain be one of:
    - "allwinner,sun4i-a10-pwm"
    - "allwinner,sun5i-a10s-pwm"
    - "allwinner,sun5i-a13-pwm"
    - "allwinner,sun7i-a20-pwm"
    - "allwinner,sun8i-h3-pwm"
  May in addition contain one of:
    - "allwinner,sun50i-a64-pwm"
    - "allwinner,sun50i-h5-pwm"
    - "allwinner,sun50i-h6-pwm"

And this would possibly need to be amended once we need to actually use
one of those strings (to implement a quirk, for instance)?
Or is there some other way of reserving those compatible strings, which
are not expected to be matched in drivers directly?

Cheers,
Andre.

>> Add new compatible strings for those SoCs to the binding document, so
>> that they can be safely used, together with a fallback string
>> (preferably "allwinner,sun5i-a13-pwm").
>> Add add the optionals "resets" property, needed by the H6.
>>
>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>> ---
>>  Documentation/devicetree/bindings/pwm/pwm-sun4i.txt | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
>> index 51ff54c8b8ef..b3a127a0e58c 100644
>> --- a/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
>> @@ -7,11 +7,17 @@ Required properties:
>>      - "allwinner,sun5i-a13-pwm"
>>      - "allwinner,sun7i-a20-pwm"
>>      - "allwinner,sun8i-h3-pwm"
>> +    - "allwinner,sun50i-a64-pwm"
>> +    - "allwinner,sun50i-h5-pwm"
>> +    - "allwinner,sun50i-h6-pwm"
>>    - reg: physical base address and length of the controller's registers
>>    - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>>      the cells format.
>>    - clocks: From common clock binding, handle to the parent clock.
>>  
>> +Optional properties:
>> +  - resets: shall be the reset control phandle for the PWM block, if required.
>> +
>>  Example:
>>  
>>  	pwm: pwm at 1c20e00 {
>> -- 
>> 2.14.1
>>
