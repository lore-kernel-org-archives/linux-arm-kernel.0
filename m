From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 09 Oct 2017 10:49:20 +0200
Subject: [RFC PATCH 1/4] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <CAL_JsqJLfU9mmrdz14rNktCx1GMJ8rB1Oq-fmFHOgHGiO8udAg@mail.gmail.com>
References: <20170928130730.8747-1-a.hajda@samsung.com>
 <CGME20170928130735eucas1p1da4f062b6948350289bba9c8bc911dd7@eucas1p1.samsung.com>
 <20170928130730.8747-2-a.hajda@samsung.com>
 <20171005231204.ghvohuue26knemn6@rob-hp-laptop>
 <f242145c-d69d-9dce-3ea4-0ed00a400eef@samsung.com>
 <CAL_JsqJLfU9mmrdz14rNktCx1GMJ8rB1Oq-fmFHOgHGiO8udAg@mail.gmail.com>
Message-ID: <26f2e606-d150-8610-34b0-13a3864201ff@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06.10.2017 19:23, Rob Herring wrote:
> On Fri, Oct 6, 2017 at 6:10 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Hi Rob,
>>
>> Thanks for review.
>>
>> On 06.10.2017 01:12, Rob Herring wrote:
>>> On Thu, Sep 28, 2017 at 03:07:27PM +0200, Andrzej Hajda wrote:
>>>> These bindings allows to describe most known standard USB connectors
>>>> and it should be possible to extend it if necessary.
>>>> USB connectors, beside USB can be used to route other protocols,
>>>> for example UART, Audio, MHL. In such case every device passing data
>>>> through the connector should have appropriate graph bindings.
>>> Yay!
>>>
>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>> ---
>>>> There are few things for discussion (IMO):
>>>> 1. vendor specific connectors, I have added them here, but maybe better is
>>>>    to place them in separate files.
>>> I'd worry about the standard connectors first, but probably good to have
>>> an idea of how vendor connectors need to be extended.
>>>
>>>> 2. physical connector description - I have split it to three properties:
>>>>    type(a,b,ab,c), max-mode(ls,fs,hs,ss,ss+), size(mini,micro,powered).
>>>>    This tripled is able to describe all USB-standard connectors, but there
>>>>    are also impossible combinations, for example(c, *, micro). Maybe better
>>>>    would be to just enumerate all possible connectors in include file.
>>> We did "type" for hdmi-connector, but I think I'd really prefer
>>> compatible be used to distinguish as least where it may matter to s/w.
>>> In the HDMI case, they all are pretty much the same, just different
>>> physical size.
>> I guess that from S/W point of view only matters:
>> - which IP is connected to which part of the connector, and this can be
>> handled by port node(s),
>> - Type: A, B, C
>> - probably maximal supported speed of the connector - for example SS+
>> connectors have the same wires but different electrical characteristics
>> than SS as I understand,
>>
>> With this in mind maybe we can drop 'type' and introduce following
>> compatibles:
>> - usb-a-connector,
>> - usb-b-connector,
>> - usb-c-connector.
>> Encoding other properties in compatible would explode their number, so I
>> would prefer to avoid it.
>> I would leave other props:
>> max-speed: hs, ss, ss+,
>> (optional)size: micro, mini
>>
>> I would drop also unpopular/obsolete variants: type-ab, powered, they
>> can be added later if necessary.
>>
>> Just for reference, list of connectors defined by USB (>= 2) specifications:
>> 1. USB 2.0 (with later amendments):
>> - Standard-A plug and receptacle
>> - Standard-B plug and receptacle
>> - Mini-B plug and receptacle
>> - Micro-B plug and receptacle
>> - Micro-AB receptacle
>> - Micro-A plug
>> 2. USB 3.0:
>> - USB 3.0 Standard-A plug and receptacle
>> - USB 3.0 Standard-B plug and receptacle
>> - USB 3.0 Powered-B plug and receptacle
>> - USB 3.0 Micro-B plug and receptacle
>> - USB 3.0 Micro-A plug
>> - USB 3.0 Micro-AB receptacle
>> 3. USB 3.1:
>> - Enhanced SuperSpeed Standard-A plug and receptacle
>> - Enhanced SuperSpeed Standard-B plug and receptacle
>> - Enhanced SuperSpeed Micro-B plug and receptacle
>> - Enhanced SuperSpeed Micro-A plug
>> - Enhanced SuperSpeed Micro-AB receptacle
>> 4. USB-C (release 1.3):
>> - USB Full-Featured Type-C receptacle
>> - USB 2.0 Type-C receptacle
>> - USB Full-Featured Type-C plug
>> - USB 2.0 Type-C plug
>> - USB Type-C Power-Only plug
>>
>>>> 3. Numbering of port/remote nodes, currently only 0 is assigned for Interface
>>>>    Controller. Maybe other functions should be also assigned:
>>>>    HS, SS, CC, SBU, ... whatever. Maybe functions should be described
>>>>    as an additional property of remote node?
>>> child of the controller is also an option. There's already prec
>> Shall we support both solutions or just make one mandatory?
> Oops, I was just going to say for display, there's already precedent
> that ports are used. So that means at least SS should just be
> described with ports. Then HS probably should be a port too just to be
> symmetrical.
>
> The connector being a child of the USB-PD (or other controller chip)
> is probably the only thing that makes sense. I guess the question is
> whether there are cases where that doesn't make sense.
>
>>>> ---
>>>>  .../bindings/connector/usb-connector.txt           | 49 ++++++++++++++++++++++
>>>>  1 file changed, 49 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> new file mode 100644
>>>> index 000000000000..f3a4e85122d5
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
>>>> @@ -0,0 +1,49 @@
>>>> +USB Connector
>>>> +=============
>>>> +
>>>> +Required properties:
>>>> +- compatible: "usb-connector"
>>>> +  connectors with vendor specific extensions can add one of additional
>>>> +  compatibles:
>>>> +    "samsung,usb-connector-11pin": 11-pin Samsung micro-USB connector
>>>> +- type: the USB connector type: "a", "b", "ab", "c"
>>>> +- max-mode: max USB speed mode supported by the connector:
>>>> +  "ls", "fs", "hs", "ss", "ss+"
>>> Do we really see cases where the connector is slower than the
>>> controller? Plus things like "ls" with an type A connector are not
>>> valid.
>> For example Galaxy Note 4 - it has USB3 controller and micro-USB 2.0
>> connector.
> How does one distinguish a micro-B SS connector with a HS plug vs. a
> SS plug? It must be at run-time.Wouldn't a HS connector behave
> operate the same as the former case?
>
> If we do need to distinguish here, then I think it should be by
> compatible. Say "usb-ss-b-connector"?

