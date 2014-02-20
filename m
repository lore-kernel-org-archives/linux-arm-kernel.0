From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 20 Feb 2014 19:30:08 +0000 (UTC)
Subject: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
In-Reply-To: <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <alpine.DEB.2.02.1402191928480.8777@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.02.1402201927280.10791@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Feb 2014, Paul Walmsley wrote:

> On Fri, 17 Jan 2014, Tomi Valkeinen wrote:
> 
> > This patch adds a simple method of rounding: during the iteration, the 
> > code keeps track of the closest rate match. If no exact match is found, 
> > the closest is returned.
> 
> So that's one possible rounding policy; maybe it works fine for a display 
> interface PLL, at least for some values of "closest rate".  But another 
> might be "only allow a selection from a set of pre-determined rates 
> characterized by the silicon validation team".  Or another rounding 
> function might need to select a more distant rate that minimizes jitter, 
> EMI, or power consumption.  

Thought about this some more.  Do you only need this for the DSS PLL, or 
do you need it for one of the core OMAP PLLs?

If the former, then how about modifying your patch to create a separate 
round_rate function that's only used for the DSS PLL that implements the 
behavior that you want?

That would eliminate any risk of impacting other users on the system.  And 
would also allow this change to get into the codebase much faster, since 
there's no need for clk API changes, etc.



- Paul
