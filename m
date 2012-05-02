From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Wed, 2 May 2012 10:55:24 +0000
Subject: [PATCH 01/19] ARM: OMAP4: PM: save/restore all DPLL settings in
 OFF mode
In-Reply-To: <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <1334914432-26456-2-git-send-email-t-kristo@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433EA6B68E@DBDE01.ent.ti.com>
 <CAMQu2gwCstL6eF92_QBDYZaA5xwxD9a+YWRVxdghA5WVkp4PEQ@mail.gmail.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433EA6C848@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 15:48:01, Shilimkar, Santosh wrote:
> On Wed, May 2, 2012 at 3:40 PM, Bedia, Vaibhav <vaibhav.bedia@ti.com> wrote:
> > Hi Tero,
> >
> > On Fri, Apr 20, 2012 at 15:03:34, Kristo, Tero wrote:
> >> From: Rajendra Nayak <rnayak@ti.com>
> >>
> >> SAR/ROM code restores only CORE DPLL to its original state
> >> post wakeup from OFF mode.
> >> The rest of the DPLL's in OMAP4 platform (MPU/IVA/ABE/USB/PER)
> >> are saved and restored here during an OFF transition.
> >>
> >
> > Most of the registers being saved and restored in the various
> > patches look to be contiguous. So, instead of a long list of these
> > contiguous registers how about having a generic API for backup and
> > restore of the registers contents based on the memory address range?
> >
> > Most of the registers which require save and restore are either part
> > of PRM, CM or Control. The PRM or CM instance could be passed as the
> > base and the save/restore API could work around that.
> >
> > One downside is that there are some read-only registers in between but
> > I don't see any simple way of avoiding save and restore of those. BTW,
> > as per the TRM that I have, this patch is also doing save and restore
> > of some read-only registers.
> >
> You should never write to read-only registers since the behavior is
> undefined.

I was afraid of that. If all the read-only registers were clubbed together
a lot of code could have been removed. Looking more closely at the TRM
I guess we can't really ask design folks to club those read-only registers
in the future. So scratch this.

> 
> [...]
> >> +void omap4_dpll_resume_off(void)
> >> +{
> >> + ? ? u32 i;
> >> + ? ? struct omap4_dpll_regs *dpll_reg = dpll_regs;
> >> +
> >> + ? ? for (i = 0; i < ARRAY_SIZE(dpll_regs); i++, dpll_reg++) {
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clksel);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m2);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m3);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m4);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m5);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m6);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->div_m7);
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clkdcoldo);
> >> +
> >> + ? ? ? ? ? ? /* Restore clkmode after the above registers are restored */
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->clkmode);
> >> +
> >> + ? ? ? ? ? ? omap4_wait_dpll_lock(dpll_reg);
> >> +
> >> + ? ? ? ? ? ? /* Restore autoidle settings after the dpll is locked */
> >> + ? ? ? ? ? ? omap4_dpll_restore_reg(dpll_reg, &dpll_reg->autoidle);
> >> + ? ? }
> >> +}
> >
> > If this function is placed in SRAM and PER PLL restored just after MPU
> > won't the exit latency be further optimized?
> >
> How ?
> SRAM is sower memory than DDR so I don't see how it
> will reduce latency.
> 

I am just guessing if that's indeed the case ;) 
Haven't done any measurements to really check if that's indeed the case though.
