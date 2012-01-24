From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jan 2012 09:06:30 +0000
Subject: [PATCH RFC 2/2] mtd : Make the mtd_suspend return 0 if the
 suspend is not implemented
In-Reply-To: <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
References: <1327306361-9803-1-git-send-email-shubhrajyoti@ti.com>
 <1327306361-9803-3-git-send-email-shubhrajyoti@ti.com>
 <CAN8TOE8i-g_QTsidqDW=TRfZMQ8u93+iP8V7rr4paek=7xZ7UA@mail.gmail.com>
Message-ID: <20120124090630.GR16726@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2012 at 12:09:04AM -0800, Brian Norris wrote:
> Hi,
> 
> On Mon, Jan 23, 2012 at 12:12 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> ...
> > ?include/linux/mtd/mtd.h | ? ?6 +++---
> > ?1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
> > index 1a81fde..c717bb6 100644
> > --- a/include/linux/mtd/mtd.h
> > +++ b/include/linux/mtd/mtd.h
> > @@ -427,9 +427,9 @@ static inline int mtd_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> >
> > ?static inline int mtd_suspend(struct mtd_info *mtd)
> > ?{
> > - ? ? ? if (!mtd->suspend)
> > - ? ? ? ? ? ? ? return -EOPNOTSUPP;
> > - ? ? ? return mtd->suspend(mtd);
> > + ? ? ? if (mtd->suspend)
> > + ? ? ? ? ? ? ? return mtd->suspend(mtd);
> > + ? ? ? return 0;
> > ?}
> >
> > ?static inline void mtd_resume(struct mtd_info *mtd)
> 
> I believe this fix is already accounted for in Artem Bityutskiy's
> l2-mtd-2.6 repository as:
> 
> commit 091a7fe219ee8d3e76be9e02221433af10c6f574
> mtd: fix MTD suspend
> (http://git.infradead.org/users/dedekind/l2-mtd-2.6.git/commit/091a7fe219ee8d3e76be9e02221433af10c6f574)
> 
> However, the bug made it into the 3.3 merge window, so shouldn't this
> bugfix be sent upstream immediately?

David is the MTD maintainer, and Artem just helps out.  I believe Artem
is waiting for David to finish travelling before asking David (last seen
at Hong Kong airport) to pull these fixes.  David in turn will pass them
onto Linus.  Plus, Linus only started adding to -rc1 yesterday, so its a
little early to expect this to be fixed.
