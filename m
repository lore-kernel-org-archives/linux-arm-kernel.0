From: will.deacon@arm.com (Will Deacon)
Date: Wed, 24 Aug 2016 16:56:50 +0100
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160824154711.GA25531@redhat.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160809184943.GA17112@redhat.com>
 <20160824071308.GA24311@localhost.localdomain>
 <20160824154711.GA25531@redhat.com>
Message-ID: <20160824155649.GG16944@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 05:47:11PM +0200, Oleg Nesterov wrote:
> On 08/24, Pratyush Anand wrote:
> >
> > > I don't think we want user_{enable,disable{_single_step in the long term,
> > > please look at 9bd1190a11c9d2 "uprobes/x86: Do not (ab)use TIF_SINGLESTEP
> > > /user_*_single_step() for single-stepping". it seems that ARM64 sets/clears
> > > TIF_SINGLESTEP. You can also lool at saved_tf logic, probably ARM64 needs
> > > the same.
> >
> > IIUC, then you mean that TIF_SINGLESTEP is a per task flag,
> 
> Yes, and nobody but ptrace should use it, otherwise ptrace/uprobes can confuse
> each other. And uprobes simply doesn't need to set/clear it.

We're already using it for kprobes, hw_breakpoint and kgdb as well as
ptrace, so I'd rather uprobes either followed existing practice, or we
converted everybody off the current code.

In what way do things get confused?

> > while
> > arch_uprobe_pre/post_xol() should enable/disable single stepping using a per
> > uprobe_task,
> 
> I can't really answer since I know nothing about arm. x86 just needs to set
> X86_EFLAGS_TF, I guess arm needs to modify some register too?

We have {user,kernel}_{enable,disable}_single_step for managing the various
registers controlling the single-step state machine on arm64.

Will
