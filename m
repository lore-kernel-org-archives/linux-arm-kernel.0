From: hannes@cmpxchg.org (Johannes Weiner)
Date: Thu, 7 Mar 2013 22:16:51 -0500
Subject: [PATCH] mm: Fixup the condition whether the page cache is free
In-Reply-To: <5139517F.60407@gmail.com>
References: <CAFNq8R7tq9kvD9LyhZJ-Cj0kexQfDsPhB4iQYyZ9s9+8Jo82QA@mail.gmail.com>
 <20130304150937.GB23767@cmpxchg.org> <51369637.6030705@gmail.com>
 <20130306194703.GA1953@cmpxchg.org> <5137E7F4.1060509@gmail.com>
 <51394945.4070803@gmail.com> <20130308023705.GI24384@cmpxchg.org>
 <5139517F.60407@gmail.com>
Message-ID: <20130308031651.GJ24384@cmpxchg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 08, 2013 at 10:48:31AM +0800, Simon Jeons wrote:
> On 03/08/2013 10:37 AM, Johannes Weiner wrote:
> >On Fri, Mar 08, 2013 at 10:13:25AM +0800, Simon Jeons wrote:
> >>Ping, :-)
> >>On 03/07/2013 09:05 AM, Simon Jeons wrote:
> >>>Hi Johannes,
> >>>On 03/07/2013 03:47 AM, Johannes Weiner wrote:
> >>>>On Wed, Mar 06, 2013 at 09:04:55AM +0800, Simon Jeons wrote:
> >>>>>Hi Johannes,
> >>>>>On 03/04/2013 11:09 PM, Johannes Weiner wrote:
> >>>>>>On Mon, Mar 04, 2013 at 09:54:26AM +0800, Li Haifeng wrote:
> >>>>>>>When a page cache is to reclaim, we should to decide whether the page
> >>>>>>>cache is free.
> >>>>>>>IMO, the condition whether a page cache is free should be 3 in page
> >>>>>>>frame reclaiming. The reason lists as below.
> >>>>>>>
> >>>>>>>When page is allocated, the page->_count is 1(code
> >>>>>>>fragment is code-1 ).
> >>>>>>>And when the page is allocated for reading files from
> >>>>>>>extern disk, the
> >>>>>>>page->_count will increment 1 by page_cache_get() in
> >>>>>>>add_to_page_cache_locked()(code fragment is code-2). When
> >>>>>>>the page is to
> >>>>>>>reclaim, the isolated LRU list also increase the page->_count(code
> >>>>>>>fragment is code-3).
> >>>>>>The page count is initialized to 1, but that does not stay with the
> >>>>>>object.  It's a reference that is passed to the allocating task, which
> >>>>>>drops it again when it's done with the page.  I.e. the pattern is like
> >>>>>>this:
> >>>>>>
> >>>>>>instantiation:
> >>>>>>page = page_cache_alloc()    /* instantiator reference -> 1 */
> >>>>>>add_to_page_cache(page, mapping, offset)
> >>>>>>   get_page(page)        /* page cache reference -> 2 */
> >>>>>>lru_cache_add(page)
> >>>>>>   get_page(page)        /* pagevec reference -> 3 */
> >>>>>>/* ...initiate read, write, associate buffers, ... */
> >>>>>>page_cache_release(page)    /* drop instantiator reference
> >>>>>>-> 2 + private */
> >>>>>>
> >>>>>>reclaim:
> >>>>>>lru_add_drain()
> >>>>>>   page_cache_release(page)    /* drop pagevec reference ->
> >>>>>>1 + private */
> >>>>>IIUC, when add page to lru will lead to add to pagevec firstly, and
> >>>>>pagevec will take one reference, so if lru will take over the
> >>>>>reference taken by pagevec when page transmit from pagevec to lru?
> >>>>>or just drop the reference and lru will not take reference for page?
> >>>>The LRU does not hold a reference, it would not make sense.  The
> >>>>pagevec only needs one because it would be awkward to remove a
> >>>>concurrently freed page out of a pagevec, but unlinking a page from
> >>>>the LRU is easy.  See mm/swap.c::__page_cache_release() and friends.
> >>>Since pagevec is per cpu, when can remove a concurrently freed
> >>>page out of a pagevec happen?
> >It doesn't because the pagevec holds a reference, as I wrote above.
> 
> I mean since pagevec is per cpu, how can remove a concurrently freed
> page out of a pagevec happen? If it doesn't happen pagevec don't
> need to hold a reference. :-)

It has nothing to do with the pagevec being per CPU.  The page may get
truncated or reclaimed and have every other reference being dropped
while it sits on the pagevec.
