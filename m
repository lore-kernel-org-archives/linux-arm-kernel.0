From: jrdr.linux@gmail.com (Souptick Joarder)
Date: Fri, 16 Nov 2018 13:45:48 +0530
Subject: [PATCH 1/9] mm: Introduce new vm_insert_range API
In-Reply-To: <20181116064049.GA5320@bombadil.infradead.org>
References: <20181115154530.GA27872@jordon-HP-15-Notebook-PC>
 <9655a12e-bd3d-aca2-6155-38924028eb5d@infradead.org>
 <CAFqt6zbLjtDab3Bz67trbnQRQdutvgA=YvAFhoW4bxsg657mGQ@mail.gmail.com>
 <20181116064049.GA5320@bombadil.infradead.org>
Message-ID: <CAFqt6zbL1tu4VWtZ5Wz-BgbOS+M2GJziMj958_h_ri4Th3n9bQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 12:11 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Nov 16, 2018 at 11:00:30AM +0530, Souptick Joarder wrote:
> > On Thu, Nov 15, 2018 at 11:44 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > On 11/15/18 7:45 AM, Souptick Joarder wrote:
> > > What is the opposite of vm_insert_range() or even of vm_insert_page()?
> > > or is there no need for that?
> >
> > There is no opposite function of vm_insert_range() / vm_insert_page().
> > My understanding is, in case of any error, mmap handlers will return the
> > err to user process and user space will decide the next action. So next
> > time when mmap handler is getting invoked it will map from the beginning.
> > Correct me if I am wrong.
>
> The opposite function, I suppose, is unmap_region().
>
> > > s/no./number/
> >
> > I didn't get it ??
>
> This is a 'sed' expression.  's' is the 'substitute' command; the /
> is a separator, 'no.' is what you wrote, and 'number' is what Randy
> is recommending instead.

Ok. Will change it in v2.
>
> > > > +     for (i = 0; i < page_count; i++) {
> > > > +             ret = vm_insert_page(vma, uaddr, pages[i]);
> > > > +             if (ret < 0)
> > > > +                     return ret;
> > >
> > > For a non-trivial value of page_count:
> > > Is it a problem if vm_insert_page() succeeds for several pages
> > > and then fails?
> >
> > No, it will be considered as total failure and mmap handler will return
> > the err to user space.
>
> I think what Randy means is "What happens to the inserted pages?" and
> the answer is that mmap_region() jumps to the 'unmap_and_free_vma'
> label, which is an accurate name.

Sorry for incorrect understanding of the question.
