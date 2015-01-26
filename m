From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Jan 2015 07:49:36 -0800
Subject: [PATCH 01/23] ARM: OMAP2+: clock: move clock provider
 infrastructure to clock driver
In-Reply-To: <54C61938.8000303@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
 <1417103514-17027-2-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.02.1501242142181.5450@utopia.booyaka.com>
 <54C61938.8000303@ti.com>
Message-ID: <20150126154936.GC28663@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150126 02:42]:
> On 24/01/15 23:51, Paul Walmsley wrote:
> > + Tomi 
> > 
> > On Thu, 27 Nov 2014, Tero Kristo wrote:
> > 
> >> Splits the clock provider init out of the PRM driver and moves it to
> >> clock driver. This is needed so that once the PRCM drivers are separated,
> >> they can logically just access the clock driver not needing to go through
> >> common PRM code. This would be wrong in the case of control module for
> >> example.
> >>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > 
> > This patch moves things in the wrong direction (ie, rather than keeping 
> > the PRM register accesses in the PRM code, it moves PRM register accesses 
> > into the clock code).  But I see that a subsequent patch in this series 
> > moves them back.  So this change is temporary and that seems reasonable to 
> > me.
> > 
> > However, as long as the clock code wants to do low-level register accesses 
> > to PRM/CM/SCM registers, there needs to be some way to keep register 
> > updates originating from the clock code from racing with register updates 
> > coming from other code (e.g. non-clock-related PRM/CM/SCM accesses). So 
> > I've changed this patch to use regmap (as below), and the followup patch 
> > later in the series will be changed too.  Seems to work so far but let's 
> > see how things go with the rest of the series.
> 
> I'm not sure if I miss something, but regmap_write does not protect from
> problems if there are multiple users for the same registers. You need to
> use regmap_update_bits() to get a protected read/write sequence, in
> which you can change only the bits that you want to change.

To me it seems that issue can be fixed by making all the code use regmap.
AFAIK that should work for the legacy code too.

Regards,

Tony
