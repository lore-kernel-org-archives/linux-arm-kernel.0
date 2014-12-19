From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Fri, 19 Dec 2014 14:54:48 +0800
Subject: [RFC] MADV_FREE doesn't work when doesn't have swap partition
In-Reply-To: <20141219010452.GC1538@bbox>
References: <35FD53F367049845BC99AC72306C23D103E688B313EE@CNBJMBX05.corpusers.net>
 <CALYGNiOuBKz8shHSrFCp0BT5AV6XkNOCHj+LJedQQ-2YdZtM7w@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B313F2@CNBJMBX05.corpusers.net>
 <20141205143134.37139da2208c654a0d3cd942@linux-foundation.org>
 <35FD53F367049845BC99AC72306C23D103E688B313F4@CNBJMBX05.corpusers.net>
 <20141208114601.GA28846@node.dhcp.inet.fi>
 <35FD53F367049845BC99AC72306C23D103E688B313FB@CNBJMBX05.corpusers.net>
 <CALYGNiMEytHuND37f+hNdMKqCPzN0k_uha6CaeL_fyzrj-obNQ@mail.gmail.com>
 <35FD53F367049845BC99AC72306C23D103E688B31408@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D103EDAF89E14C@CNBJMBX05.corpusers.net>
 <20141219010452.GC1538@bbox>
Message-ID: <35FD53F367049845BC99AC72306C23D103EDAF89E152@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Minchan Kim [mailto:minchan at kernel.org]
> Sent: Friday, December 19, 2014 9:05 AM
> To: Wang, Yalin
> Cc: 'Konstantin Khlebnikov'; 'Kirill A. Shutemov'; 'Andrew Morton'; 'linux-
> kernel at vger.kernel.org'; 'linux-mm at kvack.org'; 'linux-arm-
> kernel at lists.infradead.org'; 'n-horiguchi at ah.jp.nec.com'
> Subject: Re: [RFC] MADV_FREE doesn't work when doesn't have swap partition
> 
> On Thu, Dec 18, 2014 at 11:50:01AM +0800, Wang, Yalin wrote:
> > I notice this commit:
> > mm: support madvise(MADV_FREE),
> >
> > it can free clean anonymous pages directly, doesn't need pageout to
> > swap partition,
> >
> > but I found it doesn't work on my platform, which don't enable any
> > swap partitions.
> 
> Current implementation, if there is no empty slot in swap, it does instant
> free instead of delayed free. Look at madvise_vma.
> 
> >
> > I make a change for this.
> > Just to explain my issue clearly,
> > Do we need some other checks to still scan anonymous pages even Don't
> > have swap partition but have clean anonymous pages?
> 
> There is a few places we should consider if you want to scan anonymous page
> withotu swap. Refer 69c854817566 and 74e3f3c3391d.
> 
> However, it's not simple at the moment. If we reenable anonymous scan
> without swap, it would make much regress of reclaim. So my direction is
> move normal anonymos pages into unevictable LRU list because they're real
> unevictable without swap and put delayed freeing pages into anon LRU list
> and age them.
> 
I understand your solution, sounds a great idea!
When this design will be merged into main stream?

Thanks.
