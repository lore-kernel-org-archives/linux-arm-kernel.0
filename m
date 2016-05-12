From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 13 May 2016 07:47:02 +0800
Subject: [PATCH 2/2] clk: rockchip: fix the rk3399 sdmmc sample shift
In-Reply-To: <20160512231023.GA63308@google.com>
References: <1463076197-15900-1-git-send-email-dianders@chromium.org>
 <1463076197-15900-2-git-send-email-dianders@chromium.org>
 <20160512231023.GA63308@google.com>
Message-ID: <84673e7c-dd64-b2ca-5c7c-5c7f34d239d8@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/5/13 7:10, Brian Norris ??:
> On Thu, May 12, 2016 at 11:03:17AM -0700, Doug Anderson wrote:
>> Just like every other Rockhip device, the MMC "_sample" clocks should
>> have a shift of 0, not a shift of 1.  The rk3399 TRM agrees.  Presumably
>> these values were set to 0 because of a typo.
>
> I'll semi-disagree about the TRM: the TRM doesn't seem to agree with
> itself, so it sometimes agrees with you and sometimes doesn't :)
>
> On page 79 of the 2nd (?) book, it looks like {SDMMC,SDIO}_CON{0,}[2:1]
> are {drv,sample}_degree. But on page 208 of the 1st book, those are put
> at bits [1:0].
>


Please refer to Mobile Strorage Host Controller section for anything
about sdmmc/sdio. So shift should be 1.

Sometime I also get bothered to address it. Anyway, I will always keep
a eye on it from now on.....

> Perhaps we can get a straight answer from Rockchip though.
>
> Brian
>
>> Things _sorta_ would have worked with the incorrect sample phase shift
>> because of the register layout but wouldn't have been ideal and we would
>> have skipped lots of phases.  Also: we would never actually enabled the
>> fine delay unless we happened to have 128 or more delay elements.
>>
>> This is expected behavior before this patch:
>> * Try to set:     0 degrees +   1 delay elements
>>   Actually get:   0 degrees +   0 delay elements
>> * Try to set:    90 degrees +   0 delay elements
>>   Actually get: 180 degrees +   0 delay elements
>> * Try to set:   180 degrees +   0 delay elements
>>   Actually get:   0 degrees +   0 delay elements
>> * Try to set:   270 degrees +   0 delay elements
>>   Actually get: 180 degrees +   0 delay elements
>> * Try to set:     0 degrees + 129 delay elements
>>   Actually get:   0 degrees +   2 delay elements
>> * Try to set:   180 degrees + 129 delay elements
>>   Actually get:   0 degrees +   3 delay elements
>> * Try to set:     0 degrees + 130 delay elements
>>   Actually get:   0 degrees +   4 delay elements
>>
>> I verified that old code had a problem by turning on debug printouts and
>> seeing that the old code would report this for one SD card I had:
>>   Good phase range 347-101 (115 len)
>>   Good phase range 202-326 (125 len)
>>
>> After my fix, it went down to one big good range for the same card.
>> This is more expected:
>>   Good phase range 189-1 (173 len)
>>   Good phase range 82-85 (4 len)
>>   Good phase range 166-168 (3 len)
>>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>  drivers/clk/rockchip/clk-rk3399.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
>> index 291543f52caa..14ff3e109e1e 100644
>> --- a/drivers/clk/rockchip/clk-rk3399.c
>> +++ b/drivers/clk/rockchip/clk-rk3399.c
>> @@ -895,10 +895,10 @@ static struct rockchip_clk_branch rk3399_clk_branches[] __initdata = {
>>  			RK3399_CLKGATE_CON(6), 1, GFLAGS),
>>
>>  	MMC(SCLK_SDMMC_DRV,     "sdmmc_drv",    "clk_sdmmc", RK3399_SDMMC_CON0, 1),
>> -	MMC(SCLK_SDMMC_SAMPLE,  "sdmmc_sample", "clk_sdmmc", RK3399_SDMMC_CON1, 1),
>> +	MMC(SCLK_SDMMC_SAMPLE,  "sdmmc_sample", "clk_sdmmc", RK3399_SDMMC_CON1, 0),
>>
>>  	MMC(SCLK_SDIO_DRV,      "sdio_drv",    "clk_sdio",  RK3399_SDIO_CON0,  1),
>> -	MMC(SCLK_SDIO_SAMPLE,   "sdio_sample", "clk_sdio",  RK3399_SDIO_CON1,  1),
>> +	MMC(SCLK_SDIO_SAMPLE,   "sdio_sample", "clk_sdio",  RK3399_SDIO_CON1,  0),
>>
>>  	/* pcie */
>>  	COMPOSITE(SCLK_PCIE_PM, "clk_pcie_pm", mux_pll_src_cpll_gpll_npll_24m_p, 0,
>
>
>


-- 
Best Regards
Shawn Lin
