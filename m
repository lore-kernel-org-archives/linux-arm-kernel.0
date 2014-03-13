From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Mar 2014 11:22:47 +0900
Subject: [PATCH v3 01/20] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <3299454.uLzSWehPDg@avalon>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <2601556.jT3Q3TPugr@avalon> <20140312075520.GB25813@verge.net.au>
 <3299454.uLzSWehPDg@avalon>
Message-ID: <20140313022246.GA8802@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 12, 2014 at 11:12:02AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 12 March 2014 16:55:23 Simon Horman wrote:
> > On Wed, Feb 26, 2014 at 02:02:37PM +0100, Laurent Pinchart wrote:
>  > On Wednesday 26 February 2014 13:53:17 Laurent Pinchart wrote:
> > > > On Wednesday 26 February 2014 16:33:17 Simon Horman wrote:
> > > > > The R8A7779 SoC has several clocks that are too custom to be supported
> > > > > in a generic driver. Those clocks can be divided in two categories:
> > > > > 
> > > > > - Fixed rate clocks with multiplier and divisor set according to boot
> > > > >   mode configuration
> > > > > 
> > > > > - Custom divider clocks with SoC-specific divider values
> > > > > 
> > > > > This driver supports both.
> > > > 
> > > > Looking at the R8A7779 datasheet it looks like we only have fixed rate
> > > > clocks, without any configurable divider clock. Did I miss something ?
> > 
> > Sorry, its a cut-and past error on my part.
> > I will revise the changelog.
> > 
> > > > > Based on work for R-Car Gen2 SoCs by Laurent Pinchart.
> > > > > 
> > > > > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > > 
> > > > > ---
> > > > > v3
> > > > > * As suggested by Laurent Pinchart
> > > > > 
> > > > >   - Added external clock input
> > > > >   - Use PLLA ratio set bu MD11 and MD12
> > > > >   - Add _div suffixes of fields of struct cpt_clk_config
> > > > >   - Register PLLA as a fixed factor clock
> > > > >   - Use sizeof() instead of sizeof
> > > > >   - Use num_clks instead of CPG_NUM_CLOCKS in
> > > > >   r8a7779_cpg_clocks_init()
> > > > >   
> > > > >   - I kept this as r8a7779 binding rather than moving to a R-Car Gen1
> > > > >     binding which could be shared with other SoCs as I do not believe
> > > > >     that the SoCs is are sufficiently similar.
> > > > 
> > > > I had a look at the M1 datasheet and I still find its CPG very similar
> > > > with the H1 CPG. The PLLA multiplier and divider are different, but if
> > > > you look closely, they're both exactly twice the value compared to H1,
> > > > so there's no difference in practice.
> > > > 
> > > > What differences do you see that would make it impractical to share a
> > > > single driver for both ?
> > 
> > Thanks for pointing that out. Looking over the M1 datasheet again I agree
> > with you that there does seem to be rather a lot of similarities with the
> > H1. And I agree that it is likely that the driver could be shared.
> > 
> > However, I'd like to leave that as future work at this time.
> > 
> > The reason for this is that on the one hand I believe such work sould be
> > done in conjunctin with integrating the driver on the bockw board.
> > And that seems to be non-trivial to me.
> 
> We can always rename the driver later, that's not a big issue, but we can't 
> change compatibility strings. I would thus like to see "renesas,rcar-gen1-cpg-
> clocks" listed in the DT bindings.

I know that we have done such things in the past but these days I feel that
it is a bit contentious as it is a binding for a software abstraction
rather than the hardware. And as far as I know bindings are supposed to
describe the hardware.
