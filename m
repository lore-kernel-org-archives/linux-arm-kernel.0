From: robh@kernel.org (Rob Herring)
Date: Thu, 10 Nov 2016 11:40:35 -0600
Subject: [PATCH v2 2/6] mfd: dt: Add bindings for the Aspeed SoC Display
 Controller (GFX)
In-Reply-To: <CACPK8XeG2WnpNuHUf9VD+mZenWboq-4wei=LOkN4qVR72QbGXQ@mail.gmail.com>
References: <1478097481-14895-1-git-send-email-andrew@aj.id.au>
 <1478097481-14895-3-git-send-email-andrew@aj.id.au>
 <20161109182630.tg3puvwurgx6iinw@rob-hp-laptop>
 <CACPK8XeG2WnpNuHUf9VD+mZenWboq-4wei=LOkN4qVR72QbGXQ@mail.gmail.com>
Message-ID: <CAL_JsqLN5veD9QHMmEqX5mmX+iHM69O=o+KFauej1QdqEpyUhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 9:19 PM, Joel Stanley <joel@jms.id.au> wrote:
> On Thu, Nov 10, 2016 at 4:56 AM, Rob Herring <robh@kernel.org> wrote:
>> On Thu, Nov 03, 2016 at 01:07:57AM +1030, Andrew Jeffery wrote:
>>> The Aspeed SoC Display Controller is presented as a syscon device to
>>> arbitrate access by display and pinmux drivers. Video pinmux
>>> configuration on fifth generation SoCs depends on bits in both the
>>> System Control Unit and the Display Controller.
>>>
>>> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
>>> ---
>>>  Documentation/devicetree/bindings/mfd/aspeed-gfx.txt | 17 +++++++++++++++++
>>
>> The register space can't be split to 2 nodes?
>
> Do you mean splitting the GFX IP and enable register into two nodes?
>
> We can't. Pinmux needs to check bit 6 and 7 in GFX064, which is in the
> middle the IP block:
>
> GFX060: CRT Control Register I
> GFX064: CRT Control Register II
> GFX068: CRT Status Register
> GFX06C: CRT Misc Setting Register

Okay.

>>> +The Aspeed SoC Display Controller primarily does as its name suggests, but also
>>> +participates in pinmux requests on the g5 SoCs. It is therefore considered a
>>> +syscon device.
>>> +
>>> +Required properties:
>>> +- compatible:                "aspeed,ast2500-gfx", "syscon"
>>
>> I think perhaps we should drop the syscon here and the driver should
>> just register as a syscon.
>
> We want the regmap to be present whenever the GFX driver or pinmux is
> loaded. If we register it in pinmux but chose to not build in that
> driver, we lack the regmap. Same for the case where a user builds in
> the GFX driver and not pinmux. I think this means we want the syscon
> compatible string, unless my understanding is wrong?

Right.

Acked-by: Rob Herring <robh@kernel.org>

Rob
