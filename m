From: Matt.Sealey@arm.com (Matt Sealey)
Date: Wed, 13 Jun 2018 12:49:46 +0000
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
In-Reply-To: <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
 <20180612204802.GA15817@rob-hp-laptop>,
 <a1c0749b-9c97-b45f-716f-a62ae07af278@arm.com>
Message-ID: <5448BBB7-93FE-400F-9D87-FABF5DE0539C@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suzuki,

Why not use ?unit??

I believe we had this discussion years ago about numbering serial ports and sdhci (i.e. how do you know it?s UART0 or UART1 from just the address? Some SoC?s don?t address sequentially *or* in a forward direction) - I believe it?s not exactly codified in ePAPR, not am I sure where it may be otherwise, but it exists.

I agree with Rob on the slave-mode nonsense, this is an SPI controller concept weirdly stuffed into a directed graph which implicitly tells you the data direction - it?s a rooted tree (just like DT!).

For the case of a funnel each device supplying trace should end up into an input node - numbered with a unit - and all those nodes should point to the output node as endpoints. Describing the hardware as a black box is probably less of a good idea than showing that it?s a funnel, or replicator by showing the internal paths. You wouldn?t need to ?number? ports with a unit except where the HW needs to differentiate between them, and you don?t need reg or a node address to do it.

If you really need to parse full graphs in both directions (find root, find leaf) then could we simply introduce properties which list the phandles of all uplink sources, as linked lists point to the list head?

This gives a way to validate that the graph starts and ends the way we expect, and also allows every port to be associated with being a required path between any two devices without parsing the *whole* graph (although you still need to do that to find the route to sinks).

Ta,
Matt

Sent from my iPhone

> On Jun 13, 2018, at 04:45, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>
> Hi Rob,
>
>> On 12/06/18 21:48, Rob Herring wrote:
>>> On Fri, Jun 01, 2018 at 02:16:05PM +0100, Suzuki K Poulose wrote:
>>> The coresight drivers relied on default bindings for graph
>>> in DT, while reusing the "reg" field of the "ports" to indicate
>>> the actual hardware port number for the connections. However,
>>> with the rules getting stricter w.r.t to the address mismatch
>>> with the label, it is no longer possible to use the port address
>>> field for the hardware port number. Hence, we add an explicit
>>> property to denote the hardware port number, "coresight,hwid"
>>> which must be specified for each "endpoint".
>>>
>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>>> Cc: Rob Herring <robh@kernel.org>
>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> ---
>>>  .../devicetree/bindings/arm/coresight.txt          | 26 +++++++++---
>>>  drivers/hwtracing/coresight/of_coresight.c         | 46 ++++++++++++++++------
>>>  2 files changed, 54 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
>>> index bd36e40..385581a 100644
>>> --- a/Documentation/devicetree/bindings/arm/coresight.txt
>>> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
>>> @@ -104,7 +104,11 @@ properties to uniquely identify the connection details.
>>>      "slave-mode"
>>>     * Hardware Port number at the component:
>>> -     -  The hardware port number is assumed to be the address of the "port" component.
>>> +   - (Obsolete) The hardware port number is assumed to be the address of the "port" component.
>>> +   - Each "endpoint" must define the hardware port of the local end of the
>>> +     connection using the following property:
>>> +    "coresight,hwid" - 32bit integer, hardware port number at the local end.
>> "coresight" is not a vendor and properties are in the form
>> [<vendor>,]<prop-name>.
>
> OK. The issue here is that a coresight component could be an Arm IP or
> a custom partner IP. So, the vendor could be either arm or the partner id.
> However, this property is kind of a generic one for the Coresight family,
> which is why we opted for "coresight". What is the guideline for such
> cases ?
>
> Or in other words I see the following possible options :
>
> 1) coresight,hwid    - coresight generic
> 2) arm,coresight-hwid    - arm vendor, however the device could be from any vendor.
> 3) hwid            - Generic
> 4) none of the above, something completely different.
>
> What do you recommend from the above ?
>
>>> +
>>>      Example:
>>> @@ -120,6 +124,7 @@ Example:
>>>              etb_in_port: endpoint at 0 {
>> There shouldn't be a unit address here because there is no reg property.
>>>                  slave-mode;
>>>                  remote-endpoint = <&replicator_out_port0>;
>>> +                coresight,hwid = <0>;
>> It doesn't make sense for these to be in the endpoint. If you had
>> multiple endpoints, then you would have to duplicate it. "ports" are
>> a single data stream. "endpoints" are connections to that stream. So if
>> you have a muxed (input) or fanout/1-to-many (output) connection, then
>> you have multiple endpoints.
>
> We do have many-to-1 input (e.g, funnels) and 1-to-many outputs
> (e.g replicators). However, we have (so far) used only one endpoint per
> port.
>
> Also we could potentially have multiple data streams flowing through
> the ports, which gets filtered to different ports in 1-to-many components
> (read programmable-replicator).
>
> So the point is we have a shared path which carries different data
> streams with mux/demux components. I am open for suggestions based on
> the above facts.
>
>> The same applied to the slave-mode property, but that ship has sailed.
>> No reason to continue that though.
>>>              };
>>>          };
>>>      };
>>> @@ -134,6 +139,7 @@ Example:
>>>              tpiu_in_port: endpoint at 0 {
>>>                  slave-mode;
>>>                  remote-endpoint = <&replicator_out_port1>;
>>> +                coresight,hwid = <0>;
>>>              };
>>>          };
>>>      };
>>> @@ -154,6 +160,7 @@ Example:
>>>                  reg = <0>;
>>>                  replicator_out_port0: endpoint {
>>>                      remote-endpoint = <&etb_in_port>;
>>> +                    coresight,hwid = <0>;
>>>                  };
>>>              };
>>>  @@ -161,15 +168,17 @@ Example:
>>>                  reg = <1>;
>>>                  replicator_out_port1: endpoint {
>>>                      remote-endpoint = <&tpiu_in_port>;
>>> +                    coresight,hwid = <1>;
>>>                  };
>>>              };
>>>                /* replicator input port */
>>>              port at 2 {
>>> -                reg = <0>;
>>> +                reg = <1>;
>> This will still get flagged as an error. reg must be 2 here.
>
> Sorry, thats a mistake. I will fix it.
>
> Cheers
> Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
