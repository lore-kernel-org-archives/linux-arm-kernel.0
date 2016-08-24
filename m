From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 24 Aug 2016 17:47:11 +0200
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160824071308.GA24311@localhost.localdomain>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160809184943.GA17112@redhat.com>
 <20160824071308.GA24311@localhost.localdomain>
Message-ID: <20160824154711.GA25531@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 08/24, Pratyush Anand wrote:
>
> > I don't think we want user_{enable,disable{_single_step in the long term,
> > please look at 9bd1190a11c9d2 "uprobes/x86: Do not (ab)use TIF_SINGLESTEP
> > /user_*_single_step() for single-stepping". it seems that ARM64 sets/clears
> > TIF_SINGLESTEP. You can also lool at saved_tf logic, probably ARM64 needs
> > the same.
>
> IIUC, then you mean that TIF_SINGLESTEP is a per task flag,

Yes, and nobody but ptrace should use it, otherwise ptrace/uprobes can confuse
each other. And uprobes simply doesn't need to set/clear it.

> while
> arch_uprobe_pre/post_xol() should enable/disable single stepping using a per
> uprobe_task,

I can't really answer since I know nothing about arm. x86 just needs to set
X86_EFLAGS_TF, I guess arm needs to modify some register too?

> and we should have a flag in "struct arch_uprobe_task" to handle
> this, right?

Probably yes, because we need to record/restore X86_EFLAGS_TF in case it
was already set by ptrace or something else.

> > However, I agree we can do this later and initial version can use these
> > ptrace helpers.
>
> Yes, I would also like to do that change latter, because these set of patches
> have already been tested heavily with systemtap, so it would be better to go
> with an incremental changes latter on.

Yes, yes, I agree. Let me repeat that this patch looks good to me as initial
version, but obviously I can't really revit it and/or ack.

Oleg.
