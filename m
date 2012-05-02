From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 2 May 2012 16:30:26 +0530
Subject: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
 <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
Message-ID: <CAMQu2gxcUw5A-p25xdYeXfy=tLbDNPsjV_5MJ6s5qGNfn4Zbfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 4:25 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> On Wed, May 02, 2012 at 15:48:01, Shilimkar, Santosh wrote:
>> On Wed, May 2, 2012 at 3:40 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
>> > Hi Tero,
>> >
>> > On Fri, Apr 20, 2012 at 15:03:34, Kristo, Tero wrote:
>> >> From: Rajendra Nayak <rnayak@ti.com>
>> >>
[...]

>>
>> [...]
>> >> +void omap4_dpll_resume_off(void)
>> >> +{
>> >> + ? ? u32 i;
>> >> + ? ? struct omap4_dpll_regs *dpll_reg = dpll_regs;
>> >> +
>> >> + ? ? for (i = 0; i < ARRAY_SIZE(dpll_regs); i++, dpll_reg++) {
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clksel);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m2);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m3);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m4);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m5);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m6);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m7);
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clkdcoldo);
>> >> +
>> >> + ? ? ? ? ? ? /* Restore clkmode after the above registers are restored */
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clkmode);
>> >> +
>> >> + ? ? ? ? ? ? omap4_wait_dpll_lock(dpll_reg);
>> >> +
>> >> + ? ? ? ? ? ? /* Restore autoidle settings after the dpll is locked */
>> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->autoidle);
>> >> + ? ? }
>> >> +}
>> >
>> > If this function is placed in SRAM and PER PLL restored just after MPU
>> > won't the exit latency be further optimized?
>> >
>> How ?
>> SRAM is sower memory than DDR so I don't see how it
>> will reduce latency.
>>
>
> I am just guessing if that's indeed the case ;)
> Haven't done any measurements to really check if that's indeed the case though.
>
You don't have to do any real measurements at least on OMAP.
OCMC RAM is interfaced over L4 and MPU has to cross two interconnect
bridges to reach to SRAM. DDR is more of direct path and much faster.

Regards
Santosh
