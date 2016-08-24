From: panand@redhat.com (Pratyush Anand)
Date: Wed, 24 Aug 2016 12:43:08 +0530
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160809184943.GA17112@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160809184943.GA17112@redhat.com>
Message-ID: <20160824071308.GA24311@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

Thanks a lot for your review, and sorry for delayed response.

On 09/08/2016:08:49:44 PM, Oleg Nesterov wrote:
> On 08/02, Pratyush Anand wrote:
> >
> > This patch adds support for uprobe on ARM64 architecture.
> 
> I know nothing about ARM, so I can't actually review this change.
> But it looks good to me ;)
> 
> Just one note,
> 
> > +int arch_uprobe_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
> > +{
> > +	struct uprobe_task *utask = current->utask;
> > +
> > +	/* saved fault code is restored in post_xol */
> > +	utask->autask.saved_fault_code = current->thread.fault_code;
> > +
> > +	/* An invalid fault code between pre/post xol event */
> > +	current->thread.fault_code = UPROBE_INV_FAULT_CODE;
> > +
> > +	/* Instruction point to execute ol */
> > +	instruction_pointer_set(regs, utask->xol_vaddr);
> > +
> > +	user_enable_single_step(current);
> 
> I don't think we want user_{enable,disable{_single_step in the long term,
> please look at 9bd1190a11c9d2 "uprobes/x86: Do not (ab)use TIF_SINGLESTEP
> /user_*_single_step() for single-stepping". it seems that ARM64 sets/clears
> TIF_SINGLESTEP. You can also lool at saved_tf logic, probably ARM64 needs
> the same.

IIUC, then you mean that TIF_SINGLESTEP is a per task flag, while
arch_uprobe_pre/post_xol() should enable/disable single stepping using a per
uprobe_task, and we should have a flag in "struct arch_uprobe_task" to handle
this, right?

> 
> However, I agree we can do this later and initial version can use these
> ptrace helpers.

Yes, I would also like to do that change latter, because these set of patches
have already been tested heavily with systemtap, so it would be better to go
with an incremental changes latter on.

~Pratyush
