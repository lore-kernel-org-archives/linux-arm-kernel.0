From: mbrugger@suse.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 16:36:09 +0200
Subject: [RFC resend 1/4] dt-bindings: display: mediatek: add drm binding
In-Reply-To: <1508415566.5287.10.camel@mtkswgap22>
References: <20171019112610.13645-1-mbrugger@suse.com>
 <20171019112610.13645-2-mbrugger@suse.com>
 <1508415566.5287.10.camel@mtkswgap22>
Message-ID: <61b146fe-da63-0eeb-f55a-00bd2499d38f@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2017 02:19 PM, Ryder Lee wrote:
> Hi Matthias,
> 
> Should I base on your changes and resend this patch series
> https://patchwork.kernel.org/patch/9980061/ ?
> 
> I add a similar node - display_components, but your approach is better
> than mine.
> 

You series should have the same issue as the Ulrich sees on the chromebook.
Basically you have two nodes which both bind to mediatek,mt7623-mmsys.

The only difference here is, that your clock drivers is a
builtin_platform_driver while on mt8173 it get's probed earlier as it is defined
as CLK_OF_DECLARE.

Do you see both drivers getting probed? I don't have my mt7623 board at hand
right now to check this.

In any case, please wait until we found a way to fix the issue before we add
these bindings.

Regards,
Matthias

PS @ryder: I have the rest of the series on my radar, between today and tomorrow
I will look into this

> Thanks.
> 
> On Thu, 2017-10-19 at 13:26 +0200, Matthias Brugger wrote:
>> DRM subysystem and clock driver shared the same compatible mmsys.
>> This stopped does not work, as only the first driver for a compatible
>> gets probed. We change the comaptible to the new DRM identifier to fix
>> this.
>>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> ---
>>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt          | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> index 383183a89164..6db652463e64 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>> @@ -27,6 +27,7 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>>  
>>  Required properties (all function blocks):
>>  - compatible: "mediatek,<chip>-disp-<function>", one of
>> +	"mediatek,<chip>-dispsys"    - central component for the DRM system
>>  	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
>>  	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
>>  	"mediatek,<chip>-disp-wdma"  - write DMA
>> @@ -71,6 +72,11 @@ mmsys: clock-controller at 14000000 {
>>  	#clock-cells = <1>;
>>  };
>>  
>> +dispsys: display-system {
>> +	compatible = "mediatek,mt2701-dispsys";
>> +	mediatek,mmsys = <&mmsys>;
>> +}
>> +
>>  ovl0: ovl at 1400c000 {
>>  	compatible = "mediatek,mt8173-disp-ovl";
>>  	reg = <0 0x1400c000 0 0x1000>;
> 
> 
> 
