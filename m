From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 07 Jun 2017 16:48:50 +0800
Subject: [PATCH v2 01/11] dt-bindings: update the binding for Allwinner H3
 TVE support
In-Reply-To: <20170607084544.kgclybyxxttfk3ko@flea.lan>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-2-icenowy@aosc.io>
 <20170607084544.kgclybyxxttfk3ko@flea.lan>
Message-ID: <092D4797-0034-4C39-A30A-92CFAB23AAF8@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?6?7? GMT+08:00 ??4:45:44, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>On Mon, Jun 05, 2017 at 12:01:39AM +0800, Icenowy Zheng wrote:
>> Allwinner H3 features a "DE2.0" and a TV Encoder.
>> 
>> Add device tree bindings for the following parts:
>> - H3 TCONs
>> - H3 Mixers
>> - The connection between H3 TCONs and H3 Mixers
>> - H3 TV Encoder
>> - H3 Display engine
>> 
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v2:
>> - Changed endpoint reg definition on TCONs and Mixers. Now the
>endpoint
>>   id is just the component id.
>> - Changed TVE and TCON1 binding -- now CLK_TVE is passed as TCON1
>lcd-ch1.
>> 
>>  .../bindings/display/sunxi/sun4i-drm.txt           | 37
>+++++++++++++++++++---
>>  1 file changed, 33 insertions(+), 4 deletions(-)
>> 
>> diff --git
>a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> index b83e6018041d..7ad164cb7dcb 100644
>> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> @@ -49,7 +49,9 @@ The TV Encoder supports the composite and VGA
>output. It is one end of
>>  the pipeline.
>>  
>>  Required properties:
>> - - compatible: value should be "allwinner,sun4i-a10-tv-encoder".
>> + - compatible: value must be either:
>> +    * allwinner,sun4i-a10-tv-encoder
>> +    * allwinner,sun8i-h3-tv-encoder
>>   - reg: base address and size of memory-mapped region
>>   - clocks: the clocks driving the TV encoder
>>   - resets: phandle to the reset controller driving the encoder
>> @@ -69,23 +71,27 @@ Required properties:
>>     * allwinner,sun6i-a31-tcon
>>     * allwinner,sun6i-a31s-tcon
>>     * allwinner,sun8i-a33-tcon
>> +   * allwinner,sun8i-h3-tcon
>>     * allwinner,sun8i-v3s-tcon
>>   - reg: base address and size of memory-mapped region
>>   - interrupts: interrupt associated to this IP
>>   - clocks: phandles to the clocks feeding the TCON. Three are
>needed:
>>     - 'ahb': the interface clocks
>> -   - 'tcon-ch0': The clock driving the TCON channel 0
>>   - resets: phandles to the reset controllers driving the encoder
>>     - "lcd": the reset line for the TCON channel 0
>>  
>>   - clock-names: the clock names mentioned above
>>   - reset-names: the reset names mentioned above
>> - - clock-output-names: Name of the pixel clock created
>>  
>>  - ports: A ports node with endpoint definitions as defined in
>>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
>>    first port should be the input endpoint, the second one the output
>>  
>> +  In the situation of Display Engine 2.0 that the connection between
>> +  the mixer and the TCON can be swapped, the input should have two
>> +  endpoints. The first input endpoint should be connected to mixer0
>> +  and the second should be connected to mixer1.
>> +
>
>AFAIK, this is also the case for dual-pipelines on DE1 (for example on
>the A31). And this is already covered by:
>
>"
>For the input port of all components up to the TCON in the display
>pipeline, if there are multiple components, the local endpoint IDs
>must correspond to the index of the upstream block. For example, if
>the remote endpoint is Frontend 1, then the local endpoint ID must
>be 1.
>"

If you think it can fully cover this situation, I'm glad to remove
this paragraph, although I think overall paragraphs are easy
to be ignored.

>
>>    The output may have multiple endpoints. The TCON has two channels,
>>    usually with the first channel being used for the panels
>interfaces
>>    (RGB, LVDS, etc.), and the second being used for the outputs that
>> @@ -94,7 +100,23 @@ Required properties:
>>    channel the endpoint is associated to. If that property is not
>>    present, the endpoint number will be used as the channel number.
>>  
>> -On SoCs other than the A33 and V3s, there is one more clock
>required:
>> +For the following compatibles:
>> +   * allwinner,sun5i-a13-tcon
>> +   * allwinner,sun6i-a31-tcon
>> +   * allwinner,sun6i-a31s-tcon
>> +   * allwinner,sun8i-a33-tcon
>> +   * allwinner,sun8i-v3s-tcon
>> +there is one more clock and one more property required:
>> + - clocks:
>> +   - 'tcon-ch0': The clock driving the TCON channel 0
>> + - clock-output-names: Name of the pixel clock created
>> +
>> +For the following compatibles:
>> +   * allwinner,sun5i-a13-tcon
>> +   * allwinner,sun6i-a31-tcon
>> +   * allwinner,sun6i-a31s-tcon
>> +   * allwinner,sun8i-h3-tcon
>> +there is one more clock required:
>>     - 'tcon-ch1': The clock driving the TCON channel 1
>>  
>>  DRC
>> @@ -189,6 +211,8 @@ supported.
>>  Required properties:
>>    - compatible: value must be one of:
>>      * allwinner,sun8i-v3s-de2-mixer
>> +    * allwinner,sun8i-h3-de2-mixer0
>> +    * allwinner,sun8i-h3-de2-mixer1
>
>Again, please explain why we need to have different compatibles
>here. If it's only about the number of planes, this should be dealt
>with a property, not a compatible.

Only mixer0 has "VEP" and write-back support, at least on H3.

>
>Maxime
