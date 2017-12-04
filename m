From: andre.przywara@arm.com (=?UTF-8?Q?Andr=c3=a9_Przywara?=)
Date: Mon, 4 Dec 2017 23:25:27 +0000
Subject: [linux-sunxi] [PATCH 0/2] clk: sunxi-ng: sun50i: a64: Add 2x
 fixed post-divider to MMC module clocks
In-Reply-To: <20171204051912.7485-1-wens@csie.org>
References: <20171204051912.7485-1-wens@csie.org>
Message-ID: <25d0eff3-a0d9-fb49-8287-e65a4a102db7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/17 05:19, Chen-Yu Tsai wrote:
> Hi,
> 
> This is a small fix to get MMC performance up to proper speeds on the

Maybe a small fix for a skilled developer, but a giant leap for all
users ;-)
MMC performance goes from: (4.15-rc1)

SD: Timing buffered disk reads:   36 MB in  3.17 seconds =  11.35 MB/sec
eMMC: Timing buffered disk reads: 66 MB in  3.03 seconds =  21.81 MB/sec

to: (4.15-rc2 plus those two patches)

SD: Timing buffered disk reads:  68 MB in  3.01 seconds =   22.61 MB/sec
eMMC: Timing buffered disk reads: 132 MB in  3.01 seconds = 43.80 MB/sec

So yes, factor of two ...

Tested-by: Andre Przywara <andre.przywara@arm.com>

Given the impact I wonder if this is a candidate for stable as well.

> A64. According to the BSP kernel, the MMC module clocks have a /2 fixed
> post-divider between the clock output and the MMC module, like what
> we've seen with the "new MMC timing mode" on the A83T, but the A64 does
> not have the mode switch.
> 
> Sub-par performance was observed on the Banana Pi M64 eMMC. It only
> reached half the read throughput of other Banana Pi boards, using a
> standard sequential readout with a large block size. After these
> patches, the performance is up to spec.
> 
> The A64 can also do DDR transfer modes, but the clock delay config
> registers in the MMC module are different from what we've seen so
> far.

But the BSP doesn't set those as well, does it? I mean to remember that
they were all zero, expect for HS200/HS400?

Thanks!
Andre.

 One can just force enable DDR modes without tuning the delays,
> and it does work. Proper support for this is left for another time.
> 
> 
> ChenYu
> 
> Chen-Yu Tsai (2):
>   clk: sunxi-ng: Support fixed post-dividers on MP style clocks
>   clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module
>     clocks
> 
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 57 +++++++++++++++++++++++------------
>  drivers/clk/sunxi-ng/ccu_mp.c         | 20 ++++++++++--
>  drivers/clk/sunxi-ng/ccu_mp.h         | 24 +++++++++++++++
>  3 files changed, 79 insertions(+), 22 deletions(-)
> 
