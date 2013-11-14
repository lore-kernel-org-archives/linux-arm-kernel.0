From: yadi.brar01@gmail.com (Yadwinder Singh Brar)
Date: Thu, 14 Nov 2013 23:06:47 +0900
Subject: [RFC 0/4] Add basic support for ASV
In-Reply-To: <CAJ0PZbSe9dXdaRewwFP5UjNeOCby2EsayU4vDcQEKi5Z4SqtvA@mail.gmail.com>
References: <1378898048-25205-1-git-send-email-yadi.brar@samsung.com>
 <CAKew6eUK9ZtoVgVu_b13Bn20iMNWzHnWjSHMjxD1Y+zDtvoCWw@mail.gmail.com>
 <CAJ0PZbSe9dXdaRewwFP5UjNeOCby2EsayU4vDcQEKi5Z4SqtvA@mail.gmail.com>
Message-ID: <CAKew6eVgKXJdpn06fZQ7Q0EEotx2+-L5JoiLuF_j50rUOqK=pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi MyungJoo,

Thanks for your review.

On Wed, Nov 13, 2013 at 11:33 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> On Mon, Nov 11, 2013 at 11:27 PM, Yadwinder Singh Brar
> <yadi.brar01@gmail.com> wrote:
>> gentle ping for suggestions/reviews ..
>>
>>
>> On Wed, Sep 11, 2013 at 8:14 PM, Yadwinder Singh Brar
>> <yadi.brar@samsung.com> wrote:
>>> This series is to add basic common infrastructure for ASV.
>>>  Basically ASV is a technique used on samsung SoCs, which provides the
>>> recommended supply voltage for dvfs of arm, mif etc. For a given operating
>>> frequency, the voltage is recommended based on SoC's ASV group.
>>> ASV group gets fussed on SoCs during process of mass production.
>
> ASV is an instance of AVS. Please recondier and try to reuse
> what's already there (drivers/power/avs)
>
> Quote from drivers/power/avs/Kconfig:
>           "At a given operating point the voltage is adapted depending on
>           static factors (chip manufacturing process) and dynamic factors
>           (temperature depending performance)."
> It seems that the current ASV is subset of AVS.

Yes, both seems to be for similar purpose but  still significantly
different from each other. I would like to describe/differentiate it
little bit here
for explanation for others, that it is AVS(adaptive voltage scaling) which
seems to be an IP/module doing adaptive voltage scaling where as
ours is ASV(Adaptive scaling voltage), it provides only (adaptive) voltage
for scaling to other drivers.

> Although the current implementation of AVS does not provide significant
> infrastructure to its sisters, we may start by sharing the directory.
>

Yes, we can just share directory only right now, other then that i
didn't see any thing can be common.
Firstly i had put in that directory itself, later being doubtful i
moved it to new directory but we can share directory.
Any ideas/comments from others ?

Regards,
Yadwinder

>
> Added Jean Pihet, who has submitted AVS (TI).
>
> Cheers,
> MyungJoo.
>
>>>
>>> This series includes:
>>>  - basic common infrastructue for ASV. It provides common APIs for user drivers
>>> like cpufreq & devfreq and and an interface for SoC specific drivers to
>>> register ASV members(instances)
>>>  - a common platform driver to register ASV members for exynos SoCs
>>>  - an example providing minimal support (only for ARM ASV) for exynos5250 chips
>>>
>>> Its just basic skelton which I wanted to get it reviewed or discussed in
>>> early stage, before going ahead on further development based on it.
>>>  Presently example is based on static ASV table provided in SoC specific file,
>>> which I expects to go into DT. But exactly how and where needs to be discussed,
>>> may be in next revisions once we get through the basic skelton.
>>>  Also the location of driver in kernel may also seem odd to someone and
>>> many more things :).
>>>
>>> Looking for your valuable reviews and suggestions.
>>>
>>> Thanks
>>>
>>> Yadwinder Singh Brar (4):
>>>   power: asv: Add common ASV support for samsung SoCs
>>>   power: asv: Add a common asv driver for exynos SoCs.
>>>   power: asv: Add support for exynos5250
>>>   arm: exynos5: Register static platform device for ASV.
>>>
>>>  arch/arm/mach-exynos/mach-exynos5-dt.c   |    3 +
>>>  drivers/power/Kconfig                    |    1 +
>>>  drivers/power/Makefile                   |    1 +
>>>  drivers/power/asv/Kconfig                |   24 ++++
>>>  drivers/power/asv/Makefile               |    2 +
>>>  drivers/power/asv/exynos-asv.c           |   81 ++++++++++++++
>>>  drivers/power/asv/exynos-asv.h           |   22 ++++
>>>  drivers/power/asv/exynos5250-asv.c       |  141 ++++++++++++++++++++++++
>>>  drivers/power/asv/samsung-asv.c          |  175 ++++++++++++++++++++++++++++++
>>>  include/linux/power/samsung-asv-driver.h |   61 +++++++++++
>>>  include/linux/power/samsung-asv.h        |   37 +++++++
>>>  11 files changed, 548 insertions(+), 0 deletions(-)
>>>  create mode 100644 drivers/power/asv/Kconfig
>>>  create mode 100644 drivers/power/asv/Makefile
>>>  create mode 100644 drivers/power/asv/exynos-asv.c
>>>  create mode 100644 drivers/power/asv/exynos-asv.h
>>>  create mode 100644 drivers/power/asv/exynos5250-asv.c
>>>  create mode 100644 drivers/power/asv/samsung-asv.c
>>>  create mode 100644 include/linux/power/samsung-asv-driver.h
>>>  create mode 100644 include/linux/power/samsung-asv.h
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
>
> --
> MyungJoo Ham, Ph.D.
> System S/W Lab, S/W Center, Samsung Electronics
