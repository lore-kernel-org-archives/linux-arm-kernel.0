From: notasas@gmail.com (Grazvydas Ignotas)
Date: Wed, 16 Apr 2014 16:58:31 +0300
Subject: [PATCH 02/11] ARM: OMAP3: Fix idle mode signaling for sys_clkreq
 and sys_off_mode
In-Reply-To: <20140415225559.GA5313@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-3-git-send-email-tony@atomide.com>
 <CANOLnOO=O8xkTV9LiH+JTtmEXd9ihu0+ZYoHtrQK2QsFWOWVbg@mail.gmail.com>
 <20140415225559.GA5313@atomide.com>
Message-ID: <CANOLnONGTJb7D_jqsHbUzc7RG28oC433BCcXR_HSiW7DapwPWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 1:56 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Grazvydas Ignotas <notasas@gmail.com> [140414 15:51]:
>> On Fri, Apr 11, 2014 at 2:47 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > @@ -282,6 +283,7 @@ void omap_sram_idle(void)
>> >
>> >         /* CORE */
>> >         if (core_next_state < PWRDM_POWER_ON) {
>> > +               omap3_vc_set_pmic_signaling(core_next_state);
>>
>> I wonder how is it going to affect latencies, adding stuff to suspend
>> path hurts things like NAND transfers, which consist of lots of small
>> blocks with an interrupt after each..
>
> For most part this is the completely idle path, so there should
> not be much of hurry. Most devices should already block the deeper
> idle states for the devices listed in cm_idlest_per, cm_idlest1_core
> and cm_idlest3_core registers. So it should be mostly automatic with
> runtime PM.
>
> No idea what happens with GPMC though for NAND transfers :) Might
> be worth checking.

What happens there is that the interrupt arrives shortly after the
transfer was issued, but arm_pm_idle() would already be entered and
interrupts disabled, so it then has to go through all those slow
register accesses in omap_sram_idle(), which is just useless work in
such particular case (WFI will just return) and cause interrupt
response latency and loss of throughput. But this is mostly a problem
caused by pwrdm_pre_transition() and pwrdm_post_transition() calls
(they were optimized a bit at one point but later reverted),
core_next_state would probably stay ON and your function wouldn't be
called here, yes.


-- 
Gra?vydas
