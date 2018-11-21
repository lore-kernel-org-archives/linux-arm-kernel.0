From: willy@infradead.org (Matthew Wilcox)
Date: Wed, 21 Nov 2018 04:35:13 -0800
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <833B5050-DEF6-44A0-9832-276F86671212@oracle.com>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <20181116182836.GB17088@rapoport-lnx>
 <CAFqt6zYp0j999WXw9Jus0oZMjADQQkPfso8btv6du6L9CE3PXA@mail.gmail.com>
 <20181117143742.GB7861@bombadil.infradead.org>
 <CAFqt6zbOWX5LUTWwoGDJsGdf+pTR6N1yTPVxyr1W3-6Fte39ww@mail.gmail.com>
 <833B5050-DEF6-44A0-9832-276F86671212@oracle.com>
Message-ID: <20181121123513.GF3065@bombadil.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2018 at 04:19:11AM -0700, William Kucharski wrote:
> Could you add a line to the description explicitly stating that a failure
> to insert any page in the range will fail the entire routine, something
> like:
> 
> > * This allows drivers to insert range of kernel pages they've allocated
> > * into a user vma. This is a generic function which drivers can use
> > * rather than using their own way of mapping range of kernel pages into
> > * user vma.
> > *
> > * A failure to insert any page in the range will fail the call as a whole.
> 
> It's obvious when reading the code, but it would be self-documenting to
> state it outright.

It's probably better to be more explicit and answer Randy's question:

 * If we fail to insert any page into the vma, the function will return
 * immediately leaving any previously-inserted pages present.  Callers
 * from the mmap handler may immediately return the error as their
 * caller will destroy the vma, removing any successfully-inserted pages.
 * Other callers should make their own arrangements for calling unmap_region().

Although unmap_region() is static so there clearly isn't any code in the
kernel today other than in mmap handlers (or fault handlers) that needs to
insert pages into a VMA.
