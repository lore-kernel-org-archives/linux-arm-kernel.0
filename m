From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 08 Jun 2010 11:14:37 +0100
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <20100607213517.GA25479@oksana.dev.rtsoft.ru>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
	<20100607202701.GA14529@oksana.dev.rtsoft.ru>
	<alpine.LFD.2.00.1006071634340.30664@xanadu.home>
	<20100607213517.GA25479@oksana.dev.rtsoft.ru>
Message-ID: <1275992077.2127.13.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-07 at 22:35 +0100, Anton Vorontsov wrote:
> On Mon, Jun 07, 2010 at 04:40:01PM -0400, Nicolas Pitre wrote:
> > On Tue, 8 Jun 2010, Anton Vorontsov wrote:
> >
> > > So, can we solve this by
> > >
> > > ldrex
> > > ...
> > > strt newval
> > >    ^ may cause exception, but doesn't clear the tag, so we're still atomic
> > > strex <- clears the tag
> >
> > No, you're not atomic anymore, as some other ldrex/strex might have come
> > through by the time the strt is executed, and while this strex wouldn't
> > be executed as the tag would be cleared at that point, the strt has no
> > such concerns with atomic tags and would indeed corrupt whatever new
> > value has been stored in the mean time.
> 
> Ugh, surely right you are, thanks!
> 
> It seems Catalin's "Remove the domain switching" patch comes handy
> here.

As I said, not all the domains patch is needed for your specific case,
just the parts dealing with page permissions.

-- 
Catalin
