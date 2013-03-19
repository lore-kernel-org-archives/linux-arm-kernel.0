From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Mar 2013 11:04:52 -0700
Subject: [PATCH] ARM: OMAP: clocks: Delay clk inits atleast until slab
 is initialized
In-Reply-To: <1363689525-14584-1-git-send-email-rnayak@ti.com>
References: <1363689525-14584-1-git-send-email-rnayak@ti.com>
Message-ID: <20130319180452.GC16413@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130319 03:43]:
> clk inits on OMAP happen quite early, even before slab is available.
> The dependency comes from the fact that the timer init code starts to
> use clocks and hwmod and we need clocks to be initialized by then.
> 
> There are various problems doing clk inits this early, one is,
> not being able to do dynamic clk registrations and hence the
> dependency on clk-private.h. The other is, inability to debug
> early kernel crashes without enabling DEBUG_LL and earlyprintk.
> 
> Doing early clk init also exposed another instance of a kernel
> panic due to a BUG() when CONFIG_DEBUG_SLAB is enabled.
> More details on the issue reported can be found here,
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg85932.html

I suggest you paste the BUG info here to the commit too so it's clear
that this needs to go in as a fix. Also can you please describe how
this regression got introduced?

Other than that looks good to me as a fix for the -rc cycle. We could
add a struct for similar function pointers and SoC specific addresses,
but probably for the -rc cycle we should just keep this patch to the
minimum.

Regards,

Tony
