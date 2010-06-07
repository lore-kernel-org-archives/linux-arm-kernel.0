From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 8 Jun 2010 01:35:17 +0400
Subject: [PATCH] ARM: Add PI/robust mutexes support for SMP kernels
In-Reply-To: <alpine.LFD.2.00.1006071634340.30664@xanadu.home>
References: <20100607173630.GA10489@oksana.dev.rtsoft.ru>
	<20100607194457.GC7220@n2100.arm.linux.org.uk>
	<20100607202701.GA14529@oksana.dev.rtsoft.ru>
	<alpine.LFD.2.00.1006071634340.30664@xanadu.home>
Message-ID: <20100607213517.GA25479@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 07, 2010 at 04:40:01PM -0400, Nicolas Pitre wrote:
> On Tue, 8 Jun 2010, Anton Vorontsov wrote:
> 
> > So, can we solve this by
> > 
> > ldrex
> > ...
> > strt newval
> >    ^ may cause exception, but doesn't clear the tag, so we're still atomic
> > strex <- clears the tag
> 
> No, you're not atomic anymore, as some other ldrex/strex might have come 
> through by the time the strt is executed, and while this strex wouldn't 
> be executed as the tag would be cleared at that point, the strt has no 
> such concerns with atomic tags and would indeed corrupt whatever new 
> value has been stored in the mean time.

Ugh, surely right you are, thanks!

It seems Catalin's "Remove the domain switching" patch comes handy
here.

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
