From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 4 Jan 2018 14:16:12 +0100
Subject: [PATCH v2] dt: psci: Update DT bindings to support hierarchical
 PSCI states
In-Reply-To: <20180104123132.GA28646@e107155-lin>
References: <1514472037-25969-1-git-send-email-ulf.hansson@linaro.org>
 <20180104123132.GA28646@e107155-lin>
Message-ID: <CAPDyKFo3ZoQHWcWMYD6nnYcr8i4Hdrg3Mbvi9TOZouh5t9g3uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 4 January 2018 at 13:31, Sudeep Holla <sudeep.holla@arm.com> wrote:
> Hi Ulf,
>
> I will suggest some wording changes not of which are not compulsory and
> left to you to pick up or drop.

Thanks for reviewing!

>
> On 28/12/17 14:40, Ulf Hansson wrote:
>> From: Lina Iyer <lina.iyer@linaro.org>
>>
>> Update DT bindings to represent hierarchical CPU and CPU domain idle states
>> for PSCI. Also update the PSCI examples to clearly show how flattened and
>> hierarchical idle states can be represented in DT.
>>
>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Changes in v2:
>>       - Addressed comments from Rob.
>>       - Updated some labels in the examples to get more consistency.
>>
>> For your information, I have picked up the work from Lina Iyer around the so
>> called CPU cluster idling series [1,2] and I working on new versions. However,
>> I decided to post the updates to the PSCI DT bindings first, as they will be
>> needed to be agreed upon before further changes can be done to the PSCI firmware
>> driver.
>>
>> Note, these bindings have been discussed over and over again, at LKML, but
>> especially also at various Linux conferences, like LPC and Linaro Connect. We
>> finally came to a conclusion and the changes we agreed upon, should be reflected
>> in this update.
>>
>> Of course, it's a while ago since the latest discussions, but hopefully people
>> don't have too hard time to remember.
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> https://www.spinics.net/lists/arm-kernel/msg566200.html
>>
>> [2]
>> https://lwn.net/Articles/716300/
>>
>> ---
>>  Documentation/devicetree/bindings/arm/psci.txt | 152 +++++++++++++++++++++++++
>>  1 file changed, 152 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/psci.txt b/Documentation/devicetree/bindings/arm/psci.txt
>> index a2c4f1d..8a09bd2 100644
>> --- a/Documentation/devicetree/bindings/arm/psci.txt
>> +++ b/Documentation/devicetree/bindings/arm/psci.txt
>> @@ -105,7 +105,159 @@ Case 3: PSCI v0.2 and PSCI v0.1.
>>               ...
>>       };
>>
>> +PSCI v1.0 onwards, supports OS-Initiated mode for powering off CPUs and CPU
>> +clusters from the firmware.
>
> Since we are trying to avoid usage of "clusters"(as it's not architecturally
> defined, but I know it's too late as it widely used everywhere). Also this
> binding is not just OSI specific, it can be used for Platform Co-ordinated
> also so let's not specify them at all.
>
> How about:
> "ARM systems can have multiple cores sometimes in hierarchical arrangement.
> This often, but not always, maps directly to the processor power topology
> of the system. Individual nodes in a topology have their own specific power
> states and can be better represented in DT hierarchically"

Sounds great! Let me change to this!

>
>> For such topologies the PSCI firmware driver acts
>
> PSCI firmware can be represented as a pseudo power controller ?

Yeah, this isn't very clear. I figure out something better or perhaps
just drop this.

>
>> +as pseudo-controller, which may be specified in the psci DT node. The
>> +definitions of the CPU and the CPU cluster topology, must conform to the domain
>> +idle state specification [3].
>
> I assume it should be  "..definitions of the idle states for CPU and the CPU
> topology" above, otherwise they should conform to topology binding :) rather
> than domain idle state bindings.

Yep.

>
>> The domain idle states themselves, must be
>> +compatible with the defined 'domain-idle-state' binding [1], and also need to
>> +specify the arm,psci-suspend-param property for each idle state.
>> +
>> +DT allows representing CPU and CPU cluster idle states in two different ways -
>> +
>> +The flattened model as given in Example 1, lists CPU's idle states followed by
>> +the domain idle state that the CPUs may choose. This is the general practice
>> +followed in PSCI firmwares that support Platform Coordinated mode.
>
> I would rather drop the above statement or specify in Example 2 that it can be
> used for both OSI and PC.

Yeah, I fully agree, this needs to be more clear in the doc.

>
>> Note that
>> +the idle states are all compatible with "arm,idle-state".
>> +
>> +Example 2 represents the hierarchical model of CPU and domain idle states.
>> +CPUs define their domain provider in their DT node. The domain controls the
>> +power to the CPU and possibly other h/w blocks that would be powered off when
>> +the CPU is powered off. The CPU's idle states may therefore be considered as
>> +the domain's idle states and have the compatible "arm,idle-state". Such domains
>> +may be embedded within another domain that represents common h/w blocks between
>> +these CPUs viz. the cluster. The idle states of the cluster would be
>> +represented as the domain's idle states. In order to use OS-Initiated mode of
>> +PSCI in the firmware, the hierarchical representation must be used.
>> +
>
> Can we avoid using poweroff as it's one of the idle states and not the only
> one ?

Yeah, I guess "low power state" or "idle state" is better?

Additionally we mentioning "clusters" here again. I may be difficult
to avoid using that terminology, when describing how things work. I
can try, but perhaps it's just easier to make a statement early on to
describe what "clusters" means in this context? Or what do you think?

>
> Other than that, the examples look good to me.

Great, thanks!

Kind regards
Uffe
