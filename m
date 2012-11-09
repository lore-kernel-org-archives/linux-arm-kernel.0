From: mturquette@ti.com (Mike Turquette)
Date: Thu, 8 Nov 2012 17:17:38 -0800
Subject: [PATCH] ARM: OMAP2+: clockdomain: disabling unused clks
In-Reply-To: <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
References: <alpine.DEB.2.00.1211081800210.20703@utopia.booyaka.com>
 <1352417516-15213-1-git-send-email-mturquette@ti.com>
 <alpine.DEB.2.00.1211090052100.20703@utopia.booyaka.com>
Message-ID: <20121109011738.17381.88199@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Paul Walmsley (2012-11-08 16:58:21)
> On Thu, 8 Nov 2012, Mike Turquette wrote:
> 
> > The OMAP port to the common clk framework[1] resulted in spurious WARNs
> > while disable unused clocks.  This is due to _clkdm_clk_hwmod_disable
> > catching clkdm->usecount's with a value of zero.  Even less desirable it
> > would not allow the clkdm_clk_disable function pointer to get called due
> > to an early return of -ERANGE.
> > 
> > This patch adds a check for such a corner case by skipping the WARN and
> > early return in the event that clkdm->usecount and clk->enable_usecount
> > are both zero.  Presumably this could only happen during the check for
> > unused clocks at boot-time.
> > 
> > [1] http://article.gmane.org/gmane.linux.ports.arm.omap/88824
> > 
> > Signed-off-by: Mike Turquette <mturquette@ti.com>
> 
> I don't think this is going to work, as it currently stands.  The code 
> will just bypass the warning and the error return.  The clockdomain 
> usecount still will be decremented, which is going to cause problems since 
> the usecount will be inaccurate.
> 

You're right.  In my rush I glossed over the clkdm decrement part.  In
light of the suspend/resume issues I'm not sure this approach is really
valid.  I think getting to the bottom of those issues will give the
final word.

Regards,
Mike

> 
> - Paul
