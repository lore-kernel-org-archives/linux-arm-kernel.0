From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 5 Dec 2017 11:04:45 +0800
Subject: [linux-sunxi] [PATCH 0/2] clk: sunxi-ng: sun50i: a64: Add 2x
 fixed post-divider to MMC module clocks
In-Reply-To: <25d0eff3-a0d9-fb49-8287-e65a4a102db7@arm.com>
References: <20171204051912.7485-1-wens@csie.org>
 <25d0eff3-a0d9-fb49-8287-e65a4a102db7@arm.com>
Message-ID: <CAGb2v65Ps-z=ijMARxxxAX3h7+b_gQ-bh2B8AO6t5mpPdJNhtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 7:25 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> On 04/12/17 05:19, Chen-Yu Tsai wrote:
>> Hi,
>>
>> This is a small fix to get MMC performance up to proper speeds on the
>
> Maybe a small fix for a skilled developer, but a giant leap for all
> users ;-)
> MMC performance goes from: (4.15-rc1)
>
> SD: Timing buffered disk reads:   36 MB in  3.17 seconds =  11.35 MB/sec
> eMMC: Timing buffered disk reads: 66 MB in  3.03 seconds =  21.81 MB/sec
>
> to: (4.15-rc2 plus those two patches)
>
> SD: Timing buffered disk reads:  68 MB in  3.01 seconds =   22.61 MB/sec
> eMMC: Timing buffered disk reads: 132 MB in  3.01 seconds = 43.80 MB/sec
>
> So yes, factor of two ...
>
> Tested-by: Andre Przywara <andre.przywara@arm.com>
>
> Given the impact I wonder if this is a candidate for stable as well.

It could. But then again, nothing was broken. And it depends on the first
patch. I'm not sure stable would like that.

>
>> A64. According to the BSP kernel, the MMC module clocks have a /2 fixed
>> post-divider between the clock output and the MMC module, like what
>> we've seen with the "new MMC timing mode" on the A83T, but the A64 does
>> not have the mode switch.
>>
>> Sub-par performance was observed on the Banana Pi M64 eMMC. It only
>> reached half the read throughput of other Banana Pi boards, using a
>> standard sequential readout with a large block size. After these
>> patches, the performance is up to spec.
>>
>> The A64 can also do DDR transfer modes, but the clock delay config
>> registers in the MMC module are different from what we've seen so
>> far.
>
> But the BSP doesn't set those as well, does it? I mean to remember that
> they were all zero, expect for HS200/HS400?

What I meant was we should make it clear in the mmc driver that this
is another new configuration mechanism that is different from the
previous ones.

ChenYu

>
> Thanks!
> Andre.
>
>> One can just force enable DDR modes without tuning the delays,
>> and it does work. Proper support for this is left for another time.
>>
>>
>> ChenYu
>>
>> Chen-Yu Tsai (2):
>>   clk: sunxi-ng: Support fixed post-dividers on MP style clocks
>>   clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module
>>     clocks
>>
>>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 57 +++++++++++++++++++++++------------
>>  drivers/clk/sunxi-ng/ccu_mp.c         | 20 ++++++++++--
>>  drivers/clk/sunxi-ng/ccu_mp.h         | 24 +++++++++++++++
>>  3 files changed, 79 insertions(+), 22 deletions(-)
>>
>
