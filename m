From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Jun 2016 16:47:52 +0200
Subject: [PATCH v2 00/15] clk: sunxi: introduce "modern" clock support
In-Reply-To: <20160621114044.811e2136eca5c1d863d79ac6@free.fr>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160621114044.811e2136eca5c1d863d79ac6@free.fr>
Message-ID: <20160621144752.GR26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Francois,

On Tue, Jun 21, 2016 at 11:40:44AM +0200, Jean-Francois Moine wrote:
> On Tue,  7 Jun 2016 22:41:39 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > The current code has been tested on the H3 and an Orange Pi PC,
> > including making sure that MMC still works, so the general approach
> > seems ok.
> > 
> > Let me know what you think,
> 
> Hi Maxime,
> 
> I used your code in both the H3 and A83T, and it worked fine for the
> current clocks.

I'm glad it works :)

Your reviews have been appreciated, I'll address them in my v3.

> But I had some problems with some features as the 'mode select' in the
> A83T MMC2 clock.
> Also, I think that you did not go far enough in the changes.

At some point, you also have to support what's used out there,
otherwise it just becomes an un-maintainable mess. Plus, it really
doesn't have to be perfect from day one, it just has to works as it
used to, we can always add more stuff later on.

At it works way better than what we had.

The question also is: is there anyone that we depend on using it
(mainline u-boot)? and is it something we need? If both answers are
no, then it's just dead code, which shouldn't be here in the first
place.

> For example, most clock gates as well as most resets could be removed
> from the DT and automatically set/de-asserted on clock prepare or clock
> enable.

No. The semantics are completely different between the bus gates, bus
resets and the module clocks. For example, the module clock can be
shut down while retaining the register state, while the gate clock
can't. And drivers are already using that semantic.

Some other problems arise from that as well: this would break the DT
ABI, and it deviates way too much from what the other SoCs are doing
(which is the whole reason for that rework in the first place).

> So, I am rewriting a generic sunxi clock driver into one file (about
> 1000 lines) and I have the full (simpler and clearer) description of
> the H3 and the A863T clocks.
> 
> Coding is not finished yet. I will submit a RFC as soon as I will have
> something working.

Please don't. I don't want to waste any more time on this, this is way
overdue.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/296447dd/attachment.sig>
