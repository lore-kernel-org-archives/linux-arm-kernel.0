From: jbe@pengutronix.de (Juergen Beisert)
Date: Fri, 16 Oct 2009 10:10:15 +0200
Subject: Patch "page-allocator: preserve PFN ordering when __GFP_COLD is
	set" fails on my system
In-Reply-To: <200908131122.40423.jbe@pengutronix.de>
References: <200908111830.03224.jbe@pengutronix.de>
	<20090813083910.GA27006@csn.ul.ie>
	<200908131122.40423.jbe@pengutronix.de>
Message-ID: <200910161010.15864.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Donnerstag, 13. August 2009, Juergen Beisert wrote:
> On Donnerstag, 13. August 2009, Mel Gorman wrote:
> > On Wed, Aug 12, 2009 at 02:40:30PM -0400, Arnaud Faucher wrote:
> > > I have a rather similar problem on a driver that I try to keep
> > > up-to-date with recent kernel versions
> > > (http://code.ximeta.com/trac-ndas/ticket/1110#comment:30). The NDAS
> > > hardware is an ethernet-enabled disk controller on one chip, kind of a
> > > cheap iSCSI.
> > >
> > > In my case there is no oops: the symptoms are that the read blocks seem
> > > to be swapped or full of garbage.
> > >
> > > After investigation in the NDAS code, the bug triggers when the driver
> > > tries to merge adjacent requests before sending them to the controller.
> > > I had to disable this merge in order to restore normal behavior, at the
> > > expense of a reduced efficiency.
> >
> > That is a very interesting point and one I hadn't considered. The point
> > of the patch was to help drivers that merge adjacent requests if they
> > happen to be physically contiguous. The reported bug that led to the
> > patch was a regression of memory not being physically contiguous and
> > requests not being merged.
> >
> > > > After this oops, system startup continues. Then the next oops occurs:
> > > >
> > > > This one is new, since I try to mount the connected SD card.
> > >
> > > Mel's buffer overrun theory seems to apply in the NDAS driver case,
> > > where the original requests adjacency test seems faulty.
> > >
> > > May it also be the cause of the SD mounting crash ?
> >
> > It's a possibility. If it's not an overrun, it's possible that the
> > automatic merging code is buggy as well.
> >
> > Juergen, is the disk controller on your machine capable of merging
> > requests? If so, can you disable it and see if the bug still occurs
> > please?
>
> Hmmm, hard to say. Maybe the author of this driver can say more.
>
> @Ben: MMC/SD/SDHC driver for the s3c2440-CPU. Can you answer Mel's
> question?

For the records: A wrong __initdata at the MMC/SD/SDHC platform structure 
causes this failure to happen. I copied it from a broken implementation in 
mach-mini2440.c.

Regards,
Juergen



-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-8766-939 228     |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
