From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue, 30 Jan 2018 02:08:55 +0800
Subject: [linux-sunxi] Re: [PATCH v3 06/12] dt-bindings: display:
 sun4i-drm: Add A83T HDMI pipeline
In-Reply-To: <20180129180526.v2vokx75zg2diem3@rob-hp-laptop>
References: <20180117201421.25954-1-jernej.skrabec@siol.net>
 <20180117201421.25954-7-jernej.skrabec@siol.net>
 <20180129180526.v2vokx75zg2diem3@rob-hp-laptop>
Message-ID: <2330C9BC-F3CF-436C-83D6-79A0304A90A4@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2018?1?30? GMT+08:00 ??2:05:26, Rob Herring <robh@kernel.org> ??:
>On Wed, Jan 17, 2018 at 09:14:15PM +0100, Jernej Skrabec wrote:
>> This commit adds all necessary compatibles and descriptions needed to
>> implement A83T HDMI pipeline.
>> 
>> Mixer is already properly described, so only compatible is added.
>> 
>> However, A83T TV TCON, which is connected to HDMI, doesn't have
>channel 0,
>> contrary to all TCONs currently described. Because of that, TCON
>> documentation is extended.
>> 
>> A83T features Synopsys DW HDMI controller with a custom PHY which
>looks
>> like Synopsys Gen2 PHY with few additions. Since there is no
>> documentation, needed properties were found out through
>experimentation
>> and reading BSP code.
>> 
>> At the end, example is added for newer SoCs, which feature DE2 and DW
>> HDMI.
>> 
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> ---
>>  .../bindings/display/sunxi/sun4i-drm.txt           | 197
>++++++++++++++++++++-
>>  1 file changed, 190 insertions(+), 7 deletions(-)
>> 
>> diff --git
>a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> index cd626ee1147a..4fb380f3e53d 100644
>> --- a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
>> @@ -64,6 +64,52 @@ Required properties:
>>      first port should be the input endpoint. The second should be
>the
>>      output, usually to an HDMI connector.
>>  
>> +DWC HDMI TX Encoder
>> +-------------------
>> +
>> +The HDMI transmitter is a Synopsys DesignWare HDMI 1.4 TX controller
>IP
>> +with Allwinner's own PHY IP. It supports audio and video outputs and
>CEC.
>> +
>> +These DT bindings follow the Synopsys DWC HDMI TX bindings defined
>in
>> +Documentation/devicetree/bindings/display/bridge/dw_hdmi.txt with
>the
>> +following device-specific properties.
>> +
>> +Required properties:
>> +
>> +  - compatible: value must be one of:
>> +    * "allwinner,sun8i-a83t-dw-hdmi"
>> +  - reg: base address and size of memory-mapped region
>> +  - reg-io-width: See dw_hdmi.txt. Shall be 1.
>> +  - interrupts: HDMI interrupt number
>> +  - clocks: phandles to the clocks feeding the HDMI encoder
>> +    * iahb: the HDMI bus clock
>> +    * isfr: the HDMI register clock
>> +  - clock-names: the clock names mentioned above
>> +  - resets: phandle to the reset controller
>> +  - reset-names: must be "ctrl"
>> +  - phys: phandle to the DWC HDMI PHY
>> +  - phy-names: must be "phy"
>> +
>> +  - ports: A ports node with endpoint definitions as defined in
>> +    Documentation/devicetree/bindings/media/video-interfaces.txt.
>The
>> +    first port should be the input endpoint. The second should be
>the
>> +    output, usually to an HDMI connector.
>> +
>> +DWC HDMI PHY
>> +------------
>> +
>> +Required properties:
>> +  - compatible: value must be one of:
>> +    * allwinner,sun8i-a83t-hdmi-phy
>> +  - reg: base address and size of memory-mapped region
>> +  - clocks: phandles to the clocks feeding the HDMI PHY
>> +    * bus: the HDMI PHY interface clock
>> +    * mod: the HDMI PHY module clock
>> +    * tmds: TMDS clock
>> +  - clock-names: the clock names mentioned above
>> +  - resets: phandle to the reset controller driving the PHY
>> +  - reset-names: must be "phy"
>> +
>>  TV Encoder
>>  ----------
>>  
>> @@ -94,24 +140,23 @@ Required properties:
>>     * allwinner,sun7i-a20-tcon
>>     * allwinner,sun8i-a33-tcon
>>     * allwinner,sun8i-a83t-tcon-lcd
>> +   * allwinner,sun8i-a83t-tcon-tv
>>     * allwinner,sun8i-v3s-tcon
>>   - reg: base address and size of memory-mapped region
>>   - interrupts: interrupt associated to this IP
>> - - clocks: phandles to the clocks feeding the TCON. Three are
>needed:
>> + - clocks: phandles to the clocks feeding the TCON. One is needed:
>>     - 'ahb': the interface clocks
>> -   - 'tcon-ch0': The clock driving the TCON channel 0
>
>Well, it didn't look right before saying 3 are needed, but listing 2. 
>However, you can't just change this as it affects all the other SoCs. 
>This should probably be a separate patch.
>
>>   - resets: phandles to the reset controllers driving the encoder
>>     - "lcd": the reset line for the TCON channel 0
>>  
>>   - clock-names: the clock names mentioned above
>>   - reset-names: the reset names mentioned above
>> - - clock-output-names: Name of the pixel clock created
>
>Why is this removed?
>
>>  
>>  - ports: A ports node with endpoint definitions as defined in
>>    Documentation/devicetree/bindings/media/video-interfaces.txt. The
>>    first port should be the input endpoint, the second one the output
>>  
>> -  The output may have multiple endpoints. The TCON has two channels,
>> +  The output may have multiple endpoints. TCON can have two
>channels,
>
>Perhaps you should say "can have 1 or 2 channels".
>
>>    usually with the first channel being used for the panels
>interfaces
>>    (RGB, LVDS, etc.), and the second being used for the outputs that
>>    require another controller (TV Encoder, HDMI, etc.). The endpoints
>> @@ -119,11 +164,16 @@ Required properties:
>>    channel the endpoint is associated to. If that property is not
>>    present, the endpoint number will be used as the channel number.
>>  
>> +When TCON supports channel 0 (all TCONs except TV TCON on A83T), two
>> +more clocks are needed:
>> +   - 'tcon-ch0': The clock driving the TCON channel 0
>
>Looks like one clock to me.

