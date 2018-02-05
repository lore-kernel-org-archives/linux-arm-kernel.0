From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 05 Feb 2018 10:06:35 +0100
Subject: [RFC PATCH v2 1/5] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
References: <20180131134435.12216-1-a.hajda@samsung.com>
 <CGME20180131134457eucas1p128394aef86e0d76cfc6ccb72ee22d4b1@eucas1p1.samsung.com>
 <20180131134435.12216-2-a.hajda@samsung.com>
 <20180205060836.pybxzt5e2kdu2wew@rob-hp-laptop>
Message-ID: <a9745020-602b-8274-e2d6-63295f5b3caa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05.02.2018 07:08, Rob Herring wrote:
> On Wed, Jan 31, 2018 at 02:44:31PM +0100, Andrzej Hajda wrote:
>> These bindings allow to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v2:
>> - moved connector type(A,B,C) to compatible string (Rob),
>> - renamed size property to type (Rob),
>> - changed type description to be less confusing (Laurent),
>> - removed vendor specific compatibles (implied by graph port number),
> How so? More below...
>
>> - added requirement of connector being a child of IC (Rob),
>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>   by USB Controller in runtime, downside is that device is not able to
>>   report its real capabilities, maybe better would be to make it optional(?)),
>> - assigned port numbers to data buses (Rob).
>>
>> Regards
>> Andrzej
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>>  .../bindings/connector/usb-connector.txt           | 48 ++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> new file mode 100644
>> index 000000000000..02020f5d760a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -0,0 +1,48 @@
>> +USB Connector
>> +=============
>> +
>> +USB connector node represents physical USB connector. It should be
>> +a child of USB interface controller.
>> +
>> +Required properties:
>> +- compatible: describes type of the connector, must be one of:
>> +    "usb-a-connector", "usb-b-connector", "usb-c-connector",
> Nit: one per line.
>
>> +
>> +Optional properties:
>> +- label: symbolic name for the connector
>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>> +  non-standard (large) connector sizes: "mini", "micro"
>> +
>> +Required nodes:
>> +- any data bus to the connector should be modeled using the OF graph bindings
>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>> +  the connector. Since single connector can have multpile data buses every bus
>> +  has assigned OF graph port number as follows:
>> +    0: High Speed (HS), present in all connectors,
>> +    1: Super Speed (SS), present in SS capable connectors,
>> +    2: Sideband use (SBU), present in USB-C,
>> +    3: Mobile High-Definition Link (MHL), present in 11-pin Samsung micro-USB
> This is un-muxed unlike Type-C where the signals are muxed with USB SS. 
> That makes me think the Samsung connector should have its own compatible 
> string.

Do you mean, sth like:
??? connector {
??? ??? ??? compatible = "samsung,usb-connector-11pin";
??? ??? ??? label = "micro-USB";
??? ??? ??? ports {
??? ??? ??? ??? ??? #address-cells = <1>;
??? ??? ??? ??? ??? #size-cells = <0>;

??? ??? ??? ??? ??? port at 3 {
??? ??? ??? ??? ??? ??? ??? reg = <3>;
??? ??? ??? ??? ??? ??? ??? musb_con_mhl_in: endpoint {
??? ??? ??? ??? ??? ??? ??? ??? ??? remote-endpoint = <&mhl_out>;
??? ??? ??? ??? ??? ??? ??? };
??? ??? ??? ??? ??? };
??? };

Or should I add "usb-b-connector" extra compatible and "type" property?
I slightly prefer my approach(less different bindings), but I am also OK
with the above.

>
> Can we go ahead and define the video modes of Type-C? Normally, if 2 
> data streams are mutually exclusive, then they are a single port with 2 
> endpoints. So we'd either have 2 endpoints on port 1 or we stick with 
> port 3 is always video. We can still know what is mutually exclusive 
> based on the compatible. 

I am sorry, I do not understand what you mean. Port 3 is present only in
11-pin Samsung micro-USB, USB Type-C has only ports 0, 1, 2.
Here is list of possible ports depending on connector type:
- USB 2.0: HS
- 11-pin Samsung micro-USB: HS,MHL
- USB 3.x type A,B: HS,SS
- USB-C: HS,SS,SBU

All ports have separate lines, so they can work simultaneously.

And regarding MHL on standard micro-USB connector. MHL and MUIC will
share HS port, but there will be mux somewhere before connector:
- in MUIC, in this case MUIC will be the parent of the connector, and
there will be graph from MHL to MUIC to describe MHL link,
- in MHL, in this case MHL will be the parent of the connector, and
graph between MUIC and MHL to describe HS link,
- dedicated mux to MUIC and MHL, controlled by gpio pin, it could be
handled by MUIC's external-mux gpio property for example, or (probably)
less hacky by separate node for mux,
or as additional property in the connector (who should be the parent of
the connector then? Probably MUIC?).

Regards
Andrzej





>
>> +
>> +Example
>> +-------
>> +
>> +muic_max77843 at 66 {
>> +	...
>> +	musb_con: connector {
>> +		compatible = "usb-b-connector";
>> +		label = "micro-USB";
>> +		type = "micro";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 3 {
>> +				reg = <3>;
>> +				musb_con_mhl_in: endpoint {
>> +					remote-endpoint = <&mhl_out>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 2.15.1
>>
>
>
