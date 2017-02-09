From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 9 Feb 2017 09:17:58 -0600
Subject: [PATCH v3 1/3] of: Support parsing phandle argument lists through
 a nexus node
In-Reply-To: <CAL_JsqKS3Q2mg0aSubB3TV6LPQjCx+hqBu4TqbsqyfBvWrwctg@mail.gmail.com>
References: <20170123204851.12808-1-stephen.boyd@linaro.org>
 <20170123204851.12808-2-stephen.boyd@linaro.org> <5886F5ED.3030509@gmail.com>
 <CAL_JsqKS3Q2mg0aSubB3TV6LPQjCx+hqBu4TqbsqyfBvWrwctg@mail.gmail.com>
Message-ID: <CAL_JsqKbkynNmCrXbi=VJ5wqYtRrYbC+00qSm_uyZFBLFOUz0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 12:05 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Tue, Jan 24, 2017 at 12:36 AM, Frank Rowand <frowand.list@gmail.com> wrote:
>> Hi Stephen,
>>
>> Sorry I did not get to v1 and v2 in a timely manner.
>>
>>
>> On 01/23/17 12:48, Stephen Boyd wrote:
>>> Platforms like 96boards have a standardized connector/expansion
>>> slot that exposes signals like GPIOs to expansion boards in an
>>> SoC agnostic way. We'd like the DT overlays for the expansion
>>> boards to be written once without knowledge of the SoC on the
>>> other side of the connector. This avoids the unscalable
>>> combinatorial explosion of a different DT overlay for each
>>> expansion board and SoC pair.
>>>
>>> We need a way to describe the GPIOs routed through the connector
>>> in an SoC agnostic way. Let's introduce nexus property parsing
>>> into the OF core to do this. This is largely based on the
>>> interrupt nexus support we already have. This allows us to remap
>>> a phandle list in a consumer node (e.g. reset-gpios) through a
>>> connector in a generic way (e.g. via gpio-map). Do this in a
>>> generic routine so that we can remap any sort of variable length
>>> phandle list.
>>>
>>> Taking GPIOs as an example, the connector would be a GPIO nexus,
>>> supporting the remapping of a GPIO specifier space to multiple
>>> GPIO providers on the SoC. DT would look as shown below, where
>>> 'soc_gpio1' and 'soc_gpio2' are inside the SoC, 'connector' is an
>>> expansion port where boards can be plugged in, and
>>> 'expansion_device' is a device on the expansion board.
>>>
>>>       soc {
>>>               soc_gpio1: gpio-controller1 {
>>>                       #gpio-cells = <2>;
>>>               };
>>>
>>>               soc_gpio2: gpio-controller2 {
>>>                       #gpio-cells = <2>;
>>>               };
>>>       };
>>>
>>>       connector: connector {
>>>               #gpio-cells = <2>;
>>>               gpio-map = <0 0 &soc_gpio1 1 0>,
>>>                          <1 0 &soc_gpio2 4 0>,
>>>                          <2 0 &soc_gpio1 3 0>,
>>>                          <3 0 &soc_gpio2 2 0>;
>>>               gpio-map-mask = <0xf 0x0>;
>>>               gpio-map-pass-thru = <0x0 0x1>
>>>       };
>>>
>>>       expansion_device {
>>>               reset-gpios = <&connector 2 GPIO_ACTIVE_LOW>;
>>>       };
>>
>> The how to architect connectors and plugs threads fell asleep before
>> coming to a resolution.  We need to revive that discussion.
>>
>> One of the concepts of the plug and connector architecture is that
>> a main board may contain multiple connectors of the same type (or
>> different types, but the same type is sufficient for this discussion).
>>
>> The node describing the card that plugs into one of the connectors
>> does not know the phandle of the connector it is going to be
>> connected to.  Some other mechanism is provided to allow a card
>> to be plugged into any of the available connectors.  If there are
>> two identical cards plugged into two connectors, then both cards
>> have the same exact device tree node.  But some mechanism will
>> exist to resolve (or "link") the two card nodes to the different
>> connector nodes.
>>
>> As a result of this, in the above example the reset-gpios property
>> in the node 'expansion_device' can not contain '&connector'.  The
>> concept of &connector belongs to the entire expansion_device node,
>> not to individual properties within the node.
>
> I think this is easily solved with a connector having 2 halves and
> that we need to search parents for *-map properties. Inheriting from
> parents is a common pattern in DT though perhaps not walking the
> parents of a phandle. So we'd have something like this:
>
> base-connector-1 {
>   gpio-map = ...
>   connector {
>     child {
>       some-gpios = <&connector 1>;
>     };
>   };
> };
>
> base-connector-2 {
>   gpio-map = ...
>   connector {
>     child {
>       some-gpios = <&connector 1>;
>     };
>   };
> };
>
> Now, how we resolve that /connector from an overlay targets
> /base-connector-1 and /base-connector-2 is an orthogonal issue and one
> that's going to be connector specific (at least for probe-able
> connectors).

Frank, any more comments on this? If not, I plan to apply this series.

Rob
