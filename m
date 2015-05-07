From: orca.chen@gmail.com (Min-Hua Chen)
Date: Fri, 8 May 2015 00:20:32 +0800
Subject: [PATCH v2] arm: improve non-section-aligned low memory mapping
In-Reply-To: <20150506103249.GG2067@n2100.arm.linux.org.uk>
References: <1430038028-22625-1-git-send-email-orca.chen@gmail.com>
 <20150506103249.GG2067@n2100.arm.linux.org.uk>
Message-ID: <20150507162032.GB6188@debian777.Home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 06, 2015 at 11:32:49AM +0100, Russell King - ARM Linux wrote:
> On Sun, Apr 26, 2015 at 04:47:08PM +0800, Min-Hua Chen wrote:
> > @@ -1384,6 +1351,15 @@ static void __init map_lowmem(void)
> >  				create_mapping(&map);
> >  			}
> >  		}
> > +
> > +		/*
> > +		 * Find the first section-aligned memblock and set
> > +		 * memblock_limit at it.
> > +		 */
> > +		if (!section_memblock_limit && !(end & ~SECTION_MASK)) {
> > +			section_memblock_limit = end;
> > +			memblock_set_current_limit(section_memblock_limit);
> > +		}
> 
> I've suggested an alternative solution to this (which just means changing
> the alignment of the memblock limit to 2x SECTION_SIZE).

Sorry I do not understand your suggestion very well. Do you mean the 
alignment check should be 2X SECTION_SIZE?

	if (!section_memblock_limit && !(end & (2 * SECTION_SIZE - 1))) {

I found that this solution is based on the fact that the first memory block is 
always SECTION_SIZE-aligned. So we do not have to check the
alignment of the first memblock:

	if (!section_memblock_limit)) {
		section_memblock_limit = end;
		memblock_set_current_limit(section_memblock_limit);
	}
 
> -- 
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
