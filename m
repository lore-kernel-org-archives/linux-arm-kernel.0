From: jhnikula@gmail.com (Jarkko Nikula)
Date: Fri, 1 Jul 2011 16:36:39 +0300
Subject: [RFC 10/12] omap: mcbsp: Move sidetone clock management to
	mach-omap2/mcbsp.c
In-Reply-To: <alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com>
References: <1309510356-27147-1-git-send-email-jhnikula@gmail.com>
	<1309510356-27147-11-git-send-email-jhnikula@gmail.com>
	<alpine.DEB.2.00.1107010317460.27025@utopia.booyaka.com>
Message-ID: <20110701163639.dd6afb93.jhnikula@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Jul 2011 03:23:49 -0600 (MDT)
Paul Walmsley <paul@pwsan.com> wrote:

> In the hwmod code/data, we've got the OCPIF_SWSUP_IDLE flag that can be 
> set on a struct omap_hwmod_ocp_if.  I think this is probably what's needed 
> here.  The only problem is that we haven't linked that to the clock code 
> to deny idle on the interface clock yet (see omap_hwmod.c:_setup()).  
> Adding that code in, plus adding that OCPIF_SWSUP_IDLE flag to the 
> McBSP2/3 data, seems like the right approach here.
> 
I understood from the code that OCPIF_SWSUP_IDLE with
clkops_omap2_dflt_wait in clock data means that then ICLK won't
autoidle at all when clock is enabled? Normally, when not using the
sidetone we want to have ICLK autoidling since then omap can idle when
using threshold based transfers and McBSP FIFO.

> Otherwise these direct register manipulations of clock registers, outside 
> the clock code, could turn into a mess :-(
> 
I definitely agree. I was thinking some virtual clock for sidetone but
that didn't sound good either since then both McBSP ICLK and virtual
sidetone clock would be modifying the same register. Anyway, some omap
device API for runtime autoidle bit setting sounds much better approach
in enable_st_clock callback than hacking with clock registers.

-- 
Jarkko
