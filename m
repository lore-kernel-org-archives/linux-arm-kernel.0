From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Feb 2016 08:06:38 -0600
Subject: [PATCH V5 10/14] Documentation: DT: bindings: Add power domain
 info for NVIDIA PMC
In-Reply-To: <56BB1787.4050801@nvidia.com>
References: <1453998832-27383-1-git-send-email-jonathanh@nvidia.com>
 <1453998832-27383-11-git-send-email-jonathanh@nvidia.com>
 <20160129160625.GA21918@rob-hp-laptop>
 <56B1DE40.7080403@nvidia.com>
 <CAL_JsqLcoKW2znNNvM=sYLmZ6O6ZWqn7+aXspkXoONw6-O1ygg@mail.gmail.com>
 <56BB1787.4050801@nvidia.com>
Message-ID: <CAL_JsqKAFEpo=W=2w=7+QrmMR8uJ5SsXpkuEj=E1axOraCQ9ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 4:57 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 03/02/16 15:48, Rob Herring wrote:
>> On Wed, Feb 3, 2016 at 5:02 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>>>
>>> On 29/01/16 16:06, Rob Herring wrote:
>>>> On Thu, Jan 28, 2016 at 04:33:48PM +0000, Jon Hunter wrote:
>>>>> Add power-domain binding documentation for the NVIDIA PMC driver in
>>>>> order to support generic power-domains.
>>>>>
>>>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>>>> ---
>>>>>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 55 ++++++++++++++++++++++
>>>>>  1 file changed, 55 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>>> index 53aa5496c5cf..3c77373aa826 100644
>>>>> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>>> +++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>>>>> @@ -1,5 +1,7 @@
>>>>>  NVIDIA Tegra Power Management Controller (PMC)
>>>>>
>>>>> +== Power Management Controller Node ==
>>>>> +
>>>>>  The PMC block interacts with an external Power Management Unit. The PMC
>>>>>  mostly controls the entry and exit of the system from different sleep
>>>>>  modes. It provides power-gating controllers for SoC and CPU power-islands.
>>>>> @@ -70,6 +72,10 @@ Optional properties for hardware-triggered thermal reset (inside 'i2c-thermtrip'
>>>>>                       Defaults to 0. Valid values are described in section 12.5.2
>>>>>                       "Pinmux Support" of the Tegra4 Technical Reference Manual.
>>>>>
>>>>> +Optional nodes:
>>>>> +- powergates : This node contains a hierarchy of power domain nodes, which
>>>>> +           should match the powergates on the Tegra SoC.
>>>>> +
>>>>>  Example:
>>>>>
>>>>>  / SoC dts including file
>>>>> @@ -115,3 +121,52 @@ pmc at 7000f400 {
>>>>>      };
>>>>>      ...
>>>>>  };
>>>>> +
>>>>> +
>>>>> +== PM Domain Nodes ==
>>>>> +
>>>>> +Each of the PM domain nodes represents a power-domain on the Tegra SoC
>>>>> +that can be power-gated by the PMC and should be named appropriately.
>>>>> +
>>>>> +Required properties:
>>>>> +  - clocks: Must contain an entry for each clock required by the PMC for
>>>>> +    controlling a power-gate. See ../clocks/clock-bindings.txt for details.
>>>>> +  - resets: Must contain an entry for each reset required by the PMC for
>>>>> +    controlling a power-gate. See ../reset/reset.txt for details.
>>>>> +  - nvidia,powergate: Integer cell that contains an identifier for the PMC
>>>>> +    power-gate that is associated with the power-domain. Please refer to
>>>>> +    the Tegra TRM for more details.
>>>>
>>>> Why not make this value be the power-domain cell for consumers and the
>>>> pmc be the phandle.
>>>
>>> Is there anything wrong with using a label for the consumers? Seems
>>> simpler, if you can just say ...
>>>
>>>         adma: adma at 702e2000 {
>>>                 ...
>>>                 power-domains = <&pd_audio>;
>>>                 ...
>>>         };
>>
>> Only that is a bit unusual. It would only really matter if we had some
>> common parsing that we wanted to share. I'd look at other examples and
>> try to align. If there's no clear pattern, then it is fine.
>
> So I have been having a look at this and it appears to be mixed across
> the various SoCs. It seems that those SoCs that define the generic PM
> domains statically in the machine/soc code use a phandle plus a argument
> to identify the power domain. However, for those that describe the
> power-domain in the DT (listing clocks, resets, etc), they just use a
> phandle to the power-domain itself (like I have above). It looks like if
> you are describing the power domain in DT, then it is much simplier to
> do this.
>
> Given that I wish to keep the description of the power-domain in DT, it
> is much easier to stick with the same conventions that the other SoCs
> are using.

Okay.

Acked-by: Rob Herring <robh@kernel.org>

Rob
