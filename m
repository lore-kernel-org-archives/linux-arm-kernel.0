From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 23 Apr 2014 22:56:57 +0200
Subject: [PATCH v2 2/3] arm: exynos: Add MCPM call-back functions
In-Reply-To: <CAM4voa=WJiF-9wZB29JOFhz2kEE-TC0y6h-8GVwk3_JoXxpK+A@mail.gmail.com>
References: <1397239311-27717-6-git-send-email-a.kesavan@samsung.com>	<1398147435-3122-1-git-send-email-a.kesavan@samsung.com>	<535650AE.90501@linaro.org>
 <CAM4voa=WJiF-9wZB29JOFhz2kEE-TC0y6h-8GVwk3_JoXxpK+A@mail.gmail.com>
Message-ID: <53582919.1040905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 05:31 PM, Abhilash Kesavan wrote:
> Hi Daniel,
> On Tue, Apr 22, 2014 at 4:51 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 04/22/2014 08:17 AM, Abhilash Kesavan wrote:
>>>
>>> Add machine-dependent MCPM call-backs for Exynos5420. These are used
>>> to power up/down the secondary CPUs during boot, shutdown, s2r and
>>> switching.
>>>
>>> Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
>>> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> ---

[ ... ]

>>> +#include <plat/cpu.h>
>>> +#include "regs-pmu.h"
>>> +
>>> +#define EXYNOS5420_CPUS_PER_CLUSTER    4
>>> +#define EXYNOS5420_NR_CLUSTERS         2
>>> +
>>> +/* Secondary CPU entry point */
>>> +#define REG_ENTRY_ADDR         (S5P_VA_SYSRAM_NS + 0x1C)
>>> +
>>> +#define EXYNOS_CORE_LOCAL_PWR_EN               0x3
>>> +#define EXYNOS_CORE_LOCAL_PWR_DIS              0x0
>>>
>>> +#define EXYNOS_ARM_COMMON_CONFIGURATION                S5P_PMUREG(0x2500)
>>> +#define EXYNOS_ARM_L2_CONFIGURATION            S5P_PMUREG(0x2600)
>>> +
>>> +#define EXYNOS_ARM_CORE_CONFIGURATION(_nr)     \
>>> +                       (S5P_ARM_CORE0_CONFIGURATION + ((_nr) * 0x80))
>>> +#define EXYNOS_ARM_CORE_STATUS(_nr)            \
>>> +                       (S5P_ARM_CORE0_STATUS + ((_nr) * 0x80))
>>> +
>>> +#define EXYNOS_COMMON_CONFIGURATION(_nr)       \
>>> +                       (EXYNOS_ARM_COMMON_CONFIGURATION + ((_nr) * 0x80))
>>> +#define EXYNOS_COMMON_STATUS(_nr)              \
>>> +                       (EXYNOS_COMMON_CONFIGURATION(_nr) + 0x4)
>>> +
>>> +#define EXYNOS_L2_CONFIGURATION(_nr)           \
>>> +                       (EXYNOS_ARM_L2_CONFIGURATION + ((_nr) * 0x80))
>>> +#define EXYNOS_L2_STATUS(_nr)                  \
>>> +                       (EXYNOS_L2_CONFIGURATION(_nr) + 0x4)
>>> +
>>
>>
>> Is it possible to share the definition of those macros with the rest of the
>> code via functions, so they can be re-used for the other sub-systems ? eg:
>> https://patches.linaro.org/27798/
> OK..I will work on making wrapper functions for these. Would these new
> functions be better placed in the mcpm code or the pm code ?

Hi Abhilash,

yes, in the pm code. That would make more sense.

Thanks
   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
