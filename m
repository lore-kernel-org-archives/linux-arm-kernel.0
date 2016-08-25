From: oleg@redhat.com (Oleg Nesterov)
Date: Thu, 25 Aug 2016 15:33:25 +0200
Subject: [PATCH 5/5] arm64: Add uprobe support
In-Reply-To: <20160824155649.GG16944@arm.com>
References: <cover.1470114993.git.panand@redhat.com>
 <abaac6ebaa5dd63889803ec568663bc8c8c65b02.1470114993.git.panand@redhat.com>
 <20160809184943.GA17112@redhat.com>
 <20160824071308.GA24311@localhost.localdomain>
 <20160824154711.GA25531@redhat.com> <20160824155649.GG16944@arm.com>
Message-ID: <20160825133325.GA7653@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24, Will Deacon wrote:
>
> On Wed, Aug 24, 2016 at 05:47:11PM +0200, Oleg Nesterov wrote:
> > On 08/24, Pratyush Anand wrote:
> > >
> > > > I don't think we want user_{enable,disable{_single_step in the long term,
> > > > please look at 9bd1190a11c9d2 "uprobes/x86: Do not (ab)use TIF_SINGLESTEP
> > > > /user_*_single_step() for single-stepping". it seems that ARM64 sets/clears
> > > > TIF_SINGLESTEP. You can also lool at saved_tf logic, probably ARM64 needs
> > > > the same.
> > >
> > > IIUC, then you mean that TIF_SINGLESTEP is a per task flag,
> >
> > Yes, and nobody but ptrace should use it, otherwise ptrace/uprobes can confuse
> > each other. And uprobes simply doesn't need to set/clear it.
>
> We're already using it for kprobes, hw_breakpoint and kgdb as well as
> ptrace, so I'd rather uprobes either followed existing practice, or we
> converted everybody off the current code.

And perhaps this is fine for arm64, I do not know.

> In what way do things get confused?

Say, arch_uprobe_post_xol() should not blindly do user_disable_single_step(),
this can confuse ptrace if TIF_SINGLESTEP was set by debugger which wants
to step over the probed insn.

> > I can't really answer since I know nothing about arm. x86 just needs to set
> > X86_EFLAGS_TF, I guess arm needs to modify some register too?
>
> We have {user,kernel}_{enable,disable}_single_step for managing the various
> registers controlling the single-step state machine on arm64.

Yes, and perhaps uprobes can just do set_regs_spsr_ss() ? I never looked into
arch/arm64/, but it seems that we only need to ensure that call_step_hook()
will be called even if user_mode() == T, why do we need TIF_SINGLESTEP ?

Nevermind. I can be easily wrong and let me repeat that I agree with
user_{enable,disable}_single_step in the initial version in any case.

Oleg.
