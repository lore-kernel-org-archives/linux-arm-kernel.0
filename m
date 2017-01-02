From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 2 Jan 2017 11:08:44 +0200
Subject: [BISECTED] v4.9: OMAP MMC regression
In-Reply-To: <20161222205843.md4uggwyegcfuk3j@raspberrypi-2.musicnaut.iki.fi>
References: <20161217220120.xgyzq2hwxn3lsmm2@raspberrypi-2.musicnaut.iki.fi>
 <20161222205843.md4uggwyegcfuk3j@raspberrypi-2.musicnaut.iki.fi>
Message-ID: <92c33052-0469-1a17-a5fe-f18e88515d9b@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/22/2016 10:58 PM, Aaro Koskinen wrote:
> Hi,
> 
> On Sun, Dec 18, 2016 at 12:01:21AM +0200, Aaro Koskinen wrote:
>> OMAP MMC is silently missing when booting v4.9 on Nokia 770 (OMAP1).
>>
>> Bisected to:
>>
>> commit 2d1a9a946faebfedd660a1f1c2b90984fff41f91
>> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> Date:   Wed Jul 20 11:50:29 2016 +0300
>>
>>     dmaengine: omap-dma: Dynamically allocate memory for lch_map
>>
>> Reveting the commit makes MMC to appear and work again...
> 
> This commit basically reduces dma_requests count to 17 (from 127)
> on OMAP1.
> 
> This cannot be correct, since OMAP1 MMC is using requests (from
> omap1_init_mmc):
> 
>                         rx_req = 22;
>                         tx_req = 21;
> [...]
>                         rx_req = 55;
>                         tx_req = 54;
> 
> MMC probe will fail because omap_dma_filter_fn() will fail during
> dma_request_chan().
> 
> I think 2d1a9a946faebfedd660a1f1c2b90984fff41f91 should be reverted.
> I cannot anymore boot my 770 with >= 4.9 kernel.

I rather fix this instead of reverting the commit, I will send a patch
today for this.

-- 
P?ter
