From: robh@kernel.org (Rob Herring)
Date: Fri, 2 Dec 2016 12:45:34 -0600
Subject: [PATCH 1/3] Documentation: dt: Add TI SCI clock driver
In-Reply-To: <8579b123-f214-22f1-0236-e5b98ab51597@ti.com>
References: <1477053961-27128-1-git-send-email-t-kristo@ti.com>
 <1477053961-27128-2-git-send-email-t-kristo@ti.com>
 <20161030204121.qvb5d33dh65awwzx@rob-hp-laptop>
 <41c58712-bc00-ed05-9d1d-42e31397a70c@ti.com>
 <CAL_JsqLtSs6ifnMdEOsfXpGoWnmXuGAx83+ziB9yU+zurvob+A@mail.gmail.com>
 <0fe81866-8bfd-f3a7-d808-9cb23841f504@ti.com>
 <8579b123-f214-22f1-0236-e5b98ab51597@ti.com>
Message-ID: <CAL_JsqKox9WVXh=i1jSCijJDTACC35uiNtS-bg9fdyDrX0svRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 2, 2016 at 2:19 AM, Tero Kristo <t-kristo@ti.com> wrote:
> On 21/11/16 10:14, Tero Kristo wrote:
>>
>> On 18/11/16 19:20, Rob Herring wrote:
>>>
>>> On Mon, Oct 31, 2016 at 7:50 AM, Tero Kristo <t-kristo@ti.com> wrote:
>>>>
>>>> On 30/10/16 22:41, Rob Herring wrote:
>>>>>
>>>>>
>>>>> On Fri, Oct 21, 2016 at 03:45:59PM +0300, Tero Kristo wrote:
>>>>>>
>>>>>>
>>>>>> Add a clock implementation, TI SCI clock, that will hook to the common
>>>>>> clock framework, and allow each clock to be controlled via TI SCI
>>>>>> protocol.
>>>>>>
>>>>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>>>>> ---
>>>>>>  .../devicetree/bindings/clock/ti,sci-clk.txt       | 37
>>>>>> ++++++++++++++++++++++
>>>>>>  MAINTAINERS                                        |  1 +
>>>>>>  2 files changed, 38 insertions(+)
>>>>>>  create mode 100644
>>>>>> Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>>>>> b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..bfc3ca4
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.txt
>>>>>> @@ -0,0 +1,37 @@
>>>>>> +Texas Instruments TI-SCI Clocks
>>>>>> +===============================
>>>>>> +
>>>>>> +All clocks on Texas Instruments' SoCs that contain a System
>>>>>> Controller,
>>>>>> +are only controlled by this entity. Communication between a host
>>>>>> processor
>>>>>> +running an OS and the System Controller happens through a protocol
>>>>>> known
>>>>>> +as TI-SCI[1]. This clock implementation plugs into the common clock
>>>>>> +framework and makes use of the TI-SCI protocol on clock API requests.
>>>>>> +
>>>>>> +[1] Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
>>>>>> +
>>>>>> +Required properties:
>>>>>> +-------------------
>>>>>> +- compatible: Must be "ti,k2g-sci-clk"
>>>>>> +- #clock-cells: Shall be 2.
>>>>>> +  In clock consumers, this cell represents the device ID and clock ID
>>>>>> +  exposed by the PM firmware. The assignments can be found in the
>>>>>> header
>>>>>> +  files <dt-bindings/genpd/<soc>.h> (which covers the device IDs) and
>>>>>> +  <dt-bindings/clock/<soc>.h> (which covers the clock IDs), where
>>>>>> <soc>
>>>>>> +  is the SoC involved, for example 'k2g'.
>>>>>> +
>>>>>> +Examples:
>>>>>> +--------
>>>>>> +
>>>>>> +pmmc: pmmc {
>>>>>> +       compatible = "ti,k2g-sci";
>>>>>> +
>>>>>> +       k2g_clks: k2g_clks {
>>>>>
>>>>>
>>>>>
>>>>> Use "clocks" for node name instead.
>>>>>
>>>>>> +               compatible = "ti,k2g-sci-clk";
>>>>>
>>>>>
>>>>>
>>>>> I'm starting to think all these child nodes for SCI are pointless. Is
>>>>> there any reason why the parent node can't be the clock provider (along
>>>>> with all the other providers it acks as)?
>>>>
>>>>
>>>>
>>>> I believe the only reason to keep them separate is to have kernel
>>>> side of
>>>> things modular. If we have separate nodes, the drivers can be probed
>>>> separately.
>>>>
>>>> If not, we need to build one huge blob with all the features in it,
>>>> so the
>>>> main driver can probe everything in one go, with annoying back-and-forth
>>>> callbacks in place (assuming we still want to keep stuff somehow
>>>> modular.)
>>>
>>>
>>> Since when is DT the only way to create a device? The main driver can
>>> create devices for all the sub-functions like clocks. This is the same
>>> as MFDs which have been done both ways.
>>
>>
>> Yes obviously this can be done, my main point was that it will require
>> building some sort of infra within the driver to handle this. With
>> separate nodes, none of this is going to be needed. Also, we will lose
>> any kind of configurability via DT if we don't have separate nodes; now
>> we can select the available clocks / genpds via the compatible string of
>> the clocks/genpd nodes themselves (this isn't clearly evident as of now
>> as we only support a grand total of one device, which is k2g-evm.)
>> Otherwise we need to probe against the main node and add a separate
>> compatible string for every device, and carry this information to the
>> sibling devices also somehow. It is just so much simpler if we can just
>> keep separate nodes for them.
>>
>> Also, plenty of things are doing this kind of stuff already in
>> DT/kernel, having a parent node in place and sub-functions added
>> separately for ease of use, with apparently no visible point for having
>> the nodes within the DT.
>
>
> Rob, any response on this one? I see you have acked the reset part of the
> bindings which is doing pretty much the same thing as the clock part is
> doing here, namely adding child node under the main SCI node. Is it okay to
> do this same for other parts of the TI SCI?

Yes. It would be silly to allow for one and not others...

Rob
