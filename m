From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 9 Sep 2014 10:38:29 +1000
Subject: "mm: introduce dump_vma fix 2" still broken
In-Reply-To: <540DBD62.5040605@oracle.com>
References: <2815658.dHHBXc7oHP@wuerfel>
	<540DBD62.5040605@oracle.com>
Message-ID: <20140909103829.05c0889f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sasha,

On Mon, 08 Sep 2014 10:29:54 -0400 Sasha Levin <sasha.levin@oracle.com> wrote:
>
> On 09/08/2014 07:02 AM, Arnd Bergmann wrote:
> > 
> > I saw this commit today in linux-next, which fixes a build error, but introduces
> > a new warning:
> > 
> > commit a60224c708f880dd937b352b7461cbf14e93012d
> > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date:   Mon Sep 8 19:41:54 2014 +1000
> > 
> >     mm: introduce dump_vma fix 2
> >     
> >     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index cb510c08073b..0de60769bcf6 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -6739,7 +6739,7 @@ void dump_vma(const struct vm_area_struct *vma)
> >                 "prot %lx anon_vma %p vm_ops %p\n"
> >                 "pgoff %lx file %p private_data %p\n",
> >                 vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
> > -               vma->vm_prev, vma->vm_mm, vma->vm_page_prot.pgprot,
> > +               vma->vm_prev, vma->vm_mm, pgprot_val(vma->vm_page_prot),
> >                 vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
> >                 vma->vm_file, vma->vm_private_data);
> >         dump_flags(vma->vm_flags, vmaflags_names, ARRAY_SIZE(vmaflags_names));
> > 
> > 
> > /git/arm-soc/mm/page_alloc.c: In function 'dump_vma':
> > /git/arm-soc/mm/page_alloc.c:6744:3: warning: format '%lx' expects argument of type 'long unsigned int', but argument 8 has type 'pgprot_t' [-Wformat=]
> >    vma->vm_file, vma->vm_private_data);
> >    ^
> > 
> > This happens on machines that use ARM LPAE, where pgprot_t is in fact
> > a 64-bit integer. The simplest fix I see would be add a cast to u64
> > and always print this as a 64bit value.
> 
> Hi Arnd,
> 
> The fix for the original issue would be:
> 
> 	http://ozlabs.org/~akpm/mmots/broken-out/introduce-dump_vma-fix-2.patch
> 
> Which includes the casting that Stephen's patch didn't have.

Thanks for pointing it out, I will replace my patch with that (unless
Andrew does a new mmotm today).

> Stephen, in the future, is there a way to get build fixes faster to you? From
> what I understand -mm syncs up only once in a couple of days. It might make
> everyone?s life much easier if build errors wouldn't drag over a week.

Andrew (and others) sometime cc's me on such fixes in which case I add
them to linux-next until Andrew does a new mmotm.

It didn't help that I have been away for a week.
-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140909/ce9a2d80/attachment-0001.sig>
