From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue, 10 Dec 2013 08:08:44 -0600
Subject: [PATCHv4 2/4] clk: socfpga: Add a hook for SD/MMC driver to
 control CIU clock settings
In-Reply-To: <201312052157.37538.arnd@arndb.de>
References: <1386263677-7733-1-git-send-email-dinguyen@altera.com>
 <1386263677-7733-3-git-send-email-dinguyen@altera.com>
 <201312052157.37538.arnd@arndb.de>
Message-ID: <52A7206C.4040500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/5/13 2:57 PM, Arnd Bergmann wrote:
> On Thursday 05 December 2013, dinguyen at altera.com wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Populate the .prepare function in the clk-ops for the "sdmmc_clk" that represents
>> the "ciu" clock for the SD/MMC driver. The prepare function will handle setting
>> the correct clock-phase for the CIU clock of the SD/MMC IP.
>>
>> Re-use the "rockchip,rk2928-dw-mshc" binding as it is already defined and
>> appropriate for the SOCFPGA platform as well.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> I think with this series we're getting closer to where things should be, but
> there are still a number of the same problems. Maybe I have misunderstood
> a few things here in how the clocks fit together, but here is what still
> looks wrong about this patch:
>
>> diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
>> index 60cb2f5..01baf20 100644
>> --- a/drivers/clk/socfpga/clk.c
>> +++ b/drivers/clk/socfpga/clk.c
>> @@ -55,7 +55,13 @@
>>  #define div_mask(width)	((1 << (width)) - 1)
>>  #define streq(a, b) (strcmp((a), (b)) == 0)
>>  
>> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET	0x108
>> +/* SDMMC Group for System Manager defines */
>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)          \
>> +	((((smplsel) & 0x7) << 3) | (((drvsel) & 0x7) << 0))
>> +
>>  extern void __iomem *clk_mgr_base_addr;
>> +extern void __iomem *sys_manager_base_addr;
> As mentioned in yesterday's comments, you should not have the 'extern'
> declaration for sys_manager_base_addr here. In fact, the existing
> clk_mgr_base_addr declaration is just as wrong.
Yes, will fix..
>
>> +static int sdmmc_ciuclk_prepare(struct clk_hw *hwclk)
>> +{
>> +	struct device_node *np;
>> +	u32 timing[2];
>> +	u32 hs_timing;
>> +
>> +	np = of_find_compatible_node(NULL, NULL, "rockchip,rk2928-dw-mshc");
>> +	if (of_property_read_u32_array(np, "samsung,dw-mshc-sdr-timing", timing, 2)) {
>> +		pr_err("SDMMC: cannot find samsung,dw-mshc-sdr-timing!\n");
>> +		return -ENODATA;
>> +	}
>> +	hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[1], timing[0]);
>> +	writel(hs_timing, sys_manager_base_addr + SYSMGR_SDMMCGRP_CTRL_OFFSET);
>> +	return 0;
>> +}
>> +
> And in now way should the clock provider code look into the DT properties of the
> clock consumer. From what I can tell, the dw-mshc code already interprets the
> "samsung,dw-mshc-sdr-timing" property and uses the data to pass the correct
> clock rate using 'clk_set_rate()'. The clock code should only use the data passed
> in the argument to that function to set up the registers and not need to know
> at all who is setting it.
You're right, the dw-mshc code interprets "samsung,dw-mshc-sdr-timing",
but it is
currently doing it in the platform specific code(dw_mmc-exynos and
dw_mmc-socfpga).
I was thinking I can remove the platform specific for SOCFPGA. But
perhaps now that
patch "mmc: dw_mmc: Make the use of the hold reg generic" is
progressing, and
that patch reads "samsung,dw-mshc-sdr-timing" in the generic dw_mmc
code, I can now
pass it through the clk_set_rate call.

My initial thought to read "samsung,dw-mshc-sdr-timing" in the socfpga clock
driver's was that the SOCFPGA's sdmmc_clk only role in life is to feed
the sdmmc block. So
reading the phase shift bits that adjust this clock does seem weird, but
a straightforward way
of doing it. I stuck it in the function in .prepare function because the
setting of the clock's phase
shift also requires that CIU clock be turned off while the bits are
toggled, so the prepare function
seems to work perfectly. So I think you're only concern is that I should
figure out a way to pass
the values of "samsung,dw-mshc-sdr-timing" from the dw_mmc driver to the
clock driver, correct?

Yes, I can read the "samsung,dw-mshc-sdr-timing" in the dw_mmc code and
pass it to the clock
driver using clk_set_rate(), but this method seems more cumbersome, as
this clk_set_rate does not
have anything to do with setting the rate, but only the phase shift
settings of the clock.
>
> I am a little confused though what the SYSMGR_SDMMCGRP_CTRL_OFFSET register actually
> does. It looks like this is just a clock divider, which should be represented as
> a separate clock node (as you had in v3) and compute the correct factor from the
> requested clock rate and the parent clock rate.
The SYSMGR_SDMMCGRP_CTRL_OFFSET is just putting the 2 values of
"samsung,dw-mshc-sdr-timing"
into a a single u32 value to be written to the register.
"samsung,dw-mshc-sdr-timing" has 2 values that
controls the phase shift of 2 clocks, the drive clock and the sample clock.

Thanks,
Dinh
>
> 	Arnd
