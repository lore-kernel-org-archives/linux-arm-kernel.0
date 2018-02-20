From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 20 Feb 2018 09:10:42 +0100
Subject: [RFC PATCH v2 1/6] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <20180219142847.3rnvtai6msjlyj5b@rob-hp-laptop>
References: <20180215103920.32017-1-a.hajda@samsung.com>
 <CGME20180215103925eucas1p1d82fd73ac6ea77c8b66de4ed26101a71@eucas1p1.samsung.com>
 <20180215103920.32017-2-a.hajda@samsung.com>
 <20180219142847.3rnvtai6msjlyj5b@rob-hp-laptop>
Message-ID: <d5d38789-4d28-dce7-054f-f91bd82275cc@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.02.2018 15:28, Rob Herring wrote:
> On Thu, Feb 15, 2018 at 11:39:15AM +0100, Andrzej Hajda wrote:
>> These bindings allow to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> v3:
>> - removed MHL port (samsung connector will have separate bindings),
>> - added 2nd example for USB-C,
>> - improved formatting
>> v2:
>> - moved connector type(A,B,C) to compatible string (Rob),
>> - renamed size property to type (Rob),
>> - changed type description to be less confusing (Laurent),
>> - removed vendor specific compatibles (implied by graph port number),
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
>>
>> dt-bindings: add bindings for USB physical connector v3
>> ---
>>  .../bindings/connector/usb-connector.txt           | 74 ++++++++++++++++++++++
>>  1 file changed, 74 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> new file mode 100644
>> index 000000000000..1efda92639da
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -0,0 +1,74 @@
>> +USB Connector
>> +=============
>> +
>> +USB connector node represents physical USB connector. It should be
>> +a child of USB interface controller.
>> +
>> +Required properties:
>> +- compatible: describes type of the connector, must be one of:
>> +    "usb-a-connector",
>> +    "usb-b-connector",
>> +    "usb-c-connector".
>> +
>> +Optional properties:
>> +- label: symbolic name for the connector,
>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>> +  non-standard (large) connector sizes: "mini", "micro".
> The smaller connectors are standard too. Perhaps "non-fullsize connector 
> sizes".

The word "standard" is used in specs, but your description looks better,
maybe even shorter version would work: "non-fullsize connectors:".

>
> We're missing a micro-AB connector, but I think those are actually 
> pretty rare. Most phones are micro-B connectors, but do both host and 
> device.
>
>> +
>> +Required nodes:
>> +- any data bus to the connector should be modeled using the OF graph bindings
>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>> +  the connector. Since single connector can have multpile data buses every bus
>> +  has assigned OF graph port number as follows:
>> +    0: High Speed (HS), present in all connectors,
>> +    1: Super Speed (SS), present in SS capable connectors,
> This should also say endpoint 0 is USB-SS, endpoint 1 (and higher?) is 
> Alternate Mode. And show in the example.

What if there is SS mux before, which muxes USB-SS and DP lines. In my
case the mux is located in USB-PHY (it is 2nd example below).
In such case there is only one graph connection to SS port and this
connection will handle both USB-SS and AltMode traffic.
Anyway from USB-C connector's point of view, there is no distinction
which lines are USB-SS, which are AltMode. In fact platform decides in
real time about muxing of SS and AltMode signals, as it depends on
cable/plug orientations. Maybe instead of mapping endpoint numbers to
SS/AltMode, we should map them to SS1/SS2 lines if necessary(???).

To be sure of your intentions. Do you want to model simple SS muxes as a
part of USB-C connector?

>> +    2: Sideband use (SBU), present in USB-C.
>> +
>> +Examples
>> +--------
>> +
>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>> +
>> +muic-max77843 at 66 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-b-connector";
>> +		label = "micro-USB";
>> +		type = "micro";
>> +	};
>> +};
>> +
>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort:
> Having SBU to DP but no DP video path connection is wrong.

But it is real hardware :)
As I said earlier, DP video lines are connected to mux in USB3-PHY.
I can add this explanation to the description to make it clear.

Regards
Andrzej

>
>> +
>> +ccic: s2mm005 at 33 {
>> +	...
>> +	usb_con: connector {
>> +		compatible = "usb-c-connector";
>> +		label = "USB-C";
>> +
>> +		ports {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +
>> +			port at 0 {
>> +				reg = <0>;
>> +				usb_con_hs: endpoint {
>> +					remote-endpoint = <&max77865_usbc_hs>;
>> +				};
>> +			};
>> +			port at 1 {
>> +				reg = <1>;
>> +				usb_con_ss: endpoint {
>> +					remote-endpoint = <&usbdrd_phy_ss>;
>> +				};
>> +			};
>> +			port at 2 {
>> +				reg = <2>;
>> +				usb_con_sbu: endpoint {
>> +					remote-endpoint = <&dp_aux>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
>> -- 
>> 2.16.1
>>
>
>
