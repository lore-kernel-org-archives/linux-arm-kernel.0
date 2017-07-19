From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 19 Jul 2017 16:59:23 +0800
Subject: [PATCH 05/11] mmc: sunxi: Support controllers that can use both
 old and new timings
In-Reply-To: <20170717091747.kcrlifbp7meihszm@flea>
References: <20170714064302.20383-1-wens@csie.org>
 <20170714064302.20383-6-wens@csie.org>
 <20170717091747.kcrlifbp7meihszm@flea>
Message-ID: <CAGb2v67VmdfrMNLFH=6hhbGAHr15e0q4toDUbJ17d3exS3maFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 5:17 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Jul 14, 2017 at 02:42:56PM +0800, Chen-Yu Tsai wrote:
>> On the SoCs that introduced the new timing mode for MMC controllers,
>> both the old (where the clock delays are set in the CCU) and new
>> (where the clock delays are set in the MMC controller) timing modes
>> are available, and we have to support them both. However there are
>> two bits that control which mode is active. One is in the CCU, the
>> other is in the MMC controller. The settings on both sides must be
>> the same, or nothing will work.
>>
>> The CCU's get/set_phase callbacks return -ENOTSUPP when the new
>> timing mode is active. This provides a way to know which mode is
>> active on that side, and we can set the bit on the MMC controller
>> side accordingly.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  drivers/mmc/host/sunxi-mmc.c | 34 ++++++++++++++++++++++++++++++----
>>  1 file changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> index 0fb4e4c119e1..56e45c65b52d 100644
>> --- a/drivers/mmc/host/sunxi-mmc.c
>> +++ b/drivers/mmc/host/sunxi-mmc.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/err.h>
>>
>>  #include <linux/clk.h>
>> +#include <linux/clk/sunxi-ng.h>
>>  #include <linux/gpio.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/spinlock.h>
>> @@ -259,7 +260,7 @@ struct sunxi_mmc_cfg {
>>       /* Does DATA0 needs to be masked while the clock is updated */
>>       bool mask_data0;
>>
>> -     bool needs_new_timings;
>> +     bool has_new_timings;
>
> I think we should have both, it's a bit different. Newer SoCs like the
> A64 can only operate using new timings, while the older ones can
> operate in both modes.
>
> In one case, we're forced to use it, in the other one it's a
> policy. We should differentiate both cases.

For the A64's case, the limit is implied by not having any clk_delays.

But yes, I'll keep "needs_new_timings", and rename the new option to
"has_timing_switch" to make things clearer.

ChenYu

>
> Looks good otherwise, thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
