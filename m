From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 15 Nov 2018 13:15:00 +0100
Subject: [PATCH 1/2] clocksource: meson6_timer: use register names from
 the datasheet
In-Reply-To: <CAFBinCBueqknBzV6PJnuSzd09=dd06gkjZG+ykr5qKLf=uRT2A@mail.gmail.com>
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
 <20181028125501.17336-2-martin.blumenstingl@googlemail.com>
 <6793aba9-87fc-6cf8-cada-f1fa6a1e0040@linaro.org>
 <CAFBinCBueqknBzV6PJnuSzd09=dd06gkjZG+ykr5qKLf=uRT2A@mail.gmail.com>
Message-ID: <036e5c1e-7e02-9691-3c36-4ebdc4cce727@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/11/2018 07:23, Martin Blumenstingl wrote:
> Hi Daniel,
> 
> thanks for your feedback!
> 
> On Thu, Nov 15, 2018 at 2:35 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 28/10/2018 13:55, Martin Blumenstingl wrote:
>>> This makes the driver use the names from S805 datasheet for the
>>> preprocessor #defines. This makes it easier to spot that the driver
>>> currently only supports Timer A (as clockevent with interrupt support)
>>> and Timer E (as clocksource without interrupts). Timer B, C and D (which
>>> are similar to Timer A) are currently not supported by the driver.
>>>
>>> While here, this also removes the internal "CED_ID" and "CSD_ID" defines
>>> which are used to identify the timer. These IDs are not described in the
>>> datasheet and thus make it harder to compare the code to what's written
>>> in the datasheet.
>>>
>>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>>> ---
>>>  drivers/clocksource/meson6_timer.c | 110 ++++++++++++++++++-----------
>>>  1 file changed, 68 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
>>> index 92f20991a937..c622135bee9d 100644
>>> --- a/drivers/clocksource/meson6_timer.c
>>> +++ b/drivers/clocksource/meson6_timer.c
>>> @@ -10,6 +10,8 @@
>>>   * warranty of any kind, whether express or implied.
>>>   */
>>>
>>> +#include <linux/bitfield.h>
>>> +#include <linux/bitops.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/clockchips.h>
>>>  #include <linux/interrupt.h>
>>> @@ -20,80 +22,102 @@
>>>  #include <linux/of_address.h>
>>>  #include <linux/of_irq.h>
>>>
>>> -#define CED_ID                       0
>>> -#define CSD_ID                       4
>>> -
>>> -#define TIMER_ISA_MUX                0
>>> -#define TIMER_ISA_VAL(t)     (((t) + 1) << 2)
>>> -
>>> -#define TIMER_INPUT_BIT(t)   (2 * (t))
>>> -#define TIMER_ENABLE_BIT(t)  (16 + (t))
>>> -#define TIMER_PERIODIC_BIT(t)        (12 + (t))
>>> +enum meson6_timera_input_clock {
>>> +     MESON_TIMERA_CLOCK_1US = 0x0,
>>> +     MESON_TIMERA_CLOCK_10US = 0x1,
>>> +     MESON_TIMERA_CLOCK_100US = 0x2,
>>> +     MESON_TIMERA_CLOCK_1MS = 0x3,
>>> +};
>>>
>>> -#define TIMER_CED_INPUT_MASK (3UL << TIMER_INPUT_BIT(CED_ID))
>>> -#define TIMER_CSD_INPUT_MASK (7UL << TIMER_INPUT_BIT(CSD_ID))
>>> +enum meson6_timere_input_clock {
>>> +     MESON_TIMERE_CLOCK_SYSTEM_CLOCK = 0x0,
>>> +     MESON_TIMERE_CLOCK_1US = 0x1,
>>> +     MESON_TIMERE_CLOCK_10US = 0x2,
>>> +     MESON_TIMERE_CLOCK_100US = 0x3,
>>> +     MESON_TIMERE_CLOCK_1MS = 0x4,
>>> +};
>>
>> It is not required to specify the values. The standard defines the
>> default first value is zero, and each enum has the value which is +1 of
>> the previous one.
> the idea behind this is: these are values from the datasheet so I
> wanted to make them easy to find when comparing the datasheet with the
> driver.
> I will replace the enums with simple #defines if there are no
> objections (that also makes it consistent with the other register
> values in the driver).

No objection to change them to macros :)

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
