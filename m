From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jul 2012 17:37:12 +0100
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with
 VIVT caches
In-Reply-To: <CAFULd4a9YDrKpFavi-q+E+BAHTz3vyGDYGtA3JWGvncibWyFyw@mail.gmail.com>
References: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
 <20120719122814.GE29153@mudshark.cambridge.arm.com>
 <CAFULd4a9YDrKpFavi-q+E+BAHTz3vyGDYGtA3JWGvncibWyFyw@mail.gmail.com>
Message-ID: <20120719163711.GG29153@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 02:03:50PM +0100, Uros Bizjak wrote:
> On Thu, Jul 19, 2012 at 2:28 PM, Will Deacon <will.deacon@arm.com> wrote:
> 
> > On Mon, Jul 16, 2012 at 05:23:46PM +0100, Will Deacon wrote:
> >> The vivt_flush_cache_{range,page} functions check that the mm_struct
> >> of the VMA being flushed has been active on the current CPU before
> >> performing the cache maintenance.
> >>
> >> The gate_vma has a NULL mm_struct pointer and, as such, will cause a
> >> kernel fault if we try to flush it with the above operations. This
> >> happens during ELF core dumps, which include the gate_vma as it may be
> >> useful for debugging purposes.
> >>
> >> This patch adds checks to the VIVT cache flushing functions so that VMAs
> >> with a NULL mm_struct are ignored.
> >
> > Would one of you be able to test this patch please? I've not managed to
> > trigger the bug you reported on my boards, so it would be useful to know
> > whether or not this patch solves the problem for you.
> 
> Patched kernel works as expected. Also, backport to 3.4 (where
> original problem was triggered) works OK, so I'd suggest to backport
> this patch to 3.4.
> 
> Tested-by: Uros Bizjak <ubizjak@gmail.com>

Thanks Uros, I'll add that and CC stable on the patch too.

Will
