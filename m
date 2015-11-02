From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Nov 2015 18:31:10 +0000
Subject: [PATCH v6 2/3] percpu: add PERCPU_ATOM_SIZE for a generic percpu
 area setup
In-Reply-To: <alpine.DEB.2.20.1511021210250.28799@east.gentwo.org>
References: <1446363977-23656-1-git-send-email-jungseoklee85@gmail.com>
 <1446363977-23656-3-git-send-email-jungseoklee85@gmail.com>
 <alpine.DEB.2.20.1511021008580.27740@east.gentwo.org>
 <20151102162236.GB7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511021047420.28255@east.gentwo.org>
 <20151102173520.GC7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511021210250.28799@east.gentwo.org>
Message-ID: <20151102183110.GD7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2015 at 12:11:33PM -0600, Christoph Lameter wrote:
> On Mon, 2 Nov 2015, Catalin Marinas wrote:
> 
> > On Mon, Nov 02, 2015 at 10:48:17AM -0600, Christoph Lameter wrote:
> > > On Mon, 2 Nov 2015, Catalin Marinas wrote:
> > > > I haven't looked at the patch 3/3 in detail but I'm pretty sure I'll NAK
> > > > the approach (and the definition of PERCPU_ATOM_SIZE), therefore
> > > > rendering this patch unnecessary. IIUC, this is used to enforce some
> > > > alignment of the per-CPU IRQ stack to be able to check whether the
> > > > current stack is process or IRQ on exception entry. But there are other,
> > > > less intrusive ways to achieve the same (e.g. x86).
> > >
> > > The percpu allocator allows the specification of alignment requirements.
> >
> > Patch 3/3 does something like this:
> >
> > DEFINE_PER_CPU(char [IRQ_STACK_SIZE], irq_stacks) __aligned(IRQ_STACK_SIZE)
> >
> > where IRQ_STACK_SIZE > PAGE_SIZE. AFAICT, setup_per_cpu_areas() doesn't
> > guarantee alignment greater than PAGE_SIZE.
> 
> And we cannot use percpu_alloc() instead? Aligning the whole of the percpu
> area because one allocation requires it?

I haven't tried but it seems that pcpu_alloc() has a WARN() when align >
PAGE_SIZE and it would fail.

As I said in a previous reply, I don't think this patch is necessary,
mainly because I don't particularly like the logic for detecting the IRQ
stack re-entrance based on the stack pointer alignment.

-- 
Catalin
