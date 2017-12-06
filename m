From: will.deacon@arm.com (Will Deacon)
Date: Wed, 6 Dec 2017 18:07:07 +0000
Subject: [PATCH 0/2] Fixes for SW PAN
In-Reply-To: <20171206180135.5zorlmaij45grg25@armageddon.cambridge.arm.com>
References: <1512558968-28980-1-git-send-email-will.deacon@arm.com>
 <5ee0b1f1-c7fc-af92-2b34-4555e59d7a20@codeaurora.org>
 <20171206175641.GA26554@arm.com>
 <20171206180135.5zorlmaij45grg25@armageddon.cambridge.arm.com>
Message-ID: <20171206180706.GB26554@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 06, 2017 at 06:01:35PM +0000, Catalin Marinas wrote:
> On Wed, Dec 06, 2017 at 05:56:42PM +0000, Will Deacon wrote:
> > On Wed, Dec 06, 2017 at 11:01:46PM +0530, Vinayak Menon wrote:
> > > On 12/6/2017 4:46 PM, Will Deacon wrote:
> > > > After lots of collective head scratching in response to Vinayak's mail
> > > > here:
> > > >
> > > >   http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/545641.html
> > > >
> > > > It turns out that we have a problem with SW PAN and kernel threads, where
> > > > the saved ttbr0 value for a kernel thread can be stale and subsequently
> > > > inherited by other kernel threads over a fork.
> > > >
> > > > These two patches attempt to fix that. We've not be able to reproduce
> > > > the exact failure reported above, but I added some assertions to the
> > > > uaccess routines to check for discrepancies between the active_mm pgd
> > > > and the saved ttbr0 value (ignoring the zero page) and these no longer
> > > > fire with these changes, but do fire without them if EFI runtime services
> > > > are enabled on my Seattle board.
> > > 
> > > Thanks Will. So these 2 patches fix the case of kthreads having a stale saved ttbr0. The callstack I had shared
> > > in the original issue description was not of a kthread (its user task with PF_KTHREAD not set. The tsk->mm was
> > > set to NULL by exit_mm I think). So do you think this could be a different problem ?
> > > I had a look at the dumps again and what I see is that, the PA part of the saved ttbr0
> > > (from thread_info) is not the same as the pa(tsk->active_mm->pgd). The PA derived from saved ttbr0 actually
> > > points to a page which is "now" owned by slab.
> > 
> > Having not been able to reproduce the failure you described, I can't give
> > you a good answer to this.
> 
> While these fixes make sense for a stable backport, I could go back to
> per-cpu saved_ttbr0 as in the first version of this patchset:
> 
> http://lkml.kernel.org/r/1471015666-23125-4-git-send-email-catalin.marinas at arm.com
> 
> (changed in v2 for some marginally shorter asm code)

To be honest, if we're going to consider changes as fundamental as that, I'd
much prefer for us to use the active_mm->pgd directly, setting the zero page
if it's either NULL or init_mm. This would need some hacking for EFI...

Will
