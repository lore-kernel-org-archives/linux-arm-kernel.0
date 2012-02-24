From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 23 Feb 2012 17:11:17 -0700 (MST)
Subject: [GIT PULL] OMAP PM EMU fix for v3.3
In-Reply-To: <AA48DD8077D5D945A49BD1782C1140F10122E640@fioues08.ebgroup.elektrobit.com>
References: <87liw8agk4.fsf@ti.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC7@fioues08.ebgroup.elektrobit.com><20120127190239.GC9339@atomide.com><AA48DD8077D5D945A49BD1782C1140F1011EBBC8@fioues08.ebgroup.elektrobit.com><AA48DD8077D5D945A49BD1782C1140F10122E2B7@fioues08.ebgroup.elektrobit.com>
 <87linxa5gk.fsf@ti.com>
 <AA48DD8077D5D945A49BD1782C1140F10122E4FF@fioues08.ebgroup.elektrobit.com>
 <alpine.DEB.2.00.1202222021460.12198@utopia.booyaka.com>
 <AA48DD8077D5D945A49BD1782C1140F10122E640@fioues08.ebgroup.elektrobit.com>
Message-ID: <alpine.DEB.2.00.1202231627001.9361@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 23 Feb 2012, Madhusudhan.Gowda at elektrobit.com wrote:

> [Gowda] I found this BUG in the CM code while trying to use both SDTI as
> well as requirement of enabling Hardware supervised transition
> CLKTRCTRL_EMU to 0x3.
> 
> SDTI requires the softwre supervised transition to keep connected, by
> enabling Hardware supervised transition SDTI does not like it so Jouni
> had commented out the HW supervised transtion. Which I agree it is fine
> on SDTI part.
> .flags          = /* CLKDM_CAN_ENABLE_AUTO |  */CLKDM_CAN_SWSUP,
> 
> But my point here is when I set the HW supervised transition, across MPU
> OFF the register loses its previous value and changes to reset value 0x2
> (SW supervised) is not correct. So I submitted this patch for fixing
> this general CM code bug.

Okay, that's a little more clear.  So this patch does not affect the SDTI 
functionality with your driver?  Your patch description reads:

"Embedded trace debug tools like Serial Trace Interface(sti) using
 EMU domain loses connection across MPU OFF. The patch fixes this issue"

But it sounds like that's not the case?  At least, if the reset value for 
CM_CLKSTCTRL_EMU is 0x2, I don't understand how this patch could fix it.

About the patch - I'm fine with the basic underlying idea, but so far it 
looks like this is material for 3.4 rather than 3.3-rc, since it's not a 
regression?

> Please let me know if my comments answers your question.

Well I was hoping that you might answer my earlier questions about whether 
the driver you're using calls into the OMAP infrastructure via 
pm_runtime*(), and whether its clocks and hwmod data are defined.


- Paul
