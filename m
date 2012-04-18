From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 18 Apr 2012 03:40:59 -0600 (MDT)
Subject: [PATCH] ARM: omap: hwmod: warn only when clkdm is missing from
 both clk and hwmod
In-Reply-To: <4F8E84DC.70600@ti.com>
References: <1334238098-29859-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1204121106010.29473@utopia.booyaka.com>
 <4F8E76C3.7080803@ti.com>
 <alpine.DEB.2.00.1204180217380.29048@utopia.booyaka.com>
 <4F8E84DC.70600@ti.com>
Message-ID: <alpine.DEB.2.00.1204180312160.29048@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 18 Apr 2012, Cousson, Benoit wrote:

> Well, the point is that we do not need this warning even for that. This 
> is something we have to ensure by reviewing carefully the code. 

My perspective is slightly different.

Until we're sure that we don't need clock framework-based clockdomain 
control in mainline for main clocks, we shouldn't remove that warning.  
That is because clock framework-based clockdomain control works via the 
struct clk's clkdm field.  So until we switch away from that model, we 
should ensure that each clock is associated with the clockdomain that its 
clock control FSM is associated with (in OMAP3 terms).

I don't have a problem with switching away from that model, or switching 
individual SoCs away from that model, as long as regressions aren't 
introduced.  But until that switch happens, it seems wise to avoid 
weakening its consistency assumptions.

> If you look today, the warning is complaining about clocks that are 
> perfectly fine.

Actually, mainline is only complaining about one clock:

http://www.pwsan.com/omap/bootlogs/20120417/sparse_cppcheck_cleanup_3.5__0b93afd5d945a8c002f4d380a88b5d7a61c49289/4430es2panda_bootlog.txt

In the current model, the right fix for that clock is to associate it with 
a CM clockdomain (see for example the 4430 TRM vX Figure 3-70 "CD_DMA 
Overview").

> So keeping it will just add some noise and not necessarily highlighting 
> the real issue.
> 
> FYI here is what we have after the clock cleanup on OMAP4 (i.e removal of modulemode clock nodes):
> 

[ lots of warnings elided ]

> That's a lot of noise for nothing. That's why Rajendra's patch is needed now.

Sounds like the patch to alter the warnings should be associated with this 
clock cleanup series, then, since it sounds like it changes the 
clockdomain control model.  And if the model change is only affecting 
OMAP4+, then the warning change should also only apply to OMAP4+.


- Paul
