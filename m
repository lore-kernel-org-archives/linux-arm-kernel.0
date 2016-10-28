From: tony@atomide.com (Tony Lindgren)
Date: Fri, 28 Oct 2016 05:51:12 -0700
Subject: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
In-Reply-To: <cd32a554-ba0a-33cd-c15c-121524ce679b@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <1476805568-19264-12-git-send-email-t-kristo@ti.com>
 <20161028005047.GQ26139@codeaurora.org>
 <cd32a554-ba0a-33cd-c15c-121524ce679b@ti.com>
Message-ID: <20161028125112.xfyrx7l7m64z6cu6@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [161028 00:43]:
> On 28/10/16 03:50, Stephen Boyd wrote:
> > I suppose a PRCM is
> > like an MFD that has clocks and resets under it? On other
> > platforms we've combined that all into one node and just had
> > #clock-cells and #reset-cells in that node. Is there any reason
> > we can't do that here?
> 
> For OMAPs, there are typically multiple instances of the PRCM around; OMAP4
> for example has:
> 
> cm1 @ 0x4a004000 (clocks + clockdomains)
> cm2 @ 0x4a008000 (clocks + clockdomains)
> prm @ 0x4a306000 (few clocks + resets + power state handling)
> scrm @ 0x4a30a000 (few external clocks + plenty of misc stuff)
> 
> These instances are also under different power/voltage domains which means
> their PM behavior is different.
> 
> The idea behind having a clockdomain as a provider was mostly to have the
> topology visible : prcm-instance -> clockdomain -> clocks

Yeah that's needed to get the interconnect hierarchy right for
genpd :)

> ... but basically I think it would be possible to drop the clockdomain
> representation and just mark the prcm-instance as a clock provider. Tony,
> any thoughts on that?

No let's not drop the clockdomains as those will be needed when we
move things into proper hierarchy within the interconnect instances.
This will then help with getting things right with genpd.

In the long run we just want to specify clockdomain and the offset of
the clock instance within the clockdomain in the dts files.

Regards,

Tony
