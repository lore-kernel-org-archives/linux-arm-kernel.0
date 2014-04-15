From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Apr 2014 15:56:00 -0700
Subject: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq
 and sys_off_mode
In-Reply-To: <CANOLnOO=O8xkTV9LiH+JTtmEXd9ihu0+ZYoHtrQK2QsFWOWVbg@mail.gmail.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-3-git-send-email-tony@atomide.com>
 <CANOLnOO=O8xkTV9LiH+JTtmEXd9ihu0+ZYoHtrQK2QsFWOWVbg@mail.gmail.com>
Message-ID: <20140415225559.GA5313@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grazvydas Ignotas <notasas@gmail.com> [140414 15:51]:
> On Fri, Apr 11, 2014 at 2:47 AM, Tony Lindgren <tony@atomide.com> wrote:
> > @@ -282,6 +283,7 @@ void omap_sram_idle(void)
> >
> >         /* CORE */
> >         if (core_next_state < PWRDM_POWER_ON) {
> > +               omap3_vc_set_pmic_signaling(core_next_state);
> 
> I wonder how is it going to affect latencies, adding stuff to suspend
> path hurts things like NAND transfers, which consist of lots of small
> blocks with an interrupt after each..

For most part this is the completely idle path, so there should
not be much of hurry. Most devices should already block the deeper
idle states for the devices listed in cm_idlest_per, cm_idlest1_core
and cm_idlest3_core registers. So it should be mostly automatic with
runtime PM.

No idea what happens with GPMC though for NAND transfers :) Might
be worth checking.
 
> > +void omap3_vc_set_pmic_signaling(int core_next_state)
> > +{
> > +       u32 voltctrl;
> > +
> > +       voltctrl = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
> > +                                         OMAP3_PRM_VOLTCTRL_OFFSET);
> > +       switch (core_next_state) {
> > +       case PWRDM_POWER_OFF:
> > +               voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_RET |
> > +                             OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
> > +               voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_OFF;
> > +               break;
> > +       case PWRDM_POWER_RET:
> > +               voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
> > +                             OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP);
> > +               voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_RET;
> > +               break;
> > +       default:
> > +               voltctrl &= ~(OMAP3430_PRM_VOLTCTRL_AUTO_OFF |
> > +                             OMAP3430_PRM_VOLTCTRL_AUTO_RET);
> > +               voltctrl |= OMAP3430_PRM_VOLTCTRL_AUTO_SLEEP;
> > +               break;
> > +       }
> > +       omap2_prm_write_mod_reg(voltctrl, OMAP3430_GR_MOD,
> > +                               OMAP3_PRM_VOLTCTRL_OFFSET);
> 
> Could it only write if the value changed? Caching register value would
> be great too to avoid slow register accesses.

Yeah sure makes sense, I'll take a look at that. We should not need
to check for voltctrl constantly.
 
> > +}
> > +
> > +/*
> > + * Configure signal polarity for sys_clkreq and sys_off_mode pins
> > + * as the default values are wrong and can cause the system to hang
> > + * if any twl4030 sccripts are loaded.
> 
> s/sccripts/scripts

Will fix.
 
> > + */
> > +static void __init omap3_vc_init_pmic_signaling(void)
> > +{
> > +       u32 val, old;
> > +
> > +       val = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
> > +                                    OMAP3_PRM_POLCTRL_OFFSET);
> > +       old = val;
> > +
> > +       if (old & OMAP3430_PRM_POLCTRL_CLKREQ_POL)
> > +               val |= OMAP3430_PRM_POLCTRL_CLKREQ_POL;
> 
> Are these 2 lines actually doing anything?

Nope :) It should be if (!(old & OMAP3430_PRM_POLCTRL_CLKREQ_POL))...
 
> > +       if (old & OMAP3430_PRM_POLCTRL_OFFMODE_POL)
> > +               val &= ~OMAP3430_PRM_POLCTRL_OFFMODE_POL;
> 
> Why not just clear the bit unconditionally?

Mostly for producing some kind of debug message of what's going on
in case somebody has a PMIC with different polarity. If we agree
that's not needed, then that's not needed. 

> > +       if (val != old) {
> > +               pr_debug("PM: fixing sys_clkreq and sys_off_mode polarity 0x%x -> 0x%x\n",
> > +                        old, val);
> > +       }
> > +       omap2_prm_write_mod_reg(val, OMAP3430_GR_MOD,
> > +                               OMAP3_PRM_POLCTRL_OFFSET);
> 
> Maybe move this write inside the block just above it?

Makes sense.

Tony
