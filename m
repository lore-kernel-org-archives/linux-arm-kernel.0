From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 26 May 2014 13:02:06 +0200
Subject: [PATCH v4 4/8] Documentation: devicetree: add cpu clock
 configuration data binding for Exynos4/5
In-Reply-To: <CAJuA9aikGp=_Vgv+qGyRJhSo1a0Qpb_KLE9a63wtbRNbrxYBYQ@mail.gmail.com>
References: <1400029876-5830-1-git-send-email-thomas.ab@samsung.com>	<1400029876-5830-5-git-send-email-thomas.ab@samsung.com>	<53769E1F.1090706@gmail.com>
 <CAJuA9aikGp=_Vgv+qGyRJhSo1a0Qpb_KLE9a63wtbRNbrxYBYQ@mail.gmail.com>
Message-ID: <53831F2E.8000501@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 26.05.2014 08:05, Thomas Abraham wrote:
> Hi Tomasz,
> 
> Thanks for your comments. Please see inline reply.
> 
> On Sat, May 17, 2014 at 4:54 AM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Thomas,
>>
>> Please see my comments inline.
>>
>> On 14.05.2014 03:11, Thomas Abraham wrote:
>>> From; Thomas Abraham <thomas.ab@samsung.com>
>>>
>>> The clock blocks within the CMU_CPU clock domain are put together into a
>>> new composite clock type called the cpu clock. This clock type requires
>>> configuration data that will be atomically programmed in the multiple
>>> clock blocks encapsulated within the cpu clock type when the parent clock
>>> frequency is changed. This configuration data is held in the clock controller
>>> node. Update clock binding documentation about this configuration data format
>>> for Samsung Exynos4 and Exynos5 platforms.
>>>
>>> Cc: Tomasz Figa <t.figa@samsung.com>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>> Cc: Kumar Gala <galak@codeaurora.org>
>>> Cc: <devicetree@vger.kernel.org>
>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>> ---
>>>  .../devicetree/bindings/clock/exynos4-clock.txt    |   37 ++++++++++++++++++++
>>>  .../devicetree/bindings/clock/exynos5250-clock.txt |   36 +++++++++++++++++++
>>>  2 files changed, 73 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/exynos4-clock.txt b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
>>> index f5a5b19..0934e02 100644
>>> --- a/Documentation/devicetree/bindings/clock/exynos4-clock.txt
>>> +++ b/Documentation/devicetree/bindings/clock/exynos4-clock.txt
>>> @@ -15,6 +15,35 @@ Required Properties:
>>>
>>>  - #clock-cells: should be 1.
>>>
>>> +- samsung,armclk-divider-table: when the frequency of the APLL is changed
>>> +  the divider clocks in CMU_CPU clock domain also need to be updated. These
>>> +  divider clocks have SoC specific divider clock output requirements for a
>>> +  specific APLL clock speeds. When APLL clock rate is changed, these divider
>>> +  clocks are reprogrammed with pre-determined values in order to maintain the
>>> +  SoC specific divider clock outputs. This property lists the divider values
>>> +  for divider clocks in the CMU_CPU block for supported APLL clock speeds.
>>> +  The format of each entry included in the arm-frequency-table should be
>>> +  as defined below
>>
>> As far as I understand, the relation is not between the APLL frequency
>> and particular clocks in CPU domain, but rather between the latter and
>> input clock to CPU domain, which is _after_ the two dividers (called
>> DIV_CORE and DIV_CORE2 or ARM_DIV1 and ARM_DIV2), which is also exactly
>> the output frequency of ARMCLK.
>>
>>> +
>>> +  - for Exynos4210 and Exynos4212 based platforms:
>>> +      cell #1: arm clock parent frequency
>>
>> Considering my comment above, this should be rather ARMCLK frequency.
> 
> The clocks SCLK_APLL, SCLK_HPM, ATCLK and PCLK_DBG have no relation to
> the ARMCLK frequency. These clocks are directly derived from the PLL
> clock and so it would not be correct to have them related to ARMCLK.

Oh, right, the old driver was changing DIV_APLL, DIV_ATB and
DIV_PCLK_DBG as well. Somehow I was under an impression that we need to
care only about those dividers on the path after DIV_CORE and DIV_CORE2.
In this case the parent rate is the key here, although I'd call it "CPU
block parent rate (usually APLL)".

However this means that the trick with using DIV_CORE and DIV_CORE2 to
divide the rate of temporary parent clock is not enough, because DIV_ATB
is sourced directly from MOUT_CORE.

> 
> So, I see two solutions to this, first being preferred solution.
> 
> [A] Cell #1 should define PLL (parent of armclk) clock speed. Cell #2
> and Cell #3  should define divider values for ARMCLK clock speed. The
> hardware does support PLL frequency != ARMCLK frequency and so DT
> binding should allow that (even though implementation in the linux
> kernel does not use this feature). BTW, this was what was done in v2
> of this series.
> 
> [B] Embedded this data with the code and don't get this from DT. The
> reason for doing this is, these are SoC specific values and not board
> specific. And when we are clear about what we want to put in DT, have
> a provision to lookup DT first and if DT values are not found,
> fallback on data embedded with the code.

Well, they are not that generic as they might appear. I've seen
different values for the same SoC in different vendor kernels, depending
on device the kernel was targeted for. Also they will likely differ
between SoC revisions.

However it might be a good idea indeed to keep the table in the code as
a first step to get the driver running without creating new DT bindings.

By the way, I'm not fully convinced if there is really a need for such
hardcoded look-up tables at all. Those divisors certainly look like they
are calculated based on some upper bounds for certain clocks and the
driver could simply find them out itself if those limits were provided.

Best regards,
Tomasz
