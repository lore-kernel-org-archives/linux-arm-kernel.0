From: mbrugger@suse.com (Matthias Brugger)
Date: Thu, 19 Oct 2017 17:11:04 +0200
Subject: [RFC resend 1/4] dt-bindings: display: mediatek: add drm binding
In-Reply-To: <1508418397.7665.18.camel@pengutronix.de>
References: <20171019112610.13645-1-mbrugger@suse.com>
 <20171019112610.13645-2-mbrugger@suse.com> <8477650.BPhWpTmuMS@avalon>
 <1508418397.7665.18.camel@pengutronix.de>
Message-ID: <4160167d-dde5-98d0-7ce7-9895fd107224@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/19/2017 03:06 PM, Philipp Zabel wrote:
> On Thu, 2017-10-19 at 15:53 +0300, Laurent Pinchart wrote:
>> Hi Matthias,
>>
>> Thank you for the patch.
>>
>> On Thursday, 19 October 2017 14:26:07 EEST Matthias Brugger wrote:
>>> DRM subysystem and clock driver shared the same compatible mmsys.
>>> This stopped does not work, as only the first driver for a compatible
>>> gets probed. We change the comaptible to the new DRM identifier to fix
>>> this.
>>>
>>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>>> ---
>>>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt          | 6 +++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git
>>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>>> index 383183a89164..6db652463e64 100644
>>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
>>> @@ -27,6 +27,7 @@
>>> Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>>>
>>>  Required properties (all function blocks):
>>>  - compatible: "mediatek,<chip>-disp-<function>", one of
>>> +	"mediatek,<chip>-dispsys"    - central component for the DRM system
>>>  	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
>>>  	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
>>>  	"mediatek,<chip>-disp-wdma"  - write DMA
>>> @@ -71,6 +72,11 @@ mmsys: clock-controller at 14000000 {
>>>  	#clock-cells = <1>;
>>>  };
>>>
>>> +dispsys: display-system {
>>> +	compatible = "mediatek,mt2701-dispsys";
>>> +	mediatek,mmsys = <&mmsys>;
>>> +}
>>
>> So this node doesn't correspond to an IP core but is meant as a top-level 
>> entry point for the operating system. This leads me to three questions.
>>
>> 1. Is there any IP core in the Mediatek display subsystem that could be 
>> considered (or at least used) as a top-level entry point ? That would be my 
>> preferred solution as I'm not fond of DT nodes not describing hardware.
> 
> At least on MT8173 that node is MMSYS, which it is currently matching
> against. The issue, if I understand correctly, is that the clocks
> provided by this same region were previously created via CLK_OF_DECLARE,
> and are now changed to a separate clock driver that matches to the same 
> node.
> 

Exactly that seems to be the problem we hit. I have to setup my chromebook to do
some changes, but that won't happen before the week after next week.

So yes, the MMSYS is the top-level-entry point for the display subsystem, the
clocks in mmsys are just a small part of the whole register block. I will cite
the cover letter which unfortunately wasn't send, because I broke my email setup:
"Possible solutions:
1) We add a new mediatek,mt8173-mmsys-clk node, which lives as a simple-mfd
under the actual mmsys node. We change the clock driver to probe on this
binding. This would make sense as the clock gate register live completely in
the MMSYS configuration registers.

2) As the nodes of the DRM subsystem just need some of the registers of MMSYS
we add a new binding mediatek,mt8173-dispsys which probes the central
component of the DRM system. It has only a handle to mt8173-mmsys to access
the registerspace via regmap functions."

So this patch set implemented solution 2).


>> 2. If there's no such IP core, are all the display subsystem IP cores grouped 
>> together in one MMIO register range ? If so we could move them as children of 
>> this new display system node which, even if doesn't describe an IP core, would 
>> describe the way the display IP cores are grouped in the hardware, and would 
>> thus be a hardware description.
>>

They are all mapped somewhere at 140xxxxx. But there are other components which
are used by other HW blocks smi_common especially. So I'm not sure which impact
that move would have.

The MMSYS for mt8173 actually enables the overlays and set's the multiplexer for
the output path. Does this make sense? It's the first time I've a deeper look in
such a driver, so maybe I don't grasp everything.

Regards,
Matthias

>> 3. If the answer to the second question is also negative, shouldn't this 
>> display system node reference all other display IP DT nodes (through direct 
>> phandles and/or OF graph bindings) ?
>>
>>>  ovl0: ovl at 1400c000 {
>>>  	compatible = "mediatek,mt8173-disp-ovl";
>>>  	reg = <0 0x1400c000 0 0x1000>;
>>
> 
> regards
> Philipp
> 
