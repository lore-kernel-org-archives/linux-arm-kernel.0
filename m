From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 03 Mar 2017 11:29:12 -0800
Subject: [PATCH v2 3/3] ARM64: dts: meson-gx: Add MALI nodes for GXBB and
 GXL
In-Reply-To: <e80d9fb0-1d71-7cab-5e32-72316474fdfc@baylibre.com> (Neil
 Armstrong's message of "Thu, 2 Mar 2017 13:47:26 +0100")
References: <1488365164-22861-1-git-send-email-narmstrong@baylibre.com>
 <1488365164-22861-4-git-send-email-narmstrong@baylibre.com>
 <e26cf584-dab2-2702-f7e6-b28f750fa00c@suse.de>
 <e80d9fb0-1d71-7cab-5e32-72316474fdfc@baylibre.com>
Message-ID: <m2tw7a17nb.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Hi Andreas,
> On 03/02/2017 01:31 PM, Andreas F?rber wrote:
>> Hi Neil,
>> 
>> Am 01.03.2017 um 11:46 schrieb Neil Armstrong:
>>> The same MALI-450 MP3 GPU is present in the GXBB and GXL SoCs.
>> 
>> First of all, any reason you're upper-casing Mali in the commit message?
>> ARM doesn't.
>
> No reason, only a type, indeed it was lower-casing on the v1.
> Will fix in v2.
>
>> 
>>>
>>> The node is simply added in the meson-gxbb.dtsi file.
>> 
>> The GXBB part looks fine on a quick look.
>> 
>>>
>>> For GXL, since a lot is shared with the GXM that has a MALI-T820 IP, this
>>> patch adds a new meson-gxl-mali.dtsi and is included in the SoC specific
>>> dtsi files.
>> 
>> This part is slightly confusing though.
>> 
>> What exactly is the GXL vs. GXM difference that this can't be handled by
>> overriding node properties compatible/interrupts/clocks? I am missing a
>> GXM patch in this series as rationale for doing it this way.
>> 
>> In particular I am wondering whether the whole GXM-inherits-from-GXL
>> concept is flawed and should be adjusted if this leads to secondary
>> .dtsi files like this: My proposal would be to instead create a
>> meson-gxl-gxm.dtsi, that meson-gxl.dtsi and meson-gxm.dtsi can inherit
>> the current common parts from, then the Mali bits can simply go into
>> meson-gxl.dtsi without extra #includes needed in S905X and S905D. While
>> it's slightly more work to split once again, I think it would be cleaner.
>
> The GXL and GXM differences are very small :
>  - They share the same clock tree
>  - They share the same pinctrl and even the same pinout (S905D and S912 are pin-to-pin compatible)
>  - They share all the peripherals
>
> The only changes are :
>  - Enhanced video encoding and decoding support, this will need a family-specific compatible when pushed
>  - Slightly differences in the Video Processing Unit, this is why I introduced family-specific compatibles
>  - A secondary Cortex-A53 cluster
>  - A secondary SCPI cpufreq clock entry
>  - A different Mali core, but with the same interrupts (less but they share the same lower interrupts), clocks and memory space
>
> This is why it was decided to have a sub-dtsi, having a secondary dtsi will simply copy 99% of the GXL dtsi,
> but surely we could also have an intermediate dtsi but for boards I'm ok with it, but less for a SoC dtsi,
> since it could lead to some confusion.
>
> Finally, yes I could have added the mali node to the GXL dtsi, but the midgard Mali dt-bindings are not upstream
> and the family is too big and recent enough to consider having stable bindings for now.
>
> Nevertheless, nothing is final, this gxl-mali.dtsi could be merged into the GXL dtsi in the future when we
> have proper dt-bindings and a real support of the T820 Mali on the S912.
>
> Kevin, what's your thought about this ?

I don't have a strong preference.  I'm OK with a separate Mali .dtsi due
to the signficant overlap between GXL/GXM in terms of clocks, interrupts
etc.

However, if the plan is to #include this from GXM .dts files, whould a
better name be meson-gx-mali.dtsi?

Kevin
