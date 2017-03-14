From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 14 Mar 2017 11:14:15 +0200
Subject: [2/3] soc: samsung: Do not build ARMv7 PMU drivers on ARMv8
In-Reply-To: <0ae4c538-a3af-a1b7-418d-4bccbf09faf4@samsung.com>
References: <CGME20170314075427epcas5p19d137fbcc390e937172a17ae99f11a0c@epcas5p1.samsung.com>
 <20170311213856.21701-3-krzk@kernel.org>
 <2da8c346-dae9-6754-8349-df0946c89ae2@samsung.com>
 <CAJKOXPd=K8rbBxV21ibubjgU8BV3g4AqDrXX0f6-N_VPkR=puQ@mail.gmail.com>
 <0ae4c538-a3af-a1b7-418d-4bccbf09faf4@samsung.com>
Message-ID: <CAJKOXPfaUhw=vzKKZc=3RjoRsRWP7qmPborjg+qpv5hr6iff8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 10:40 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>
>
> On 03/14/2017 01:32 PM, Krzysztof Kozlowski wrote:
>> On Tue, Mar 14, 2017 at 9:51 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>>> Hi Krzysztof,
>>>
>>> On 03/12/2017 03:08 AM, Krzysztof Kozlowski wrote:
>>>> The Exynos Power Management Unit (PMU) drivers contain quite large
>>>> static arrays of register values necessary for given Exynos SoC to enter
>>>> low power mode.  All this data is useless for ARMv8 SoC like
>>>> Exynos5433, because the image will not be shared between ARMv7 and
>>>> ARMv8.
>>>>
>>>> Add additional Kconfig symbol for selecting the SoC-specific driver
>>>> addons thus skipping the useless data in the final image (this is
>>>> similar approach to chosen for Exynos clock controller drivers):
>>>>  - exynos-pmu driver will be compiled on both architectures ARMv7
>>>>    and ARMv8,
>>>>  - additional driver_data for ARMv7 SoCs will not be built on ARMv8
>>>>    and a macro will return NULL for them in of_device_id - this should
>>>>    be safe as these compatibles cannot match on ARMv7 and driver
>>>>    anyway handles NULL driver_data,
>>>>  - on ARMv8 compile only exynos-pmu driver which exposes the
>>>>    syscon-regmap for PMU address space.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>>>> ---
>>>>  drivers/soc/samsung/Kconfig      |  8 +++++++-
>>>>  drivers/soc/samsung/Makefile     |  4 +++-
>>>>  drivers/soc/samsung/exynos-pmu.c | 22 ++++++++++++++++------
>>>>  drivers/soc/samsung/exynos-pmu.h |  3 +++
>>>>  4 files changed, 29 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
>>>> index 245533907d1b..8b25bd55e648 100644
>>>> --- a/drivers/soc/samsung/Kconfig
>>>> +++ b/drivers/soc/samsung/Kconfig
>>>> @@ -8,7 +8,13 @@ if SOC_SAMSUNG
>>>>
>>>>  config EXYNOS_PMU
>>>>       bool "Exynos PMU controller driver" if COMPILE_TEST
>>>> -     depends on (ARM && ARCH_EXYNOS) || ((ARM || ARM64) && COMPILE_TEST)
>>>> +     depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
>>>> +     select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
>>>> +
>>>
>>> In general this patch look ok, but I was think we should make these
>>> configs configurable via _menuconfig_. Currently these are visible only
>>> if COMPILE_TEST is enabled.
>>> Recently I was working on adding PMU support for Exynos7 and I face
>>> issues when I want to disable this option and re-enable it for testing
>>> purpose.
>>
>> These drivers are not available in menuconfig on purpose - these are
>> essential parts of SoC. Without them usually something will not work
>> so user should not be able to disable them. For all of such drivers,
>> we use the SELECT from mach approach.
>>
> Well, what you are saying is very subjective. In past I have face issues
> where to isolate or narrow down some issue, we do need to play with PMU
> and power domains. So, having a configurable option won't hurt here.
> Anyway if you (or anyone else) strongly feel we should be following
> "SELECT from MACH approach" then lets follow it.

For ARMv7, in the past you could not do this. It behaved (almost)
always the same as it is now. The PMU driver was being compiled in if
ARCH_EXYNOS is selected.

On ARMv8 - Exynos7 - there was no PMU driver so indeed this behavior
changes. However PMU driver now is necessary for pinctrl (and actually
for some others referring by syscon) so really you cannot disable it
and expect things to work. Menuconfig serves such purpose - user
(distro config developer) can choose what he wants but he wants to
boot the kernel. People in general and people setting up configs for
distro usually do not know all the subtle SoC submodule relations for
all of the SoCs. That is our responsibility to provide them something
which is usable.

On the other hand, for debugging we always had to change some things.
That's debugging.

Best regards,
Krzysztof
