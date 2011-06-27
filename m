From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 27 Jun 2011 09:29:51 -0600 (MDT)
Subject: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
In-Reply-To: <20110627101427.GH23145@atomide.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
	<86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE2@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1106251635340.30205@utopia.booyaka.com>
	<20110627101427.GH23145@atomide.com>
Message-ID: <alpine.DEB.2.00.1106270910210.460@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Jun 2011, Tony Lindgren wrote:

> This fix will cause bad dependency issues with sys_timer.
> 
> This patch has a dependency to omap3_beagle_init_rev, which depends on
> the mux framework and gpio framework. Not cool for init_early. We just
> want to initialize sys_timer early without any complicated dependencies.
> 
> The best way to fix this is to set a separate machine ID for the properly
> working beagle boards like xm, then just set the .timer entry to omap3_timer
> for working beagle boards and omap3_secure_timer for non-working beagle
> boards. The rest of the board-*.c file can be shared.

Sanjeev, want to take care of this?  Machine ID update info is in 
linux/arch/arm/tools/mach-types.  

This strategy will unfortunately involve patching bootloaders.  But if the 
default is to use GPT12, it should work out okay.

Hopefully we won't have to do the same thing for the other Beagle-derived 
boards, Devkit8000, Touchbook, etc. etc.  Then again, I suppose this will 
eventually just be another property passed in via DT, with a single 
machine ID.

> The above assumes the patches in devel-timer branch where we no longer
> have the non-standard timer interface, but use the sys_timer entries
> instead like we should.


- Paul
