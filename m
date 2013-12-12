From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Dec 2013 21:40:08 +0100
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <52A9B9B4.3080105@linaro.org>
References: <1386770541-15056-1-git-send-email-zhangfei.gao@linaro.org>
 <201312112112.52746.arnd@arndb.de> <52A9B9B4.3080105@linaro.org>
Message-ID: <201312122140.08566.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 December 2013, zhangfei wrote:
> On 12/12/2013 04:12 AM, Arnd Bergmann wrote:
> > On Wednesday 11 December 2013, zhangfei wrote:
> >
> > But aren't the times fixed for each mode? Why do you need to specify them in
> > the DT? I would expect that the clock rates for each mode are set in the
> > MMC and SD specifications. When you call clk_set_rate(), it should normally
> > be enough to ask for the clock you actually want and let the clk subsystem
> > figure out how to set up the parents and multipliers on the way.
> 
> Yes. that's will be perfect.
>
> However, currently this ip still has no such capability.
>  Input rate for init are diferent for different controller, not the 
> init 400K, some are 13M, others are 25M, since different clock source.
> This can be easily solved by clock-freq-init = <25000000>
> 2. There is maxmum limit, also can be easily solved by define CLK_MAX.
> 3. However some mode can not use the max speed from ios->clock
> for example UHS_SDR104_MAX_DTR 208000000 can not be used, only half may 
> be reached, at least currently.

I don't fully understand the explanation, but if some of the other
people with interest in dw-mmc (I've added some more to Cc now) think
this makes sense, I'm fine with it too. 

> How about this desc
> 
> * clock-freq-table: should be the frequency (in Hz) array of the ciu 
> clock
>          in each supported timing. 
> 
>          1. CIU clock rate in HZ for MMC_TIMING_LEGACY mode 
> 
>          2. CIU clock rate in HZ for MMC_TIMING_MMC_HS mode
>          3. CIU clock rate in HZ for MMC_TIMING_SD_HS mode
>          4. CIU clock rate in HZ for MMC_TIMING_UHS_SDR12 mode 
> 
>          5. CIU clock rate in HZ for MMC_TIMING_UHS_SDR25 mode 
> 
>          6. CIU clock rate in HZ for MMC_TIMING_UHS_SDR50 mode 
> 
>          7. CIU clock rate in HZ for MMC_TIMING_UHS_SDR104 mode 
> 
>          8. CIU clock rate in HZ for MMC_TIMING_SD_HS mode 
> 
>          9. CIU clock rate in HZ for MMC_TIMING_MMC_HS200 mode 
> 

Yes, that is much better. but please avoid using Linux internal
identifiers (e.g. MMC_TIMING_LEGACY) and instead use the terminology from
the MMC and SD specs. Also 'Hz' is the official symbol for Hertz, not 'HZ'.

	Arnd
