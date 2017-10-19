From: a.hajda@samsung.com (Andrzej Hajda)
Date: Thu, 19 Oct 2017 08:48:47 +0200
Subject: [RFC PATCH 1/4] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <3079487.ip075DyLUk@avalon>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130735eucas1p1da4f062b6948350289bba9c8bc911dd7@eucas1p1.samsung.com>
 <20170928130730.8747-2-a.hajda@samsung.com> <3079487.ip075DyLUk@avalon>
Message-ID: <b99881e2-e37e-8365-eb34-524193c2bc4a@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Thank you for the review.

On 18.10.2017 17:11, Laurent Pinchart wrote:
> Hi Andrzej,
>
> Thank you for the patch.
>
> On Thursday, 28 September 2017 16:07:27 EEST Andrzej Hajda wrote:
>> These bindings allows to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> There are few things for discussion (IMO):
>> 1. vendor specific connectors, I have added them here, but maybe better is
>>    to place them in separate files.
> It's useful to have one vendor-specific compatible string to be used in the 
> example. We could split vendor-specific connectors to separate files later if 
> needed, but for now I'm fine keeping them here.
>
>> 2. physical connector description - I have split it to three properties:
>>    type(a,b,ab,c), max-mode(ls,fs,hs,ss,ss+), size(mini,micro,powered).
>>    This tripled is able to describe all USB-standard connectors, but there
>>    are also impossible combinations, for example(c, *, micro). Maybe better
>>    would be to just enumerate all possible connectors in include file.
> I don't have a strong opinion on this. The three properties are nicely 
> descriptive. You might want to list the valid combinations in the bindings 
> though.

According to Rob's suggestion in next iteration I will encode USB port
type into compatible ie:
- usb-a-connector,
- usb-b-connector,
- usb-c-connector.

Rob suggested also to encode there speed as well, but I am afraid it
will inflate number of compatibles:
(3 types: a, b, c) x (3 speed modes: hs, ss, ssplus) = 9 combinations

>> 3. Numbering of port/remote nodes, currently only 0 is assigned for
>> Interface Controller. Maybe other functions should be also assigned:
>>    HS, SS, CC, SBU, ... whatever. Maybe functions should be described
>>    as an additional property of remote node?
> Given that one of the main reasons this binding is needed is to describe MHL 
> connection to a USB connector, I think we'll need to define additional 
> functions, yes. I'm not sure yet how that should look like though.

Current idea is to encode it in port number.

>
>> ---
>>  .../bindings/connector/usb-connector.txt           | 49 +++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644
>> Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt
>> b/Documentation/devicetree/bindings/connector/usb-connector.txt new file
>> mode 100644
>> index 000000000000..f3a4e85122d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> @@ -0,0 +1,49 @@
>> +USB Connector
>> +=============
>> +
>> +Required properties:
>> +- compatible: "usb-connector"
>> +  connectors with vendor specific extensions can add one of additional
>> +  compatibles:
>> +    "samsung,usb-connector-11pin": 11-pin Samsung micro-USB connector
>> +- type: the USB connector type: "a", "b", "ab", "c"
>> +- max-mode: max USB speed mode supported by the connector:
>> +  "ls", "fs", "hs", "ss", "ss+"
>> +
>> +Optional properties:
>> +- label: a symbolic name for the connector
>> +- size: size of the connector, should be specified in case of
>> +  non-standard USB connectors: "mini", "micro", "powered"
> "non-standard" sounds like "vendor-specific", while I assume you're talking 
> about the size. The USB specification uses the term "standard" for this 
> purpose, so it's hard to use another one that would convey the right meaning 
> precisely. Maybe "non-standard ('large') USB connector sizes" ?

OK.

And answer for your question from other e-mail:
> One more comment, do I assume correctly that the Samsung 11-pin connector 
> carries USB and MHL on different pins ?

Yes, there are three additional pins: MHL_DP, MHL_DN and MHL_ID [1].

[1]:
https://ae01.alicdn.com/kf/HTB1nn.6KVXXXXaNXFXXq6xXFXXXc/221542210/HTB1nn.6KVXXXXaNXFXXq6xXFXXXc.jpg?size=69211&height=700&width=700&hash=dcababf11610a489d451d7cb0b8ab60e

Thanks
Andrzej

>
>> +Required nodes:
>> +- any data bus to the connector should be modeled using the
>> +  OF graph bindings specified in bindings/graph.txt.
>> +  There should be exactly one port with at least one endpoint to
>> +  different device nodes. The first endpoint (reg = <0>) should
>> +  point to USB Interface Controller.
>> +
>> +Example
>> +-------
>> +
>> +musb_con: connector {
>> +	compatible = "samsung,usb-connector-11pin", "usb-connector";
>> +	label = "usb";
>> +	type = "b";
>> +	size = "micro";
>> +	max-mode = "hs";
>> +
>> +	port {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		musb_con_usb_in: endpoint at 0 {
>> +			reg = <0>;
>> +			remote-endpoint = <&muic_usb_out>;
>> +		};
>> +
>> +		musb_con_mhl_in: endpoint at 1 {
>> +			reg = <1>;
>> +			remote-endpoint = <&mhl_out>;
>> +		};
>> +	};
>> +};
