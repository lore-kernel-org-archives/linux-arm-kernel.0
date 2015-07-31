From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Jul 2015 11:14:32 +0100
Subject: [RFC] arm64:change jump_label to use branch instruction, not use
 NOP instr
In-Reply-To: <20150731093355.GU25159@twins.programming.kicks-ass.net>
References: <94E2034B-9DE4-4ADF-8B2F-197D38A363CF@gmail.com>
 <20150731075259.GR25159@twins.programming.kicks-ass.net>
 <8F6A71B0-C7DB-4505-BEE2-79967FC91A8F@gmail.com>
 <20150731093355.GU25159@twins.programming.kicks-ass.net>
Message-ID: <20150731101432.GA29497@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 31, 2015 at 10:33:55AM +0100, Peter Zijlstra wrote:
> On Fri, Jul 31, 2015 at 05:25:02PM +0800, yalin wang wrote:
> > > On Jul 31, 2015, at 15:52, Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Fri, Jul 31, 2015 at 03:41:37PM +0800, yalin wang wrote:
> > >> This change a little arch_static_branch(), use b . + 4 for false
> > >> return, why? According to aarch64 TRM, if both source and dest
> > >> instr are branch instr, can patch the instr directly, don't need
> > >> all cpu to do ISB for sync, this means we can call
> > >> aarch64_insn_patch_text_nosync() during patch_text(),
> > >> will improve the performance when change a static_key.
> > > 
> > > This doesn't parse.. What?
> > > 
> > > Also, this conflicts with the jump label patches I've got.
> > 
> > this is arch depend , you can see aarch64_insn_patch_text( ) for more info,
> > if aarch64_insn_hotpatch_safe() is true, will patch the text directly.
> 
> So I patched all arches, including aargh64.
> 
> > what is your git branch base? i make the patch based on linux-next branch,
> > maybe a little delay than yours , could you share your branch git address?
> > i can make a new based on yours .
> 
> https://git.kernel.org/cgit/linux/kernel/git/peterz/queue.git/log/?h=locking/jump_label
> 
> Don't actually use that branch for anything permanent, this is throw-away
> git stuff.
> 
> But you're replacing a NOP with an unconditional branch to the next
> instruction? I suppose I'll leave that to Will and co.. I just had
> trouble understanding your Changelog -- also I was very much not awake
> yet.

Optimising the (hopefully rare) patching operation but having a potential
impact on the runtime code (assumedly a hotpath) seems completely backwards
to me.

Yalin, do you have a reason for this change or did you just notice that
paragraph in the architecture and decide to apply it here?

Even then, I think there are technical issues with the proposal, since
we could get spurious execution of the old code without explicit
synchronisation (see the kick_all_cpus_sync() call in
aarch64_insn_patch_text).

Will
