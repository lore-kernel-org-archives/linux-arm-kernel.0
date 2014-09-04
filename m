From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Sep 2014 11:52:27 +0100
Subject: [PATCH v5 3/3] kprobes: arm: enable OPTPROBES for ARM 32
In-Reply-To: <1409827235.3008.46.camel@linaro1.home>
References: <1409144552-12751-1-git-send-email-wangnan0@huawei.com>
 <1409144552-12751-4-git-send-email-wangnan0@huawei.com>
 <1409665784.2873.49.camel@linaro1.home>
 <5406EADC.8080009@hitachi.com> <20140903103044.GC32378@arm.com>
 <1409827235.3008.46.camel@linaro1.home>
Message-ID: <20140904105227.GC7156@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 11:40:35AM +0100, Jon Medhurst (Tixy) wrote:
> On Wed, 2014-09-03 at 11:30 +0100, Will Deacon wrote:
> > On Wed, Sep 03, 2014 at 11:18:04AM +0100, Masami Hiramatsu wrote:
> > > (2014/09/02 22:49), Jon Medhurst (Tixy) wrote:
> > > > 1. On SMP systems it's very slow because of kprobe's use of stop_machine
> > > > for applying and removing probes, this forces the system to idle and
> > > > wait for the next scheduler tick for each probe change.
> > > 
> > > Hmm, agreed. It seems that arm32 limitation of self-modifying code on SMP.
> > > I'm not sure how we can handle it, but I guess;
> > >  - for some processors which have better coherent cache for SMP, we can
> > >    atomically replace the breakpoint code with original code.
> > 
> > Except that it's not an architected breakpoint instruction, as I mentioned
> > before. It's also not really a property of the cache.
> > 
> > >  - Even if we get an "undefined instruction" exception, its handler can
> > >    ask kprobes if the address is under modifying or not. And if it is,
> > >    we can just return from the exception to retry the execution.
> > 
> > It's not as simple as that -- you could potentially see an interleaving of
> > the two instructions. The architecture is even broader than that:
> > 
> >  Concurrent modification and execution of instructions can lead to the
> >  resulting instruction performing any behavior that can be achieved by
> >  executing any sequence of instructions that can be executed from the
> >  same Exception level,
> > 
> > There are additional guarantees for some instructions (like the architected
> > BKPT instruction).
> 
> I should point out that the current implementation of kprobes doesn't
> use stop_machine because it's trying to meet the above architecture
> restrictions, and that arming kprobes (changing probed instruction to an
> undefined instruction) isn't usually done under stop_machine, so other
> CPUs could be executing the original instruction as it's being modified.
> 
> So, should we be making patch_text unconditionally use stop machine and
> remove all direct use of __patch_text? (E.g. by jump labels.)

You could take a look at what we do for arm64 (see aarch64_insn_hotpatch_safe)
for inspiration.

Will
