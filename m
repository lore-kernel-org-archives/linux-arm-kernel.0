From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Fri, 16 Nov 2018 11:00:30 +0530
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
Message-ID: <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > Previouly drivers have their own way of mapping range of
> > kernel pages/memory into user vma and this was done by
> > invoking vm_insert_page() within a loop.
> >
> > As this pattern is common across different drivers, it can
> > be generalized by creating a new function and use it across
> > the drivers.
> >
> > vm_insert_range is the new API which will be used to map a
> > range of kernel memory/pages to user vma.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Reviewed-by: Matthew Wilcox <willy@infradead.org>
> > ---
> >  include/linux/mm_types.h |  3 +++
> >  mm/memory.c              | 28 ++++++++++++++++++++++++++++
> >  mm/nommu.c               |  7 +++++++
> >  3 files changed, 38 insertions(+)
>
> Hi,
>
> What is the opposite of vm_insert_range() or even of vm_insert_page()?
> or is there no need for that?

There is no opposite function of vm_insert_range() / vm_insert_page().
My understanding is, in case of any error, mmap handlers will return the
err to user process and user space will decide the next action. So next
time when mmap handler is getting invoked it will map from the beginning.
Correct me if I am wrong.
>
>
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 15c417e..da904ed 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1478,6 +1478,34 @@ static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> >  }
> >
> >  /**
> > + * vm_insert_range - insert range of kernel pages into user vma
> > + * @vma: user vma to map to
> > + * @addr: target user address of this page
> > + * @pages: pointer to array of source kernel pages
> > + * @page_count: no. of pages need to insert into user vma
>
> s/no./number/

I didn't get it ??
>
> > + *
> > + * This allows drivers to insert range of kernel pages they've allocated
> > + * into a user vma. This is a generic function which drivers can use
> > + * rather than using their own way of mapping range of kernel pages into
> > + * user vma.
> > + */
> > +int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
> > +                     struct page **pages, unsigned long page_count)
> > +{
> > +     unsigned long uaddr = addr;
> > +     int ret = 0, i;
> > +
> > +     for (i = 0; i < page_count; i++) {
> > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > +             if (ret < 0)
> > +                     return ret;
>
> For a non-trivial value of page_count:
> Is it a problem if vm_insert_page() succeeds for several pages
> and then fails?

No, it will be considered as total failure and mmap handler will return
the err to user space.
>
> > +             uaddr += PAGE_SIZE;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/**
> >   * vm_insert_page - insert single page into user vma
> >   * @vma: user vma to map to
> >   * @addr: target user address of this page
>
>
> thanks.
> --
> ~Randy
