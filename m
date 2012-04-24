From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 24 Apr 2012 09:10:59 +0530
Subject: [PATCH V2 1/6] SPEAr: clk: Add VCO-PLL Synthesizer clock
In-Reply-To: <CAJOA=zOmV12j+hp90dzK=XtNh0QKw2r-jeE2A4bagDmesGpSKw@mail.gmail.com>
References: <cover.1334852393.git.viresh.kumar@st.com>
 <24b0bd2794cd2d8ca317d25745fc7d3d5c294bc7.1334852394.git.viresh.kumar@st.com>
 <CAJOA=zOmV12j+hp90dzK=XtNh0QKw2r-jeE2A4bagDmesGpSKw@mail.gmail.com>
Message-ID: <4F9620CB.9030801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2012 1:01 AM, Turquette, Mike wrote:
> On Thu, Apr 19, 2012 at 9:28 AM, Viresh Kumar <viresh.linux@gmail.com> wrote:
>> diff --git a/drivers/clk/spear/clk.h b/drivers/clk/spear/clk.h
>> new file mode 100644
>> index 0000000..a66024e
>> --- /dev/null
>> +++ b/drivers/clk/spear/clk.h
>> @@ -0,0 +1,76 @@
>> +/*
>> + * Clock framework definitions for SPEAr platform
>> + *
>> + * Copyright (C) 2012 ST Microelectronics
>> + * Viresh Kumar <viresh.kumar@st.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2. This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#ifndef __PLAT_CLOCK_H
>> +#define __PLAT_CLOCK_H
> 
> Any reason to use __PLAT_CLOCK_H from drivers/clk/ now?  Is it
> copy/paste from your old platform code?

Ya. Will fix it to __SPEAR_CLK_H

>> +static inline long clk_round_rate_index(struct clk_hw *hw, unsigned long drate,
>> +               clk_calc_rate calc_rate, u8 rtbl_cnt, int *index)
>> +{
>> +       unsigned long prev_rate, rate = 0;
>> +       unsigned long parent_rate = __clk_get_rate(__clk_get_parent(hw->clk));
>> +
>> +       for (*index = 0; *index < rtbl_cnt; (*index)++) {
>> +               prev_rate = rate;
>> +               rate = calc_rate(hw, parent_rate, *index);
>> +               if (drate < rate) {
>> +                       /* previous clock was best */
>> +                       if (*index) {
>> +                               rate = prev_rate;
>> +                               (*index)--;
>> +                       }
>> +                       break;
>> +               }
>> +       }
>> +
>> +       return rate;
>> +}
> 
> Any reason for this code to exist in a header?  I prefer code in C
> files.  Also it is a bit large for an inline function.

There is no C file common to entire SPEAr clock framework, so kept it in header.
Because this is called only from 2-3 places, inline would also be fine.

But if you insist, i can create clk.c in spear, where i can keep it.

-- 
viresh
