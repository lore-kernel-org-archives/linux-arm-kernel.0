From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 7 Mar 2017 11:36:39 +0100
Subject: [PATCH v2 3/3] ARM64: dts: meson-gx: Add MALI nodes for GXBB and
 GXL
In-Reply-To: <m2efya1fjg.fsf@baylibre.com>
References: <1488365164-22861-1-git-send-email-narmstrong@baylibre.com>
 <1488365164-22861-4-git-send-email-narmstrong@baylibre.com>
 <e26cf584-dab2-2702-f7e6-b28f750fa00c@suse.de>
 <e80d9fb0-1d71-7cab-5e32-72316474fdfc@baylibre.com>
 <m2tw7a17nb.fsf@baylibre.com> <9f3a17e8-63fa-6c14-4d17-0539ef7cd5a2@suse.de>
 <1825920f-586f-7c84-8e0e-958046397b64@baylibre.com>
 <m2efya1fjg.fsf@baylibre.com>
Message-ID: <074a13e8-5772-6fb4-fc45-cfbb57790e58@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2017 06:27 PM, Kevin Hilman wrote:
> Neil Armstrong <narmstrong@baylibre.com> writes:
> 
>> On 03/04/2017 01:38 PM, Andreas F?rber wrote:
>>> Am 03.03.2017 um 20:29 schrieb Kevin Hilman:
>>>> Neil Armstrong <narmstrong@baylibre.com> writes:
>>>>> On 03/02/2017 01:31 PM, Andreas F?rber wrote:
>>>>>> Am 01.03.2017 um 11:46 schrieb Neil Armstrong:
>>>>>>> The same MALI-450 MP3 GPU is present in the GXBB and GXL SoCs.
>>> [...]
>>>>>>> The node is simply added in the meson-gxbb.dtsi file.
>>> [...]
>>>>>>> For GXL, since a lot is shared with the GXM that has a MALI-T820 IP, this
>>>>>>> patch adds a new meson-gxl-mali.dtsi and is included in the SoC specific
>>>>>>> dtsi files.
>>>>>>
>>>>>> This part is slightly confusing though.
>>>>>>
>>>>>> What exactly is the GXL vs. GXM difference that this can't be handled by
>>>>>> overriding node properties compatible/interrupts/clocks? I am missing a
>>>>>> GXM patch in this series as rationale for doing it this way.
>>>>>>
>>>>>> In particular I am wondering whether the whole GXM-inherits-from-GXL
>>>>>> concept is flawed and should be adjusted if this leads to secondary
>>>>>> .dtsi files like this: My proposal would be to instead create a
>>>>>> meson-gxl-gxm.dtsi, that meson-gxl.dtsi and meson-gxm.dtsi can inherit
>>>>>> the current common parts from, then the Mali bits can simply go into
>>>>>> meson-gxl.dtsi without extra #includes needed in S905X and S905D. While
>>>>>> it's slightly more work to split once again, I think it would be cleaner.
>>> [...]
>>>>> The only changes are :
>>> [...]
>>>>>  - A different Mali core, but with the same interrupts (less but they share the same lower interrupts), clocks and memory space
>>>>>
>>>>> This is why it was decided to have a sub-dtsi, having a secondary dtsi will simply copy 99% of the GXL dtsi,
>>>>> but surely we could also have an intermediate dtsi but for boards I'm ok with it, but less for a SoC dtsi,
>>>>> since it could lead to some confusion.
>>>>>
>>>>> Finally, yes I could have added the mali node to the GXL dtsi, but the midgard Mali dt-bindings are not upstream
>>>>> and the family is too big and recent enough to consider having stable bindings for now.
>>>>>
>>>>> Nevertheless, nothing is final, this gxl-mali.dtsi could be merged into the GXL dtsi in the future when we
>>>>> have proper dt-bindings and a real support of the T820 Mali on the S912.
>>>>>
>>>>> Kevin, what's your thought about this ?
>>>>
>>>> I don't have a strong preference.  I'm OK with a separate Mali .dtsi due
>>>> to the signficant overlap between GXL/GXM in terms of clocks, interrupts
>>>> etc.
>>>>
>>>> However, if the plan is to #include this from GXM .dts files, whould a
>>>> better name be meson-gx-mali.dtsi?
>>>
>>> I thought the purpose was specifically to not have GXM include it
>>> because it uses a Midgard IP.
>>>
>>> If you want to share the fragment with GXBB too (gx), we should rather
>>> use meson-gx-mali-utgard.dtsi, which would differentiate from GXM's
>>> Midgard while still allowing for variation on the 4xx side (e.g., 470).
>>>
>>> Regards,
>>> Andreas
>>>
>>
>> Exact, there is no plan to include it from GXM.
>>
>> I'm not fan of having meson-gx-mali-utgard.dtsi, we should still need some attributes additions for
>> the clocks to the mali node in the gxbb dtsi and each s905x and s905d dtsi files.
>> I'm not sure this is even cleaner...
> 
> OK, I misunderstood the intent of having it separated from out from the
> GXL .dsti then.  Could you please clarify?
> 
> Kevin

Hi,

Indeed, my changelog was not really clear, here is the reworded one that will land in v2 :
"
This patch add nodes for the Mali-450 MP3 GPU present in the GXBB and GXL SoCs.

For GXBB, the node is simply added in the meson-gxbb.dtsi file.

Fox GXL, since the GXM dtsi is a superset of the GXL dtsi, the Mali node is added to
the GXL SoC specific dtsi files via an intermediate "meson-gxl-mali.dtsi" file to avoid
having an invalid Mali-450 node in the GXM device tree.
"

Thanks,
Neil
