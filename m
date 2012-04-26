From: Russ.Dill@ti.com (Russ Dill)
Date: Thu, 26 Apr 2012 13:43:10 -0700
Subject: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source selection
 using kernel param
In-Reply-To: <87aa1ybaxf.fsf@ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
 <87aa1ybaxf.fsf@ti.com>
Message-ID: <CA+Bv8XYG2heeWKMt-gdWkPD3_1kkcZspP_XgvCAdwynXzTA3AQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 11:33 AM, Kevin Hilman <khilman@ti.com> wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
>
>> Current OMAP code supports couple of clocksource options based
>> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
>> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
>
> [...]
>
>> +
>> + ? ? sync32k_ick = clk_get(NULL, "omap_32ksync_ick");
>> + ? ? if (!IS_ERR(sync32k_ick))
>> + ? ? ? ? ? ? clk_enable(sync32k_ick);
>> +
>> + ? ? sync32k_cnt_reg = base + OMAP2_32KSYNCNT_CR_OFF;
>> +
>> + ? ? /*
>> + ? ? ?* 120000 rough estimate from the calculations in
>> + ? ? ?* __clocksource_updatefreq_scale.
>> + ? ? ?*/
>> + ? ? clocks_calc_mult_shift(&persistent_mult, &persistent_shift,
>> + ? ? ? ? ? ? ? ? ? ? 32768, NSEC_PER_SEC, 120000);
>> +
>> + ? ? ret = clocksource_mmio_init(base, "32k_counter", 32768, 250, 32,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? clocksource_mmio_readl_up);
>
> After discussing this a bit with Vaibhav offline, we found that 'base'
> here should be sync32k_cnt_reg.
>
> Can you guys that were seeing the hang confirm that that fixes the
> issue?
>
> If so, please reply with your Tested-by.

Tested-by: Russ Dill <Russ.Dill@ti.com>

All three patches in series boot tested on:
Beagleboard xM
Beagleboard B4
Mistral AM37X-EVM
