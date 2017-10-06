From: a.hajda@samsung.com (Andrzej Hajda)
Date: Fri, 06 Oct 2017 13:10:39 +0200
Subject: [RFC PATCH 1/4] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <20171005231204.ghvohuue26knemn6@rob-hp-laptop>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130735eucas1p1da4f062b6948350289bba9c8bc911dd7@eucas1p1.samsung.com>
 <20170928130730.8747-2-a.hajda@samsung.com>
 <20171005231204.ghvohuue26knemn6@rob-hp-laptop>
Message-ID: <f242145c-d69d-9dce-3ea4-0ed00a400eef@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thanks for review.

On 06.10.2017 01:12, Rob Herring wrote:
> On Thu, Sep 28, 2017 at 03:07:27PM +0200, Andrzej Hajda wrote:
>> These bindings allows to describe most known standard USB connectors
>> and it should be possible to extend it if necessary.
>> USB connectors, beside USB can be used to route other protocols,
>> for example UART, Audio, MHL. In such case every device passing data
>> through the connector should have appropriate graph bindings.
> Yay!
>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
>> There are few things for discussion (IMO):
>> 1. vendor specific connectors, I have added them here, but maybe better is
>>    to place them in separate files.
> I'd worry about the standard connectors first, but probably good to have 
> an idea of how vendor connectors need to be extended.
>
>> 2. physical connector description - I have split it to three properties:
>>    type(a,b,ab,c), max-mode(ls,fs,hs,ss,ss+), size(mini,micro,powered).
>>    This tripled is able to describe all USB-standard connectors, but there
>>    are also impossible combinations, for example(c, *, micro). Maybe better
>>    would be to just enumerate all possible connectors in include file.
> We did "type" for hdmi-connector, but I think I'd really prefer 
> compatible be used to distinguish as least where it may matter to s/w. 
> In the HDMI case, they all are pretty much the same, just different 
> physical size.

I guess that from S/W point of view only matters:
- which IP is connected to which part of the connector, and this can be
handled by port node(s),
- Type: A, B, C
- probably maximal supported speed of the connector - for example SS+
connectors have the same wires but different electrical characteristics
than SS as I understand,

With this in mind maybe we can drop 'type' and introduce following
compatibles:
- usb-a-connector,
- usb-b-connector,
- usb-c-connector.
Encoding other properties in compatible would explode their number, so I
would prefer to avoid it.
I would leave other props:
max-speed: hs, ss, ss+,
(optional)size: micro, mini

I would drop also unpopular/obsolete variants: type-ab, powered, they
can be added later if necessary.

Just for reference, list of connectors defined by USB (>= 2) specifications:
1. USB 2.0 (with later amendments):
- Standard-A plug and receptacle
- Standard-B plug and receptacle
- Mini-B plug and receptacle
- Micro-B plug and receptacle
- Micro-AB receptacle
- Micro-A plug
2. USB 3.0:
- USB 3.0 Standard-A plug and receptacle
- USB 3.0 Standard-B plug and receptacle
- USB 3.0 Powered-B plug and receptacle
- USB 3.0 Micro-B plug and receptacle
- USB 3.0 Micro-A plug
- USB 3.0 Micro-AB receptacle
3. USB 3.1:
- Enhanced SuperSpeed Standard-A plug and receptacle
- Enhanced SuperSpeed Standard-B plug and receptacle
- Enhanced SuperSpeed Micro-B plug and receptacle
- Enhanced SuperSpeed Micro-A plug
- Enhanced SuperSpeed Micro-AB receptacle
4. USB-C (release 1.3):
- USB Full-Featured Type-C receptacle
- USB 2.0 Type-C receptacle
- USB Full-Featured Type-C plug
- USB 2.0 Type-C plug
- USB Type-C Power-Only plug

>> 3. Numbering of port/remote nodes, currently only 0 is assigned for Interface
>>    Controller. Maybe other functions should be also assigned:
>>    HS, SS, CC, SBU, ... whatever. Maybe functions should be described
>>    as an additional property of remote node?
> child of the controller is also an option. There's already prec

Shall we support both solutions or just make one mandatory?

>
>> ...
>>
>> Regards
>> Andrzej
>> ---
>>  .../bindings/connector/usb-connector.txt           | 49 ++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>
>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>> new file mode 100644
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
> Do we really see cases where the connector is slower than the 
> controller? Plus things like "ls" with an type A connector are not 
> valid.

For example Galaxy Note 4 - it has USB3 controller and micro-USB 2.0
connector.

>
>> +
>> +Optional properties:
>> +- label: a symbolic name for the connector
>> +- size: size of the connector, should be specified in case of
>> +  non-standard USB connectors: "mini", "micro", "powered"
> What does powered mean?

It is standard-B connector with additional power pins, as defined in
USB3.0 spec, we can drop it as not-popular one.


>
> This is really "type" if you compare to HDMI.

As type is already used,? I have to use other word, maybe 'form' would
be better.

>
>> +
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
> These all are implied by "samsung,usb-connector-11pin".

Yes, but "usb-connector" compatible requires/permits it, or am I wrong ?

>
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
> I think this should be 2 ports, not 2 endpoints. Think of ports as 
> different data streams and endpoints are either the same data stream 
> muxed or fanned out depending on direction. Now for Type-C, 1 port for 
> USB and alternate modes is probably correct.

I agree for ports.
Regarding type-c, it has separate lines for HS and for SS. HS lines
often go to Interface Controller as they can be used to legacy detection
methods and alternatively muxed to UART.
SS lines go directly to USB3 chip, see for example TPS65982 [1][2]. For
me it is an argument against merging SS and HS lines into one port. What
do you think?
My proposition of port numbering:
0: ID for type-B, CC for type-C
1: HS
2: VBUS - I am not sure if this should be modeled this way, as it is not
a data line,
3: SS
4: SBU

In case of connector being child node of controller some ports can be
omited.

[1]: http://www.ti.com/ods/images/SLVSD02C/pg1_slvsd02.gif
[2]: http://www.ti.com/product/TPS65982/datasheet

Regards
Andrzej

>
> Rob
>
>
>
