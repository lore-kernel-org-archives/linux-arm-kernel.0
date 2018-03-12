From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 12 Mar 2018 08:06:42 +0100
Subject: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
 <ed0ce43c-3c81-b027-2eb1-30e49156c3ac@ti.com>
 <b588527d-2ca2-9e88-9e27-e09e5b52f8d6@samsung.com>
Message-ID: <3503bb79-e9aa-360d-adb8-767f68ba5330@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.03.2018 08:02, Andrzej Hajda wrote:
> On 09.03.2018 11:24, Roger Quadros wrote:
>> Hi,
>>
>> On 27/02/18 09:11, Andrzej Hajda wrote:
>>> These bindings allow to describe most known standard USB connectors
>>> and it should be possible to extend it if necessary.
>>> USB connectors, beside USB can be used to route other protocols,
>>> for example UART, Audio, MHL. In such case every device passing data
>>> through the connector should have appropriate graph bindings.
>>>
>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>> ---
>>> v4:
>>> - improved 'type' description (Rob),
>>> - improved description of 2nd example (Rob).
>>> v3:
>>> - removed MHL port (samsung connector will have separate bindings),
>>> - added 2nd example for USB-C,
>>> - improved formatting.
>>> v2:
>>> - moved connector type(A,B,C) to compatible string (Rob),
>>> - renamed size property to type (Rob),
>>> - changed type description to be less confusing (Laurent),
>>> - removed vendor specific compatibles (implied by graph port number),
>>> - added requirement of connector being a child of IC (Rob),
>>> - removed max-mode (subtly suggested by Rob, it should be detected anyway
>>>   by USB Controller in runtime, downside is that device is not able to
>>>   report its real capabilities, maybe better would be to make it optional(?)),
>>> - assigned port numbers to data buses (Rob).
>>>
>>> Regards
>>> Andrzej
>>> ---
>>>  .../bindings/connector/usb-connector.txt           | 75 ++++++++++++++++++++++
>>>  1 file changed, 75 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> new file mode 100644
>>> index 000000000000..e1463f14af38
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>> @@ -0,0 +1,75 @@
>>> +USB Connector
>>> +=============
>>> +
>>> +USB connector node represents physical USB connector. It should be
>>> +a child of USB interface controller.
>>> +
>>> +Required properties:
>>> +- compatible: describes type of the connector, must be one of:
>>> +    "usb-a-connector",
>>> +    "usb-b-connector",
>>> +    "usb-c-connector".
>> compatible should be just "usb-connector"
>>
>> Type should be a property
>>
>> type: type of usb connector "A", "B", "AB", "C"
>> AB is for dual-role connectors.
> I have proposed such property (and size also) in my first RFC [1]. Rod
> did not like it :)

Ups, ugly typo, I meant Rob, of course.

Regards
Andrzej

>
> [1]: https://marc.info/?l=devicetree&m=150660411515233&w=2
>
>
>> micro super-speed and high-speed connectors are different. How do you differentiate that?
> I am aware of it, and property differentiating it was also in my earlier
> iterations.
> If there will be need to differentiate such connectors, adding property
> max-speed or max-mode would do the thing.
>
>>> +
>>> +Optional properties:
>>> +- label: symbolic name for the connector,
>> Why do you need label? We can't maintain consistency as people will put creative names there.
>> Device/bus driver could generate a valid label.
> It follows convention for other connectors: HDMI, DVI, ....
>
>>> +- type: size of the connector, should be specified in case of USB-A, USB-B
>>> +  non-fullsize connectors: "mini", "micro".
>> type is misleading. Type is usually A/B/C. It should be size here instead.
> As you can see in discussion for previous iterations it follows
> convention already established for other connectors.
>
>> size: size of the connector if not standard size. "mini", "micro"
>>
>> If not specified it is treated as standard sized connector.
>> e.g. for Type-C there is no mini/micro. so size doesn't have to be specificed
> Few lines above it is described: should be specified in case of USB-A,
> USB-B non-fullsize connectors.
>
>> What about Type-C connector?
>>> +
>>> +Required nodes:
>>> +- any data bus to the connector should be modeled using the OF graph bindings
>> s/modeled/modelled
>>> +  specified in bindings/graph.txt, unless the bus is between parent node and
>>> +  the connector. Since single connector can have multpile data buses every bus
>> s/multpile/multiple
> OK, I will fix both typos.
>
>>> +  has assigned OF graph port number as follows:
>>> +    0: High Speed (HS), present in all connectors,
>>> +    1: Super Speed (SS), present in SS capable connectors,
>>> +    2: Sideband use (SBU), present in USB-C.
>>> +
>>> +Examples
>>> +--------
>>> +
>>> +1. Micro-USB connector with HS lines routed via controller (MUIC):
>>> +
>>> +muic-max77843 at 66 {
>>> +	...
>>> +	usb_con: connector {
>>> +		compatible = "usb-b-connector";
>>> +		label = "micro-USB";
>>> +		type = "micro";
>>> +	};
>>> +};
>>> +
>>> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
>>> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
>>> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
>>> +
>>> +ccic: s2mm005 at 33 {
>>> +	...
>>> +	usb_con: connector {
>>> +		compatible = "usb-c-connector";
>>> +		label = "USB-C";
>> The label is not consistent with the earlier example.
> Why?
>
> Regards
> Andrzej
>
>>> +
>>> +		ports {
>>> +			#address-cells = <1>;
>>> +			#size-cells = <0>;
>>> +
>>> +			port at 0 {
>>> +				reg = <0>;
>>> +				usb_con_hs: endpoint {
>>> +					remote-endpoint = <&max77865_usbc_hs>;
>>> +				};
>>> +			};
>>> +			port at 1 {
>>> +				reg = <1>;
>>> +				usb_con_ss: endpoint {
>>> +					remote-endpoint = <&usbdrd_phy_ss>;
>>> +				};
>>> +			};
>>> +			port at 2 {
>>> +				reg = <2>;
>>> +				usb_con_sbu: endpoint {
>>> +					remote-endpoint = <&dp_aux>;
>>> +				};
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>>
