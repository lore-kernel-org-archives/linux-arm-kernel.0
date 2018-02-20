From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 20 Feb 2018 11:17:06 +0800
Subject: [PATCH] clk: sunxi-ng: a31: Fix CLK_OUT_* clock ops
In-Reply-To: <694c5137-0020-bb62-68c7-f9729c101462@gmail.com>
References: <20180217130504.8668-1-wens@csie.org>
 <694c5137-0020-bb62-68c7-f9729c101462@gmail.com>
Message-ID: <CAGb2v64F9oHCv=uOGmeLc4_Qnz4BZO29ct8mCbJsRgdTJMDk3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 9:54 PM, Philipp Rossak <embed3d@gmail.com> wrote:
>
>
> On 17.02.2018 14:05, Chen-Yu Tsai wrote:
>>
>> When support for the A31/A31s CCU was first added, the clock ops for
>> the CLK_OUT_* clocks was set to the wrong type. The clocks are MP-type,
>> but the ops was set for div (M) clocks. This went unnoticed until now.
>> This was because while they are different clocks, their data structures
>> aligned in a way that ccu_div_ops would access the second ccu_div_internal
>> and ccu_mux_internal structures, which were valid, if not incorrect.
>>
>> Furthermore, the use of these CLK_OUT_* was for feeding a precise 32.768
>> kHz clock signal to the WiFi chip. This was achievable by using the parent
>> with the same clock rate and no divider. So the incorrect divider setting
>> did not affect this usage.
>>
>> Commit 946797aa3f08 ("clk: sunxi-ng: Support fixed post-dividers on MP
>> style clocks") added a new field to the ccu_mp structure, which broke
>> the aforementioned alignment. Now the system crashes as div_ops tries
>> to look up a nonexistent table.
>>
>> Reported-by: Philipp Rossak <embed3d@gmail.com>
>> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Tested-by: Philipp Rossak <embed3d@gmail.com>
>>
>> ---
>>
>> Philipp, can you give this a test and report if this fixes thing?
>> I don't have any A31/A31s boards online to test this.
>>
> Thanks!
> That fixes that bug!

Thanks.

It looks like this has been applied by Maxime.
