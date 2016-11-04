From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 4 Nov 2016 12:49:14 -0700
Subject: [PATCH v4 00/23] soc: renesas: Add R-Car RST driver for
 obtaining mode pin state
In-Reply-To: <CAMuHMdXOW4Ubafu=x9pCw_W-MtLGe3N974dbfHCH5TJuUAeYrQ@mail.gmail.com>
References: <1477055857-17936-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdVbpuv94x-ocTSDoEj+SbnESDbkuMXsXExQvoyZepp+Zg@mail.gmail.com>
 <20161031081923.GF18195@verge.net.au>
 <CAMuHMdXA-hemOT=ZysEfettei9=HsDddGhqddkw38hwRrdeagw@mail.gmail.com>
 <20161031232537.GT16026@codeaurora.org>
 <CAMuHMdXOW4Ubafu=x9pCw_W-MtLGe3N974dbfHCH5TJuUAeYrQ@mail.gmail.com>
Message-ID: <20161104194914.GB16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02, Geert Uytterhoeven wrote:
> On Tue, Nov 1, 2016 at 12:25 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> >
> > Would the pull requests for clk also have dts changes at the base
> > of the tree? Perhaps clk side can just ack the clk patches and
> 
> Yes they would: this is moving functionality from platform code to DT.
> Without the DT updates, it will break bisection (except for R-Car Gen2,
> where we have fallback code to handle old DTBs).
> 
> > then have it all routed through arm-soc? The only worry I have is
> > if we need to make some sort of change in clk side that conflicts
> > with these changes. I don't usually like taking dts changes
> > through clk tree, so I'd like to avoid that if possible.
> 
> Everything could go through arm-soc only with your Acked-by.
> However, there are new clock drivers pending on this series.
> Either they have to go through arm-soc, too, or this series would
> be pulled into the clk tree with these new clock drivers.
> 
> > Part E could happen anytime after everything else happens, so
> > that doesn't seem like a concern.
> 
> Part E can indeed by postponed.
> But if parts A-D are applied together, there's no reason to postpone part E.
> 
> > Part C could also be made to
> > only call into the new reset drivers if the reset dts nodes are
> > present? If that's done then we could merge clk patches anytime
> > and remove the dead code and the node search at some later time
> > when everything has settled?
> 
> That would require adding more backwards compatibility code for
> old DTBs, even for platform where we're not interested in maintaining
> that. In addition, Part C depends on the header file for the reset driver
> to compile the clock driver, even if you would add some DT detection,
> and on the reset driver to link. So I'm afraid this is not feasible.
> 

TL;DR: Sounds fine, I'll be on the lookout for the PR.

Longer version: Let me step back a bit and actually think about
this longer than 2 minutes. From what I see
rcar_rst_read_mode_pins() already returns -ENODEV if the nodes
aren't present. Great.

So clk tree could be given a pull for the clk patches, part C, on
top of part A, the reset driver. If the rcar_rst_read_mode_pins()
returns failure because the node is missing, we fall back to the
old style of doing things. Some drivers already do that anyway,
so this looks to be replacing things like 

	if (rcar_rst_read_mode_pins())
		return;
		
with
	
	if (rcar_rst_read_mode_pins() != -ENODEV)
		return;


Then in arm-soc tree, the dts patches are merged. That causes us
to do some duplicate work reading the pins twice in mach-shmobile
and in the new reset driver. That's duplicate/wasteful, but it
works. Finally, everything is merged together into a tagged
release. The mach-shmobile changes can happen anytime after that
(part D). Again we're left with dead code in the clk driver (part
E) until the dependency merges, but that's ok. Once part D merges
we can get rid of the dead code in part E and any backwards
compatibility we don't want to maintain.

In summary, it's all feasible to do this and most people wouldn't
have had to know about the dependency chain but it's not fast by
any means. Instead we merge everything in one shot and get it
over with now.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
