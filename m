From: wxt@rock-chips.com (Caesar Wang)
Date: Sun, 07 Jun 2015 10:51:54 +0800
Subject: [PATCH v4 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <CAD=FV=XGOVpAA5+NQ8O910T=CPrYKfTseBXfNbR4EkenzDECaQ@mail.gmail.com>
References: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>	<1433523923-4755-2-git-send-email-wxt@rock-chips.com>
 <CAD=FV=XGOVpAA5+NQ8O910T=CPrYKfTseBXfNbR4EkenzDECaQ@mail.gmail.com>
Message-ID: <5573B1CA.1050204@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2015?06?06? 04:55, Doug Anderson ??:
> Caesar,
>
> On Fri, Jun 5, 2015 at 10:05 AM, Caesar Wang <wxt@rock-chips.com> wrote:
>> +               if (!on)
>> +                       reset_control_assert(rstc);
>> +
>> +               ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
>> +               if (ret < 0) {
>> +                       pr_err("%s: could not update power domain\n", __func__);
>> +                       reset_control_put(rstc);
>> +                       return ret;
>> +               }
>> +
>>                  if (on)
>>                          reset_control_deassert(rstc);
>> -               else
>> -                       reset_control_assert(rstc);
> As Heiko indicated in the previous patchset, he thought it would be
> nice to move the 'pmu_power_domain_is_on(pd)' to before you deasserted
> reset.  ...but then I pointed out that you tested that in patch set #2
> and it didn't work.
>
> Talking to Heiko offline he thought that perhaps you could make
> 'pmu_power_domain_is_on(pd)' work if you increased your 'udelay(10);'
> in rockchip_boot_secondary().  Perhaps the old
> 'pmu_power_domain_is_on' was acting like an extra bit of delay and
> that's why moving it broke things.
>
>
> I actually went back and tested patch set #2 and it worked for me, so
> I couldn't test Heiko's theory.  Could you go and reproduce the
> problem with patch set #2 again and then try increasing the udelay()
> and see if your problems go away?  If that works, it might be a
> slightly better solution.  Note that I think Heiko had a slightly
> cleaner version of your patch set #2 that he posted in response to
> your patch set #3.

@@ -150,13 +159,15 @@ static int __cpuinit 
rockchip_boot_secondary(unsigned int cpu,
                  * sram_base_addr + 4: 0xdeadbeaf
                  * sram_base_addr + 8: start address for pc
                  * */
-               udelay(10);
+               udelay(20);

I increased the 'udelay(20)' or 'udelay(50)' in rockchip_boot_secondary().
Set#2 also can repro this issue over 22600 cycles with testing scripts. 
(about 1 hours)

log:
================= 226 ============
[ 4069.134419] CPU1: shutdown
[ 4069.164431] CPU2: shutdown
[ 4069.204475] CPU3: shutdown
......
[ 4072.454453] CPU1: shutdown
[ 4072.504436] CPU2: shutdown
[ 4072.554426] CPU3: shutdown
[ 4072.577827] CPU1: Booted secondary processor
[ 4072.582611] CPU2: Booted secondary processor
[ 4072.587426] CPU3: Booted secondary processor
<hang>

The set #4 will be better work.

>
> -Doug
>
>
>

-- 
Thanks,
- Caesar
