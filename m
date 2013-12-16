From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 16 Dec 2013 14:42:46 +0000
Subject: [PATCH 4/4] arm64: add early_ioremap support
In-Reply-To: <1386350449.1861.196.camel@deneb.redhat.com>
References: <1385606679-30446-1-git-send-email-msalter@redhat.com>
 <1385606679-30446-5-git-send-email-msalter@redhat.com>
 <20131205162800.GB1495@darko.cambridge.arm.com>
 <1386350449.1861.196.camel@deneb.redhat.com>
Message-ID: <20131216144246.GG17713@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 05:20:49PM +0000, Mark Salter wrote:
> On Thu, 2013-12-05 at 16:28 +0000, Catalin Marinas wrote:
> > On Thu, Nov 28, 2013 at 02:44:39AM +0000, Mark Salter wrote:
> > > + * These 'compile-time allocated' memory buffers are
> > > + * page-sized. Use set_fixmap(idx,phys) to associate
> > > + * physical memory with fixmap indices.
> > > + *
> > > + */
> > > +enum fixed_addresses {
> > > +	FIX_EARLYCON,
> > > +	__end_of_permanent_fixed_addresses,
> > > +
> > > +	/*
> > > +	 * Temporary boot-time mappings, used by early_ioremap(),
> > > +	 * before ioremap() is functional.
> > > +	 */
> > 
> > How temporary are this mappings? The early console may not be disabled
> > at run-time, so it still needs the mapping.
> 
> It varies by arch, but we have flexibility on arm64 because there is a
> dedicated pmd which stays around forever. So, you see the FIX_EARLYCON
> above is a "permanent" mapping which isn't really an early_ioremap
> mapping. The earlyprintk code uses set_fixmap_io. I suppose this could
> have been broken up into two patches, one fixmap, and one early_ioremap.
> To answer your concern, the earlyprintk mapping doesn't go away. The
> early_ioremap mappings should be temporary and there's a checker for
> that which is run at late_initcall time.

OK, thanks for clarification, I don't think it's worth splitting the
patch.

-- 
Catalin
