From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 8 Nov 2018 15:54:31 +0000
Subject: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
In-Reply-To: <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org> <20181009115713.GE6248@arm.com>
 <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
Message-ID: <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 19:32, Rob Herring wrote:
> On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
>>
>> Hi Rob,
>>
>> On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
>>> Convert ARM PMU binding to DT schema format using json-schema.
>>>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: devicetree at vger.kernel.org
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
>>>   .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
>>>   2 files changed, 96 insertions(+), 70 deletions(-)
>>>   delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
>>>   create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
>>
>> [...]
>>
>>> -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
>>> -               interrupt (PPI) then 1 interrupt should be specified.
>>
>> [...]
>>
>>> +  interrupts:
>>> +    oneOf:
>>> +      - maxItems: 1
>>> +      - minItems: 2
>>> +        maxItems: 8
>>> +        description: 1 interrupt per core.
>>> +
>>> +  interrupts-extended:
>>> +    $ref: '#/properties/interrupts'
>>
>> This seems like a semantic different between the two representations, or am
>> I missing something here? Specifically, both the introduction of
>> interrupts-extended and also dropping any mention of using a single per-cpu
>> interrupt (the single combined case is no longer support by Linux; not sure
>> if you want to keep it in the binding).
> 
> In regards to no support for the single combined interrupt, it looks
> like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
> have only a single interrupt. Though the interrupt gets routed to MPIC
> which then has a GIC PPI. So it isn't supported or happens to work
> still since it is a PPI?

Well, the description of the MPIC in the Armada XP functional spec says:

"Interrupt sources ID0?ID28 are private events per CPU. Thus, each 
processor has a different set of events map interrupts ID0?ID28."

Odd grammar aside, that would seem to imply that <&mpic 3> is a per-cpu 
interrupt itself, thus AFAICS so long as it's cascaded to a GIC PPI and 
not an SPI then there's no issue there.

Robin.
