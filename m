From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 30 Oct 2018 07:06:01 +0100
Subject: [PATCH v3] mm/page_owner: use kvmalloc instead of kmalloc
In-Reply-To: <1540862950.12374.40.camel@mtkswgap22>
References: <1540790176-32339-1-git-send-email-miles.chen@mediatek.com>
 <20181029080708.GA32673@dhcp22.suse.cz>
 <20181029081706.GC32673@dhcp22.suse.cz>
 <1540862950.12374.40.camel@mtkswgap22>
Message-ID: <20181030060601.GR32673@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 30-10-18 09:29:10, Miles Chen wrote:
> On Mon, 2018-10-29 at 09:17 +0100, Michal Hocko wrote:
> > On Mon 29-10-18 09:07:08, Michal Hocko wrote:
> > [...]
> > > Besides that, the following doesn't make much sense to me. It simply
> > > makes no sense to use vmalloc for sub page allocation regardless of
> > > HIGHMEM.
> > 
> > OK, it is still early morning here. Now I get the point of the patch.
> > You just want to (ab)use highmeme for smaller requests. I do not like
> > this, to be honest. It causes an internal fragmentation and more
> > importantly the VMALLOC space on 32b where HIGHMEM is enabled (do we
> > have any 64b with HIGHMEM btw?) is quite small to be wasted like that.
> > 
> thanks for your comment. It looks like that using vmalloc fallback for
> sub page allocation is not good here.
> 
> Your comment gave another idea:
> 
> 1. force kbuf to PAGE_SIZE
> 2. allocate a page by alloc_page(GFP_KERNEL | __GFP_HIGHMEM); so we can
> get a highmem page if possible
> 3. use kmap/kunmap pair to create mapping for this page. No vmalloc
> space is used.
> 4. do not change kvmalloc logic.

If you mean for this particular situation then is this really worth
it? I mean this is a short term allocation for root only so you do not
have to worry about low mem depletion.

If you are thiking in more generic terms to allow kmalloc to use highmem
then I am not really sure this will work out.
-- 
Michal Hocko
SUSE Labs
