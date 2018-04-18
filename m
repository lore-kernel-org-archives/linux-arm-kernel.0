From: peda@axentia.se (Peter Rosin)
Date: Wed, 18 Apr 2018 09:31:53 +0200
Subject: [PATCH v2 2/6] dt-bindings: display: atmel: optional
 video-interface of endpoints
In-Reply-To: <20180418091658.690e3d5e@bbrezillon>
References: <20180417131052.16336-1-peda@axentia.se>
 <20180417131052.16336-3-peda@axentia.se> <20180418091658.690e3d5e@bbrezillon>
Message-ID: <ffa56109-db0a-5619-2214-d163a2a42ef6@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-04-18 09:16, Boris Brezillon wrote:
> Hi Peter,
> 
> On Tue, 17 Apr 2018 15:10:48 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> With bus-type/bus-width properties in the endpoint nodes, the video-
>> interface of the connection can be specified for cases where the
>> heuristic fails to select the correct output mode. This can happen
>> e.g. if not all RGB pins are routed on the PCB; the driver has no
>> way of knowing this, and needs to be told explicitly.
>>
>> This is critical for the devices that have the "conflicting output
>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>> RGB bits move around depending on the selected output mode. For
>> devices that do not have the "conflicting output formats" issue
>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> index 82f2acb3d374..244b48869eb4 100644
>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>> @@ -15,6 +15,14 @@ Required children nodes:
>>   to external devices using the OF graph reprensentation (see ../graph.txt).
>>   At least one port node is required.
>>  
>> +Optional properties in grandchild nodes:
>> + Any endpoint grandchild node may specify a desired video interface
>> + according to ../../media/video-interfaces.txt, specifically
>> + - bus-type: must be <0>.
>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
>> +   override any output mode selection hueristic, forcing "rgb444",

heuristic, I'll fix that for v3, so please review as if it wasn't there...

>> +   "rgb565", "rgb666" and "rgb888" respectively.
>> +
> 
> Can you add an example or update the existing one to show how this
> should be defined?

For v3, I'll extend the binding with this after the preexisting example:

------------------8<-----------------
Example 2: With a video interface override to force rgb565, as above
but with these changes/additions:

&hlcdc {
	hlcdc-display-controller {
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;

		port at 0 {
			hlcdc_panel_output: endpoint at 0 {
				bus-type = <0>;
				bus-width = <16>;
			};
		};
	};
};
------------------8<-----------------

Is that a good plan, or should I perhaps duplicate the whole example?

Cheers,
Peter


>>  Example:
>>  
>>  	hlcdc: hlcdc at f0030000 {
> 
> 
> Thanks,
> 
> Boris
> 