I guess that from S/W POV we may need it only in corner cases,
but it could be also good to have this distinction even for informative
purposes.

But if we want to encode it in compatible we can end up with:
usb-a-connector
usb-ss-a-connector
usb-ssplus-a-connector
usb-b-connector
usb-ss-b-connector
usb-ssplus-b-connector
usb-c-connector
usb-ss-c-connector

I see no big problem with it, but I do not see advantage over separate
property 'max-speed', or maybe better 'max-mode'.
I suppose I miss some important DT principles, what is the rationale
behind encoding such things in compatibles.

>
>>>> +Optional properties:
>>>> +- label: a symbolic name for the connector
>>>> +- size: size of the connector, should be specified in case of
>>>> +  non-standard USB connectors: "mini", "micro", "powered"
>>> What does powered mean?
>> It is standard-B connector with additional power pins, as defined in
>> USB3.0 spec, we can drop it as not-popular one.
> Okay. Nothing about it on wikipedia.
>
>>> This is really "type" if you compare to HDMI.
>> As type is already used,  I have to use other word, maybe 'form' would
>> be better.
> But you've dropped type in favor of compatible strings, so you can add
> it back to replace size and keep the meaning aligned with HDMI.


OK.

>
>>>> +
>>>> +Required nodes:
>>>> +- any data bus to the connector should be modeled using the
>>>> +  OF graph bindings specified in bindings/graph.txt.
>>>> +  There should be exactly one port with at least one endpoint to
>>>> +  different device nodes. The first endpoint (reg = <0>) should
>>>> +  point to USB Interface Controller.
>>>> +
>>>> +Example
>>>> +-------
>>>> +
>>>> +musb_con: connector {
>>>> +    compatible = "samsung,usb-connector-11pin", "usb-connector";
>>>> +    label = "usb";
>>>> +    type = "b";
>>>> +    size = "micro";
>>>> +    max-mode = "hs";
>>> These all are implied by "samsung,usb-connector-11pin".
>> Yes, but "usb-connector" compatible requires/permits it, or am I wrong ?
> Yes, but we're mixing where the compatible implies all the information
> and where it's separate fields.

So how 11-pin connector should be described?

>
>>>> +    port {
>>>> +            #address-cells = <1>;
>>>> +            #size-cells = <0>;
>>>> +
>>>> +            musb_con_usb_in: endpoint at 0 {
>>>> +                    reg = <0>;
>>>> +                    remote-endpoint = <&muic_usb_out>;
>>>> +            };
>>>> +
>>>> +            musb_con_mhl_in: endpoint at 1 {
>>>> +                    reg = <1>;
>>>> +                    remote-endpoint = <&mhl_out>;
>>>> +            };
>>> I think this should be 2 ports, not 2 endpoints. Think of ports as
>>> different data streams and endpoints are either the same data stream
>>> muxed or fanned out depending on direction. Now for Type-C, 1 port for
>>> USB and alternate modes is probably correct.
>> I agree for ports.
>> Regarding type-c, it has separate lines for HS and for SS. HS lines
>> often go to Interface Controller as they can be used to legacy detection
>> methods and alternatively muxed to UART.
>> SS lines go directly to USB3 chip, see for example TPS65982 [1][2]. For
>> me it is an argument against merging SS and HS lines into one port. What
>> do you think?
> If you support USB3 and HDMI/DP alternate modes, there has to be a mux
> somewhere. It could be on the SoC or external chip.

Yes. In the device I am working on it is in USB3 phy, but this mux is
only for SS lines.

>
>> My proposition of port numbering:
>> 0: ID for type-B, CC for type-C
> I'd expect ID is just a GPIO line, phy pin or goes to some control IC.

Yes, ID and CC should not be described by graph at all if the connector
is the child of InterfaceController.

>
>> 1: HS
>> 2: VBUS - I am not sure if this should be modeled this way, as it is not
>> a data line,
> Probably not. Pre USB-PD, it's going to be a regulator supply or sink
> or goes to some control IC. In the last case, we just need a phandle
> reference of some sort. For USB-PD, I'd expect that Vbus, CC, SBU and
> perhaps all the SS lines are just routed to some controller. Maybe
> just need a similar phandle reference.

Yes, phandle is something more appropriate here, I am not sure only how
it will work with current kernel frameworks, but this is different issue.

>
>> 3: SS
>> 4: SBU
> Handling these is probably somewhat out of scope of the connector.

Why? This is integral part of the connector.

> HDMI expects to have a "ddc-i2c-bus" and hpd-gpios properties
> typically. Where do we put those in this use case?

In case of USB-C DP Alt mode:
- HPD is encapsulated in USB-PD messages,
- DDC is encapsulated in DP-AUX channel which goes via SBU lines,
In case of USB-C HDMI Alt-mode:
- DDC is encapsulated in USB-PD messages,
- HPD is passed together with HEAC and utility via SBU lines.
In USB-A, USB-B, USB-C without alt modes these signals does not make sense.

Do we need ddc-i2c-bus and hpd-gpios properties in USB connector?

Regards
Andrzej
