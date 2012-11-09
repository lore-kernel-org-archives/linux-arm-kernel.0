From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 9 Nov 2012 00:58:21 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
In-Reply-To: <1352417516-15213-1-git-send-email-mturquette@ti.com>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
 <1352417516-15213-1-git-send-email-mturquette@ti.com>
Message-ID: <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 8 Nov 2012, Mike Turquette wrote:

> The OMAP port to the common clk framework[1] resulted in spurious WARNs
> while disable unused clocks.  This is due to _clkdm_clk_hwmod_disable
> catching clkdm->usecount's with a value of zero.  Even less desirable it
> would not allow the clkdm_clk_disable function pointer to get called due
> to an early return of -ERANGE.
> 
> This patch adds a check for such a corner case by skipping the WARN and
> early return in the event that clkdm->usecount and clk->enable_usecount
> are both zero.  Presumably this could only happen during the check for
> unused clocks at boot-time.
> 
> [1] http://article.gmane.org/gmane.linux.ports.arm.omap/88824
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>

I don't think this is going to work, as it currently stands.  The code 
will just bypass the warning and the error return.  The clockdomain 
usecount still will be decremented, which is going to cause problems since 
the usecount will be inaccurate.


- Paul
