From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Jan 2015 09:27:36 -0800
Subject: [PATCH 2/7] ARM: OMAP2+: Fix error handling for
 omap2_clk_enable_init_clocks
In-Reply-To: <20150114012148.GE18523@saruman>
References: <1421190837-4692-1-git-send-email-tony@atomide.com>
 <1421190837-4692-3-git-send-email-tony@atomide.com>
 <20150114012148.GE18523@saruman>
Message-ID: <20150114172736.GN2419@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150113 17:25]:
> On Tue, Jan 13, 2015 at 03:13:52PM -0800, Tony Lindgren wrote:
> > We need to check if we got the clock before trying to do anything
> > with it. Otherwise we will get something like this:
> > 
> > Unable to handle kernel paging request at virtual address fffffffe
> > ...
> > [<c04bef78>] (clk_prepare) from [<c00338a4>] (omap2_clk_enable_init_clocks+0x50/0x8)
> > [<c00338a4>] (omap2_clk_enable_init_clocks) from [<c0876838>] (dm816x_dt_clk_init+0)
> > ...
> > 
> > Let's add check for the clock and WARN if the init clock was not
> > found.
> > 
> > Cc: Brian Hutchinson <b.hutchman@gmail.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Just one minor nit below, other than that:
> 
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> 
> > ---
> >  arch/arm/mach-omap2/clock.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> > index 6ad5b4d..89a0732 100644
> > --- a/arch/arm/mach-omap2/clock.c
> > +++ b/arch/arm/mach-omap2/clock.c
> > @@ -620,6 +620,11 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
> >  
> >  	for (i = 0; i < num_clocks; i++) {
> >  		init_clk = clk_get(NULL, clk_names[i]);
> > +		if (IS_ERR(init_clk)) {
> > +			WARN(1, "omap clock: could not find init clock %s\n",
> > +			     clk_names[i]);
> 
> you can combine the if with the WARN():
> 
> 		if (WARN(IS_ERR(init_clk), "could not find init clock %s\n",
> 			clk_names[i]))
> 
> not that I also removed that "omap clock" prefix because WARN() will
> print the file name anyway.
> 
> > +			continue;
> > +		}
> >  		clk_prepare_enable(init_clk);
> >  	}
> >  }

Sure makes sense to me. Updated patch below.

Regards,

Tony

8< -------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 22 Dec 2014 08:19:07 -0800
Subject: [PATCH] ARM: OMAP2+: Fix error handling for omap2_clk_enable_init_clocks

We need to check if we got the clock before trying to do anything
with it. Otherwise we will get something like this:

Unable to handle kernel paging request at virtual address fffffffe
...
[<c04bef78>] (clk_prepare) from [<c00338a4>] (omap2_clk_enable_init_clocks+0x50/0x8)
[<c00338a4>] (omap2_clk_enable_init_clocks) from [<c0876838>] (dm816x_dt_clk_init+0)
...

Let's add check for the clock and WARN if the init clock was not
found.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -620,6 +620,9 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 
 	for (i = 0; i < num_clocks; i++) {
 		init_clk = clk_get(NULL, clk_names[i]);
+		if (WARN(IS_ERR(init_clk), "could not find init clock %s\n",
+				clk_names[i]))
+			continue;
 		clk_prepare_enable(init_clk);
 	}
 }