He should mean one input and one output.

>
>> +   - clock-output-names: Name of the pixel clock created
>
>It's better to not move this, but just add what compatibles it does or 
>doesn't apply to.

The existence of pclk out is tied with ch0 input, as ch0 input
is the parent of pclk output.

>
>> +
>>  On SoCs other than the A33 and V3s, there is one more clock
>required:
>>     - 'tcon-ch1': The clock driving the TCON channel 1
>>  
>> -On SoCs that support LVDS (all SoCs but the A13, H3, H5 and V3s),
>you
>> -need one more reset line:
>> +When TCON support LVDS (all TCONs except TV TCON on A83T and those
>found
>> +in A13, H3, H5 and V3s SoCs), you need one more reset line:
>>     - 'lvds': The reset line driving the LVDS logic
>>  
>>  And on the A23, A31, A31s and A33, you need one more clock line:
>> @@ -226,6 +276,7 @@ supported.
>>  Required properties:
>>    - compatible: value must be one of:
>>      * allwinner,sun8i-a83t-de2-mixer-0
>> +    * allwinner,sun8i-a83t-de2-mixer-1
>>      * allwinner,sun8i-v3s-de2-mixer
>>    - reg: base address and size of the memory-mapped region.
>>    - clocks: phandles to the clocks feeding the mixer
>> @@ -261,7 +312,7 @@ Required properties:
>>    - allwinner,pipelines: list of phandle to the display engine
>>      frontends (DE 1.0) or mixers (DE 2.0) available.
>>  
>> -Example:
>> +Example 1:
>>  
>>  panel: panel {
>>  	compatible = "olimex,lcd-olinuxino-43-ts";
>> @@ -460,3 +511,135 @@ display-engine {
>>  	compatible = "allwinner,sun5i-a13-display-engine";
>>  	allwinner,pipelines = <&fe0>;
>>  };
>> +
>> +Example 2:
>
>Is this really different enough to need an example? Examples don't 
>need to enumerate all possible options. They are often wrong because 
>they don't compile on their own and that creates a maintenance burden.
>
>Rob
