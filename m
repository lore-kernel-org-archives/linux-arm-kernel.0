From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jan 2013 07:07:10 +0100
Subject: [PATCH 2/3] ARM: Orion: Bind the orion bridge interrupt
 controller through DT
In-Reply-To: <20130110014734.GC5075@titan.lakedaemon.net>
References: <1355188683-18208-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1355188683-18208-2-git-send-email-jgunthorpe@obsidianresearch.com>
 <20121211062430.GD25466@lunn.ch>
 <20121211065813.GA14843@obsidianresearch.com>
 <20121211071333.GR17242@lunn.ch>
 <20121211185535.GA14534@obsidianresearch.com>
 <20130110014734.GC5075@titan.lakedaemon.net>
Message-ID: <20130110060710.GM24650@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 08:47:34PM -0500, Jason Cooper wrote:
> Sebastian,
> 
> On Tue, Dec 11, 2012 at 11:55:35AM -0700, Jason Gunthorpe wrote:
> > On Tue, Dec 11, 2012 at 08:13:33AM +0100, Andrew Lunn wrote:
> > > On Mon, Dec 10, 2012 at 11:58:13PM -0700, Jason Gunthorpe wrote:
> > > > > > +	bridge_irq = irq_of_parse_and_map(np, 0);
> > > > > > +	/* FIXME: irq_of_parse_and_map returns 0 on error, but on Dove the
> > > > > > +	 * bridge IRQ is 0.
> > > > > > +	if (!bridge_irq)
> > > > > > +		return -ENODEV;*/
> > > > > > +
> > > > > > +	return orion_bridge_irq_init(bridge_irq, -1, base, np);
> > > > > 
> > > > > So does this mean for Dove it will currently always fail?
> > > > 
> > > > I guess that is hard to read without syntax hi-lighting, the 'if' is
> > > > also commented out.
> > > > 
> > > > I was hopefull it would work as is, but looking deeper at
> > > > irq_of_parse_and_map and its call tree makes me doubtfull now..
> > > > 
> > > > Fixing irq_of_parse_and_map is way to big a job for me :(
> > > 
> > > Hi Jason
> > > 
> > > https://lwn.net/Articles/470820/
> > > 
> > > I don't think its fixable. 
> > 
> > Oh right. That.
> > 
> > Looking at this some more, I think it should work, but not for very
> > good reasons.. irq_of_parse_and_map will return 0 on dove. It returns
> > 0 because it is going through its error paths because it saw a 0 deep
> > inside, but it still returns 0.
> > 
> > orion_bridge_irq_init will work with 0 as a bridge_irq, we know this
> > because the timer code was using those code paths for a long time
> > 
> > > We need to see how other machine remap 0 to some other value and
> > > implement that for Dove.
> > 
> > It looks like it is straightforward to adjust Dove's
> > get_irqnr_and_base to add 1 to all the interrupt numbers, adjust
> > irqs.h to add 1, and adjust the irq setup. There would be no
> > performance penalty to doing this, but testing would be need to be
> > sure 100% of changes were made. If the above works it would be better
> > to do that sort of change after, or maybe after the non-DT code is
> > purged...
> > 
> > Kirkwood is already OK WRT the 0 IRQ, it is handled internally to
> > get_irqnr_and_base.
> > 
> > So, I will suggest to please test on dove as-is...
> 
> Did you have a chance to test this on dove?

Hi Jason

We discussed this a little and I prefer Sebastians implementation.

Sebastian, do you have time to work on your code and get it ready?

Thanks
	Andrew
